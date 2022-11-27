# Provably Fair Rare @TheChunksNFT airdrop
Every 10 trades of original offerfiles accepted via Dexie.space (0.1 xch offerfiles created with the TheChunksNFT wallet) a random winner is picked among those 10 trades and will be airdropped a rare Chunk (top 1K)
to be completed : why -> dexie offers being botted, 168 rare Chunks already botted/accepted, 830 rare Chunks left, 2 rare Chunks reserved for giveaway to outstanding members of the Phunk community

One draw will be made every single day until all of the rare Chunks left in the wallet have been drop (830 rare chunks left.

## Requirements
The provably_fair.sh script requires a Block Id as parameter in order to scan for the last 4608 blocks (equivalent to 24h)
It uses the block_header_hash of that block to generate random numbers and randomly select a winner on every 10 trades samples, and a rare Chunk to be airdropped to that winner

These block Ids are already known in advance of a draw, no one can predict a future block_header_hash, thus making the draw **provably fair**.
The list of future blocks used is in the repo.

You need a chia **full node** to make rpc calls scanning the blockchain
And you need to be in the chiadevtools venv to encode to bech32m the winning addresses.
This tool is only available for linux OS.

## Files
The rare_nftids.txt stores the current rare chunks left in the pool to be airdropped
The next_block_remainder.txt stores the "leftover trades (<10)" that will be included in the next draw

## How to run the script and verify yourself a past draw
1. Make sure you first have the latest commits of the following files
- next_block_remainder.txt
- rare_nftids.txt

2. Pass in the block number as the first parameter, or provide also a second block as parameter (only used for the initial draw : 2864212).

Example (in the case of the original rare_nftids.txt with 830 total) :
This simulates the original draw if it were made at block 2883290 (around 12:00am UTC the 27th of November 2022)
```
  ./provably_fair.sh 2883291 2864212
```

This will give the following output :

```
Scanning from block 2864212 to 2883291
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
Current max valid (sample rejected) random numbers = 41
Not enough data in the current block header hash, using next block header hash
Added block header hash           : bf226130fbd2788a184d8425b2279d246e753c82bb7ac18aa87766b546d87a32
Added block header digits         : 22613027881848425227924675382718877665468732
----------------------------------------------------------------
Verifying if the current block header hash provides enough random numbers...
Current max valid (sample rejected) random numbers = 82
----------------------------------------------------------------
Total single digits random numbers : 88
9-0-1-2-6-1-4-5-8-6-6-2-5-7-1-1-7-4-9-1-4-0-5-1-9-0-4-6-9-3-7-0-5-2-1-8-0-4-8-9-7-5-3-1-2-2-6-1-3-0-2-7-8-8-1-8-4-8-4-2-5-2-2-7-9-2-4-6-7-5-3-8-2-7-1-8-8-7-7-6-6-5-4-6-8-7-3-2-
Total multiple digits random numbers : 82
713-127-432-125-336-629-437-57-363-816-448-82-732-478-345-90-22-765-11-576-732-520-211-245-747-470-544-298-241-386-413-522-239-521-145-579-490-748-676-624-62-602-124-321-473-538-279-299-412-519-715-189-185-693-126-103-33-248-620-303-455-117-808-526-114-69-403-508-802-229-549-228-578-477-297-196-15-737-489-538-234-433-
----------------------------------------------------------------
draw,random 1,xch_address,random 2,Rare Chunk Airdropped
1,10,xch1g0g8p9llqmgmxlqyhgv0knp6zl67qcl8nldt7kalnkzvnym6xc6s9lv8gu,713,nft1n9vnzgg5ca63lrdc2ygzarxtw536zggh5nnj07d863ucjglamajsmhtgse
2,1,xch1l6aew8jjuhvry4hqhlps4xnd4w69yaxw73tqlk0ml9qdxl50dadscrksre,127,nft14fy3unclcfk48jxph9d5yqrt8sq87xt9ymv7amxvpwsgkwer29ustr07t2
3,2,xch1pffcktlu0uqhmnlnn333lkz22wtd83v40nrl22cm7dvngn4zfqesz68wee,432,nft1q6nunls2cpm7nyx5dzkcp92ntsnn5laxty0ewy9jaw0ysgrr7x7qrhjvf9
4,3,xch1dwwc4s783wrewc6rfyz28lx0e4dzr8aa4p5e9wqdajcmtscgznaqry5xkm,125,nft1t47t6gn9we9zzvct772kmqpt2fdv66gw2yqpj3c82ynlv8uk67yqt65vtu
5,7,xch1kje8ckyqwpxg7unfcf5gc03q2fs4hr9d9t6en2ga62u6dakpr8es8tf99d,336,nft1zfz3n6letdnmskh0x99mwlw6pvw448mgc6r9cxqkjw7d9akenwxsqx4zxx
6,2,xch1acrctgzzlz8pytgc5shmesncgd9a25errfuxreseueypzzm9ck7qahumvg,629,nft18x7anyl8jqqp8as56chsh27952wjfzuvffj73xz2cwh2mp2eaftq2mv3rs
7,5,xch1ytguv69hh4j37vv07fq4e258wyvxxc8g3khm435g8rtn8n2vth7qsrm8lt,437,nft1t32krnysmvgxr8rdky2eteddmevh50c5ljqhc8sm4qnau434qdas359tes
8,6,xch1ger7nynfwgn3q589dq8v0ncaragup2tz8s67fsfp34tke0lzuz8qntmzm2,57,nft1sdxw9ga956sn2pynp3qyej69wtkt7a5e83qqurj88j6g8xxwzk7s7w53a2
9,9,xch1fqv5u2rwgh8hz0a5p8v3wz80u70c4d7lqjscugxdqwh2spkxzttshs8y8c,363,nft1xa3qdyjn7z90ewh5tlp4msa04c2wu89tfkw9urs07r5eg2x9hftsq90xvq
10,7,xch1zafzasneuq5xctp70zjmzzdlq3a3faz7l5zt50guqp3r8csrd7wqwcynrg,816,nft1f94y4ezmghxg00vhzqceuaep59cr0lmqsuaww2jtap83jewxn0wqk8wzga
11,7,xch1a6l7dx5uuftpxkzzkqwulcaq7sc0jv3w5ayx0ucclqxz57enapksvlwtsm,448,nft1qmuvhlqmzgh6pnk2sklk6pa5kjc3f9djdtp8gvssu256e52fejws5kehsk
12,3,xch13edxp5zekann788fw2tzh35ne66u47cw7h9dwj56gnpwnffp6j5s7l80rr,82,nft126ewa2er0xk4fz9hnnlz3d0qts855a9cu6ymr4pkqdgatgf0jnqqclyd92
13,6,xch1s8l8ackmatvrw6pxq6e86wyyxq0hlpthv9egvlrpd0ycm9h496jqth98ja,732,nft1xl6czp5ny7m3kljunv4qlevrfzswsyy8c0m4tn3rgc7k5s2g0rvqj20jgx
14,8,xch1ekawrc7wfk38sspxagdka253q4n2vw960yw6du093enxcyzxz4usxu8jvq,478,nft1rv7sg7pruqfgnmmvm9axvgu72atrukgssx9v6yqek0eshqr26z4sr23url
15,2,xch1f8q36eempg0xucs3v3vf5sd9vmwq8u9cjgd2g9x23jnp89smeneqvyu7s9,345,nft1ut9gsmt96u088wdk4afsykt9n99zge86yjrdtz5y5qlm25pwqnxqc44l2h
16,2,xch1t6967gft77k9rv4n2n7pg0c98jp7f5g88mjreza7a3evnpj7ntxscmvagq,90,nft19j4kwesx4pqgsgpnufgtw5cj0gw7fx4y47luqds4p0lwujhxxyusm22uf2
17,8,xch1ukt9zrmq8mm9uke7y8h46z56zmf3a9lng5cvytevjeek8pd422ns5l70sf,22,nft1kv2wh5wnqyjj7kearszsyu9l85s2g3pxt6x6rqd4mstq03xgw3qszu0m5w
18,5,xch12255hn3vcsyp7xhexak9ye9mcefzqpa0gnawwjwrt8kj6nu2jwzs2yfctq,765,nft1hxe5mrzapc6tkmhnmzxdpjukr44dp5xgnq4admqdt9hrrt93m0cqep99r7
19,10,xch1kpxpf2jhafylescuzgvv7ufu07ntshxggwfexlugme8d6tnvrduqdju8gk,11,nft1hew0r3av5ux7aqnzr7qcz6fucwu2ttnxfkhg4scx3n8q72aqxqds2swx0y
20,2,xch1s5atf8jkea0xtj22dchh75mtn77ygs385l29k84dvapmgnqlst9s2acfca,576,nft153tje6q3mggccke2dkzjtvpg2vl8693up9e7zzwzd4jwa0h384mqq03e2g
21,5,xch16jnzufvqt45c8dm2e3v5eenm20pvv0j0l00lgevn3fwr0rlu44ys7sx38w,732,nft1xl6czp5ny7m3kljunv4qlevrfzswsyy8c0m4tn3rgc7k5s2g0rvqj20jgx
22,1,xch1nqu7sca0mks3n903587xz7eg5lc6tjje3tya2cnwxtfd3sq7m9asfnk4cy,520,nft1ja0kg6zs7xjxws3ejfd6uqejvdtdwe9xxuv35v9m2r0hkvknj8csree3lp
23,6,xch1mlna89x32pr84w7p2txkwedzujpj32whnw8e4ltzp2fkr3ff8w9s560nc5,211,nft1wafn3arxfvg54ucycg6wf8mhlkusjw3lrwu6w353a27ajen9lavsjacxv0
24,2,xch1tqv05u7fjwnckdk6r2vscfkcvmwg87km7n7h93mwrk2557t93nuq37mm4e,245,nft1s6pjktee8zcmpg6n2wtjrc77lrgfgac8euhk5mwyhavenlyz0xnq0cfmdv
25,10,xch1kpnx5zd2qmqa425mj4xf7jhyv6ljw0etd3fzsx08synduw67uh3syux3u0,747,nft1atted99vkyty0sdtprmp8j9maqkq7nh00umknue359h2kr03k39qs94gr3
26,1,xch1m254j057mgha6uar80hyjmtv08znrx43zwmhw9uldl9cq9yz2y4syjazp9,470,nft1fanla5kjsemdmlxp8fahjt5nz7dnkqj3wzfx9j0k9x0j8ctdsxassjdhp8
27,5,xch1f8q36eempg0xucs3v3vf5sd9vmwq8u9cjgd2g9x23jnp89smeneqvyu7s9,544,nft1lrcydh8nt38nnamkppz4mnt59lr8g9eacplph77lpsdxsw6qrd7qgllym7
28,7,xch1g5ts2735xdx6kaxtctzn2cluug9qlcnwgjg95rjjh5jzxp94r3usdn32me,298,nft1yggxq6h79unrmqtzguc23qfhfry3tv8ja8tx0cxcnr3zhkxalqkqvnkf8j
29,10,xch1pnlz47rfhum9v07k26sawq8ctzlcjq088cnyzz64jc24qzwqgnqsku508a,241,nft1wfxxfgmnc5yy6yt6m38u70nwtdngcsqh22222jge479e82y8z8ss8jjj9c
30,4,xch1z7sjmk26mts593e0vlhg2yanmgvxnwju6et3xy09tht4d7qdgvls69dqu0,386,nft1m0glyxt5pkult9q00fffcucp2kclmueffpqzgs20fqncp65td0ds9k5u0t
31,8,xch1z0mthejqrrmvme7ymxnzldyvskkx4gurenadmdjw4ugp3ng4yg8q94890s,413,nft1urpzh6w8e3vrtjr9xd27q2javsdcq2nwpzqg023hjmdsm2x2mkls78636m
32,1,xch1z0mthejqrrmvme7ymxnzldyvskkx4gurenadmdjw4ugp3ng4yg8q94890s,522,nft1r6dk7zqznnk9w79096kjhs9jt9rgjetvj4s5gm8z342n6zh38z5qjpvrn7
33,6,xch16jnzufvqt45c8dm2e3v5eenm20pvv0j0l00lgevn3fwr0rlu44ys7sx38w,239,nft1d56x95jynywrls8vh7z5ngy35gk5dmp7dmhqq6jzg2kerhmtw7ws4e777u
34,3,xch1f8q36eempg0xucs3v3vf5sd9vmwq8u9cjgd2g9x23jnp89smeneqvyu7s9,521,nft1q6d0m3yrj85efsueg37vj4u6ut0lvqalnjl3nutqq5w7aezndqns8mdvtx
35,2,xch1f8q36eempg0xucs3v3vf5sd9vmwq8u9cjgd2g9x23jnp89smeneqvyu7s9,145,nft14ewet4tnq240p3km05zdxhgxrdf4luz8wkkfpx3qtlxnpy6ny43qqgw2ja
36,9,xch1yl8nlfq59mndpn7fkdyru0ze92f66ad74uxgcdw7d4y9evghty8sxswwvs,579,nft1tpvg9rxatjna6gvykasruq5sldtav5mzgdqcsdgpfmty4ryl4s4s37hwnn
37,1,xch1m0v0sw5qync3lsjncg2yzas653wrsjqp5ezlcpfwy6hhxuyqtwrq7zu0n3,490,nft1qzeln88mq7lm96dnhdl76u2cr0ak8pqrgxvnwkswt34dmvljf5tq7j93mq
38,5,xch13ym5cay6ec4yjeqmxz63qxsllklavj6c9sm77zjaqsa2t6us863q7afjdn,748,nft19dvum8vr5h6jgy5qqqukngank5xrqf5es4v0dr8khva34rcg9w5skugm7g
39,9,xch13ctp68qfjw9z0g58fd6un6hd4qee6y730v7j632u3tzmlwf7g93sakesxc,676,nft1avmxqe8hkguwegrg08ytln6uqx78952w6v9u7vlgjk7s28lypresl5ynah
40,10,xch1rlvkmz9ejvj9kjldpuen4vp3rx225mqxz8djcj73xj9eg5ctf85slcu63h,624,nft1qc2r2p5075xmgnz70ma0vdtglv52mc6tp76fca6v6phmlgwlunwsejnxnn
41,8,xch1f0j2mr4m59z2sunr83jvjn3vx365mjdgkfduclcydnqky4euxppq028mh4,62,nft1tr8s59mqmctvkzv5vaznwylnjlkypjxm30kk4vh5rzmkvmzg02cswxa3h2
42,6,xch1qtqwf5ge7pc6l3w3p6ut995qm3rqayanwdj3lk25vu3wswaaqtlsdk7dlw,602,nft1fg7glk3aqwvk7ddw3854muulccml9lrdvdum6drdhrrsq4ktpw3s9hr9t6
43,4,xch1upez079m8g9cfsvcapttqcu0mq6tvr7zungatv4egl3nfm7lvhlsey0hct,124,nft162p9e0h2agqtkrsldvnwrev9xqh25vryqufugfkcqdy9aju95urqrakl5k
44,2,xch1f8q36eempg0xucs3v3vf5sd9vmwq8u9cjgd2g9x23jnp89smeneqvyu7s9,321,nft1kxte4p7alxazrf5de4kmfxtmhqnwcusswy564qqcktyhe3mcu4sq7sxasw
45,3,xch16jnzufvqt45c8dm2e3v5eenm20pvv0j0l00lgevn3fwr0rlu44ys7sx38w,473,nft1jqlk9q83053d5sfghc6gcwfhwzx04nltctypchw9ykhzg3hhhkfsyecmsa
----------------------------------------------------------------

```
