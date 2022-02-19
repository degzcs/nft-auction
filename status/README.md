# NTF auction

The Ethereum NFT auction allows individuals to make bids on purchasing a *rare* single Ethereum NFT (lets call it the Sardine NFT). The APIs functionality consists of:

- registration - allow the user to register themselves to use the platform
- - bid - place bids in USD for the NFT.
- - view - returns the current highest bid.
-
- This API will use `JSON` for it's request/responses.


requirements are [here] (https://sardine.notion.site/for-candidate-Sardine-Ethereum-NFT-Auction-152a7c67822f40e6b435f1aca4578811)

## Installation

install gems
```
$ bundle install
```
copy your public and prive key in the `config` folder

update the env variables in the `config/application.yml` file

NOTE: this is going to use the BID database

NOTE: the Auction model was created but it will be implemented
in future iteraction in the app. I will use the auction_id = 1
for this demo

### Development
to open a rails like console execute:

```
$ bundle exec irb -r ./config/environment.rb
```

## Run App

```
$ bundle exec puma -C ./config/puma.rb
```

## Get the action status

NOTE: user the `access_token` from registrtion service
Default Port is 3302

### Resquest

```
$ curl -H "Content-Type: application/json" -H "Access-Token: <access_token>" -X GET http://localhost:3302/auction/1/check-status
``````

### Response

```
{"highest_bid":{"amount":200.0,"owner":true},"current_bid":{"amount":200.0}}

```
or

### Resquest

```
$ curl -H "Content-Type: application/json" -X GET http://localhost:3302/auction/1/check-status
``````

### Response

```
{"highest_bid":{"amount":200.0,"owner":false}}
```

## Run Tests

```
rspec spec
```

## Improve

- Create Auction logic and endpoints

## Contributos

- Diego Gomez

