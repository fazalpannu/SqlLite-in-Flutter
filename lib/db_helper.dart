import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'card.dart'; // Import the path package

class dbhelper {
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initdatabase();
  }

  initdatabase() async {
    io.Directory documentdirectory = await getApplicationDocumentsDirectory();

    String path1 = join(documentdirectory.path, 'cart.db');
    var db = await openDatabase(
      path1,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart (id INTEGER PRIMARY KEY , productId VARCHAR UNIQUE,productName TEXT,initialPrice INTEGER, productPrice INTEGER , quantity INTEGER, unitTag TEXT , image TEXT )');
  }

  Future<Cart> insert(Cart cart) async {
    var dbclient = await db;
    await dbclient!.insert('cart', cart.toMap());
    return cart;
  }

  Future<List<Cart>> getcartlist() async {
    var dbclient = await db;
    final List<Map<String, Object?>> dbresult = await dbclient!.query('cart');
    return dbresult.map((e) => Cart.fromMap(e)).toList();
  }
}
