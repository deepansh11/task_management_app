import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/src/data/tasks.dart';

class ReportsCard extends StatelessWidget {
  const ReportsCard({
    Key? key,
    this.title,
    this.startLocation,
    this.endLocation,
    this.id,
    required this.date,
    required this.wheelChair,
    this.status,
  }) : super(key: key);

  final String? title;

  final String? startLocation;
  final String? endLocation;
  final String? id;
  final String date;
  final bool wheelChair;
  final TaskStatus? status;

  @override
  Widget build(BuildContext context) {
    final String yesNo = wheelChair ? 'Yes' : 'No';

    Color? color;

    if (status?.taskId == 0) {
      color = Colors.yellow;
    } else if (status?.taskId == 1) {
      color = Colors.green;
    } else {
      color = Colors.red;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        color: Colors.blue.shade200,
        child: ExpandablePanel(
          header: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Task Name: $title',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          collapsed: const SizedBox(),
          expanded: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Task ID: $id',
                    ),
                    SizedBox(
                      height: 30,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.location_on),
                        label: const Text('Porter Location'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Start Location: $startLocation'),
                    Text('Destination: $endLocation'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('Schedule Time: $date'),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: 'Task Status: '),
                          TextSpan(
                            text: status?.taskStatus,
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text('Is Wheel Chair Needed? : $yesNo'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('Assigned to : ${status?.assignedTo}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
