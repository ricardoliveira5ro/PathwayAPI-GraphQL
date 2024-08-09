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