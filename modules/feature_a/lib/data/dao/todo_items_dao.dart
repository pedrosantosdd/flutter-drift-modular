import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../database.dart';
import '../database.drift.dart';
import 'todo_items_dao.drift.dart';

abstract class TodoItemsDao {
  Stream<List<TodoItemsTableData>> getAllWatch();
  Future<int> create(String title, String content);
}

@LazySingleton(as: TodoItemsDao)
@DriftAccessor(tables: [TodoItemsTable])
class TodoItemsDaoImpl extends DatabaseAccessor<GeneratedDatabase>
    with $TodoItemsDaoImplMixin
    implements TodoItemsDao {
  TodoItemsDaoImpl(super.attachedDatabase);

  @override
  Stream<List<TodoItemsTableData>> getAllWatch() {
    return (select(todoItemsTable)).watch();
  }

  @override
  create(String title, String content) {
    return into(todoItemsTable).insert(TodoItemsTableCompanion.insert(
      title: title,
      content: content,
    ));
  }
}
