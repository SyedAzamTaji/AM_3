import 'dart:developer';

import 'package:app/controller/mqtt_controller/mqtt_controller.dart';
import 'package:app/views/dashboard/custom_widget/pressure/pressure_widget.dart';
import 'package:app/views/dashboard/custom_widget/pressure/pressures_setting/high_pressure_setting.dart';
import 'package:app/views/dashboard/custom_widget/pressure/pressures_setting/low_pressure_setting.dart';
import 'package:app/views/dashboard/custom_widget/pressure/pressures_setting/oil_pressure_setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Pressures extends StatelessWidget {
  Pressures({super.key});
  final MqttController controller = Get.find<MqttController>();

  void _showPasswordDialog() {
    TextEditingController _passwordController = TextEditingController();
    Get.defaultDialog(
      title: "Enter Password",
      content: Column(
        children: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.number,
                  obscureText: controller.isObscured.value,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      // Rounded border
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isObscured.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        controller.isObscured.value =
                            !controller.isObscured.value; // Toggle visibility
                      },
                    ),
                  )),
            ),
          ),
          SizedBox(height: Get.height * 0.01),
          ElevatedButton(
            onPressed: () {
              if (_passwordController.text == "1234") {
                controller.isOilPressureVisible.value = !controller
                    .isOilPressureVisible.value; // Show Oil Pressure widget

                Get.back();
              } else {
                Get.snackbar("Error", "Wrong Password!",
                    backgroundColor: Colors.red);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Green Background
              foregroundColor: Colors.white, // White Text
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Rounded Corners
              ),
            ),
            child: Text("Unlock"),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * 0.2,
            ),
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.air_outlined,
                      size: 30,
                      color: Colors.red,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Pressures',
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
                    Get.to(() => LowPressureSetting());
                  },
                  child: Obx(
                    () => Pressurewidget(
                        title: "SUCTION",
                        // high: controller.psig1setlow.value.toString(),
                        low: controller.psig1sethigh.value.toString(),
                        setpoint: controller.psig1.value.toString(),
                        getColorLogic: (pressure) => controller.psig1.value >=
                                controller.psig1sethigh.value
                            ? Colors.red
                            : Colors.white),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => HighPressureSetting());
                  },

                  child: Obx(
                    ()=> Pressurewidget(
                      title: "DISCHARGE",
                      high: controller.psig2setlow.value.toString(),
                      // low: controller.psig2sethigh.value.toString(),
                      setpoint: controller.psig2.value.toString(), getColorLogic: (pressure) => controller.psig2.value <=
                                controller.psig2setlow.value
                            ? Colors.red
                            : Colors.white ,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
                onLongPress:
                    _showPasswordDialog, // Long press to enter password
                child: Obx(
                  () => controller.isOilPressureVisible.value
                      ? GestureDetector(
                          onTap: () {
                            Get.to(() => OilPressureSetting());
                          },
                          child: Obx(
                              () => Pressurewidget(
                                title: "OIL",
                                // high: controller.psig3setlow.value.toString(),
                                low: controller.psig3sethigh.value.toString(),
                                setpoint: controller.psig3.value.toString(),
                                getColorLogic: (pressure) => controller.psig3.value >=
                                controller.psig3sethigh.value
                            ? Colors.red
                            : Colors.white,
                              ),
                            ),
                        )
                      : Icon(Icons.lock, color: Colors.white, size: 40),
                ) // Locked Icon
                ),
          ],
        ),
      ),
    );
  }
}
