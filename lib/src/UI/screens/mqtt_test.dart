import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:sample_app/src/repo/provider.dart';

class MqttClientData extends ConsumerWidget {
  const MqttClientData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MqttBrowserClient client =
        MqttBrowserClient('ws://159.89.171.158', '');

    final mqtt = ref.watch(mqttProvider(client));

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('This is profile screen'),
          ElevatedButton(
            onPressed: () async {
              mqtt.connect();
            },
            child: const Text('Fetch mqtt data'),
          ),
          ElevatedButton(
            onPressed: () async {
              mqtt.disconnect();
            },
            child: const Text('Disconnect'),
          ),
        ],
      ),
    );
  }
}
