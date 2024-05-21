import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@InjectableInit.microPackage(ignoreUnregisteredTypes: [GeneratedDatabase])
void configureDependencies() {}
