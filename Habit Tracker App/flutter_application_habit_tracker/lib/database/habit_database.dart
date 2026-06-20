import 'package:isar/isar.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_application_habit_tracker/models/habit.dart';
import 'package:flutter_application_habit_tracker/models/app_settings.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar _isar;

  /*
  SETUP ISAR DATABASE
  */

  // Initialize the Isar database with the specified schemas
    static Future<void> initialize() async {
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open(
      [HabitSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }
  // Save first launch date to the database (for heatmap)
  Future<void> saveFirstLaunchDate(DateTime date) async {
    final existingSettings = await _isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await _isar.writeTxn(() => _isar.appSettings.put(settings));
    }
  }
  // Get first launch date from the database (for heatmap)
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await _isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  /*
  CRUD OPERATIONS FOR HABITS
  */

  // Lists all habits in the database
  final List<Habit> currentHabits = [];

  // CREATE: Adds a new habit to the database
  Future<void> addHabit(String habitnName) async {
    // create a new habit object and save it to the database
    final habit = Habit()..name = habitnName;
    await _isar.writeTxn(() => _isar.habits.put(habit));
    // re-read from db
    readHabits();
  }

  // READ - read saved habits from the database
  Future<void> readHabits() async {
    // fetch all habits from the database
    List<Habit> fetchedHabits = await _isar.habits.where().findAll();
    //give to current habits
    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);
    // update UI
    notifyListeners();
  }

  // UPDATE - check habit on and off (add or remove completed day)
  Future<void> updateHabitCompletion(int id, bool isCompleted) async {
    // find the specific habit
    final habit = await _isar.habits.get(id);
    // update completion status
    if (habit != null) {
      final List<DateTime> updatedDays = List.from(habit.completedDays);
      final today = DateTime.now();
      final todayDateOnly = DateTime(today.year, today.month, today.day);

      await _isar.writeTxn(() async {
        // if habit is completed, add today's date to completedDays, otherwise remove it
        if (isCompleted && !habit.completedDays.contains(todayDateOnly)) {
          // today
          updatedDays.add(todayDateOnly);
        }
        // if habit is not completed -> remove the current date from the list 
        else if (!isCompleted){
          // remove the current date if the habit is marked as not completed
          updatedDays.removeWhere((date) => 
          date.year == DateTime.now().year && 
          date.month == DateTime.now().month && 
          date.day == DateTime.now().day,
          );
        }
        habit.completedDays = updatedDays;
        // save the updated habits back to the db
        await _isar.habits.put(habit);
      });
    } 
    readHabits();
  }

  // UPDATE - edit habit name
  Future<void> updateHabitName(int id, String newName) async {
    // find the specific habit
    final habit = await _isar.habits.get(id);

    // update habit name
    if (habit != null) {
      // update name
      await _isar.writeTxn(() async {
        habit.name = newName;
        // save updated habit back to the db
        await _isar.habits.put(habit);
      });
    }

    // re-read from db
    readHabits();
  }

  // DELETE - delete habit from the database
  Future<void> deleteHabit(int id) async {
    // perform the delete
    await _isar.writeTxn(() async {
      await _isar.habits.delete(id);
    });
    
    // re-read from db
    readHabits();
  }

}