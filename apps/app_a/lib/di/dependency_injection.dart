import 'package:app_a/data/database.dart';
import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:feature_a/di/dependency_injection.dart' as feature_a_di;
import 'package:storage/sql_database.dart';

import 'dependency_injection.config.dart';

final getIt = GetIt.I;

@InjectableInit(
  initializerName: 'init', // Default.
  preferRelativeImports: true, // Default.
  asExtension: false,
)
void configureDependencies() {
  feature_a_di.configureDependencies(getIt);
  final database = AppADatabase(SqlDatabase.openConnection('app-a'));
  getIt.registerSingleton<GeneratedDatabase>(database);
  getIt.registerSingleton<AppADatabase>(database);
  init(getIt);
}
