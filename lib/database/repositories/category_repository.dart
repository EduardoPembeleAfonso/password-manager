import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// settings
import 'package:password_manager/database/settings.dart';

// models
import 'package:password_manager/database/models/model_category.dart';

class CategoryRepository {
  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) async {
        await db.execute(CREATE_ACCOUNTS_TABLE_SCRIPT);
        var dbCategory = await db.execute(CREATE_CATEGORYS_TABLE_SCRIPT);
        return dbCategory;
      },
      version: 1,
    );
  }

  Future createCategory(int idC, String nameC, String imageC) async {
    try {
      final Database db = await _getDatabase();

      final model = CategoryModel(
        id: idC,
        name: nameC,
        image: imageC,
      );

      await db.insert(
        TABLE_NAME,
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

    } catch (ex) {
      return;
    }
  }

  Future<void> deleteDatabase() async {
    // Obtenha o caminho do banco de dados
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + DATABASE_NAME;

    // Exclua o banco de dados
    await databaseFactory.deleteDatabase(path);
  }

  Future<List<Object>> getCategorys() async {
    try {
      final Database db = await _getDatabase();
      List<Map> list = await db.query(TABLE_NAME);

      // await deleteDatabase();

      return list;
    } catch (ex) {
      return <CategoryModel>[];
    }
  }

  Future<List<CategoryModel>> search(String term) async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(
        TABLE_NAME,
        where: "name LIKE ?",
        whereArgs: [
          '%$term%',
        ],
      );

      return List.generate(
        maps.length,
        (i) {
          return CategoryModel(
            id: maps[i]['id'],
            name: maps[i]['name'],
            image: maps[i]['image'],
          );
        },
      );
    } catch (ex) {
      return <CategoryModel>[];
    }
  }

  Future<CategoryModel> getCategory(int id) async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(
        TABLE_NAME,
        where: "id = ?",
        whereArgs: [id],
      );

      return CategoryModel(
        id: maps[0]['id'],
        name: maps[0]['name'],
        image: maps[0]['image'],
      );
    } catch (ex) {
      return CategoryModel(id: 0, image: '', name: '');
    }
  }

  Future<List<Object>> getAllAccountOfCategory(int id) async {
    try {
      final Database db = await _getDatabase();
      List<Map> list = await db.query(
        TABLE_NAME_ACCOUNT,
        where: "categoryId = ?",
        whereArgs: [id],
      );
      return list;
    } catch (ex) {
      return <CategoryModel>[];
    }
  }

  Future deleteCategory(int id) async {
    try {
      final Database db = await _getDatabase();
      await db.delete(
        TABLE_NAME,
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (ex) {
      return;
    }
  }

  Future updateCategory(int id, String name, String image) async {
    try {
      final Database db = await _getDatabase();
      final model = await getCategory(id);

      model.name = name;
      model.image = image;

      await db.update(
        TABLE_NAME,
        model.toMap(),
        where: "id = ?",
        whereArgs: [model.id],
      );
      var list = [model.name, model.image];
      return list;
    } catch (ex) {
      return;
    }
  }
}
