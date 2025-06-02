# How to decode OP_RETURN

## Run Electrum Bitcoin client to get the transaction data

Example for MacOS and transaction hash `73ab343cd9535cce67f1cccf4e28fa9a71ef322d0abb4af50df6bbc16c08a6e3`
```
cd /Applications/Electrum.app/Contents/MacOS
./run_electrum --testnet gettransaction "73ab343cd9535cce67f1cccf4e28fa9a71ef322d0abb4af50df6bbc16c08a6e3"
```

You get a long hex: 
```
02000000000101e046e5642861a924e915b65a26c9eec5910150dced51bbfcc0236782d62ea2ee0200000000fdffffff0200000000000000003a6a384c6f72656d20697073756d20646f6c6f722073697420616d65742c20636f6e73656374657475722061646970697363696e6720656c69742ee803000000000000160014756e95201f2e7dc729ec747beb20483ceed37b0e0247304402200b2b516ea9dfda5900e90be4f4d0df854b06ff5f2da1ecd6f5703ae4a1f22ef602203bb882e4ed4411f75f4e661e5b6732ef265a7d5cfc7897229c38c6909772a5a2012103f2b1be08e7beadd2aa124e102b5fda5bc31bc0a1edf0424be9d9331d6a281edcabae4400
```

## Run op_return_decode.sh script to get the ASCII of OP_RETURN

You need to get a substring that starts with `6a`, which stands for `OP_RETURN`.

In this case: 

```
[...]6a1e[data in 30 bytes]
```
as 1e in hex is 30 in decimal

and decode these 30 bytes to ASCII codes.

All of this is done in the `./op_return_decode.sh` script:

```
./op_return_decode.sh "02000000000101e046e5642861a924e915b65a26c9eec5910150dced51bbfcc0236782d62ea2ee0200000000fdffffff0200000000000000003a6a384c6f72656d20697073756d20646f6c6f722073697420616d65742c20636f6e73656374657475722061646970697363696e6720656c69742ee803000000000000160014756e95201f2e7dc729ec747beb20483ceed37b0e0247304402200b2b516ea9dfda5900e90be4f4d0df854b06ff5f2da1ecd6f5703ae4a1f22ef602203bb882e4ed4411f75f4e661e5b6732ef265a7d5cfc7897229c38c6909772a5a2012103f2b1be08e7beadd2aa124e102b5fda5bc31bc0a1edf0424be9d9331d6a281edcabae4400"
```

and you get:

```
OP_RETURN: Lorem ipsum dolor sit amet, consectetur adipiscing elit.
```

# How to encode OP_RETURN in Electrum

## Run op_return_encode.sh script to get HEX from ASCII

```
./op_return_encode.sh "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
```

```
4c6f72656d20697073756d20646f6c6f722073697420616d65742c20636f6e73656374657475722061646970697363696e6720656c69742e
```

## Put HEX value into multi receiver window in Electrum

```
{{btc_wallet_address like tb1qw4hf2gql9e7uw20vw3a7kgzg8nhdx7cwzf6gcg}},1000
script(OP_RETURN 4c6f72656d20697073756d20646f6c6f722073697420616d65742c20636f6e73656374657475722061646970697363696e6720656c69742e), 0
```
