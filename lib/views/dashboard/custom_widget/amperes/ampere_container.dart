import 'package:app/controller/mqtt_controller/mqtt_controller.dart';
import 'package:app/utilz/App_dialog.dart';
import 'package:app/views/dashboard/custom_widget/amperes/ampere_settings/ampere_setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmpereContainer extends StatelessWidget {
  final MqttController _mqttController = Get.find<MqttController>();

  AmpereContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.95,
      height: Get.height * 0.24,
      decoration: BoxDecoration(
        //  gradient: LinearGradient( begin: Alignment.topLeft,
        //                   end: Alignment.bottomRight,
        //                   colors: [
        //                     Colors.green.shade700,
        //                     Colors.white,
        //                   ], ),
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
                  "Currents",
                  style: TextStyle(
                    fontSize: Get.width * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      PasswordDialog().showPasswordDialog(AmpereSetting());
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
                    child: AmpereWidget(
                        title: "Phase 1", ampere: _mqttController.amp2.value)),
                SizedBox(width: Get.width * 0.01),
                Expanded(
                    child: AmpereWidget(
                        title: "Phase 2", ampere: _mqttController.amp3.value)),
                SizedBox(width: Get.width * 0.01),
                Expanded(
                    child: AmpereWidget(
                        title: "Phase 3", ampere: _mqttController.amp1.value)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AmpereWidget extends StatelessWidget {
  final MqttController _mqttController = Get.find<MqttController>();
  final String title;
  final int ampere;

  AmpereWidget({
    required this.title,
    required this.ampere,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.15,
      width: Get.width * 0.29,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Get.width * 0.03),
        //  gradient: LinearGradient(begin: Alignment.topLeft,
        //                   end: Alignment.bottomRight,
        //     colors: [Colors.black,Colors.white])
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
                fontSize: Get.width * 0.04,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.015),
          Icon(Icons.electric_bolt,
              color: Colors.yellow, size: Get.width * 0.08),
          SizedBox(height: Get.height * 0.005),
          Obx(() {
            Color ampColor =
                _mqttController.amp1low.value > _mqttController.amp2.value
                    ? Colors.red
                    : Colors.white;

            return Text(
              "$ampere Amp",
              style: TextStyle(
                fontSize: Get.width * 0.045,
                fontWeight: FontWeight.bold,
                color: ampColor,
              ),
            );
          })
        ],
      ),
    );
  }
}
