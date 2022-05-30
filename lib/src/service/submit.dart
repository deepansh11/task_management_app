import 'dart:async';

import 'package:dio/dio.dart';
import 'package:sample_app/src/data/create_task.dart';
import 'package:sample_app/src/data/tasks.dart';

class DioClient {
  DioClient();

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://warm-eyrie-19537.herokuapp.com/',
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "Origin,Content-Type",
        "Access-Control-Allow-Methods": "GET,POST,HEAD,OPTIONS,PUT,DELETE"
      },
    ),
  );

  Future<TaskResponse?> getTask() async {
    TaskResponse? data;

    try {
      Response taskData = await dio.get(
        '/task',
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

  Future<bool> createTask({
    required CreateTaskData taskData,
  }) async {
    try {
      Response response = await dio.post(
        '/addTask',
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
