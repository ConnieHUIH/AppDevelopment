import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_habit_tracker/pages/home_page.dart';
import 'package:flutter_application_habit_tracker/Theme/theme_provider.dart';
import 'package:flutter_application_habit_tracker/database/habit_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize the Isar database
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirstLaunchDate(DateTime.now());

  runApp(MultiProvider(providers: [
    // habit provider
    ChangeNotifierProvider(create: (context) => HabitDatabase()),
    // theme provider
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
  ],
  child: const MyApp(),
  ),
    
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder:(context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
          theme: themeProvider.themeData,
        );
      },
    );
  }
}