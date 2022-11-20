import 'package:hive/hive.dart';
import 'package:magic/core/models/workout_set.dart';

part 'workout.g.dart';

@HiveType(typeId: 1)
class Workout {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final DateTime createdAt;

  @HiveField(2)
  final List<WorkoutSet> sets;

  Workout({
    required this.name,
    required this.createdAt,
    required this.sets,
  });

}