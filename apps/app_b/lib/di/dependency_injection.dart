import 'package:app_b/data/database.dart';
import 'package:drift/drift.dart';
import 'package:feature_a/di/dependency_injection.module.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:storage/sql_database.dart';

import 'dependency_injection.config.dart';

@InjectableInit(
    asExtension: false,
    externalPackageModulesBefore: [ExternalModule(FeatureAPackageModule)])
void configureDependencies() {
  final getIt = GetIt.I;
  getIt.registerSingleton<GeneratedDatabase>(
      AppBDatabase(SqlDatabase.openConnection('app-b')));
  init(getIt);
}
