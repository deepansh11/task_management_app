import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_app/src/UI/screens/task_created.dart';
import 'package:sample_app/src/UI/screens/task_reports.dart';
import 'package:sample_app/src/UI/screens/home_screen.dart';

final routesProvider = Provider((ref) {
  return Routes();
});

final routesRepo = Provider(
  (ref) {
    final repo = ref.read(routesProvider);
    return repo.routesMap;
  },
);

class Routes {
  final Map<String, Widget Function(BuildContext)> routesMap = {
    HomeScreen.routeName: (BuildContext context) => const HomeScreen(),
    TaskCard.routeName: (BuildContext context) => const TaskCard(),
  };
}
