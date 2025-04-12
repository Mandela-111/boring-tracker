import 'package:flutter/material.dart';
import 'package:habit_tracker/data/services/storage_service.dart';
import 'package:habit_tracker/data/models/habit.dart';
import '../widgets/day_button.dart';

class HabitTrackingScreen extends StatefulWidget {
  @override
  _HabitTrackingScreenState createState() => _HabitTrackingScreenState();
}

class _HabitTrackingScreenState extends State<HabitTrackingScreen> {
  final StorageService _storageService = StorageService();
  Habit? _habit;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _loadHabit();
  }

  void _loadHabit() {
    final habitBox = _storageService.getHabitsBox();
    final habit = habitBox.get('selected_habit') as Habit?;
    setState(() {
      _habit = habit;
      if (habit != null) {
        final today = DateTime.now();
        _isChecked = habit.completedDates.any((date) =>
        date.year == today.year &&
            date.month == today.month &&
            date.day == today.day);
      }
    });
  }

  void _markHabitCompleted() {
    if (_habit == null) return;
    setState(() {
      _isChecked = true;
    });
    final today = DateTime.now();
    final updatedCompletedDates = List<DateTime>.from(_habit!.completedDates)
      ..add(today);
    final habitBox = _storageService.getHabitsBox();
    habitBox.put(
      'selected_habit',
      Habit(
        id: _habit!.id,
        name: _habit!.name,
        date: _habit!.date,
        days: _habit!.days,
        time: _habit!.time,
        completedDates: updatedCompletedDates,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final days = List.generate(7, (index) {
      final date = today.subtract(Duration(days: 6 - index));
      return {
        'day': date.day.toString(),
        'label': index == 6
            ? 'TODAY'
            : ['FRI', 'SAT', 'SUN', 'MON', 'TUE', 'WED', 'THU'][date.weekday % 7],
        'isToday': date.day == today.day,
        'isCompleted': _habit?.completedDates.any((d) =>
        d.year == date.year &&
            d.month == date.month &&
            d.day == date.day) ??
            false,
      };
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                Text(
                  _habit?.name ?? 'STRETCH',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onLongPress: _markHabitCompleted,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                              border: Border.all(color: Colors.white),
                            ),
                            child: Center(
                              child: _isChecked
                                  ? Icon(
                                Icons.check,
                                size: 40,
                                color: Colors.white,
                              )
                                  : Text(
                                _habit?.name ?? 'STRETCH',
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: days.map((day) {
                            return DayButton(
                              day: day['day'] as String,
                              label: day['label'] as String,
                              isToday: day['isToday'] as bool,
                              isSelected: day['isCompleted'] as bool,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '(Not Boring) Habits',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'curated by Mobbin',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}