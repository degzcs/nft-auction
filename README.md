# NFT auction

The Ethereum NFT auction allows individuals to make bids on purchasing a *rare* single Ethereum NFT (lets call it the Sardine NFT). The APIs functionality consists of:

- registration - allow the user to register themselves to use the platform
- bid - place bids in USD for the NFT.
- view - returns the current highest bid.
- This API will use `JSON` for it's request/responses.


The requirements are [here](https://sardine.notion.site/for-candidate-Sardine-Ethereum-NFT-Auction-152a7c67822f40e6b435f1aca4578811)

### Installation

You can go to the next links to install each service

- Register [Readme](register/README.md)
- Bid [Readme](bid/README.md)
- Status [Readme](status/README.md)

### Running services

#### As Individuals

Go to each service and execute in diferent terminals

```
$ bundle exec puma -C .config/puma.rb
```

![image](https://user-images.githubusercontent.com/3716432/154773994-fcc74ea6-97e6-43df-b8eb-ca264d0fdbfc.png)

#### Foreman

```
$ gem install foreman
$ foremna start
```
![image](https://user-images.githubusercontent.com/3716432/154775688-3ad5501b-280b-488e-933f-7552f5e70f80.png)



