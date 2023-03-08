import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hive_notes_app/Models/hive_models.dart';
import 'package:flutter_hive_notes_app/Pages/add_notes.dart';
import 'package:flutter_hive_notes_app/Pages/home_page.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'Components/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();

  Hive.init(directory.path);
  Hive.registerAdapter(HiveModelsAdapter());

  await Hive.openBox<HiveModels>("notes");
  SystemUiOverlayStyle(statusBarColor: Colors.transparent);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeRoute,
      routes: {
        AppRoutes.homeRoute: (context) => HomePage(),
        AppRoutes.addNotesRoute: (context) => AddNotes(),
      },
    );
  }
}
