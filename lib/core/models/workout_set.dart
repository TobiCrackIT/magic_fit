import 'package:hive/hive.dart';

part 'workout_set.g.dart';

@HiveType(typeId: 2)
class WorkoutSet {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int repetitions;

  @HiveField(2)
  final double weight;

  WorkoutSet({
    required this.name,
    required this.repetitions,
    required this.weight
  });

}