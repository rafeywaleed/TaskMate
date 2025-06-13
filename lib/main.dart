import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes/app_routes.dart';
import 'viewmodels/task_view_model.dart';

void main() {
  runApp(TaskMateApp());
}

class TaskMateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskViewModel()..loadTasks(),
      child: MaterialApp(
        title: 'TaskMate',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(primary: Colors.blue),
        ),
        initialRoute: '/',
        routes: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
