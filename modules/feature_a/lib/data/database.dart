import 'package:drift/drift.dart';
import 'dao/todo_items_dao.dart';

part 'table/todo_items_table.dart';
part 'table/categories_table.dart';

class FeatureADatabase {
  static const tables = [TodoItemsTable, CategoriesTable];
  static const daos = [TodoItemsDao];
}
