import 'package:password_manager/database/models/model_add_account.dart';
import 'package:password_manager/database/settings.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AccountRepository {
  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) async {
        var dbAccount = await db.execute(CREATE_ACCOUNTS_TABLE_SCRIPT);
        return dbAccount;
      },
      version: 1,
    );
  }

  Future createAccount(int id, int categoryId, String image, String link,
      String contact, String password) async {
    try {
      final Database db = await _getDatabase();

      bool hasDigits = RegExp(r'\d').hasMatch(password);
      bool hasPunct =
          RegExp(r'[!@#<>?.":_`~;[\]\\|=+)(*&^%$£]').hasMatch(password);
      bool hasUpper = RegExp(r'[A-Z]').hasMatch(password);

      late var securityTest = 0;

      if (hasDigits == true && hasPunct == true) {
        securityTest = 2;
      }
      if (hasDigits == true && hasUpper == true) {
        securityTest = 2;
      }

      if (hasPunct == true && hasUpper == true) {
        securityTest = 2;
      }

      if (hasDigits == true && hasPunct == true && hasUpper == true) {
        securityTest = 1;
      }

      final model = AccountModel(
          id: id,
          categoryId: categoryId,
          image: image,
          link: link,
          contact: contact,
          password: password,
          security: securityTest);

      await db.insert(
        TABLE_NAME_ACCOUNT,
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      return;
    }
  }

  Future<List<Object>> getAccounts() async {
    try {
      final Database db = await _getDatabase();

      List<Map> list = await db.query(TABLE_NAME_ACCOUNT);

      return list;
    } catch (ex) {
      return <AccountModel>[];
    }
  }

  Future getAccountsSecurityLevelOne() async {
    try {
      final Database db = await _getDatabase();

      const term = 1;

      List<Map> list = await db.query(
        TABLE_NAME_ACCOUNT,
        where: "security LIKE ?",
        whereArgs: [
          '%$term%',
        ],
      );

      int length = list.length;

      return length;
    } catch (ex) {
      return 0;
    }
  }

  Future getAccountsSecurityLevelTwo() async {
    try {
      final Database db = await _getDatabase();

      const term = 2;

      List<Map> list = await db.query(
        TABLE_NAME_ACCOUNT,
        where: "security LIKE ?",
        whereArgs: [
          '%$term%',
        ],
      );

      int length = list.length;

      return length;
    } catch (ex) {
      return 0;
    }
  }

  Future getAccountsSecurityLevelZero() async {
    try {
      final Database db = await _getDatabase();

      const term = 0;

      List<Map> list = await db.query(
        TABLE_NAME_ACCOUNT,
        where: "security LIKE ?",
        whereArgs: [
          '%$term%',
        ],
      );

      int length = list.length;

      return length;
    } catch (ex) {
      return 0;
    }
  }

  Future<List<Object>> search(String term) async {
    try {
      final Database db = await _getDatabase();

      List<Map> list = await db.query(
        TABLE_NAME_ACCOUNT,
        where: "contact LIKE ?",
        whereArgs: [
          '%$term%',
        ],
      );
      if (list.isEmpty) {
        List<Map> listSearchByLink = await db.query(
          TABLE_NAME_ACCOUNT,
          where: "link LIKE ?",
          whereArgs: [
            '%$term%',
          ],
        );
        return listSearchByLink;
      }
      return list;
    } catch (ex) {
      return <AccountModel>[];
    }
  }

  Future<AccountModel> getAccount(int id) async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(
        TABLE_NAME_ACCOUNT,
        where: "id = ?",
        whereArgs: [id],
      );

      return AccountModel(
          id: maps[0]['id'],
          categoryId: maps[0]['categoryId'],
          image: maps[0]['image'],
          link: maps[0]['link'],
          contact: maps[0]['contact'],
          password: maps[0]['password'],
          security: maps[0]['security']);
    } catch (ex) {
      return AccountModel(
          id: 0,
          categoryId: 0,
          image: '',
          link: '',
          contact: '',
          password: '',
          security: 0);
    }
  }

  Future deleteAccount(int id) async {
    try {
      final Database db = await _getDatabase();
      await db.delete(
        TABLE_NAME_ACCOUNT,
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (ex) {
      return;
    }
  }

  Future updateAccount(int id, int categoryId, String image, String link,
      String contact, String password) async {
    try {
      final Database db = await _getDatabase();
      final model = await getAccount(id);

      bool hasDigits = RegExp(r'\d').hasMatch(password);
      bool hasPunct =
          RegExp(r'[!@#<>?.":_`~;[\]\\|=+)(*&^%$£]').hasMatch(password);
      bool hasUpper = RegExp(r'[A-Z]').hasMatch(password);

      late var securityTest = 3;

      if (hasDigits == true && hasPunct == true) {
        securityTest = 2;
      }
      if (hasDigits == true && hasUpper == true) {
        securityTest = 2;
      }

      if (hasPunct == true && hasUpper == true) {
        securityTest = 2;
      }

      if (hasDigits == true && hasPunct == true && hasUpper == true) {
        securityTest = 1;
      }

      model.categoryId = categoryId;
      model.image = image;
      model.link = link;
      model.contact = contact;
      model.password = password;
      model.security = securityTest;

      await db.update(
        TABLE_NAME_ACCOUNT,
        model.toMap(),
        where: "id = ?",
        whereArgs: [model.id],
      );
    } catch (ex) {
      return;
    }
  }
}
