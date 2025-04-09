import 'package:app/controller/mqtt_controller/mqtt_controller.dart';
import 'package:app/utilz/App_dialog.dart';
import 'package:app/views/dashboard/custom_widget/temperature/temperature.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TemperatureContainer extends StatelessWidget {
  final MqttController _mqttController = Get.find<MqttController>();
  TemperatureContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.95,
      height: Get.height * 0.24,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(Get.width * 0.03),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Temperatures",
                  style: TextStyle(
                      fontSize: Get.width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                GestureDetector(
                    onTap: () {
                      PasswordDialog().showPasswordDialog(Temperature());
                    },
                    child: Icon(Icons.settings,
                        color: Colors.white, size: Get.width * 0.07)),
              ],
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TemperatureWidget(
                  title: "Return",
                  temperature: _mqttController.temp1.value,
                  getColorLogic: () => (_mqttController.temp1sethigh.value >=
                              _mqttController.temp1.value ||
                          _mqttController.temp1setlow.value <=
                              _mqttController.temp1.value)
                      ? Colors.red
                      : Colors.white,
                ),
                SizedBox(
                  width: Get.width * 0.02,
                ),
                TemperatureWidget(
                  title: "Supply",
                  temperature: _mqttController.temp2.value,
                  getColorLogic: () => (_mqttController.temp2sethigh.value >=
                              _mqttController.temp2.value ||
                          _mqttController.temp2setlow.value <=
                              _mqttController.temp2.value)
                      ? Colors.red
                      : Colors.white,
                ),
                SizedBox(
                  width: Get.width * 0.02,
                ),
                TemperatureWidget(
                  title: "Suction",
                  temperature: _mqttController.temp3.value,
                  getColorLogic: () => _mqttController.temp3.value <=
                          _mqttController.temp3sethigh.value
                      ? Colors.red
                      : Colors.white,
                ),
                SizedBox(
                  width: Get.width * 0.02,
                ),
                TemperatureWidget(
                  title: "Discharge",
                  temperature: _mqttController.temp4.value,
                  getColorLogic: () => _mqttController.temp4.value >=
                          _mqttController.temp4setlow.value
                      ? Colors.red
                      : Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TemperatureWidget extends StatelessWidget {
  final String title;
  final int temperature;
  final Color Function()? getColorLogic;

  TemperatureWidget({
    required this.title,
    required this.temperature,
    Key? key,
    this.getColorLogic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tempColor = getColorLogic != null ? getColorLogic!() : Colors.white;

      return Container(
        height: Get.height * 0.14,
        width: Get.width * 0.2,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.green.withAlpha(50),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.01),
            Text(
              title,
              style: TextStyle(
                  fontSize: Get.width * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: Get.height * 0.01),
            Icon(Icons.thermostat, color: Colors.blue, size: Get.width * 0.07),
            SizedBox(width: Get.width * 0.02),
            Text(
              "${temperature.toStringAsFixed(1)}°C",
              style: TextStyle(
                  fontSize: Get.width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: tempColor),
            ),
          ],
        ),
      );
    });
  }
}
