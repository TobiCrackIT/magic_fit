import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/hive_test.dart';
import 'package:magic/app/app.router.dart';
import 'package:magic/core/enums/workout_status.dart';
import 'package:magic/core/models/workout.dart';
import 'package:magic/core/models/workout_set.dart';
import 'package:magic/core/services/local_storage_service.dart';
import 'package:magic/ui/workout_list/workout_list_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';

import '../helpers/test_helpers.dart';
import '../mock_data/mock_workout.dart';

void main() {
  late LocalStorageService localStorageService;
  late NavigationService navigationService;

  late Box<Workout> testBox;

  late WorkOutListViewModel model;

  setUp(() async {
    await setUpTestHive();
    registerGenericServices();

    localStorageService = getAndRegisterLocalStorageServiceMock();
    navigationService = getAndRegisterNavigationServiceMock();

    testBox = await Hive.openBox<Workout>('testBox');
    when(localStorageService.getBox()).thenReturn(testBox);
    when(localStorageService.workoutBox).thenReturn(testBox);
    when(localStorageService.workoutStatus).thenReturn(WorkoutStatus.add);
    when(localStorageService.deleteWorkout(0))
        .thenAnswer((realInvocation) => Future.value(true));
    model = WorkOutListViewModel();
  });

  tearDown(() async {
    unregisterGenericServices();
    await tearDownTestHive();
  });

  group('WorkOutListViewModel - ', () {
    group('initialise - ', () {
      test('when called, box is empty', () async {
        model.initialise();
        expect(testBox.values.length, 0);
      });

      test('when called, box is not empty', () async {
        Hive.registerAdapter(WorkoutAdapter());
        Hive.registerAdapter(WorkoutSetAdapter());
        testBox.add(mockWorkOut1);
        model.initialise();
        expect(testBox.values.length, 1);
      });
    });

    group('viewDetail - ', () {
      test('should navigate to workoutView when called', () async {
        int index = 0;
        when(localStorageService.selectedIndex).thenReturn(index);
        model.viewDetail(index);
        expect(localStorageService.selectedIndex,index);
        verify(navigationService.navigateTo(Routes.workoutView));
      });
    });

    group('deleteWorkOut - ', () {
      test('should return true when called', () async {
        bool result = await model.deleteWorkOut(0);
        expect(result, true);
      });
    });

    group('addWorkOut - ', () {
      test('should navigate to workoutView when called', () async {
        model.addWorkOut();
        verify(navigationService.navigateTo(Routes.workoutView));
      });

      test('workOutStatus should be add when called', () async {
        model.addWorkOut();
        expect(localStorageService.workoutStatus, WorkoutStatus.add);
      });
    });
  });
}
