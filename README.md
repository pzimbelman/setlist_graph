## Concert Setlist GraphQL API

This project is an experiment with GraphQL. I have a database of concert setlists that I've pulled together and I decided to try and build a simple GraphQL API on top of the database. More details will come as I continue to build on it but for now, it supports a couple of basic queries as described below:


**Get the last 20 shows performed by a band:**
```
query={ band(slug: "phish") {
     name
     slug
     performances(limit: 20) {
       date
       first_set
       second_set
       encore
       venue {
         name
         city
         state
       }
     }
 }}
```

**Get a single performance for a band on a particular date:**

```
query={ performance(band: "phish", date: "2009-12-02") {
     date
     first_set
     second_set
     encore
     venue {
       name
       city
       state
     }
 }}
```
