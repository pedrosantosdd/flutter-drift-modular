import 'package:drift/drift.dart';
import 'dao/todo_items_dao.dart';

part 'table/todo_items_table.dart';

class FeatureADatabase {
  static const tables = [
    TodoItemsTable
  ];
  static const daos = [
    TodoItemsDao
  ];
}