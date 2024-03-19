import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../database.dart';
import '../database.drift.dart';
import 'todo_items_dao.drift.dart';

abstract class TodoItemsDao {
  Stream<List<TodoItemsTableData>> getAllWatch();
  Future<int> create(String title, String content, {int? categoryId});
}

@LazySingleton(as: TodoItemsDao)
@DriftAccessor(tables: [TodoItemsTable, CategoriesTable])
class TodoItemsDaoImpl extends DatabaseAccessor<GeneratedDatabase>
    with $TodoItemsDaoImplMixin
    implements TodoItemsDao {
  TodoItemsDaoImpl(super.attachedDatabase);

  @override
  Stream<List<TodoItemsTableData>> getAllWatch() {
    return (select(todoItemsTable))
        .join([
          leftOuterJoin(super.categoriesTable,
              super.categoriesTable.id.equalsExp(super.todoItemsTable.category))
        ])
        .watch()
        .map((rows) => rows.map((e) {
              final todoItem = e.readTable(super.todoItemsTable);
              return TodoItemsTableData(
                  content: todoItem.content,
                  id: todoItem.id,
                  title: todoItem.title,
                  category: todoItem.category,
                  categoryEntity: e.readTableOrNull(super.categoriesTable));
            }).toList());
  }

  @override
  create(String title, String content, {int? categoryId}) {
    return into(todoItemsTable).insert(TodoItemsTableCompanion.insert(
      title: title,
      content: content,
      category: Value(categoryId),
    ));
  }
}
