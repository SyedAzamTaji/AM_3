import 'package:app/controller/mqtt_controller/mqtt_controller.dart';
import 'package:app/views/dashboard/custom_widget/temperature/temperature_widget.dart';
import 'package:app/views/dashboard/custom_widget/temperature/temperatures_settings/return_setting.dart';
import 'package:app/views/dashboard/custom_widget/temperature/temperatures_settings/supply_setting.dart';
import 'package:app/views/dashboard/custom_widget/temperature/temperatures_settings/discharge_setting.dart';
import 'package:app/views/dashboard/custom_widget/temperature/temperatures_settings/suction_setting.dart';
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
                    Icons.settings,
                    size: 30,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Temperatures',
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
              GestureDetector(
                onTap: () {
                  Get.to(() => ReturnSetting());
                },
                child: Obx(
                  () => TemperatureWidget(
                    title: "RETURN",
                    setpoint: _mqttController.temp1.value.toString(),
                    high: _mqttController.temp1setlow.value.toString(),
                    low: _mqttController.temp1sethigh.value.toString(),
                    getColorLogic: (pressure) =>
                        (_mqttController.temp1sethigh.value >=
                                    _mqttController.temp1.value ||
                                _mqttController.temp1setlow.value <=
                                    _mqttController.temp1.value)
                            ? Colors.red
                            : Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => SupplySetting());
                },
                child: Obx(
                  () => TemperatureWidget(
                    title: "SUPPLY",
                    setpoint: _mqttController.temp2.value.toString(),
                    high: _mqttController.temp2setlow.value.toString(),
                    low: _mqttController.temp2sethigh.value.toString(),
                    getColorLogic: (pressure) =>
                        (_mqttController.temp2sethigh.value >=
                                    _mqttController.temp2.value ||
                                _mqttController.temp2setlow.value <=
                                    _mqttController.temp2.value)
                            ? Colors.red
                            : Colors.white,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => SuctionSetting());
                },
                child: Obx(
                  () => TemperatureWidget(
                    title: "SUCTION",
                    setpoint: _mqttController.temp3.value.toString(),
                    low: _mqttController.temp3sethigh.value.toString(),
                    getColorLogic: (pressure) => _mqttController.temp3.value <=
                            _mqttController.temp3sethigh.value
                        ? Colors.red
                        : Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => DischargeSetting());
                },
                child: Obx(
                  () => TemperatureWidget(
                    title: "DISCHARGE",
                    setpoint: _mqttController.temp4.value.toString(),
                    high: _mqttController.temp4setlow.value.toString(),
                    getColorLogic: (pressure) => _mqttController.temp4.value >=
                            _mqttController.temp4setlow.value
                        ? Colors.red
                        : Colors.white,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
