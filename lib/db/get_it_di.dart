import 'package:get_it/get_it.dart';

import 'package:mceasy/ui/usuarios/db/sqlite_usuario_respository.dart';
import 'package:mceasy/shared/infrastructure/base_sqlite_repository.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<BaseSqliteRepository>(BaseSqliteRepository.db);
  getIt.registerLazySingleton(
      () => SqliteUsuarioRepository(BaseSqliteRepository.db.instance!));
}
