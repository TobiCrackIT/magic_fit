import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:magic/app/app.locator.dart';
import 'package:magic/app/app.router.dart';
import 'package:magic/core/constants/hive_constants.dart';
import 'package:magic/core/models/workout.dart';
import 'package:magic/core/models/workout_set.dart';
import 'package:stacked_services/stacked_services.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(WorkoutSetAdapter());
  await Hive.openBox<Workout>(HiveConstants.workoutBox);
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Magic Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
