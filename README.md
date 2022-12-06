# Provably Fair Rare @TheChunksNFT airdrop
Every 10 trades of original offerfiles accepted via Dexie.space (0.1 xch offerfiles created with the TheChunksNFT wallet) a random winner is picked among those 10 trades and will be airdropped a rare Chunk (top 1K)

One draw will be made every single day until all of the rare Chunks left in the wallet have been drop (830 rare chunks left.

Initial Block chosen in advance by @_Ghost_Friend : https://twitter.com/TheChunksNFT/status/1599518122436067328?s=20&t=qclIXcEUAnOg5cyk3suuLw
INIT_BLOCK=2920610

Initial cutoff block for 1st draw only annonced in the following tweet : https://twitter.com/CassFairiesClub/status/1595549236623548418?s=20&t=E4do1R6SOVk0zmadaNAV5g
CUTOFF_BLOCK=2864212


## Requirements
The verify_draw.sh script requires a Block Id as parameter in order to scan for the last 32256 blocks (equivalent to 7 days)
It uses the block_header_hash of that block to generate random numbers and randomly select a winner on every 10 trades samples, and a rare Chunk to be airdropped to that winner

These block Ids are already known in advance of a draw, no one can predict a future block_header_hash, thus making the draw **provably fair**.
The list of future blocks used will be pushed to the repo before the first draw.

You need a chia **full node** to make rpc calls scanning the blockchain.
You need to be in the chiadevtools venv to encode to bech32m the winning addresses.

This tool is only available for linux OS.

## How to run the script and verify yourself a past draw
1. Download the verify.sh script from the github repository and make it executable

```
wget https://raw.githubusercontent.com/CassFairiesClub/testrepo/master/verify_draw.sh
chmod +x verify_draw.sh
```

2. Pass in the block number as parameter.

Example (in the case of the original rare_nftids.txt with 830 total) :
This simulates the original draw if it were made at block 2883291 (around 12:00am UTC the 27th of November 2022)

```
./verify_draw.sh 2883291
```

This will give the following output :

```
----------------------------------------------------------------
Using block_header_hash from block 2883291
block_header_hash from 2883291     : 9ec0c12cf614586f6dc257e1c17491405e1f90d4f693fc70b521a8f0489753e1
Random digits from 2883291         : 90126145866257117491405190469370521804897531
Calling the dexie API... 
Call to the dexie API successful 
----------------------------------------------------------------
Remainder of previous draw added to current draw :
   No remainder in previous draw
----------------------------------------------------------------
Current draw eligible trades      : 453
Remainder eligible trades         : 
Total eligible trades             : 453
Number of draws                   : 45
Remainder of current draw         : 3
The following puzzle hash will be included in the next draw
69a271e97ddb9802f3044d1027628815d1885922cae8591a716eba238539eca2
ff6757b768eec83e5345458b7b242113155e73fca7769053c94371924bb04d63
81c403374b0f3c79329ce6771779f56bc12c47dabb42bfe066d2c7c34255d9ea
----------------------------------------------------------------
Enough trades (more than 10) => Creating files for each 10 consecutive trades
----------------------------------------------------------------
block_header_hash from 2883291    : 9ec0c12cf614586f6dc257e1c17491405e1f90d4f693fc70b521a8f0489753e1
Random digits from 2883291        : 90126145866257117491405190469370521804897531
Number of rares left to be won    : 830
Sample rejection number           : 9961
----------------------------------------------------------------
Verifying if the current block header hash provides enough random numbers...
Current max valid (sample rejected) random numbers = 40
Not enough data in the current block header hash, using next block header hash
Added block header hash           : bf226130fbd2788a184d8425b2279d246e753c82bb7ac18aa87766b546d87a32
Added block header digits         : 22613027881848425227924675382718877665468732
----------------------------------------------------------------
Verifying if the current block header hash provides enough random numbers...
Current max valid (sample rejected) random numbers = 80
----------------------------------------------------------------
Total single digits random numbers : 88
9-0-1-2-6-1-4-5-8-6-6-2-5-7-1-1-7-4-9-1-4-0-5-1-9-0-4-6-9-3-7-0-5-2-1-8-0-4-8-9-7-5-3-1-2-2-6-1-3-0-2-7-8-8-1-8-4-8-4-2-5-2-2-7-9-2-4-6-7-5-3-8-2-7-1-8-8-7-7-6-6-5-4-6-8-7-3-2-
Total multiple digits random numbers : 80
713-127-432-125-336-629-437-57-363-816-448-82-732-478-345-90-22-765-11-576-520-211-245-747-470-544-298-241-386-413-522-239-521-145-579-490-748-676-624-62-602-124-321-473-538-279-299-412-519-715-189-185-693-126-103-33-248-620-303-455-117-808-526-114-69-403-508-802-229-549-228-578-477-297-196-15-737-489-234-433-
----------------------------------------------------------------
draw,random 1,xch_address,random 2,Rare Chunk Airdropped
1,10,xch1f8q36eempg0xucs3v3vf5sd9vmwq8u9cjgd2g9x23jnp89smeneqvyu7s9,713,nft1n9vnzgg5ca63lrdc2ygzarxtw536zggh5nnj07d863ucjglamajsmhtgse
2,1,xch1gmm2858jxym78upf5m4zs7gv7szh5p66dnagem60y3mct4pnhkmsj3kd9l,127,nft14fy3unclcfk48jxph9d5yqrt8sq87xt9ymv7amxvpwsgkwer29ustr07t2
3,2,xch1q7vygm7zkw78w0rgz4gsgvylkkc673cjxlruwgt40ravae7vwhws3v3rhx,432,nft1q6nunls2cpm7nyx5dzkcp92ntsnn5laxty0ewy9jaw0ysgrr7x7qrhjvf9
4,3,xch1f8q36eempg0xucs3v3vf5sd9vmwq8u9cjgd2g9x23jnp89smeneqvyu7s9,125,nft1t47t6gn9we9zzvct772kmqpt2fdv66gw2yqpj3c82ynlv8uk67yqt65vtu
5,7,xch13k6t7lmw5w8jsmn0xrtlk4t4npp4zyezj7xf3h2pa4mn5fsaks8s5u74uc,336,nft1zfz3n6letdnmskh0x99mwlw6pvw448mgc6r9cxqkjw7d9akenwxsqx4zxx
6,2,xch1dpxdw6l0nfrv5njt03tyvh8xxtk23fmj4p8yvrdws7tam09une9s2y3ek9,629,nft18x7anyl8jqqp8as56chsh27952wjfzuvffj73xz2cwh2mp2eaftq2mv3rs
7,5,xch1xkwfjaxs0af6f2effql5ngsnx7lgfygm30d5dnepvcmlp5zx8dyqw2yl9k,437,nft1t32krnysmvgxr8rdky2eteddmevh50c5ljqhc8sm4qnau434qdas359tes
8,6,xch1td89kttwaz43flxfqazufmn92ed2qfgym80ht8mnu05ettp8quas7wku7g,57,nft1sdxw9ga956sn2pynp3qyej69wtkt7a5e83qqurj88j6g8xxwzk7s7w53a2
9,9,xch1pnlz47rfhum9v07k26sawq8ctzlcjq088cnyzz64jc24qzwqgnqsku508a,363,nft1xa3qdyjn7z90ewh5tlp4msa04c2wu89tfkw9urs07r5eg2x9hftsq90xvq
10,7,xch198070fvhdm3s4994atzezp2vfrvudspdf3caea9ydglsjya3p7fq6uc7ph,816,nft1f94y4ezmghxg00vhzqceuaep59cr0lmqsuaww2jtap83jewxn0wqk8wzga
11,7,xch1u0909zmu3dg4n8jm9wmz94f3vsdnzduf8uhqfw3p40nkdnqlecls7pgkzu,448,nft1qmuvhlqmzgh6pnk2sklk6pa5kjc3f9djdtp8gvssu256e52fejws5kehsk
12,3,xch1f8q36eempg0xucs3v3vf5sd9vmwq8u9cjgd2g9x23jnp89smeneqvyu7s9,82,nft126ewa2er0xk4fz9hnnlz3d0qts855a9cu6ymr4pkqdgatgf0jnqqclyd92
13,6,xch16jnzufvqt45c8dm2e3v5eenm20pvv0j0l00lgevn3fwr0rlu44ys7sx38w,732,nft1xl6czp5ny7m3kljunv4qlevrfzswsyy8c0m4tn3rgc7k5s2g0rvqj20jgx
14,8,xch1z0mthejqrrmvme7ymxnzldyvskkx4gurenadmdjw4ugp3ng4yg8q94890s,478,nft1rv7sg7pruqfgnmmvm9axvgu72atrukgssx9v6yqek0eshqr26z4sr23url
15,2,xch1f2ckvk0kt6suznxwdk0mamjdxy5jkngvvnsylnz9f3fjmzwyw96skpwuap,345,nft1ut9gsmt96u088wdk4afsykt9n99zge86yjrdtz5y5qlm25pwqnxqc44l2h
16,2,xch1z7sjmk26mts593e0vlhg2yanmgvxnwju6et3xy09tht4d7qdgvls69dqu0,90,nft19j4kwesx4pqgsgpnufgtw5cj0gw7fx4y47luqds4p0lwujhxxyusm22uf2
17,8,xch1q2kykhyraj5slp0khd49f5n7alhwzqza4remavz4cmkakwg6l7xsdru7jx,22,nft1kv2wh5wnqyjj7kearszsyu9l85s2g3pxt6x6rqd4mstq03xgw3qszu0m5w
18,5,xch1xnzhrndmzcfke8a6wtku5vua58ctfc8vp0m3av7qcsc3kgd3g4sq09jtvj,765,nft1hxe5mrzapc6tkmhnmzxdpjukr44dp5xgnq4admqdt9hrrt93m0cqep99r7
19,10,xch1mx7tpvk9gv6gdlhk25t7lwgrjqr3h94hxghr0pa50r4v35rrc7zqkcsx06,11,nft1hew0r3av5ux7aqnzr7qcz6fucwu2ttnxfkhg4scx3n8q72aqxqds2swx0y
20,2,xch1svf3lc4zmvx2z8vuj6yx4v69gzpnm9ekg63drmqp7pqmaap4z3cs7h0t69,576,nft153tje6q3mggccke2dkzjtvpg2vl8693up9e7zzwzd4jwa0h384mqq03e2g
21,5,xch1s482qnzvre25c6stcjehvjl5x3a4dj03h6k29cgzrwv7kk2f6yqsjlk365,520,nft1ja0kg6zs7xjxws3ejfd6uqejvdtdwe9xxuv35v9m2r0hkvknj8csree3lp
22,1,xch1dmtyamp8cew2n84khxpw64wzzhl5jet3azzgpg9e4gctu37jpaassyxs7a,211,nft1wafn3arxfvg54ucycg6wf8mhlkusjw3lrwu6w353a27ajen9lavsjacxv0
23,6,xch1mlna89x32pr84w7p2txkwedzujpj32whnw8e4ltzp2fkr3ff8w9s560nc5,245,nft1s6pjktee8zcmpg6n2wtjrc77lrgfgac8euhk5mwyhavenlyz0xnq0cfmdv
24,2,xch1am6xldqevs4hphqfr2xseuvtjmmq36d8qjsfzpyqjura2hxmruysuv0xvt,747,nft1atted99vkyty0sdtprmp8j9maqkq7nh00umknue359h2kr03k39qs94gr3
25,10,xch1cqd7afxwpe72vwnxdlv7ud6u0mj73xme5m8przdwxqaa5djvn5xqeq26e4,470,nft1fanla5kjsemdmlxp8fahjt5nz7dnkqj3wzfx9j0k9x0j8ctdsxassjdhp8
26,1,xch137ce44uvkg5dx7szu38unldm6uffapcaytdsg7xf63zxv44kxc0q8jg9uq,544,nft1lrcydh8nt38nnamkppz4mnt59lr8g9eacplph77lpsdxsw6qrd7qgllym7
27,5,xch1zmv8djafvne2us9qedmnaqgn6fszejr0sk5qqpzz6al60zxun2zs4r90ra,298,nft1yggxq6h79unrmqtzguc23qfhfry3tv8ja8tx0cxcnr3zhkxalqkqvnkf8j
28,7,xch18w4n9np35ec5qtxxwx5lhvc3x3yn0xqq78qc2k3dmelaemv70lsq07l2qn,241,nft1wfxxfgmnc5yy6yt6m38u70nwtdngcsqh22222jge479e82y8z8ss8jjj9c
29,10,xch106eyyvcgwsrndu3jqztv8srk9hsu9w7fs8aaxdxe5pfkgk22stpq3njmhv,386,nft1m0glyxt5pkult9q00fffcucp2kclmueffpqzgs20fqncp65td0ds9k5u0t
30,4,xch1ct40729f36289d43shv40hp2206gqw5x8mgg6s5wxa46p9e87zwszq5vx8,413,nft1urpzh6w8e3vrtjr9xd27q2javsdcq2nwpzqg023hjmdsm2x2mkls78636m
31,8,xch1kvq4nny85vjhpm07ftxr8k6gw7cfhf0ksc8qa7ju9cth343kyeusf7gkqf,522,nft1r6dk7zqznnk9w79096kjhs9jt9rgjetvj4s5gm8z342n6zh38z5qjpvrn7
32,1,xch1m4s8660qrnqa2lkks2e8fmj8nctesvzlk8yvahjf3v63l762flssexst6w,239,nft1d56x95jynywrls8vh7z5ngy35gk5dmp7dmhqq6jzg2kerhmtw7ws4e777u
33,6,xch1s8l8ackmatvrw6pxq6e86wyyxq0hlpthv9egvlrpd0ycm9h496jqth98ja,521,nft1q6d0m3yrj85efsueg37vj4u6ut0lvqalnjl3nutqq5w7aezndqns8mdvtx
34,3,xch13edxp5zekann788fw2tzh35ne66u47cw7h9dwj56gnpwnffp6j5s7l80rr,145,nft14ewet4tnq240p3km05zdxhgxrdf4luz8wkkfpx3qtlxnpy6ny43qqgw2ja
35,2,xch125eenr4r32avr80a7sn7hz53t8dajuk3pxr59j7kkk56u777s8xqgkv3qv,579,nft1tpvg9rxatjna6gvykasruq5sldtav5mzgdqcsdgpfmty4ryl4s4s37hwnn
36,9,xch153fpad69qklpnllf3ne4he62czqvc2acfq53zr8qmed50yymsn0sfe34tt,490,nft1qzeln88mq7lm96dnhdl76u2cr0ak8pqrgxvnwkswt34dmvljf5tq7j93mq
37,1,xch198070fvhdm3s4994atzezp2vfrvudspdf3caea9ydglsjya3p7fq6uc7ph,748,nft19dvum8vr5h6jgy5qqqukngank5xrqf5es4v0dr8khva34rcg9w5skugm7g
38,5,xch1yd0k4v95xjtf7s8ua9xpt88qal4yllz84whdcfcszgrzdu95lrhq20lcyr,676,nft1avmxqe8hkguwegrg08ytln6uqx78952w6v9u7vlgjk7s28lypresl5ynah
39,9,xch1d8ry9hsuwfzcjy94gevjexdkm0cwz8c8p4g3fxxklsrchzgykf9qwryffl,624,nft1qc2r2p5075xmgnz70ma0vdtglv52mc6tp76fca6v6phmlgwlunwsejnxnn
40,10,xch16jv3ar670e57efnhcfkp2z6qfwgrkjud6tggec92sw57erts96sqpnz0fw,62,nft1tr8s59mqmctvkzv5vaznwylnjlkypjxm30kk4vh5rzmkvmzg02cswxa3h2
41,8,xch169mpxceymppr83j2rdjjv3tpxactu550sq2jns24ckhv936s3nxsxfsvuu,602,nft1fg7glk3aqwvk7ddw3854muulccml9lrdvdum6drdhrrsq4ktpw3s9hr9t6
42,6,xch16rcvs6mhjkxnudy6uclr8nm03n4w843ud9vjg4k5uzgdlkeslynqzfsawp,124,nft162p9e0h2agqtkrsldvnwrev9xqh25vryqufugfkcqdy9aju95urqrakl5k
43,4,xch1suy98y3ty8dkanq4p7wg3hp8gr2eh602fkhnunz5psaj0ael7rhqcnp7n3,321,nft1kxte4p7alxazrf5de4kmfxtmhqnwcusswy564qqcktyhe3mcu4sq7sxasw
44,2,xch1e9qrrdegxupzz7d9f4fycy3a6jplvdhl4k6swcxra9eh8n2mek7sydvzyf,473,nft1jqlk9q83053d5sfghc6gcwfhwzx04nltctypchw9ykhzg3hhhkfsyecmsa
45,3,xch18lnult7wdlxv5w8qpglgwkz5ayu42mnuy8dhqmxak2n6xj0glraql7q5th,538,nft1dexp22nklttzas8e2t3t9eyf0u4nddjhywuyg0plkeyf5p3pzf4q3f6e4p


```
