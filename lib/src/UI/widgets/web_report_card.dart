import 'package:flutter/material.dart';
import 'package:sample_app/src/data/tasks.dart';
import 'package:url_launcher/url_launcher.dart';

class WebReportCard extends StatefulWidget {
  const WebReportCard({Key? key, required this.data}) : super(key: key);

  final List<TaskData?>? data;

  @override
  State<WebReportCard> createState() => _WebReportCardState();
}

class _WebReportCardState extends State<WebReportCard> {
  late List<TaskData?>? tasks;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tasks = widget.data;
  }

  bool _sortAsc = false;
  final int _sortColumnIndex = 0;

  onSortColum(int columnIndex, bool ascending) {
    setState(() {
      _sortAsc = ascending;
      print(_sortAsc);
    });
    if (columnIndex == _sortColumnIndex) {
      if (ascending) {
        tasks?.sort((a, b) => a?.taskId?.compareTo(b?.taskId ?? 0) ?? 0);
      } else {
        tasks?.sort((a, b) => b?.taskId?.compareTo(a?.taskId ?? 0) ?? 0);
      }
    }
  }

  void _launchUrl() async {
    final Uri _url =
        Uri.parse('http://159.89.171.158:5010/dashboard/floorinfo?floor=0');

    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      sortColumnIndex: _sortColumnIndex,
      sortAscending: _sortAsc,
      columns: [
        DataColumn(
          label: const Text('Task ID'),
          onSort: (columnIndex, ascending) {
            onSortColum(columnIndex, ascending);
          },
        ),
        const DataColumn(label: Text('Task Name')),
        const DataColumn(label: Text('Start Location')),
        const DataColumn(label: Text('Destination')),
        const DataColumn(label: Text('Task Status')),
        const DataColumn(
          label: Text('Is Wheelchair needed?'),
        ),
        const DataColumn(
          label: Text('WheelChair Type'),
        ),
        const DataColumn(
          label: const Text('Priority'),
        ),
        const DataColumn(
          label: const Text('Scheduled Date'),
        ),
        const DataColumn(
          label: const Text('Turn Around Time'),
        ),
        const DataColumn(
          label: Text('Accept Time'),
        ),
        const DataColumn(
          label: Text('Decline Time'),
        ),
        const DataColumn(
          label: Text('Special Instructions'),
        ),
        const DataColumn(
          label: const Text('Live Location'),
        ),
        const DataColumn(
          label: const Text('Actions'),
        ),
      ],
      rows: tasks?.map<DataRow>(
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
                  padding: const EdgeInsets.all(4),
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
                  onPressed: _launchUrl,
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
      ).toList() as List<DataRow>,
    );
  }
}
