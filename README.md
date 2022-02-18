# NTF auction

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
```

NOTE: the Auction model was created but it will be implemented
in future iteraction in the app. I will use the auction_id = 1
for this demo

### Development
to open a rails like console execute:

```
bundle exec irb -r ./lib/api.rb
```

## Run App

```
$ bundle exec puma -C puma.rb
```

## Register user

### Request

```
$ curl -H "Content-Type: application/json"  -d '{ "username": "test", "address": "0xF3D713a2Aa684E97de770342E1D1A2e6D65812A7"}' -X POST http://localhost:3300/auction/1/registration
``````

### Response

```
User registered to auction 1
```

NOTE: copy the `access_token` in the headers and add to the next requests.

## Bid

### Resquest

```
$ curl -H "Content-Type: application/json" -H "Access-Token: <access_token>"  -d '{ "amount": 200}' -X POST http://localhost:3300/auction/1/bid
``````

### Response
```
{"id":5,"amount":200.0,"user_id":1,"auction_id":1,"created_at":"2022-02-18T21:13:05.621Z","updated_at":"2022-02-18T21:13:05.621Z"}
```

## Get the action status

### Resquest

```
$ curl -H "Content-Type: application/json" -H "Access-Token: <access_token>" -X GET http://localhost:3300/auction/1/check-status
``````

### Response

```
{"highest_bid":{"amount":200.0,"owner":true},"current_bid":{"amount":200.0}}

```
or

### Resquest

```
$ curl -H "Content-Type: application/json" -X GET http://localhost:3300/auction/1/check-status
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

