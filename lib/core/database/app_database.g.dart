// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  LivroDao? _livroDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Livro` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  LivroDao get livroDao {
    return _livroDaoInstance ??= _$LivroDao(database, changeListener);
  }
}

class _$LivroDao extends LivroDao {
  _$LivroDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _livroInsertionAdapter = InsertionAdapter(
            database,
            'Livro',
            (Livro item) =>
                <String, Object?>{'id': item.id, 'title': item.title},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Livro> _livroInsertionAdapter;

  @override
  Future<List<Livro>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Livro',
        mapper: (Map<String, Object?> row) =>
            Livro(row['id'] as int?, row['title'] as String));
  }

  @override
  Stream<List<String>> findAllLivroTitle() {
    return _queryAdapter.queryListStream('SELECT titulo FROM Livro',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        queryableName: 'Livro',
        isView: false);
  }

  @override
  Stream<Livro?> findLivroById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Livro WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Livro(row['id'] as int?, row['title'] as String),
        arguments: [id],
        queryableName: 'Livro',
        isView: false);
  }

  @override
  Future<void> insertLivro(Livro livro) async {
    await _livroInsertionAdapter.insert(livro, OnConflictStrategy.abort);
  }
}
