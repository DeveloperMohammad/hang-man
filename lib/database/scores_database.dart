import 'dart:io';

import 'package:hang_man/model/score.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ScoreDatabase {
  ScoreDatabase._instance();
  static final ScoreDatabase instance = ScoreDatabase._instance();
  factory ScoreDatabase() => instance;

  static Database? _db;

  Future<Database> get db async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path + '/scores.db');
    final scoresDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return scoresDatabase;
  }

  /// save column names as static const Strings
  static const String scoreTable = 'score';
  static const String colId = 'id';
  static const String colDate = 'date';
  static const String colScore = 'score';

  void _createDb(Database db, int version) async {
    await db.execute('''CREATE TABLE $scoreTable(
      $colId INTEGER PRIMARY KEY AUTOINCREMENT,
      $colDate STRING NOT NULL,
      $colScore INTEGER NOT NULL)''');
  }

  Future<List<Map<String, dynamic>>> getScoreMapList() async {
    final db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(scoreTable);
    return result;
  }

  /// CREATE
  Future<void> insertScore({
    required Score score,
  }) async {
    final db = await this.db;
    final result = await db
        .query(scoreTable, where: 'score = ?', whereArgs: [score.score]);
    if (result.isEmpty) {
      await db.insert(
        scoreTable,
        score.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      await db.update(
        scoreTable,
        score.toMap(),
        where: '$colScore = ?',
        whereArgs: [score.score],
      );
    }
  }

  /// READ
  Future<List<Score>> getScoreList() async {
    final List<Map<String, dynamic>> scoreMapList = await getScoreMapList();
    final List<Score> scoresList = [];
    for (var score in scoreMapList) {
      scoresList.add(Score.fromMap(score));
    }
    scoresList.sort((scoreA, scoreB) => scoreB.score.compareTo(scoreA.score));
    return scoresList;
  }

  /// UPDATE
  Future<int> updateScores({required Score score}) async {
    final db = await this.db;
    final updateCount = await db.update(
      scoreTable,
      score.toMap(),
      where: '$colId = ?',
      whereArgs: [score.id],
    );
    return updateCount;
  }

  /// DELETE
  Future<int> deleteScores({required int id}) async {
    final db = await this.db;
    final deleteCount = await db.delete(
      scoreTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return deleteCount;
  }

  Future<int> deleteAllScores() async {
    final db = await this.db;
    final deleteCount = await db.delete(scoreTable);
    return deleteCount;
  }
}
