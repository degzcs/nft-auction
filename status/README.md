# Status service

Returns the current highest bid

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

