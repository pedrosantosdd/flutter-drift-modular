part of '../database.dart';

abstract class TodoItemsDao {
  Stream<List<ModelTodoItems>> getAllWatch();
  Future<int> create(String title, String content, {int? categoryId});
}

class ModelTodoItems {
  final int id;
  final String title;
  final String content;
  final int? categoryId;
  final Category? category;

  ModelTodoItems(
      {required this.id,
      required this.title,
      required this.content,
      required this.categoryId,
      required this.category});
}

@LazySingleton(as: TodoItemsDao)
@DriftAccessor(tables: [TodoItemsTable, CategoriesTable])
class TodoItemsDaoImpl extends DatabaseAccessor<GeneratedDatabase>
    with $TodoItemsDaoImplMixin
    implements TodoItemsDao {
  TodoItemsDaoImpl(super.attachedDatabase);

  @override
  Stream<List<ModelTodoItems>> getAllWatch() {
    return (select(todoItemsTable))
        .join([
          leftOuterJoin(super.categoriesTable,
              super.categoriesTable.id.equalsExp(super.todoItemsTable.category))
        ])
        .watch()
        .map((rows) => rows.map((e) {
              final todoItem = e.readTable(super.todoItemsTable);
              return ModelTodoItems(
                  content: todoItem.content,
                  id: todoItem.id,
                  title: todoItem.title,
                  categoryId: todoItem.category,
                  category: e.readTableOrNull(super.categoriesTable));
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
