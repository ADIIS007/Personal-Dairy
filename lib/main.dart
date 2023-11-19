import 'package:flutter/material.dart';
import 'package:my_flutter_project/Pages/Diary/add_page.dart';
import 'package:my_flutter_project/Pages/Diary/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_flutter_project/Entity/dairy.dart';
import 'package:my_flutter_project/Pages/Diary/stats_page.dart';
import 'package:my_flutter_project/Pages/nav_page.dart';
import 'package:my_flutter_project/Service/db.dart';
import 'package:my_flutter_project/Pages/Diary/read_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DairyAdapter());
  await Hive.openBox<DiaryEntry>('diary_entries');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/addDairy': (context) => const AddDairy(),
        '/statsDairy': (context) => Calendar(),
        '/readDairy': (context) {
          final dateStr = (ModalRoute.of(context)?.settings.arguments
              as Map<String, String>)['dateStr'];
          if (dateStr != null) {
            return ReadDairy(dateStr: dateStr);
          } else {
            return const Text('Error: No date provided');
          }
        }
      },
      home: const BottomNavigation(),
    );
  }
}
