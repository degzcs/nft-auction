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
$ RAKE_ENV=test rake db:migrate
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

## Register user
Default Port is 3300

### Request

```
$ curl -H "Content-Type: application/json"  -d '{ "username": "test", "address": "0xF3D713a2Aa684E97de770342E1D1A2e6D65812A7"}' -X POST http://localhost:3300/registration
``````

### Response

```
User was registered
```

NOTE: copy the `access_token` in the headers and add to the next requests.

## Run Tests

```
rspec spec
```

## Improve

- Create Auction logic and endpoints

## Contributos

- Diego Gomez

