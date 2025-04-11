import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:app/notification_service/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

//new controller

class MqttController extends GetxController {
  String topicSSIDvalue = "";
  var amp1 = 18.obs; //phase3 ka current ampere
  var amp2 = 15.obs; //phase1 ka current ampere
  var amp3 = 13.obs; //phase2 ka current ampere
  var temp1 = 16.obs; //cw in current temp
  var temp2 = 18.obs; //cw out current temp
  var temp3 = 24.obs; //suction current temp
  var temp4 = 80.obs; //discharge ka current temp
  var psig1 = 18.25.obs; //low pressure ka current pressure
  var psig2 = 25.24.obs; //high ka current pressure
  var psig3 = 30.18.obs; //oil pressure ka current pressure
  var temp1setlow = 18.obs; //chill in ka low slider
  var temp2setlow = 25.obs;
  var temp3setlow = 25.obs; //suction ka low slider
  var temp4setlow = 81.obs; //Discharge ka low slider
  var psig1setlow = 17.obs; //low pressure setting ka high slider
  var psig2setlow = 100.obs; //high ka high slider
  var psig3setlow = 70.obs; //oil pressure ka high slider

  var temp1sethigh = 18.obs;
  var temp2sethigh = 18.obs;
  var temp3sethigh = 26.obs; //suction ka high slider
  var temp4sethigh = 82.obs; //Discharge ka high slider
  var psig1sethigh = 18.obs; //low pressure setting ka low slider
  var psig2sethigh = 90.obs; //high ka low slider
  var psig3sethigh = 50.obs; //oil pressure ka low slider

  var amp1high = 30.obs; //phase 1 ko low slider
  var amp2high = 40.obs; //phase 2 ko low slider
  var amp3high = 50.obs; //phase 3 ko low slider
  var amp1low = 35.obs; //phase 1 ka high slider
  var amp2low = 25.obs; //phase 2 ko high slider
  var amp3low = 15.obs; //phase 3 ko high slider
  var comp1status = 1.obs;
  

  RxString mqttBroker = 'a31qubhv0f0qec-ats.iot.eu-north-1.amazonaws.com'.obs;
  RxInt port = 8883.obs;
  var clientId = "flutter459gjmhhg".obs;

  var receivedMessage = "".obs;

  var isConnected = false.obs;
  var message = "".obs;

  // var correctPassword = "1234567".obs;
  // var isPasswordCorrect = false.obs;
  // var currentCardIndex = 0.obs;
  // var isOilTemperatureOn = false.obs;
  var isOilPressureVisible = false.obs; 
  var isObscured=false.obs; 
  MqttServerClient? client;

//notification

  // var notifications = <String>[].obs;
  //  void updateTemp(int newTemp) {
  //   temp1.value = newTemp;
  //   if (newTemp > temp1setlow.value || newTemp < temp1sethigh.value) {
  //     String msg = "Temperature Alert: $newTemp°C";
  //     NotificationService.showNotification(title: "Temperature Alert", body: msg);
  //     notifications.add(msg);
  //   }
  // }

  // void updatePressure(double newPressure) {
  //   psig1.value = newPressure;
  //   if (newPressure > psig1sethigh.value || newPressure < psig1.value) {
  //     String msg = "Pressure Alert: $newPressure PSI";
  //     NotificationService.showNotification(title: "Pressure Alert", body: msg);
  //     notifications.add(msg);
  //   }
  // }

  // void updateAmpere(int newAmpere) {
  //   amp2.value = newAmpere;
  //   if (newAmpere > amp1low.value || newAmpere < amp2.value) {
  //     String msg = "Ampere Alert: $newAmpere A";
  //     NotificationService.showNotification(title: "Ampere Alert", body: msg);
  //     notifications.add(msg);
  //   }
  // }

  //notification

  @override
  void onInit() {
    log("MQTT controller onit");
    super.onInit();
    _setupMqttClient();
    _connectMqtt();
  }

  updatetopicSSIDvalue(value) {
    print("log 3232:${value} ");
    topicSSIDvalue = value;
    update();
  }

  void _setupMqttClient() {
    client =
        MqttServerClient.withPort(mqttBroker.value, clientId.value, port.value);
    client?.secure = true;
    client?.keepAlivePeriod = 60;
    client?.setProtocolV311();
    client?.logging(on: false);

    client?.onDisconnected = _onDisconnected;
    client?.onConnected = _onConnected;
    client?.onSubscribed = _onSubscribed;
  }

  void _onDisconnected() {
    log('Disconnected from MQTT broker.');

    isConnected.value = false;
    Future.delayed(
        Duration(
          seconds: 5,
        ),
        _connectMqtt);
  }

  void _onConnected() {
    log('Connected to Onconnect.');
    isConnected.value = true;

    client?.subscribe('/KRC/AM3-AAA001', MqttQos.atLeastOnce);
    client?.updates?.listen((List<MqttReceivedMessage<MqttMessage>>? messages) {
      final MqttPublishMessage msg = messages![0].payload as MqttPublishMessage;

      log('subscribe.');
      log('subscribe_____/KRC/$topicSSIDvalue');
      final String topic = messages[0].topic;
      final String message =
          MqttPublishPayload.bytesToStringAsString(msg.payload.message);
      log(topic);
      log("message1");
      receivedMessage.value = message;

      if (topic == "/KRC/AM3-AAA001") {
        print('Message Received on /KRC/$topicSSIDvalue: $message');
        _handleMessage(message);
      }
    });
  }

  // Future<void> _connectMqtt() async {
  //   while (true) {
  //     try {
  //       log('Attempting to connect...');
  //       await client?.connect();
  //       if (client?.connectionStatus?.state == MqttConnectionState.connected) {
  //         log('Connected to MQTT broker.');
  //         isConnected.value = true;
  //         break;
  //       } else {
  //         log('Connection failed: ${client?.connectionStatus?.state}');
  //       }
  //     } catch (e) {
  //       log('Exception while connecting: $e');
  //     }
  //     await Future.delayed(Duration(seconds: 5));
  //   }
  // }

  Future<void> _connectMqtt() async {
    if (client == null) {
      log("MQTT Client is not initialized!");
      return;
    }

    try {
      log("Loading certificates...");
      final context = SecurityContext.defaultContext;

      final rootCa = await rootBundle.load('assets/root-CA.crt');
      final deviceCert = await rootBundle.load('assets/Temperature.cert.pem');
      final privateKey =
          await rootBundle.load('assets/Temperature.private.key');

      context.setClientAuthoritiesBytes(rootCa.buffer.asUint8List());
      context.useCertificateChainBytes(deviceCert.buffer.asUint8List());
      context.usePrivateKeyBytes(privateKey.buffer.asUint8List());

      client!.securityContext = context;
      client!.connectionMessage = MqttConnectMessage()
          .withClientIdentifier(clientId.value)
          .startClean();

      log("Connecting to MQTT broker...");
      await client!.connect();

      if (client!.connectionStatus!.state == MqttConnectionState.connected) {
        log('Connected to MQTT broker.');
        isConnected.value = true;
      } else {
        log('Connection failed: ${client!.connectionStatus!.state}');
        client!.disconnect();
      }
    } catch (e) {
      log('MQTT client exception: $e');
      client?.disconnect();
    }
  }

  void _onSubscribed(String topic) {
    print('Subscribed to topic: $topic');
  }

  void _handleMessage(String message) async {
    try {
      Map<String, dynamic> jsonMap = jsonDecode(message);

      amp1.value = int.tryParse(jsonMap['value0']?.toString() ?? '') ?? 0;
      amp2.value = int.tryParse(jsonMap['value8']?.toString() ?? '') ?? 0;
      amp3.value = int.tryParse(jsonMap['value9']?.toString() ?? '') ?? 0;
      temp1.value = int.tryParse(jsonMap['value1']?.toString() ?? '') ?? 0;
      temp2.value = int.tryParse(jsonMap['value2']?.toString() ?? '') ?? 0;
      temp3.value = int.tryParse(jsonMap['value3']?.toString() ?? '') ?? 0;
      temp4.value = int.tryParse(jsonMap['value4']?.toString() ?? '') ?? 0;

      psig1.value = double.tryParse(jsonMap['value5']?.toString() ?? '') ?? 0.0;
      psig2.value = double.tryParse(jsonMap['value6']?.toString() ?? '') ?? 0.0;
      psig3.value = double.tryParse(jsonMap['value7']?.toString() ?? '') ?? 0.0;

      temp1setlow.value =
          int.tryParse(jsonMap['value10']?.toString() ?? '') ?? 0;
      temp2setlow.value =
          int.tryParse(jsonMap['value11']?.toString() ?? '') ?? 0;
      temp3setlow.value =
          int.tryParse(jsonMap['value12']?.toString() ?? '') ?? 0;
      temp4setlow.value =
          int.tryParse(jsonMap['value13']?.toString() ?? '') ?? 0;

      psig1setlow.value =
          int.tryParse(jsonMap['value14']?.toString() ?? '') ?? 0;
      psig2setlow.value =
          int.tryParse(jsonMap['value15']?.toString() ?? '') ?? 0;
      psig3setlow.value =
          int.tryParse(jsonMap['value16']?.toString() ?? '') ?? 0;

      temp1sethigh.value =
          int.tryParse(jsonMap['value21']?.toString() ?? '') ?? 0;
      temp2sethigh.value =
          int.tryParse(jsonMap['value22']?.toString() ?? '') ?? 0;
      temp3sethigh.value =
          int.tryParse(jsonMap['value23']?.toString() ?? '') ?? 0;
      temp4sethigh.value =
          int.tryParse(jsonMap['value24']?.toString() ?? '') ?? 0;

      psig1sethigh.value =
          int.tryParse(jsonMap['value25']?.toString() ?? '') ?? 0;
      psig2sethigh.value =
          int.tryParse(jsonMap['value26']?.toString() ?? '') ?? 0;
      psig3sethigh.value =
          int.tryParse(jsonMap['value27']?.toString() ?? '') ?? 0;

      amp1high.value = int.tryParse(jsonMap['value28']?.toString() ?? '') ?? 0;
      amp2high.value = int.tryParse(jsonMap['value29']?.toString() ?? '') ?? 0;
      amp3high.value = int.tryParse(jsonMap['value20']?.toString() ?? '') ?? 0;
      amp1low.value = int.tryParse(jsonMap['value17']?.toString() ?? '') ?? 0;
      amp2low.value = int.tryParse(jsonMap['value18']?.toString() ?? '') ?? 0;
      amp3low.value = int.tryParse(jsonMap['value19']?.toString() ?? '') ?? 0;
      comp1status.value =
          int.tryParse(jsonMap['value30']?.toString() ?? '') ?? 0;

      log("Received MQTT Data:");
      log("amp1 = $amp1");
      log("amp2 = $amp2");
      log("amp3 = $amp3");
      log("temp1 = $temp1");
      log("temp2 = $temp2");
      log("temp3 = $temp3");
      log("temp4 = $temp4");
      log("psig1 = $psig1");
      log("psig2 = $psig2");
      log("psig3 = $psig3");
      log("temp1setlow = $temp1setlow");
      log("temp2setlow = $temp2setlow");
      log("temp3setlow = $temp3setlow");
      log("temp4setlow = $temp4setlow");
      log("psig1setlow = $psig1setlow");
      log("psig2setlow = $psig2setlow");
      log("psig3setlow = $psig3setlow");
      log("temp1sethigh = $temp1sethigh");
      log("temp2sethigh = $temp2sethigh");
      log("temp3sethigh = $temp3sethigh");
      log("temp4sethigh = $temp4sethigh");
      log("psig1sethigh = $psig1sethigh");
      log("psig2sethigh = $psig2sethigh");
      log("psig3sethigh = $psig3sethigh");
      log("amp1high = $amp1high");
      log("amp2high = $amp2high");
      log("amp3high = $amp3high");
      log("amp1low = $amp1low");
      log("amp2low = $amp2low");
      log("amp3low = $amp3low");
      log("comp1status = $comp1status");
    } catch (e) {
      log("Error parsing JSON: $e");
    }
  }

  void buildJsonPayload() {
    Map<String, dynamic> jsonPayload = {
      "amp1": amp1.value.toString(),
      "amp2": amp2.value.toString(),
      "amp3": amp3.value.toString(),
      "temp1": temp1.value.toString(),
      "temp2": temp2.value.toString(),
      "temp3": temp3.value.toString(),
      "temp4": temp4.value.toString(),
      "psig1": psig1.value.toString(),
      "psig2": psig2.value.toString(),
      "psig3": psig3.value.toString(),
      "temp1set_LOW": temp1setlow.value.toString(),
      "temp2set_LOW": temp2setlow.value.toString(),
      "temp3set_LOW": temp3setlow.value.toString(),
      "temp4set_LOW": temp4setlow.value.toString(),
      "psig1set_LOW": psig1setlow.value.toString(),
      "psig2set_LOW": psig2setlow.value.toString(),
      "psig3set_LOW": psig3setlow.value.toString(),
      "temp1set_HIGH": temp1sethigh.value.toString(),
      "temp2set_HIGH": temp2sethigh.value.toString(),
      "temp3set_HIGH": temp3sethigh.value.toString(),
      "temp4set_HIGH": temp4sethigh.value.toString(),
      "psig1set_HIGH": psig1sethigh.value.toString(),
      "psig2set_HIGH": psig2sethigh.value.toString(),
      "psig3set_HIGH": psig3sethigh.value.toString(),
      "AMP1_HIGH": amp1high.value.toString(),
      "AMP2_HIGH": amp2high.value.toString(),
      "AMP3_HIGH": amp3high.value.toString(),
      "AMP1_LOW": amp1low.value.toString(),
      "AMP2_LOW": amp2low.value.toString(),
      "AMP3_LOW": amp3low.value.toString(),
      "comp1status": comp1status.value.toString(),
    };

    String jsonString = jsonEncode(jsonPayload);
    publishMessage(jsonString);
  }




  //Cw in ka low slider
  void updateChillInlp(double value) {
    temp1sethigh.value = value.toInt();
    buildJsonPayload();
    update();
  }

  //Cw in ka high slider
  void updateChillInhp(double value) {
    temp1setlow.value = value.toInt();
    buildJsonPayload();
    update();
  }

 

  //Cw out ka low slider
  void updateChillOutlp(double value) {
    temp2sethigh.value = value.toInt();
    buildJsonPayload();
    update();
  }

  //Cw out ka high slider
  void updateChillOuthp(double value) {
    temp2setlow.value = value.toInt();
    buildJsonPayload();
    update();
  }

 


  void updateSuctionLow(double value) {
    temp3sethigh.value = value.toInt();
    buildJsonPayload();
    update();
  }

  //low pressure ka low slider
  void updateLowPressurelp(double value) {
    psig1sethigh.value = value.toInt();
    buildJsonPayload();
    update();
  }

  //low pressure ka high slider
  void updateLowPressurehp(double value) {
    psig1setlow.value = value.toInt();
    buildJsonPayload();
    update();
  }

  //high pressure ka low slider
  void updateHighPressurelp(double value) {
    psig2sethigh.value = value.toInt();
    buildJsonPayload();
    update();
  }

  //high pressure ka high slider
  void updateHighPressurehp(double value) {
    psig2setlow.value = value.toInt();
    buildJsonPayload();
    update();
  }

  //oil pressure ka low slider
  void updateOilPressurelp(double value) {
    psig3sethigh.value = value.toInt();
    buildJsonPayload();
    update();
  }

  //oil pressure ka high slider
  void updateOilPressurehp(double value) {
    psig3setlow.value = value.toInt();
    buildJsonPayload();
    update();
  }

  //phase 1 ka low slider
  void updatePhase1lp(double value) {
    amp1high.value = value.toInt();
    buildJsonPayload();
    update();
  }

  //phase 1 ka high slider
  void updatePhase1hp(double value) {
    amp1low.value = value.toInt();
    buildJsonPayload();
    update();
  }

  //phase 2 ka low slider
  void updatePhase2lp(double value) {
    amp2high.value = value.toInt();
    buildJsonPayload();
    update();
  }

  //phase 2 ka high slider
  void updatePhase2hp(double value) {
    amp2low.value = value.toInt();
    buildJsonPayload();
    update();
  }

  //phase 3 ka low slider
  void updatePhase3lp(double value) {
    amp3high.value = value.toInt();
    buildJsonPayload();
    update();
  }

  //phase 3 ka high slider
  void updatePhase3hp(double value) {
    amp3low.value = value.toInt();
    buildJsonPayload();
    update();
  }

  
  void updateDischargeHigh(double value) {
    temp4setlow.value = value.toInt();
    buildJsonPayload();
    update();
  }

  void publishMessage(String message) {
    String topic = "/test/AM3-AAA001/1";
    if (client != null) {
      final builder = MqttClientPayloadBuilder();
      builder.addString(message);

      try {
        client!.publishMessage(
          topic,
          MqttQos.atLeastOnce,
          builder.payload!,
          retain: false,
        );
        log('Message published to $topic: $message');
      } catch (e) {
        log('Failed to publish message: $e');
      }
    }
  }


  @override
  void onClose() {
    super.onClose();
  }
}
