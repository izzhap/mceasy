import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    setup();
    await initLocalDatabase();
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UsuarioListChangeNotifier(),
          ),
          ChangeNotifierProvider(
            create: (_) => UsuarioFormChangeNotifier(),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }, (error, stackTrace) {
    print("Error :  $error");
    print("StackTrace :  $stackTrace");
  });
}

Future<void> initLocalDatabase() async {
  await BaseSqliteRepository.db.database;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'CRUD Usuarios',
      debugShowCheckedModeBanner: false,
      home: UsuarioListPage(),
    );
  }
}
