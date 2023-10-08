const String DATABASE_NAME = "password_manager.db";
const String TABLE_NAME = "category";
const String TABLE_NAME_ACCOUNT = "account";
const String CREATE_CATEGORYS_TABLE_SCRIPT =
    "CREATE TABLE category(id INTEGER PRIMARY KEY,name TEXT, image TEXT)";

const String CREATE_ACCOUNTS_TABLE_SCRIPT =
    "CREATE TABLE account(id INTEGER PRIMARY KEY, categoryId INTEGER, link TEXT, image TEXT, contact TEXT, password TEXT)";
