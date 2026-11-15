# A3 · Generic data access

## A3.1

Open connection, prepare parameterized SQL, bind values, execute, map a result if applicable, and close result, statement and connection. Table/column names, parameter order, keys and field mapping vary. A shared connection provider can encapsulate configuration and pooling while each DAO owns its statements and row mapper.

## A3.2

Dao<T,K> declares insert(T), findById(K), findAll(), update(T) and delete(K). StudentDao implements Dao<Student,String> and returns Optional for absent rows. It binds SQL values by type and uses try-with-resources. Update/delete report whether one row was affected. The generic interface describes operations rather than trying to construct SQL from type parameters.

## A3.3

| Java | Column | Type |
|---|---|---|
| registration | reg_no | VARCHAR(20), primary key |
| name | name | VARCHAR(100), NOT NULL |

A UI with direct SQL must change every query and mapping referencing a renamed column. The DAO localizes these edits to its queries and mapping. The number may still be several statements in that DAO. Identical SQL plans cost the same asymptotically. An indexed lookup is roughly O(log n) database index work and O(1) result space for one row, plus network round trip. findAll is O(n) row work, transfer and materialized space. A DAO call adds constant local overhead.
