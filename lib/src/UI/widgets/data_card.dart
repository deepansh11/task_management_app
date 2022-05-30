import 'package:flutter/material.dart';

class DataCards extends StatelessWidget {
  const DataCards({
    Key? key,
    required this.title,
    this.data1,
    this.subTitle1,
    this.data2,
    this.subTitle2,
    this.data3,
    this.subTitle3,
    this.data4,
    this.subTitle4,
  }) : super(key: key);
  final String title;
  final String? data1;
  final String? subTitle1;

  final String? data2;
  final String? subTitle2;

  final String? data3;
  final String? subTitle3;

  final String? data4;
  final String? subTitle4;

  @override
  Widget build(BuildContext context) {
    const theme = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(20)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  data1 != null && subTitle1 != null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                data1.toString(),
                                style: theme,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                subTitle1.toString(),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  data2 != null && subTitle2 != null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                data2.toString(),
                                style: theme,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                subTitle2.toString(),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  data3 != null && subTitle3 != null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                data3.toString(),
                                style: theme,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                subTitle3.toString(),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  data4 != null && subTitle4 != null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                data4.toString(),
                                style: theme,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                subTitle4.toString(),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
