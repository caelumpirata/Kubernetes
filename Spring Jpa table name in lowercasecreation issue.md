# How to create the table name same as you write in @Table | `postgresql` | `Spring JPA`

write your column/table name inside `"\"replace_me\""` if it contains any Uppercase letter in it.

> example
> Dog -> Dog
> CAt -> CAt
> noob -> noob

add this in `application.properties` file
```
spring.jpa.hibernate.naming.physical-strategy=org.hibernate.boot.model.naming.PhysicalNamingStrategyStandardImpl
```
add this in `ExampleTable.java`
```
@Table(name = "\"bacnet_Single_Row_Data\"") 
```
this will create table name `bacnet_Single_Row_Data`



## source:
```
https://stackoverflow.com/questions/29087626/entity-class-name-is-transformed-into-sql-table-name-with-underscores
```
