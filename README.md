# PathwayAPI (GraphQL)

`pathwayapi-graphql.onrender.com` hosts a public instance of the API. 

> [!Important]
> Please notice this API serves the same purpose of the original one, but with a different architecture. You can find everything you need to know in this [repository](https://github.com/ricardoliveira5ro/PathwayAPI/blob/master/README.md)
<br/>

## 🚀 Getting Started

#### 🔐 Authentication / Authorization

Each endpoint requires prior authentication based on bearer token. This token can be obtained after signing up and/or logging and it will be needed as authorization header in every request you make.

**Register**
```
mutation Register {
    register(email: "test@example.com", password: "1234567890") {
        user {
            id
            email
            createdAt
        }
        success
        errors {
            fullMessages
        }
    }
}
```

**Login**
```
mutation Login {
    login(email: "test@example.com", password: "1234567890") {
        errors
        success
        token
    }
}
```

---

#### 🔍 Query
Use queries to obtain one object or a list of objects, like Roadmaps, Categories and Steps

```
query Roadmaps {
    roadmaps {
        id
        description
        title
        completed
        categories {
            id
            name
        }
        steps {
            id
            completed
            description
            order
            roadmapId
            title
        }
    }
}
```

---

#### 🧬 Mutations
Use mutations to create or modify an object, like Roadmaps, Steps and Tracking Steps

```
mutation CreateRoadmap {
    createRoadmap(
        title: "New Roadmap"
        description: "New Roadmap Description"
        categoryIds: [7, 8]
        steps: [
            { title: "First Step", description: "First Description Step", order: 1 },
            { title: "Second Step", description: "Second Description Step", order: 2 }
        ]
    ) {
        success
        errors {
            details
            fullMessages
        }
        roadmap {
            id
            title
            description
            categories {
                id
                name
            }
            steps {
                id
                title
                description
                order
            }
        }
    }
}
```

<br/>

## 💻 Technical Details

This section is for the developers who want to explore the technical characteristics of the API.

#### 🛠️ Tech stack

* Ruby (v3)
* Ruby on rails (v7)
* Postgresql
* graphql (gem)
* jwt (gem)

#### 🚀 Run

* Run `bundle install`
* Create the user/role in your local postgres database
* Edit your *database.yml* to include your local database information provided by your keys in *credentials.yml.enc*
* Run `rails db:create` and `rails db:migrate` (every time there is a change in your schema)
* Edit your *seeds.rb* file to include any preloaded data and run `run db:seed`
* Start the server `rails s`

#### 💭 Considerations

* Postgre database (shared with the original PathwayAPI)
* Webservice hosted in *render.com*
* Use of *Postman* or any other graphql interpreter recommended to check all the queries and mutations available