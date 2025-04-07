import 'package:app/controller/mqtt_controller/mqtt_controller.dart';
import 'package:app/utilz/App_dialog.dart';
import 'package:app/views/dashboard/custom_widget/temperature/temperature.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TemperatureContainer extends StatelessWidget {
  final MqttController _mqttController = Get.find<MqttController>();
  TemperatureContainer({Key? key}) : super(key: key);

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
                //cw in=>return
                TemperatureWidget(
                    title: "Return", temperature: _mqttController.temp1.value),
                SizedBox(
                  width: Get.width * 0.02,
                ),
                //cw out =>cw out
                TemperatureWidget(
                    title: "Supply", temperature: _mqttController.temp2.value),
                SizedBox(
                  width: Get.width * 0.02,
                ),
                TemperatureWidget(
                    title: "Suction", temperature: _mqttController.temp3.value),
                SizedBox(
                  width: Get.width * 0.02,
                ),
                TemperatureWidget(
                    title: "Discharge",
                    temperature: _mqttController.temp4.value),
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

  const TemperatureWidget({
    required this.title,
    required this.temperature,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color tempColor = temperature >= 35 ? Colors.red : const Color.fromARGB(255, 245, 172, 172);

    return Container(
      height: Get.height * 0.14,
      width: Get.width * 0.2,
      decoration: BoxDecoration(
        // boxShadow: [BoxShadow( color: Colors.green.shade100,blurRadius: 2,spreadRadius: 2),],
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.green.withAlpha(50), 
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
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
  }
}

