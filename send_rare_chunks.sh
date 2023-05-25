#!/bin/bash
FINGERPRINT=3187864955
WALLETID=5
BLOCK=3662498

wait_transfer() {
MINT_STATE=$(chia rpc wallet get_wallet_balance '{"wallet_id": 1}' | jq '.wallet_balance.pending_coin_removal_count')
while [ "$MINT_STATE" -ne 0 ]; do
sleep 15
MINT_STATE=$(chia rpc wallet get_wallet_balance '{"wallet_id": 1}' | jq '.wallet_balance.pending_coin_removal_count')
done
}

wget https://raw.githubusercontent.com/CassFairiesClub/TheChunksNFT/main/$BLOCK/rare_transfer_list_$BLOCK.txt

for i in $(cat rare_transfer_list_$BLOCK.txt)
do
TA=$(echo $i | cut -d ',' -f1)
NFT_ID=$(echo $i | cut -d ',' -f2)
NFT_COIN_ID=$(chia rpc wallet nft_get_info '{"wallet_id": '$WALLETID', "coin_id": "'$NFT_ID'"}' | jq -r '.nft_info.nft_coin_id')
chia wallet nft transfer -f $FINGERPRINT -i $WALLETID -ni $NFT_COIN_ID -ta $TA -m 0.0000000001
sleep 300
done
