# README

### Requirements
ruby 2.6.6

### Build
```
bundle install
bundle exec rails db:setup
```

### Run
```
bundle exec rails s


# in a another terminal
# test first payload format
curl -vX POST http://localhost:3000/reservations.json -d @payload1.json --header "Content-Type: application/json"

# test second payload format
curl -vX POST http://localhost:3000/reservations.json -d @payload2.json --header "Content-Type: application/json"
```

### Test

`bundle exec rails test`
