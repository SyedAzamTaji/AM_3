import 'dart:math';

import 'package:app/controller/mqtt_controller/mqtt_controller.dart';
import 'package:app/controller/theme_controller.dart';
import 'package:app/views/dashboard/custom_widget/amperes/ampere_container.dart';
import 'package:app/views/dashboard/custom_widget/pressure/pressure_container.dart';
import 'package:app/views/notification/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_widget/temperature/temperature_container.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ThemeController themeController=Get.find<ThemeController>();
  final MqttController _mqttController = Get.put(MqttController());
  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          backgroundColor:Get.isDarkMode ? Colors.black : Colors.grey.shade100,
          body: Container(
            decoration: BoxDecoration(color: Colors.white
                // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [Colors.white, Colors.white],
                // ),
                ),
            child: SingleChildScrollView(
              child: Container(color: themeController.isDarkMode.value ? Colors.black : Colors.grey.shade100,
                child: Column(
                  children: [
                    AppBar(
                      elevation: 4,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(25),
                        ),
                      ),
                      title: const Text(
                        "Alert Master",
                        style: TextStyle(fontSize: 26, color: Colors.white),
                      ),
                      centerTitle: true,
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.notifications,
                              color: Colors.white),
                          onPressed: () {
                            // Get.to(() => NotificationScreen());
                          },
                        ),
                        IconButton(
                          icon: Icon(Get.isDarkMode
                              ? Icons.dark_mode
                              : Icons.light_mode),
                          onPressed: () {
                           themeController .toggleTheme(
                           );
                          }
                        ),
                        
                      ],
                    ),
                    SizedBox(height: Get.height * 0.012),
                    Center(
                      child: Container(
                        height: Get.height * 0.08,
                        width: Get.width * 0.95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black..withValues(alpha: 0.5),
                          // gradient: LinearGradient(
                          //   begin: Alignment.topCenter,
                          //   end: Alignment.topRight,
                          //   colors: [
                          //     Colors.black,
                          //     Colors.white,
                          //   ],
                          // ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Compressor Status",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _mqttController.comp1status.value == 0
                                    ? 'ON'
                                    : 'OFF',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: _mqttController.comp1status.value == 0
                                      ? Colors.green
                                      : Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: themeController.isDarkMode.value ? Colors.black : Colors.grey.shade100,
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          TemperatureContainer(),
                          PressureContainer(),
                          AmpereContainer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
