import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mceasy/provider/form_change_notifier.dart';
import 'package:mceasy/provider/list_change_notifier.dart';
import 'package:mceasy/ui/list/list_page.dart';
import 'package:mceasy/ui/home_page.dart';

import 'package:provider/provider.dart';

import 'db/base_sqlite_repository.dart';
import 'db/get_it_di.dart';


Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    setup();
    await initLocalDatabase();
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ListChangeNotifier(),
          ),
          ChangeNotifierProvider(
            create: (_) => FormChangeNotifier(),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
