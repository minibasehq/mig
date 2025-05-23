# Commands

## Sqitch commands

Iko aliases all of [Sqitch's commands](https://sqitch.org/docs/manual/).

You can also access `sqitch` directly, for example:

```sh
iko sqitch --version
```

See [the full list of Sqitch's commands](https://sqitch.org/docs/manual/).

## Ad-hoc migrations

If your change is not covered by the below commands, use `add` to crate an
ad-hoc migration, for example:

```sh
add create_customer_view
```

You'll be required to set a note, and then write the deploy, verify and revert
scripts yourself.

> 📖 Refer to [sqitch-add](https://sqitch.org/docs/manual/sqitch-add/).

## Comments

> 📖 Refer to Postgres
> [COMMENT](https://www.postgresql.org/docs/current/sql-comment.html).

### comment

Define or change the comment of an object.

```sh
comment <object> <comment>
```

The last argument is taken as the comment; everything before that is considered
the object.

<h4>Example</h4>

To set a comment on the `api` schema:

```sh
comment schema api 'Schema for the API endpoints'
```

## Extensions

> 📖 Refer to Postgres [CREATE
> EXTENSION](https://www.postgresql.org/docs/current/sql-comment.html).

### create_extension

Install an extension.

```sh
create_extension <extension>
```

<h4>Example</h4>

To create an extension named `pgcrypto`:

```sh
create_extension pgcrypto
```

## Functions

> 📖 Refer to Postgres [CREATE
> FUNCTION](https://www.postgresql.org/docs/current/sql-createfunction.html).

### create_function

Define a new function. Use with `--edit`.

```sh
create_function <function>
```

`<function>` can be schema-qualified.

<h4>Example</h4>

To create a function named `create_user`:

```sh
create_function create_user
```

### create_function_as

Define a new function inline. Useful in scripts.

```sh
create_function_as <function> <sql>
```

`<function>` can be schema-qualified.

<h4>Example</h4>

To define a function named `square`:

```sh
create_function_as square <<'EOF'
create function square(number int) returns int as $$
begin
    return number * number;
end;
$$ language plpgsql;
EOF
```

## Grants

> 📖 Refer to Postgres
> [GRANT](https://www.postgresql.org/docs/current/sql-grant.html).

### grant_execute

Grants execute permission on a function to a role.

```sh
grant_execute <function> <signature> <role>
```

`<function>` can be schema-qualified.

<h4>Example</h4>

To grant execute permission on `login` to `dbuser`:

```sh
grant_execute login '(text,text)' dbuser
```

### grant_schema_usage

Grant schema usage to a role.

```sh
grant_schema_usage <schema> <role>
```

<h4>Example</h4>

To grant usage of the `api` schema to `dbuser`:

```sh
grant_schema_usage api dbuser
```

### grant_role_membership

Grant membership in a role.

```sh
grant_role_membership <role_specification> <role>
```

<h4>Example</h4>

To grant membership in `authenticator` to `dbuser`:

```sh
grant_role_membership authenticator dbuser
```

### grant_table_privilege

Grant privileges on a table.

```sh
grant_table_privilege <type> <table> <role>
```

`<table>` can be schema-qualified.

<h4>Example</h4>

To allow an `dbuser` to insert into the `asset` table:

```sh
grant_privilege insert asset dbuser
```

## Roles

> 📖 Refer to Postgres [CREATE
> ROLE](https://www.postgresql.org/docs/current/sql-createrole.html).

### create_role

Creates a `nologin` role.

```sh
create_role <role>
```

<h4>Example</h4>

To create a `dbuser` role:

```sh
create_role dbuser
```

### create_login_role

Creates a login role with a password.

```sh
create_login_role <role> <password>
```

<h4>Example</h4>

To create a `dbuser` role with password, `securepass123`:

```sh
create_login_role dbuser 'securepass123'
```

## Schemas

> 📖 Refer to Postgres [CREATE
> SCHEMA](https://www.postgresql.org/docs/current/sql-createschema.html).

### create_schema

Enter a new schema into the database.

```sh
create_schema <schema>
```

<h4>Example</h4>

To create a schema named `api`:

```sh
create_schema api
```

## Tables

> 📖 Refer to Postgres [CREATE
> TABLE](https://www.postgresql.org/docs/current/sql-createtable.html).

### create_table

Generates a migration to create a table. Use with `--edit`.

```sh
create_table <table>
```

`<table>` can be schema-qualified.

<h4>Example</h4>

To create a table named `customer`:

```sh
create_table customer
```

The editor is launched for you to edit the function.

### create_table_as

Create a new table in the database, inline. Useful in scripts.

```sh
create_table_as <table> <sql>
```

`<table>` can be schema-qualified.

<h4>Example</h4>

To create a table named `customer`:

```sh
create_table_as customer <<'EOF'
create table customer (
  id bigint generated always as identity primary key,
  created_at timestamp not null default now(),
  name text not null
);
EOF
```

## Triggers

> 📖 Refer to Postgres [CREATE
> TRIGGER](https://www.postgresql.org/docs/current/sql-createtrigger.html).

### create_trigger

Create a trigger on a table.

```sh
create_trigger <trigger> <table> <function>
```

`<table>` and `<function>` can be schema-qualified.

Note: Don't schema-qualify the `<trigger>`. From the Postgres docs:

> The name cannot be schema-qualified — the trigger inherits the schema of its
> table.

<h4>Example</h4>

To create a trigger named `customer_updated` that fires before updating a row
in `customer`, calling `customer_updated`:

```sh
create_trigger customer_updated customer customer_updated
```

### create_trigger_as

Create a trigger on a table, inline.

```sh
create_trigger_as <trigger> <table> <sql>
```

`<table>` can be schema-qualified.

<h4>Example</h4>

Create a trigger `modify` on table `contact` calling `modify_record`:

```sh
create_trigger_as modify contact <<'EOF'
create trigger modify
  after insert or update on contact
  for each row execute function modify_record();
EOF
```
