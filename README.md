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

```
$ curl -H "Content-Type: application/json"  -d '{ "username": "test", "address": "0xF3D713a2Aa684E97de770342E1D1A2e6D65812A7"}' -X POST http://localhost:3300/auction/1/registration
``````

NOTE: copy the `access_token` in the headers and add to the next requests.

## Bid

```
$ curl -H "Content-Type: application/json" -H "Access-Token: <access_token>"  -d '{ "amount": 100}' -X POST http://localhost:3300/auction/1/bid
``````

## Get the action status

```
$ curl -H "Content-Type: application/json" -H "Access-Token: <access_token>" -X GET http://localhost:3300/auction/1/check-status
``````
or

```
$ curl -H "Content-Type: application/json" -H "Access-Token: <access_token>" -X GET http://localhost:3300/auction/1/check-status
``````

## Run Tests

```
rspec spec
```

## Improve

- Create Auction logic and endpoints

## Contributos

- Diego Gomez

