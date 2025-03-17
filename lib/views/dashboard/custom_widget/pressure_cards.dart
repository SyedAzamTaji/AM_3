import 'package:app/controller/mqtt_controller/mqtt_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OilTemperatureCard extends StatelessWidget {
  final MqttController controller;

  const OilTemperatureCard({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( width: Get.width * 0.9,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
           color: Colors.black.withValues( alpha:  0.5),
            borderRadius: BorderRadius.circular(12),
          ),
      
      child: Row(
       
        children: [
          Icon(
            Icons.thermostat_outlined,
            color: Colors.blue,
            size: 40,
          ),
          Column(
         crossAxisAlignment:  CrossAxisAlignment.start,
            children: [
              const Text(
                'Oil Pressure ',
               
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Obx(() {
                return Text(
                  controller.isOilTemperatureOn.value ? 'OPEN' : 'CLOSE',
                  style: TextStyle(
                    color: controller.isOilTemperatureOn.value
                        ? Colors.green
                        : Colors.red,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
