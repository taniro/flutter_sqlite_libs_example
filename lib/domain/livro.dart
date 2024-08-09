import 'package:floor/floor.dart';

@entity
class Livro {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String title;

  Livro(this.id, this.title);

  @override
  String toString() {
    return 'Livro{id: $id, title: $title}';
  }
}