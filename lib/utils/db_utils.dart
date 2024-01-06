import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;


class DbUtil {
  // método assíncrono
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
        path.join(dbPath,
            'app-financas-ui.db'
        ),
        onCreate: (db, version) {
          _createDb(db);
        },
        version: 1
    );
  }

  static void _createDb(sql.Database db) {
    db.execute("""
      CREATE TABLE conta(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome VARCHAR(50), 
        valor REAL
       )
    """);
  }

  static Future<void> insereDados(String table, Map<String, dynamic> dados) async {
    final db = await DbUtil.database();
    await db.insert(
      table,
      dados,
      conflictAlgorithm: sql.ConflictAlgorithm.replace
    );
  }
}