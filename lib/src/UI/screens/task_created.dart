import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sample_app/src/data/create_task.dart';
import 'package:sample_app/src/repo/provider.dart';
import 'package:sample_app/src/repo/tasks.dart';

import '../widgets/date_picker.dart';

class TaskCard extends ConsumerStatefulWidget {
  const TaskCard({Key? key}) : super(key: key);

  static const routeName = '/createTask';

  @override
  ConsumerState<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends ConsumerState<TaskCard> {
  bool tick = false;

  late TextEditingController taskController;

  late TextEditingController specialController;

  late List<String> list;

  late List<String> priorityTypes;
  late List<String> wheelChairTypes;

  late String? priority;

  late String? wheelChairType;

  late String? start;

  late String? end;

  // late TextEditingController startLocationController;

  // late TextEditingController destinationController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskController = TextEditingController();
    specialController = TextEditingController();

    list = [
      'Reception',
      'Floor 1',
      'Floor 2',
      'Floor 3',
      'Floor 4',
      'Floor 5',
      'Basement',
    ];

    priorityTypes = ['Urgent', 'Scheduled'];

    wheelChairTypes = ['Type A', 'Type B', 'Type C', 'Type D'];

    start = null;
    end = null;
    priority = null;
    wheelChairType = null;

    // startLocationController = TextEditingController();

    // destinationController = TextEditingController();
  }

  String? _valiDator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter appropriate value';
    }
    return null;
  }

  void _submitData(
    String taskName,
    String startLocation,
    String endLocation,
    bool wheelChair,
    String? date,
    String? priority,
    String? wheelChairType,
    String? specialInstructions,
  ) async {
    if (_formKey.currentState!.validate() != true) {
      return;
    }

    final payload = CreateTaskData(
      taskName,
      startLocation,
      endLocation,
      wheelChair,
      date,
      priority,
      wheelChairType,
      specialInstructions,
    );

    Future.microtask(() async {
      final watch = ref.watch(taskCreateProvider(payload).future);
      final temp = await watch;

      if (temp) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Task Submitted Successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please try again later'),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    taskController.dispose();
    specialController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = ref.watch(dateProvider.notifier);
    final date = prov.returnDate();

    final size = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 36,
        vertical: 24,
      ),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: SizedBox(
              height: size * 0.7,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Create Task',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Task Name'),
                      ),
                      controller: taskController,
                      validator: (s) => _valiDator(taskController.text),
                    ),
                    // TextFormField(
                    //   decoration: const InputDecoration(
                    //     label: Text('Start Location'),
                    //   ),
                    //   controller: startLocationController,
                    //   validator: (s) => _valiDator(taskController.text),
                    // ),
                    DropdownButtonFormField<String>(
                      hint: const Text('Please select start location'),
                      validator: (s) => _valiDator(start),
                      isExpanded: true,
                      items: list
                          .map((e) => DropdownMenuItem<String>(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (s) {
                        setState(() {
                          start = s.toString();
                        });
                      },
                      value: start,
                    ),
                    DropdownButtonFormField<String>(
                      hint: const Text('Please select end location'),
                      isExpanded: true,
                      validator: (s) => _valiDator(end),
                      items: list
                          .map((e) => DropdownMenuItem<String>(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (s) {
                        setState(() {
                          end = s.toString();
                        });
                      },
                      value: end,
                    ),

                    DropdownButtonFormField<String>(
                      hint: const Text('Please select priority type'),
                      isExpanded: true,
                      validator: (s) => _valiDator(priority),
                      items: priorityTypes
                          .map((e) => DropdownMenuItem<String>(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (s) {
                        setState(() {
                          priority = s.toString();
                        });
                      },
                      value: priority,
                    ),
                    priority == 'Scheduled'
                        ? const DatePicker()
                        : const SizedBox(),
                    CheckboxListTile(
                      value: tick,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (newValue) {
                        setState(
                          () {
                            tick = newValue ?? false;
                          },
                        );
                      },
                      title: const Text('Is wheelchair required?'),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    tick
                        ? DropdownButtonFormField<String>(
                            hint: const Text('Wheelchair type'),
                            isExpanded: true,
                            items: wheelChairTypes
                                .map((e) => DropdownMenuItem<String>(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (s) {
                              setState(() {
                                wheelChairType = s.toString();
                              });
                            },
                            value: wheelChairType,
                          )
                        : const SizedBox(),

                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Special Insctructions'),
                      ),
                      controller: specialController,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _submitData(
                          taskController.text,
                          start.toString(),
                          end.toString(),
                          // startLocationController.text,
                          // destinationController.text,
                          tick,
                          priority == 'Urgent' ? '-' : date,
                          priority,
                          tick ? wheelChairType : '-',
                          specialController.text,
                        );
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
