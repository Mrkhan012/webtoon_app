import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/webtoon.dart'; // Import your Webtoon model

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  DatabaseService._internal();

  factory DatabaseService() => _instance;

  // Getter for the database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // Initialize the database and create the 'favorites' table
  Future<Database> _initDB() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'favorites.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY,
            title TEXT,
            imageUrl TEXT,
            description TEXT,
            rating REAL
          )
        ''');
      },
    );
  }

  // Insert a favorite webtoon into the database
  Future<void> insertFavorite(Webtoon webtoon) async {
    final db = await database;
    await db.insert(
      'favorites',
      {
        'id': webtoon.id,
        'title': webtoon.title,
        'imageUrl': webtoon.imageUrl,
        'description': webtoon.description,
        'rating': webtoon.rating,
      },
      conflictAlgorithm: ConflictAlgorithm.replace, // In case of duplicate IDs
    );
  }

  // Fetch all favorite webtoons from the database
  Future<List<Webtoon>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');

    // Convert the List<Map<String, dynamic>> to List<Webtoon>
    return List.generate(maps.length, (i) {
      return Webtoon(
        id: maps[i]['id'],
        title: maps[i]['title'],
        imageUrl: maps[i]['imageUrl'],
        description: maps[i]['description'],
        rating: maps[i]['rating'],
      );
    });
  }

  // Delete a favorite webtoon by ID
  Future<void> deleteFavorite(int id) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
