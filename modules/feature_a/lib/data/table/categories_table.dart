part of '../database.dart';

@DataClassName('Category')
class CategoriesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}
