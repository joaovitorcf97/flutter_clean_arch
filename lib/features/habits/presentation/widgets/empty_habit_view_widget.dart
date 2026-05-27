import 'package:flutter/material.dart';

class EmptyHabitViewWidget extends StatelessWidget {
  const EmptyHabitViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Icon(Icons.check_box_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'No habits yet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),

          Text(
            'Add a new habit to get started',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
