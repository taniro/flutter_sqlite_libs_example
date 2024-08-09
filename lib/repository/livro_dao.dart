import 'package:floor/floor.dart';
import 'package:flutter_sqlite_libs_example/domain/livro.dart';

@dao
abstract class LivroDao {
  @Query('SELECT * FROM Livro')
  Future<List<Livro>> findAll();

  @Query('SELECT titulo FROM Livro')
  Stream<List<String>> findAllLivroTitle();

  @Query('SELECT * FROM Livro WHERE id = :id')
  Stream<Livro?> findLivroById(int id);

  @insert
  Future<void> insertLivro(Livro livro);
}