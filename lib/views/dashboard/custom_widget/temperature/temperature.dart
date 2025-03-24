import 'package:app/controller/mqtt_controller/mqtt_controller.dart';
import 'package:app/views/dashboard/custom_widget/temperature/temperature_widget.dart';
import 'package:app/views/dashboard/custom_widget/temperature/temperatures_settings/chill_in_setting.dart';
import 'package:app/views/dashboard/custom_widget/temperature/temperatures_settings/chill_out_setting.dart';
import 'package:app/views/dashboard/custom_widget/temperature/temperatures_settings/discharge_setting.dart';
import 'package:app/views/dashboard/custom_widget/temperature/temperatures_settings/suction_setting.dart';
import 'package:app/views/dashboard/settings_screens/discharge_setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Temperature extends StatelessWidget {
  Temperature({super.key});
  final MqttController _mqttController = Get.find<MqttController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.thermostat,
                    size: 30,
                    color: Colors.red,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'TEMPERATURES',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(onTap: (){
                Get.to(()=> ChillInSetting());
              },
                child: Obx(
                  ()=> TemperatureWidget(
                      title: "CHILLED WATER IN",
                      setpoint: _mqttController.temp1.value.toString(),
                      high: _mqttController.temp1setlow.value.toString(),
                      low: _mqttController.temp1sethigh.value.toString(),),
                ),
              ),
              GestureDetector(onTap: (){
                     Get.to(()=> ChillOutSetting());
              },
                child: Obx(
                  ()=> TemperatureWidget(
                      title: "CHILLED WATER OUT",
                      setpoint: _mqttController.temp2.value.toString(),
                      high: _mqttController.temp2setlow.value.toString(),
                      low: _mqttController.temp2sethigh.value.toString(),),
                ),
              )
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(onTap: (){
                     Get.to(()=> SuctionSetting());
              },
                child: Obx(
                  ()=> TemperatureWidget(
                      title: "SUCTION",
                      setpoint: _mqttController.temp3.value.toString(),
                      high:_mqttController.temp3setlow.value.toString(),
                      low: _mqttController.temp3sethigh.value.toString()),
                ),
              ),
              GestureDetector(onTap: (){
                     Get.to(()=> DischargeSetting());
              },
                child: Obx(
                  ()=> TemperatureWidget(
                      title: "DISCHARGE",
                      setpoint: _mqttController.temp4.value.toString(),
                      high: _mqttController.temp4setlow.value.toString(),
                      low: _mqttController.temp4sethigh.value.toString()),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}