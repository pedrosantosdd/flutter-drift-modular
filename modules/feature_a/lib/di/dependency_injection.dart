import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'dependency_injection.config.dart';

@InjectableInit(initializerName: 'init', asExtension: false)
void configureDependencies(GetIt instance) => init(instance);
