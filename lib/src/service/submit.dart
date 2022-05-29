import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:dio/dio.dart';
import 'package:nanoid/nanoid.dart';
import 'package:sample_app/src/data/create_task.dart';
import 'package:sample_app/src/data/tasks.dart';

class DioClient {
  DioClient();

  final Dio dio = Dio();
  final _baseUrl = 'https://warm-eyrie-19537.herokuapp.com';

  Future<TaskResponse?> getTask() async {
    TaskResponse? data;

    try {
      Response taskData = await dio.get(
        _baseUrl + '/task',
      );

      final json = taskData.data;
      final tasks = TaskResponse.fromJson(json);
      data = tasks;
      print(data.data?.first?.taskId);
    } catch (e, s) {
      print('Error while fetching task: $e $s');
    }
    return data;
  }

  Future<void> getTasksFromNotif() async {
    try {
      final callable =
          FirebaseFunctions.instance.httpsCallable('sendToTopic').call();
      final results = await callable;
      print(results.data);
    } catch (e, s) {
      print('$e $s');
    }
  }

  Future<bool> createTask({
    required CreateTaskData taskData,
  }) async {
    try {
      Response response = await dio.post(
        _baseUrl + '/addTask',
        data: taskData.toJson(),
      );

      // final id = nanoid(4);

      // final firebaseData = CreateTaskForFirebase(id, taskData.toJson());

      if (response.statusCode == 201) {
        // FirebaseFirestore.instance.collection('task').add(
        //       firebaseData.toJson(),
        //     );
        // getTasksFromNotif();
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      print('Error while creating task: $e $s');
      return false;
    }
  }
}
