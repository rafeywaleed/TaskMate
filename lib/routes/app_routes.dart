import '../screens/add_task_screen.dart';
import '../screens/home_screen.dart';

class AppRoutes {
  static final routes = {
    '/': (context) => HomeScreen(),
    '/add': (context) => AddTaskScreen(),
  };
}
