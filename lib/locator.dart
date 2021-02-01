import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import 'parts/eden/databasehelper.dart';
import 'parts/events/utility/constants_event.dart';
import 'repository.dart';


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
