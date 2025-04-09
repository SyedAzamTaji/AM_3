import 'package:app/controller/mqtt_controller/mqtt_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class NotificationScreen extends StatelessWidget {
  final MqttController _mqttController=Get.put(MqttController()); 
   NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: Obx(() => ListView.builder(
        itemCount: _mqttController.notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.notification_important),
            title: Text(_mqttController.notifications[index]),
          );
        },
      )),
    );
  }
  }
