// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:magic/core/models/workout.dart';
import 'package:magic/core/services/local_storage_service.dart';

import 'package:magic/main.dart';
import 'package:magic/ui/splash/splash_view.dart';
import 'package:magic/ui/workout_list/workout_list_view.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helpers.dart';

void main() {
  late LocalStorageService localStorageService;
  late Box<Workout> testBox;
  setUp(() async {
    await setUpTestHive();
    registerGenericServices();
    localStorageService = getAndRegisterLocalStorageServiceMock();
    testBox = await Hive.openBox<Workout>('testBox');
    when(localStorageService.getBox()).thenReturn(testBox);
  });

  tearDown(() async {
    unregisterGenericServices();
    await tearDownTestHive();
  });

  testWidgets('Widget test for MaterialApp', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    await tester.pump(Duration(milliseconds: 1500));
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Widget test for SplashView', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(SplashView());
    await tester.pump(Duration(milliseconds: 1500));
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
    expect(find.text('Magic'), findsOneWidget);
  });

  testWidgets('Widget test for WorkoutListView', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: WorkOutListView()));
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.text('Workouts'), findsOneWidget);
    expect(find.byType(Builder), findsWidgets);
    expect(find.byType(Container), findsWidgets);
  });
}
