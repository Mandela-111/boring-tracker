import 'package:hive/hive.dart';
import '../models/habit.dart';

class StorageService {
  Box<Habit>? _habitsBox;

  Future<void> init() async {
    _habitsBox = await Hive.openBox<Habit>('habits');
  }

  Box<Habit> getHabitsBox() {
    if (_habitsBox == null || !_habitsBox!.isOpen) {
      throw Exception('Habits box is not initialized');
    }
    return _habitsBox!;
  }
}