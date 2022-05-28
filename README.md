# FX Transaction API

A microservice to store FX transactions. These transactions will store how much money we will receive from our customers in the input currency, and how much we will pay them out in the output currency.

### Specification summary:

- RESTful api.
- JSON response
- Api versioning.
- Exception Handling
- Pagination
- Cached index.
- RSpec testing.

### Requirements

- Ruby version 3.0.1

- Rails version 6.1.6

### Installation

- Clone the repository and get inside it:

```
git clone git@github.com:JamesOkunlade/fx-transactions-api.git

cd fx-transactions-api
```

- Install all gems:

```
bundle install
```

- Setup database:

```
rake db:setup
```

- Run tests

```
bundle exec rspec
```

- Install [Httpie](https://httpie.io/cli) to use in testing endpoints locally from the terminal

```
# For Mac
$ brew install httpie

# Linux
$ apt install httpie
```


### API Endpoints

| API Endpoint                      | Functionality                           |
| ----------------------------------| --------------------------------------- |
| POST /transactions         | Creates a new transaction                   |
| GET /transactions     | Fetches a list of transactions   |
| GET /transactions/:id     | Fetches a transaction by id   |


### Testing API locally from terminal using the Httpie

```ruby
# To get all transactions
http :3000/transactions

# To get a transaction by Id
http :3000/transactions/<:id>

# To create a new transaction
http POST :3000/transactions created_by_id=123 input_amount_currency=USD input_amount_cents=1000_00 output_amount_currency=NGN output_amount_cents=570000_00 date_of_transaction="Fri, 27 May 2022 15:51:15 +0100"
```

### Caching is disabled by default in development enviroment so you should toggle to test caching locally

```
rails dev:cache
```


## Author

James Okunlade

- [LinkedIN](https://www.linkedin.com/in/james-okunlade/)
- [Github](https://github.com/JamesOkunlade)
- [Twitter](https://twitter.com/JamesOkunlade)