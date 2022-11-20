import 'package:magic/core/models/workout.dart';
import 'package:magic/core/models/workout_set.dart';

Workout mockWorkOut1 = Workout(
    name: 'Hey',
    createdAt: DateTime.now(),
    sets: [WorkoutSet(name: 'Test', repetitions: 2, weight: 11)]);

Workout mockWorkOut2 = Workout(
    name: 'May',
    createdAt: DateTime.now(),
    sets: [WorkoutSet(name: 'Test', repetitions: 5, weight: 45)]);
