import 'package:drift/drift.dart';
import 'package:feature_a/data/database.dart';

import 'database.drift.dart';

@DriftDatabase(
    tables: [...FeatureADatabase.tables], daos: [...FeatureADatabase.daos])
class AppBDatabase extends $AppBDatabase implements GeneratedDatabase {
  AppBDatabase(super.nativeDatabase);

  @override
  int get schemaVersion => 1;
}
