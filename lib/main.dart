import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:sample_app/src/repo/provider.dart';
import 'package:sample_app/src/utils/routes.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseFunctions.instance.useFunctionsEmulator('192.168.1.44', 5001);
  // FirebaseFirestore.instance.useFirestoreEmulator('192.168.1.44', 5002);
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routes = ref.watch(routesRepo);

    return MaterialApp(
      title: 'Task Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
