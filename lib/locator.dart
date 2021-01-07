import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:son_roe/parts/eden/databasehelper.dart';
import 'package:son_roe/repository.dart';
import 'events/utility/constants_event.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<GetStorage>(GetStorage());
  getIt.registerSingleton<RepositoryClass>(RepositoryClass());
  getIt.registerSingleton<ConstantOfEvents>(ConstantOfEvents());
  getIt.registerSingleton<DatabaseHelper>(DatabaseHelper());

  print('locator oluşturuldu ');
}

//GetStorage box = getIt<GetStorage>();
//RepositoryClass repo = getIt<RepositoryClass>();
