import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

import '../models/task.dart';

class ShowDetailsDialog extends StatelessWidget {
  final Task task;
  const ShowDetailsDialog({super.key, required this.task});

  int get daysLeft {
    final now = DateTime.now();
    final difference = task.dueDate.difference(now);
    return difference.inDays;
  }

  String get formattedDueDate =>
      DateFormat.yMMMMd().format(task.dueDate.toLocal());

  String get formattedCreatedAt => task.createdAt != null
      ? DateFormat.yMMMMd().add_jm().format(task.createdAt!.toLocal())
      : 'Unknown';

  @override
  Widget build(BuildContext context) {
    final isOverdue = daysLeft < 0;
    final isDueToday = daysLeft == 0;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              task.title,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                decoration: TextDecoration.underline,
                decorationColor: Colors.black38,
                decorationThickness: 2,
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),
            const SizedBox(height: 16),

            // Description
            task.description.isEmpty
                ? const Text(
                    'No description provided.',
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.grey),
                  )
                : Text(
                    task.description,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
            const SizedBox(height: 20),

            // Other details
            _infoRow(
              icon: Icons.calendar_today_outlined,
              label: 'Due Date',
              value: formattedDueDate,
              valueColor: isOverdue
                  ? Colors.red
                  : (isDueToday ? Colors.orange : Colors.black87),
            ),
            const SizedBox(height: 10),

            _infoRow(
              icon: Icons.hourglass_bottom_outlined,
              label: 'Days Left',
              value: daysLeft >= 0 ? '$daysLeft days' : 'Overdue',
              valueColor: isOverdue ? Colors.red : Colors.green,
            ),
            const SizedBox(height: 10),

            _infoRow(
              icon: task.isCompleted
                  ? Icons.check_circle_outline
                  : Icons.pending_outlined,
              label: 'Status',
              value: task.isCompleted ? 'Completed' : 'Pending',
              valueColor: task.isCompleted ? Colors.green : Colors.orange,
            ),
            const SizedBox(height: 10),

            _infoRow(
              icon: Icons.event_note_outlined,
              label: 'Created At',
              value: formattedCreatedAt,
              valueColor: Colors.black54,
            ),

            const SizedBox(height: 24),

            // Close button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  // backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.black26)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 22, color: Colors.black),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 15,
              color: valueColor ?? Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
