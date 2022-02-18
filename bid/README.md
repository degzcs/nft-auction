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

run migrations

```
$ rake db:migrate
$ RACK_ENV=test rake db:migrate
```

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

NOTE: use the `access_token` registation service

## Bid

### Resquest

```
$ curl -H "Content-Type: application/json" -H "Access-Token: <access_token>"  -d '{ "amount": 200}' -X POST http://localhost:3300/auction/1/bid
``````

### Response
```
{"id":5,"amount":200.0,"user_id":1,"auction_id":1,"created_at":"2022-02-18T21:13:05.621Z","updated_at":"2022-02-18T21:13:05.621Z"}
```

## Run Tests

```
rspec spec
```

## Improve

- Create Auction logic and endpoints

## Contributos

- Diego Gomez

