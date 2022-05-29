import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_app/src/data/create_task.dart';
import 'package:sample_app/src/service/submit.dart';

final dioClientProvider = Provider((ref) {
  return DioClient();
});

final taskFetchProvider = FutureProvider((ref) {
  final repo = ref.read(dioClientProvider);

  return repo.getTask();
});

final taskCreateProvider =
    FutureProvider.family.autoDispose((ref, CreateTaskData payload) {
  final repo = ref.watch(dioClientProvider);

  print('provider being called');

  return repo.createTask(taskData: payload);
});
