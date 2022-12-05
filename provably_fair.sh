#!/bin/bash
# Cass@TheChunksNFT provably fair rare Chunks drop
# Every ten trades samples a random winner is picked and airdropped a free rare Chunk
if [ $# -eq 1 ]
  then
    # Scan the last 32256 blocks (7d)
    block=$1
    previousblock=$(($block-32256))
    echo "Scanning from block $previousblock to $block (7d)"
  else
  	# Only for the first draw : scan from block 2920610 as annonced on the following tweet : https://twitter.com/TheChunksNFT/status/1599518122436067328?s=20&t=qclIXcEUAnOg5cyk3suuLw
  	# Otherwise scan the last 32256 blocks (7d)
  	block=$1
  	previousblock=$2
  	echo "Scanning from cutoff block $previousblock to 1st $block"
fi

# -------------------------------------------------------------------------------------
# the 'createdexielist' function creates the full list of completed trades of Chunks (status=4) 
# -------------------------------------------------------------------------------------
check=false
createdexielist() {
# make sure we have a valid set of data, and a new tx did not occur while creating the list through the curl calls
while [ "$check" != "true" ]; do
	count=$(curl -s 'https://api.dexie.space/v1/offers?offered=col16gshnku52v7sjnxucwxx9k7aw73643qht9uhzw50g99qafqz7ptskr3vnp&status=4&sort=date_completed&compact=true&page_size=1' | jq '.count')
	pagecount=$((($count/100)+1))

	for i in $(seq 1 $pagecount)
	do
		curl -s 'https://api.dexie.space/v1/offers?offered=col16gshnku52v7sjnxucwxx9k7aw73643qht9uhzw50g99qafqz7ptskr3vnp&status=4&sort=date_completed&compact=true&page_size=100&page='$i'' > $block/json_dexie/$i.json
		cat $block/json_dexie/$i.json | jq >> $block/alltrades.txt	
	done
	
# check if the $count did not change while curling the data
	if [ 1 = "$(cat $block/alltrades.txt| jq '.count' | uniq | wc -l)" ]
	then
		check=true
	fi
	done
}

random_generator() {
# generate the random single digits list
for d in $(seq 1 $(echo $digits_hash | wc -c))
do
	echo $digits_hash | cut -c$d >> $block/single_random_list_$block.txt
	sed -i '/^$/d' $block/single_random_list_$block.txt
done
# generate the random 4 digits list => then modulo/sample reject to have a list of random numbers ranging from 1 to rare_number (the number of rares left to be airdropped)
i=1
while [ $i -lt "$(($(echo $digits_hash | wc -c)-3))" ]; do
	if [ $(echo $digits_hash | cut -c$i-$(($i+3)) | sed 's/^0*//') -lt "$sample_rejection" ]
	then
		echo $((($(echo $digits_hash | cut -c$i-$(($i+3)) | sed 's/^0*//')%$rare_number)+1)) >> $block/tri_random_list_$block.txt
		sed -i '/^$/d' $block/tri_random_list_$block.txt
	fi
	((i++))
done

tri_random_number=$(awk '!_[$0]++' $block/tri_random_list_$block.txt | wc -l)
}


current_block_data=`curl -s --insecure --cert ~/.chia/mainnet/config/ssl/full_node/private_full_node.crt --key ~/.chia/mainnet/config/ssl/full_node/private_full_node.key -d '{"height": '$block'}' -H "Content-Type: application/json" -X POST https://localhost:8555/get_block_record_by_height`
hash=$(echo $current_block_data  | jq '.block_record.header_hash' | cut -c 4-67)
digits_hash=$(echo $hash | tr -cd '[[:digit:]]')
mkdir $block $block/json_dexie 

cp next_block_remainder.txt $block/next_block_remainder_$block.txt

echo "----------------------------------------------------------------" | tee -a $block/$block.log
echo "Using block_header_hash from block $block" | tee -a $block/$block.log
echo "block_header_hash from $block     : $hash" | tee -a $block/$block.log
echo "Random digits from $block         : $digits_hash" | tee -a $block/$block.log
echo "Calling the dexie API... " | tee -a $block/$block.log
createdexielist
echo "Call to the dexie API successful " | tee -a $block/$block.log

# -------------------------------------------------------------------------------------
# filter only the valid completed trades
# -------------------------------------------------------------------------------------
jq -r '.offers | .[] | select((.spent_block_index >= '$previousblock') and .spent_block_index < '$block' and .previous_price == null) | .offered | .[].id ' $block/alltrades.txt > $block/puzzle_hash_$block.txt
current_valid_trades=$(cat $block/puzzle_hash_$block.txt | wc -l)

# -------------------------------------------------------------------------------------
# Calculate the number of draws, and store the rejected trades for next draw
# -------------------------------------------------------------------------------------

if [ -s next_block_remainder.txt ]
then
	cat next_block_remainder.txt >> $block/puzzle_hash_$block.txt
	total_eligible_trades=$(cat $block/puzzle_hash_$block.txt | wc -l)
	# select only the last *10 chunks and store the remaining ones for next draw
	number_of_draws=$(($total_eligible_trades/10))
	valid_draws=$(($number_of_draws*10))
	#remainder for next draw, filter the newest ones with 'head'
	next_block_draws=$(($total_eligible_trades-$valid_draws))
	echo "----------------------------------------------------------------" | tee -a $block/$block.log
	echo "Remainder of previous draw added to current draw :" | tee -a $block/$block.log
	echo "$(cat next_block_remainder.txt)" | tee -a $block/$block.log
	echo "----------------------------------------------------------------" | tee -a $block/$block.log
	remainder_valid_trades=$(cat next_block_remainder.txt | wc -l)
	cat $block/puzzle_hash_$block.txt | head -n $next_block_draws > next_block_remainder.txt
else
	total_eligible_trades=$(cat $block/puzzle_hash_$block.txt | wc -l)
	# select only the last *10 chunks and store the remaining ones for next draw
	number_of_draws=$(($total_eligible_trades/10))
	valid_draws=$(($number_of_draws*10))
	#remainder for next draw, filter the newest ones with 'head'
	next_block_draws=$(($total_eligible_trades-$valid_draws))
	echo "----------------------------------------------------------------" | tee -a $block/$block.log
	echo "Remainder of previous draw added to current draw :" | tee -a $block/$block.log
	echo "   No remainder in previous draw" | tee -a $block/$block.log
	echo "----------------------------------------------------------------" | tee -a $block/$block.log
	cat $block/puzzle_hash_$block.txt | head -n $next_block_draws > next_block_remainder.txt
fi

echo "Current draw eligible trades      : $current_valid_trades" | tee -a $block/$block.log
echo "Remainder eligible trades         : $remainder_valid_trades" | tee -a $block/$block.log
echo "Total eligible trades             : $total_eligible_trades" | tee -a $block/$block.log
echo "Number of draws                   : $number_of_draws" | tee -a $block/$block.log
echo "Remainder of current draw         : $next_block_draws" | tee -a $block/$block.log
echo "The following puzzle hash will be included in the next draw" | tee -a $block/$block.log
echo "$(cat next_block_remainder.txt)" | tee -a $block/$block.log
mv $block/alltrades.txt $block/trades_$(echo "$previousblock"_"$block").txt

# Check if enough trades to make a draw (more than 10)
if [ "$valid_draws" == "0" ]
then
	echo "----------------------------------------------------------------" | tee -a $block/$block.log
	echo "Not enough trades (less than 10) => no draw"
	exit
else
	cat $block/puzzle_hash_$block.txt | tail -n $valid_draws > $block/valid_draws.txt
	# 'Chunk' the total eligible trades into sample of 10
	m=0
	for i in $(seq 1 $number_of_draws)
	do
		cat $block/valid_draws.txt | head -n $(($i*10)) | tail -n 10 > $block/draw_$(($number_of_draws-$m)).txt
		((m++))
	done
	mkdir $block/10_trade_samples
	mv $block/draw*.txt $block/10_trade_samples/
	echo "----------------------------------------------------------------" | tee -a $block/$block.log
	echo "Enough trades (more than 10) => Creating files for each 10 consecutive trades"
	# echo "$(ls $block/10_trade_samples/)" | tee -a $block/$block.log
fi

# -------------------------------------------------------------------------------------
# Generate the random numbers from the block_header_hash
# -------------------------------------------------------------------------------------
# calcultate how many rares left are to be distributed, and what is the rejection number above which randoms numbers are filtered out, in order to avoid modulo bias
rare_number=$(cat rare_nftids.txt | wc -l)

# we're using 4 digits number and modulo them in order to get a maximum 3 digits number (they are 830 rares to be airdropped)
# any number above the sample_rejection will be discarded to avoid modulo bias
sample_rejection=$((1+(9999/$rare_number)*rare_number))

echo "----------------------------------------------------------------" | tee -a $block/$block.log
echo "block_header_hash from $block    : $hash" | tee -a $block/$block.log
echo "Random digits from $block        : $digits_hash" | tee -a $block/$block.log
echo "Number of rares left to be won    : $rare_number" | tee -a $block/$block.log
echo "Sample rejection number           : $sample_rejection" | tee -a $block/$block.log

# -------------------------------------------------------------------------------------
# Check if the current block_header_hash provides enough random numbers for the total number of draws to be made
# if not then fetch next block_header_hash until we have enough valid random numbers
# -------------------------------------------------------------------------------------
tri_random_number=0
k=1
while [ "$tri_random_number" -lt "$number_of_draws" ]; do
	random_generator
	echo "----------------------------------------------------------------" | tee -a $block/$block.log
	echo "Verifying if the current block header hash provides enough random numbers..." | tee -a $block/$block.log
	echo "Current max valid (sample rejected) random numbers = $tri_random_number" | tee -a $block/$block.log
	if [ "$tri_random_number" -lt "$number_of_draws" ]
	then
		echo "Not enough data in the current block header hash, using next block header hash"
		current_block_data_plus=`curl -s --insecure --cert ~/.chia/mainnet/config/ssl/full_node/private_full_node.crt --key ~/.chia/mainnet/config/ssl/full_node/private_full_node.key -d '{"height": '$(($block+$k))'}' -H "Content-Type: application/json" -X POST https://localhost:8555/get_block_record_by_height`
		hash=$(echo $current_block_data_plus  | jq '.block_record.header_hash' | cut -c 4-67)
		digits_hash=$(echo $hash | tr -cd '[[:digit:]]')
		echo "Added block header hash           : $hash" | tee -a $block/$block.log
		echo "Added block header digits         : $digits_hash" | tee -a $block/$block.log
		((k++))
	fi
done
#sort only uniques random tri digits numbers
awk '!_[$0]++' $block/tri_random_list_$block.txt >> $block/sorted_tri_random_list_$block.txt

echo "----------------------------------------------------------------" | tee -a $block/$block.log
echo "Total single digits random numbers : $(cat $block/single_random_list_$block.txt | wc -l)" | tee -a $block/$block.log
for i in $(cat $block/single_random_list_$block.txt)
do
	echo -n "$i-" | tee -a $block/$block.log
done 
echo ""
echo "Total multiple digits random numbers : $(cat $block/sorted_tri_random_list_$block.txt | wc -l)" | tee -a $block/$block.log
for i in $(cat $block/sorted_tri_random_list_$block.txt)
do
	echo -n "$i-" | tee -a $block/$block.log
done 
echo ""
echo "----------------------------------------------------------------" | tee -a $block/$block.log

# -------------------------------------------------------------------------------------
# Create the winners (1 among 10, and which rare airdropped to that winner)
# -------------------------------------------------------------------------------------
echo "draw,random 1,xch_address,random 2,Rare Chunk Airdropped" | tee -a $block/$block.log
for i in $(seq 1 $number_of_draws)
do
	index=$((1+$(cat $block/single_random_list_$block.txt | head -n$i |tail -n1)))
	winner=$(cat $block/10_trade_samples/draw_$i.txt | head -n$index |tail -n1)
	index_nft=$(cat $block/sorted_tri_random_list_$block.txt | head -n$i |tail -n1)
	nft_draw=$(cat rare_nftids.txt | head -n$index_nft |tail -n1)
	encoded_winner=$(cdv encode -p nft $winner)
	winning_chunk=$(curl -s https://api.mintgarden.io/nfts/$encoded_winner | jq '.data.metadata_json.name')
	xch_address=$(curl -s https://api.mintgarden.io/nfts/$encoded_winner | jq '.events | .[] | select(.event_index == 2) | .address.encoded_id' | cut -d '"' -f2)
	echo "draw $i,$index,$winning_chunk,$winner,$xch_address,$index_nft,$nft_draw," >> $block/raw_draw.txt
	echo "$i,$index,$winning_chunk,$xch_address,$index_nft,$nft_draw" | tee -a $block/$block.log
	echo "$xch_address,$nft_draw" >> $block/rare_transfer_list_$block.txt
	echo "$nft_draw" >> $block/deleted_nftids_$block.txt
# delete from rare_nftids list the rare chunks won of the current draw
done

cp rare_nftids.txt $block/rare_nftids_$block.txt

# delete the nft_draw from rare_nftids.txt list
for i in $(cat $block/deleted_nftids_$block.txt)
do
	sed -i "/$i/d" rare_nftids.txt
done

echo "----------------------------------------------------------------" | tee -a $block/$block.log
git add .
echo "git commit $block"
git commit -m "$block commit"
echo "git push $block"
git push origin main
echo "----------------------------------------------------------------" | tee -a $block/$block.log





