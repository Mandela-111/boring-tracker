import 'package:hive/hive.dart';

part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  List<bool>? days; // For routine days

  @HiveField(4)
  String? time; // For routine time

  @HiveField(5)
  List<DateTime> completedDates; // To track completed days

  Habit({
    required this.id,
    required this.name,
    required this.date,
    this.days,
    this.time,
    this.completedDates = const [],
  });
}