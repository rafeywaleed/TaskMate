import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/task_view_model.dart';
import '../widgets/task_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context);
    final tasks = viewModel.tasks;
    final pending = tasks.where((t) => !t.isCompleted).toList();
    final completed = tasks.where((t) => t.isCompleted).toList();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskMate',
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: const Icon(Icons.add_task_rounded, color: Colors.black54),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.black54),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text('Hold a task to view details.\nSwipe to delete'),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      backgroundColor: Colors.grey[100],
      body: tasks.isEmpty
          ? Center(
              child: Text(
                'No tasks yet. Tap + to add one!',
                style: TextStyle(color: Colors.grey, fontSize: width * 0.05),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(12),
              children: [
                if (pending.isNotEmpty) ...[
                  _sectionName('Pending'),
                  ...pending.map((task) {
                    final index = tasks.indexOf(task);
                    return TaskCard(task: task, index: index);
                  }),
                ],
                if (completed.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _sectionName('Completed'),
                  ...completed.map((task) {
                    final index = tasks.indexOf(task);
                    return TaskCard(task: task, index: index);
                  }),
                ],
              ],
            ),
    );
  }

  // for complete and incomplete sections
  Widget _sectionName(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
      ),
    );
  }
}
