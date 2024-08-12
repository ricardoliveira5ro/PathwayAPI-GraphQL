# PathwayAPI (GraphQL)

`---will-be-here-soon` hosts a public instance of the API. 

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