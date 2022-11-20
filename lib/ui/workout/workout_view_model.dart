import 'package:magic/app/app.locator.dart';
import 'package:magic/core/enums/workout_status.dart';
import 'package:magic/core/models/workout.dart';
import 'package:magic/core/models/workout_set.dart';
import 'package:magic/core/services/local_storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class WorkOutViewModel extends BaseViewModel {
  final _localStorageService = locator<LocalStorageService>();
  final _navigationService = locator<NavigationService>();

  Workout? currentWorkout;
  WorkoutStatus? workoutStatus;

  String screenTitle = '';
  String workOutName = '';
  String selectedExercise = '';

  bool canContinue = false;

  int repetitions = 1;
  double weight = 0;

  List<String> exerciseList = [];

  void initialise() {
    setBusy(true);
    workoutStatus = _localStorageService.workoutStatus;
    if (workoutStatus == WorkoutStatus.add) {
      screenTitle = 'Add Workout';
      exerciseList = [
        'Barbell Row',
        'Bench Press',
        'Deadlift',
        'Shoulder Press',
        'Squat'
      ];
      selectedExercise = exerciseList[0];
    } else {
      screenTitle = 'Workout Detail';
      currentWorkout = _localStorageService.getWorkOut();
    }

    setBusy(false);
  }

  void setWorkOutName(String? value) {
    if (value == null || value == '') {
      return;
    }
    workOutName = value;
    checkCanContinue();
  }

  void setWeight(String? value) {
    if (value == null || value == '') {
      return;
    }
    weight = double.tryParse(value) ?? 0;
    checkCanContinue();
  }

  increaseRepetition() {
    repetitions++;
    notifyListeners();
  }

  decreaseRepetition() {
    if (repetitions > 1) {
      repetitions--;
    } else {
      return;
    }
    notifyListeners();
  }

  selectExercise(String exercise) {
    selectedExercise = exercise;
    notifyListeners();
  }

  void checkCanContinue() {
    if (weight > 0 && selectedExercise != '') {
      canContinue = true;
    } else {
      canContinue = false;
    }
    notifyListeners();
  }

  void saveWorkOut() async {
    Workout newWorkOut = Workout(
      name: workOutName == '' ? 'Workout' : workOutName,
      createdAt: DateTime.now(),
      sets: [
        WorkoutSet(
            name: selectedExercise, repetitions: repetitions, weight: weight)
      ],
    );
    await _localStorageService.addWorkout(newWorkOut);
    _navigationService.back(result: true);
  }

  void back() {
    _navigationService.back();
  }
}
