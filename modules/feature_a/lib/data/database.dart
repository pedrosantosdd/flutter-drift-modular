import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import './database.drift.dart';

part 'table/todo_items_table.dart';
part 'table/categories_table.dart';
part 'dao/todo_items_dao.dart';

class FeatureADatabase {
  static const tables = [TodoItemsTable, CategoriesTable];
  static const daos = [TodoItemsDaoImpl];
}
