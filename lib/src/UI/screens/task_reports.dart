import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sample_app/src/UI/widgets/web_report_card.dart';
import 'package:sample_app/src/repo/tasks.dart';

class DataSubmitted extends ConsumerStatefulWidget {
  const DataSubmitted({Key? key}) : super(key: key);

  static const routeName = '/dataSubmitted';

  @override
  ConsumerState<DataSubmitted> createState() => _DataSubmittedState();
}

class _DataSubmittedState extends ConsumerState<DataSubmitted> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(taskFetchProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Text(
              'Task Lists',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          list.when(data: (data) {
            return Expanded(
                child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: data != null
                    ? WebReportCard(
                        data: data,
                      )
                    : const Center(
                        child: Text('No data to show'),
                      ),
              ),
            ));
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
