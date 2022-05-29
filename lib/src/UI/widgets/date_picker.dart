import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sample_app/src/repo/provider.dart';

class DatePicker extends ConsumerStatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  ConsumerState<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends ConsumerState<DatePicker> {
  late TextEditingController controller;
  late SelectDate prov;

  DateTime? _chosenDateTime;

  void _showDatePicker(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: CupertinoDatePicker(
                      minimumDate: DateTime.now(),
                      onDateTimeChanged: (val) {
                        setState(() {
                          _chosenDateTime = val;
                          if (_chosenDateTime != null) {
                            final d = _chosenDateTime ?? DateTime.now();

                            final date = DateFormat.yMd().add_Hms().format(d);
                            controller.text = date;
                          }
                        });
                        prov.selectDate(controller.text);
                      },
                    ),
                  ),
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              ),
            ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();

    final date = DateFormat.yMd().add_Hms().format(DateTime.now());

    controller.text = date.toString();
    prov = ref.read(dateProvider.notifier);
    prov.selectDate(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        _showDatePicker(context);
      },
      controller: controller,
      decoration: const InputDecoration(
        label: Text('Schedule Time'),
      ),
      readOnly: true,
      validator: (s) {
        if (s != null && s.isNotEmpty) {
          return null;
        } else {
          return;
        }
      },
    );
  }
}
