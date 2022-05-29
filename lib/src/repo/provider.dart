import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:sample_app/src/service/fetch_mqtt.dart';

final dateProvider = StateNotifierProvider<SelectDate, String>((ref) {
  return SelectDate();
});

class SelectDate extends StateNotifier<String> {
  SelectDate() : super('');

  void selectDate(String date) {
    state = date;
  }

  String returnDate() {
    return state;
  }
}

final mqttProvider = Provider.family((ref, MqttServerClient payload) {
  return FetchMqtt(client: payload);
});
