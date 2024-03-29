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

    db.execute("""
      CREATE TABLE operacao(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome VARCHAR(50), 
        resumo VARCHAR(100),
        tipo VARCHAR(20),
        data DATETIME,
        conta INTEGER,
        custo REAL,
        FOREIGN KEY(conta) REFERENCES conta(id)
      )    
    """);
  }

  static Future<void> insereDados(String table, Map<String, dynamic> dados) async {
    final db = await DbUtil.database();
    int qtdeRegistros = await db.insert(
      table,
      dados,
      conflictAlgorithm: sql.ConflictAlgorithm.replace
    );
    print("[$table] -> $qtdeRegistros registros");
  }

  static Future<List<Map<String, dynamic>>> getDados(String tabela) async {
    final db = await DbUtil.database();
    return db.query(tabela);
  }

  static Future<List> getDataWhere(String table, String whereString, List<dynamic> whereArgs) async {
    final db = await DbUtil.database();
    final data = await db.query(
      table,
      where: whereString,
      whereArgs: whereArgs,
    );
    return data.toList();
  }

  static Future<void> executaSQL (String sql, List<dynamic> args) async {
    final db = await DbUtil.database();
    db.rawUpdate(sql, args);
  }
}