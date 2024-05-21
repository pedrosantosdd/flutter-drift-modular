import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'dependency_injection.config.dart';

@InjectableInit(asExtension: false, ignoreUnregisteredTypes: [GeneratedDatabase])
void configureDependencies(GetIt instance) => init(instance);
