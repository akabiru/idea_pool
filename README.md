# Idea Pool REST API :bulb:

Idea Pool is a service that records your ideas! After signing up for an account, users can log their ideas and assign them scores.
Every idea contains 3 scores: Impact, Ease and Confidence. Each idea can be added, edited and deleted.
All the ideas will be sorted by the average of all three scores. Every API call will return 10 ideas.
When not using the service, users can log out of the system.

* [Getting Started](#getting-started)
* [Dependencies](#dependencies)
* [Tests](#tests)
* [API Endpoints](#api-endpoints)
* [Responses](#responses)
* [Error handling](#error-handling)
* [Versions](#versions)
* [Request & Response Examples](#request--response-examples)
* [Contributing](#contributing)

## Getting Started

Clone the repository:

```sh
$ git clone https://github.com/akabiru/idea_pool && cd $_
```

Install the dependencies

```sh
$ bundle install
```

Setup the database & Redis store:

```
$ bundle exec rails db:setup
$ brew services start redis # on MacOS
```

The above will get you a copy of the project up and running on your local machine for development and testing purposes.

### Dependencies

  1. [Ruby](https://github.com/rbenv/rbenv)
  2. [PostgreSQL](http://www.postgresql.org/download/macosx/)
  3. [Bundler](http://bundler.io/)
  4. [Ruby on Rails](http://guides.rubyonrails.org/getting_started.html#installing-rails)
  5. [RSpec](http://rspec.info/)

## Tests

```sh
$ bundle exec rspec -fd
```

## API Endpoints

    $ http https://infinite-dusk-17447.herokuapp.com/ideas Authorization: "Bearer eyJ0eXAiOiJ..."

| EndPoint                                |   Functionality                      |
| --------------------------------------- | ------------------------------------:|
| POST /users                            | Signup a user                        |
| POST /access-tokens                       | Login user                         |
| POST /access-tokens/Refresh                | Refresh token **(Header X-Refresh-Token)** |
| DELETE /access-tokens                        | Logout user                          |
| POST /ideas                      | Create a new bucket list             |
| GET /ideas/                       | List all the created bucket lists    |
| GET /ideas?page=1&limit=5         | List five ideas from page 1    |
| GET /ideas/:id                    | Get single idea               |
| PUT /ideas/:id                    | Update this idea               |
| DELETE /ideas/:id                 | Delete this single idea        |

### Auth API

_POST /signup_

```sh
$ echo '{"email": "jack-black@codementor.io","name": "Jack Black","password": "the-Secret-123"}' | http https://infinite-dusk-17447.herokuapp.com/users
```

_POST /access-tokens (Login)_

```sh
$ echo '{"email": "jack-black@codementor.io","password": "the-Secret-123"}' | http https://infinite-dusk-17447.herokuapp.com/access-tokens
```

_POST /access-tokens/refresh_

```sh
$ http POST https://infinite-dusk-17447.herokuapp.com/access-tokens/refresh X-Refresh-Token: 'ashdahskjdhak....'
```

_DELETE /access-tokens (Logout)_

```sh
$ http DELETE https://infinite-dusk-17447.herokuapp.com/access-tokens X-Refresh-Token: 'ashdahskjdhak....'
```

### Ideas API

_POST /ideas_

```sh
$ echo '{"content": "the-content","impact": 8,"ease": 8,"confidence": 8}' | http POST https://infinite-dusk-17447.herokuapp.com/ideas Authorization: 'Bearer hajsdhkasd'
```

_GET /ideas_

```sh
$ http https://infinite-dusk-17447.herokuapp.com/ideas page==1 Authorization: 'Bearer hajsdhkasd'
```

_GET /ideas/:id_

```sh
$ http https://infinite-dusk-17447.herokuapp.com/ideas/1 Authorization: 'Bearer hajsdhkasd'
```

_PUT /ideas/:id_

```sh
$ echo '{"impact": 10}' | http PUT https://infinite-dusk-17447.herokuapp.com/ideas/1 Authorization: 'Bearer hajsdhkasd'
```

_DELETE /ideas/:id_

```
$ http DELETE https://infinite-dusk-17447.herokuapp.com/ideas/1 Authorization: 'Bearer hajsdhkasd'
```

## Responses

The API responds with JSON data by default.

## Error Handling

The API responds with an error message and http status code whenenever it encounters an error.

    {
      "message": "Signature has expired"
    }

## Versions

TODO:

## Request & Response examples

Request GET /ideas?page=2&limit=2

     $ http https://infinite-dusk-17447.herokuapp.com/ideas?page=2&limit=2 \
     Authorization: 'Bearer eyJ0eXAiOiJKV...'

Response (application/json)

    [
      {
        "id": 1,
        "confidence": 8,
        "ease": 8,
        "impact": 8,
        "content": "Idea",
        "user_id": 2,
        "created_at": "2018-08-30T10:08:08.876Z",
        "updated_at": "2018-08-30T10:08:08.904Z",
        "average_score": 8.0
      },
      {
        "id": 2,
        "confidence": 8,
        "ease": 8,
        "impact": 8,
        "content": "Idea",
        "user_id": 2,
        "created_at": "2018-08-30T10:08:10.646Z",
        "updated_at": "2018-08-30T10:08:10.649Z",
        "average_score": 8.0
      },
    ]

## Contributing

1. Fork it! :fork_and_knife:
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git add -A && git commit -m 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature` :rocket:
5. Submit a pull request :sunglasses:

## License

This project is licensed under the MIT License - see the [LICENSE.md](https://opensource.org/licenses/MIT) file for details
