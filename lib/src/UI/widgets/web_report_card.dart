import 'package:flutter/material.dart';
import 'package:sample_app/src/data/tasks.dart';

class WebReportCard extends StatelessWidget {
  const WebReportCard({Key? key, required this.data}) : super(key: key);

  final TaskResponse data;

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: const [
          DataColumn(label: Text('Task ID')),
          DataColumn(label: Text('Task Name')),
          DataColumn(label: Text('Start Location')),
          DataColumn(label: Text('Destination')),
          DataColumn(label: Text('Task Status')),
          DataColumn(
            label: Text('Is Wheelchair needed?'),
          ),
          DataColumn(
            label: Text('WheelChair Type'),
          ),
          DataColumn(
            label: Text('Priority'),
          ),
          DataColumn(
            label: Text('Scheduled Date'),
          ),
          DataColumn(
            label: Text('Turn Around Time'),
          ),
          DataColumn(
            label: Text('Accept Time'),
          ),
          DataColumn(
            label: Text('Decline Time'),
          ),
          DataColumn(
            label: Text('Special Instructions'),
          ),
          DataColumn(
            label: Text('Live Location'),
          ),
          DataColumn(
            label: Text('Actions'),
          ),
        ],
        rows: data.data?.map<DataRow>(
          (e) {
            bool wc = e?.wheelChair ?? false;

            final String yesNo = wc ? 'Yes' : 'No';

            Color? color;

            if (e?.taskStatus?.taskId == 0) {
              color = Colors.yellow.shade600;
            } else if (e?.taskStatus?.taskId == 1) {
              color = Colors.green;
            } else {
              color = Colors.red;
            }

            return DataRow(
              cells: [
                DataCell(
                  Text(e?.taskId.toString() ?? '-'),
                ),
                DataCell(
                  Text(e?.taskName.toString() ?? '-'),
                ),
                DataCell(
                  Text(e?.startLocation.toString() ?? '-'),
                ),
                DataCell(
                  Text(e?.destination.toString() ?? '-'),
                ),
                DataCell(
                  Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(4),
                    child: Text(
                      e?.taskStatus?.taskStatus.toString() ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                DataCell(
                  Text(yesNo),
                ),
                DataCell(
                  Text(e?.wheelChairType ?? '-'),
                ),
                DataCell(
                  Text(e?.priority ?? '-'),
                ),
                DataCell(
                  Text(e?.scheduleDate ?? '-'),
                ),
                DataCell(
                  Text(e?.turnAroundTime ?? '-'),
                ),
                DataCell(
                  Text(e?.acceptTime ?? '-'),
                ),
                DataCell(
                  Text(e?.declineTime ?? '-'),
                ),
                DataCell(
                  Text(e?.specialInstructions ?? '-'),
                ),
                DataCell(ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.location_on),
                    label: const Text('Live Location'))),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ).toList() as List<DataRow>);
  }
}
