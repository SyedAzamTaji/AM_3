import 'package:app/controller/mqtt_controller/mqtt_controller.dart';
import 'package:app/utilz/App_dialog.dart';
import 'package:app/views/dashboard/custom_widget/pressure/pressure.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PressureContainer extends StatelessWidget {
  final MqttController _mqttController = Get.find<MqttController>();
  PressureContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Get.width * 0.02),
      child: Container(
        width: Get.width * 0.95,
        height: Get.height * 0.24,
        decoration: BoxDecoration(
          //  gradient: LinearGradient( begin: Alignment.topLeft,
          //                 end: Alignment.bottomRight,
          //                 colors: [
          //                   Colors.green.shade700,
          //                   Colors.white,
          //                 ], ),
           color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(Get.width * 0.03),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(Get.width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pressures",
                    style: TextStyle(
                      fontSize: Get.width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        PasswordDialog().showPasswordDialog(Pressures());
                      },
                      child: Icon(Icons.settings,
                          color: Colors.white, size: Get.width * 0.07)),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: PressureHomeWidget(
                          title: "Suction",
                          pressure: _mqttController.psig1.value,
                          userSetLow: _mqttController.psig1.value,
                          getColorLogic: (pressure) =>
                              _mqttController.psig1.value <=
                                      _mqttController.psig1sethigh.value
                                  ? Colors.red
                                  : Colors.white)),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  Expanded(
                      child: PressureHomeWidget(
                    title: "Discharge",
                    pressure: _mqttController.psig2.value,
                    userSetLow: _mqttController.psig2.value,
                    getColorLogic: (pressure) => _mqttController.psig2.value <=
                            _mqttController.psig2setlow.value
                        ? Colors.red
                        : Colors.white,
                  )),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  Expanded(
                      child: PressureHomeWidget(
                    title: "Oil",
                    pressure: _mqttController.psig3.value,
                    userSetLow: _mqttController.psig3.value,
                    getColorLogic: (pressure) => _mqttController.psig3.value <=
                            _mqttController.psig3sethigh.value
                        ? Colors.red
                        : Colors.white,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PressureHomeWidget extends StatelessWidget {
  final String title;
  final double pressure;
  final double userSetLow;
  final Color Function(double pressure)? getColorLogic;
  const PressureHomeWidget({
    required this.title,
    required this.pressure,
    super.key,
    required this.userSetLow,
    this.getColorLogic,
  });
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final psi = pressure;
      final pressureColor =
          getColorLogic != null ? getColorLogic!(psi) : Colors.white;

      return Container(
        height: Get.height * 0.15,
        width: Get.width * 0.29,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Get.width * 0.03),
          // gradient: LinearGradient(begin: Alignment.topLeft,
          //                 end: Alignment.bottomRight,
          //   colors: [Colors.black,Colors.white])
            color: Colors.grey.shade800,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Get.width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.015),
            Icon(Icons.speed, color: Colors.red, size: Get.width * 0.08),
            SizedBox(height: Get.height * 0.005),
            Text(
              "$psi PSI",
              style: TextStyle(
                fontSize: Get.width * 0.045,
                fontWeight: FontWeight.bold,
                color: pressureColor,
              ),
            ),
          ],
        ),
      );
    });
  }
}
