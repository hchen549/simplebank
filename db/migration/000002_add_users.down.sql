Alter TABLE if exists "accounts" drop constraint if exists "owner_currency_key";

Alter Table if exists "accounts" drop constraint if exists "accounts_owner_fkey" ;

drop table if exists "users";

