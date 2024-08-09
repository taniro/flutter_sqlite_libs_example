import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:flutter_sqlite_libs_example/domain/livro.dart';



import '../../repository/livro_dao.dart';


part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Livro])
abstract class AppDatabase extends FloorDatabase {
  LivroDao get livroDao;
}