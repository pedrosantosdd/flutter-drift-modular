import 'package:app_a/main.dart';
import 'package:feature_a/data/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTodoItemsDao extends Mock implements TodoItemsDao {}

void main() {
  testWidgets('MyHomePage displays AppBar title', (tester) async {
    // Arrange
    final mockTodoItemsDao = MockTodoItemsDao();
    when(() => mockTodoItemsDao.getAllWatch())
        .thenAnswer((_) => Stream.value([]));

    // Act
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(todoItemsDao: mockTodoItemsDao),
    ));

    // Assert
    expect(find.text('App A Database'), findsOneWidget);
  });

  testWidgets('MyHomePage displays CircularProgressIndicator when loading',
      (tester) async {
    // Arrange
    final mockTodoItemsDao = MockTodoItemsDao();
    when(() => mockTodoItemsDao.getAllWatch())
        .thenAnswer((_) => const Stream.empty());

    // Act
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(todoItemsDao: mockTodoItemsDao),
    ));

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('MyHomePage displays GridView with items', (tester) async {
    // Arrange
    final mockTodoItemsDao = MockTodoItemsDao();
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
    when(() => mockTodoItemsDao.getAllWatch())
        .thenAnswer((_) => Stream.value(mockData));

    // Act
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(todoItemsDao: mockTodoItemsDao),
    ));
    await tester.pump();

    // Assert
    expect(find.byType(GridView), findsOneWidget);
    expect(find.text('Title1Content1'), findsOneWidget);
    expect(find.text('Title2Content2'), findsOneWidget);
  });

  testWidgets('MyHomePage calls increaseDatabase on FloatingActionButton press',
      (tester) async {
    // Arrange
    final mockTodoItemsDao = MockTodoItemsDao();
    when(() => mockTodoItemsDao.getAllWatch())
        .thenAnswer((_) => Stream.value([]));
    when(() => mockTodoItemsDao.create(any(), any()))
        .thenReturn(Future.value(1));

    // Act
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(todoItemsDao: mockTodoItemsDao),
    ));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    // Assert
    verify(() => mockTodoItemsDao.create(any(), any())).called(1);
  });
}
