import 'package:drift/drift.dart';
import 'package:feature_a/data/database.dart';

import 'database.drift.dart';

@DriftDatabase(
    tables: [...FeatureADatabase.tables], daos: [...FeatureADatabase.daos])
class AppADatabase extends $AppADatabase {
  AppADatabase(super.nativeDatabase);

  @override
  int get schemaVersion => 1;
}
