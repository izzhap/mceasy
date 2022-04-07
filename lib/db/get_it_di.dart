import 'package:get_it/get_it.dart';
import 'package:mceasy/db/sqlite_respository.dart';

import 'base_sqlite_repository.dart';


final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<BaseSqliteRepository>(BaseSqliteRepository.db);
  getIt.registerLazySingleton(
      () => SqliteRepository(BaseSqliteRepository.db.instance!));
}
