import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../viewmodels/task_view_model.dart';
import 'show_details_dialog.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final int index;

  const TaskCard({required this.task, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
      child: GestureDetector(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) => ShowDetailsDialog(task: task),
          );
        },
        child: Dismissible(
          key: ValueKey('${task.title}-$index'),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) async {
            return await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete Task'),
                      content: const Text(
                          'Are you sure you want to delete this task?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                ) ??
                false;
          },
          onDismissed: (_) => viewModel.deleteTask(index, context),
          background: Container(
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerRight,
            child: const Icon(Icons.delete, color: Colors.white, size: 28),
          ),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            child: ListTile(
              leading: Checkbox(
                value: task.isCompleted,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                onChanged: (_) => viewModel.toggleComplete(index),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              // trailing:
              title: Text(
                task.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: task.description.isNotEmpty
                  ? Text(
                      task.description,
                      style: TextStyle(
                        color: Colors.grey[700],
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    )
                  : null,
              onTap: () => viewModel.toggleComplete(index),
            ),
          ),
        ),
      ),
    );
  }
}
