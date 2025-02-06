import 'package:drift/drift.dart';
import 'package:feature_a/data/database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDatabase extends Mock implements GeneratedDatabase {}

class MockTodoItemsTable extends Mock implements TableInfo {}

void main() {
  late MockDatabase mockDatabase;
  late TodoItemsDaoImpl todoItemsDao;
  late MockTodoItemsTable mockTodoItemsTable;

  setUp(() {
    mockDatabase = MockDatabase();
    mockTodoItemsTable = MockTodoItemsTable();
    todoItemsDao = TodoItemsDaoImpl(mockDatabase);
  });

  test('getAllWatch returns stream of ModelTodoItems list', () async {
    // Arrange
    final mockData = [
      ModelTodoItems(
          id: 1,
          title: 'Title1',
          content: 'Content1',
          categoryId: null,
          category: null),
      ModelTodoItems(
          id: 2,
          title: 'Title2',
          content: 'Content2',
          categoryId: null,
          category: null),
    ];
    await Future.forEach(mockData,
        (data) async => await todoItemsDao.create(data.title, data.content));

    // Act
    final result = todoItemsDao.getAllWatch();

    // Assert
    expect(await result.first, mockData);
  });

  test('create inserts a new todo item and returns its id', () async {
    // Arrange
    const title = 'New Todo';
    const content = 'New Content';
    const categoryId = 1;
    const insertedId = 1;

    when(() => mockDatabase.into(mockTodoItemsTable).insert(any()))
        .thenAnswer((_) async => insertedId);

    // Act
    final result =
        await todoItemsDao.create(title, content, categoryId: categoryId);

    // Assert
    expect(result, insertedId);
    verify(() => mockDatabase.into(mockTodoItemsTable).insert(any())).called(1);
  });
}
