import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskViewModel extends ChangeNotifier {
  List<Task> tasks = [];

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('tasks') ?? [];
    tasks = data.map((t) => Task.fromJson(json.decode(t))).toList();
    notifyListeners();
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = tasks.map((t) => json.encode(t.toJson())).toList();
    await prefs.setStringList('tasks', data);
  }

  void addTask(Task task) {
    tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void deleteTask(int index, BuildContext context) {
    tasks.removeAt(index);
    saveTasks();
    notifyListeners();
  }

  void toggleComplete(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
    saveTasks();
    notifyListeners();
  }
}
