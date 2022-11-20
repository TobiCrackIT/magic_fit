import 'package:hive_flutter/hive_flutter.dart';
import 'package:magic/core/constants/hive_constants.dart';
import 'package:magic/core/enums/workout_status.dart';
import 'package:magic/core/models/workout.dart';

class LocalStorageService {
  var workoutBox = Hive.box<Workout>(HiveConstants.workoutBox);

  int selectedIndex=0;
  WorkoutStatus? workoutStatus;

  // List<Workout> getWorkouts() {
  //   try {
  //     return workoutBox.values.toList();
  //   } on Exception catch (e) {
  //     throw Exception('${e.toString()}.');
  //   }
  // }

  Workout getWorkOut() {
    try {
      Workout? workout = workoutBox.getAt(selectedIndex);
      return workout!;
    } on Exception catch (e) {
      throw Exception('${e.toString()}.');
    }
  }

  Future<bool> addWorkout(Workout workout) async {
    try {
      await workoutBox.add(workout);
    } on Exception catch (e) {
      throw Exception('${e.toString()}.');
    }
    return true;
  }

  Future<bool> deleteWorkout(int index) async {
    try {
      await workoutBox.deleteAt(index);
    } on Exception catch (e) {
      throw Exception('${e.toString()}.');
    }
    return true;
  }

  Box<Workout> getBox() {
    return workoutBox;
  }
}
