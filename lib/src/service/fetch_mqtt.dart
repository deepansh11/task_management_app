import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:nanoid/async.dart';

class FetchMqtt {
  MqttBrowserClient client;
  FetchMqtt({
    required this.client,
  });
  Future<MqttBrowserClient> connect() async {
    client.logging(on: true);

    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;
    client.keepAlivePeriod = 60;
    client.port = 1883;
    client.websocketProtocols = ['ws'];

    final id = await nanoid();

    final MqttConnectMessage connMessage = MqttConnectMessage()
        .authenticateAs('clevercare', 'sacC2p7rFaLj')
        .withClientIdentifier(id)
        .withWillTopic('willTopic')
        .withWillMessage('Hello')
        .startClean()
        .withWillQos(
          MqttQos.atLeastOnce,
        );

    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } catch (e, s) {
      print('Error occurred while connecting to mqtt client: $e $s');
      client.disconnect();
    }

    return client;
  }

  Future<String> fetchLocationData() async {
    client.subscribe('zone_wise_location', MqttQos.atMostOnce);
    String payload = '';

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);

      print('Received message:$payload from topic: ${c[0].topic}>');
    });

    return payload;
  }

  void disconnect() {
    client.disconnect();
  }

  // connection succeeded
  void onConnected() {
    print('Connected');
    fetchLocationData();
  }

// unconnected
  void onDisconnected() {
    print('Disconnected');
    disconnect();
  }

// subscribe to topic succeeded
  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

// subscribe to topic failed
  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

// PING response received
  void pong() {
    print('Ping response client callback invoked');
  }
}
