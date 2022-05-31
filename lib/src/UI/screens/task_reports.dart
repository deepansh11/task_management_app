import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_app/src/UI/widgets/data_card.dart';

import 'package:sample_app/src/UI/widgets/web_report_card.dart';
import 'package:sample_app/src/repo/tasks.dart';

import '../../data/tasks.dart';

class DataSubmitted extends ConsumerStatefulWidget {
  const DataSubmitted({Key? key}) : super(key: key);

  static const routeName = '/dataSubmitted';

  @override
  ConsumerState<DataSubmitted> createState() => _DataSubmittedState();
}

class _DataSubmittedState extends ConsumerState<DataSubmitted> {
  late String? filters;
  late List<String> filterType;
  late ScrollController _scrollController1;

  late ScrollController _scrollController2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filterType = [
      'Outside',
      'Gate',
      "Waiting Area",
      "Public Lift",
      "Patient Lift",
      "Admission Hub Heritage",
      "Report Collection",
      "Public Lift-1",
      "Patient Lift-1",
      "Ortho",
      'ECGReception',
      'USG',
    ];
    filters = null;

    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();
  }

  int _addToList(List<TaskData?>? data) {
    List<TaskData?>? tasks = [];

    if (data != null) {
      for (var element in data) {
        if (element?.taskStatus?.taskId == 0) {
          tasks.add(element);
        }
      }
    }
    return tasks.length;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController1.dispose();
    _scrollController2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(taskFetchProvider);
    final totalTasks = list.value?.data?.length ?? 0;
    final totalPending = _addToList(list.value?.data);

    final totalAccepted = totalTasks - totalPending;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DataCards(
                title: 'Tasks',
                data1: totalTasks.toString(),
                subTitle1: 'Total Tasks',
                data2: totalPending.toString(),
                subTitle2: 'Pending',
                data3: totalAccepted.toString(),
                subTitle3: 'Accepted',
                data4: '0',
                subTitle4: 'Rejected',
              ),
              const DataCards(
                title: 'Floors',
                data1: '2',
                subTitle1: 'No. of Floors',
                data2: '10',
                subTitle2: 'No. of wheel chairs',
              ),
              const DataCards(
                title: 'Porters',
                data1: '5',
                subTitle1: 'Total Porters',
                data2: '0',
                subTitle2: 'On Task',
                data3: '0',
                subTitle3: 'On Break',
                data4: '5',
                subTitle4: 'Available Porters',
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Search', prefixIcon: Icon(Icons.search)),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 4,
                  child: Center(
                    child: Text(
                      'Task Lists',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: DropdownButtonFormField<String>(
                      hint: const Text('Location Filter'),
                      isExpanded: true,
                      items: filterType
                          .map((e) => DropdownMenuItem<String>(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (s) {
                        setState(() {
                          filters = s.toString();
                        });
                      },
                      value: filters,
                    ),
                  ),
                ),
              ],
            ),
          ),
          list.when(data: (data) {
            final isDataEmpty = data?.data?.isNotEmpty ?? false;

            return Expanded(
              child: SingleChildScrollView(
                controller: _scrollController1,
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  controller: _scrollController2,
                  scrollDirection: Axis.horizontal,
                  child: data != null && isDataEmpty
                      ? WebReportCard(
                          data: data.data?.reversed.toList(),
                        )
                      : const Center(
                          child: Text('No data to show'),
                        ),
                ),
              ),
            );
          }, error: (e, s) {
            print('Error: $e $s');
            return const Center(
              child: Text('Error Can\'t load data at the moment'),
            );
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        ],
      ),
    );
  }
}
