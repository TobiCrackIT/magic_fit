import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:magic/app/app.locator.dart';
import 'package:magic/core/constants/hive_constants.dart';
import 'package:magic/core/models/workout.dart';
import 'package:magic/core/models/workout_set.dart';
import 'package:magic/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration tests', () {
    setUp(() async {
      await Hive.initFlutter();
      Hive.registerAdapter(WorkoutAdapter());
      Hive.registerAdapter(WorkoutSetAdapter());
      await Hive.openBox<Workout>(HiveConstants.workoutBox);
      setupLocator();
    });

    testWidgets('go to splashView', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();
    });
  });
}
