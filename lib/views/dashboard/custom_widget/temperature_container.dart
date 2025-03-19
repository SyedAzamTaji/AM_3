import 'package:flutter/material.dart';
import 'package:get/get.dart';
class TemperatureContainer extends StatelessWidget {
  const TemperatureContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      
         Container(
          padding: EdgeInsets.all(Get.width * 0.04),
          margin: EdgeInsets.all(Get.width * 0.05),
          width: Get.width * 0.9, // Responsive Width
          height: Get.height * 0.3, // Responsive Height
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(Get.width * 0.03),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Header Row (Title + Settings Icon)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Temperatures",
                    style: TextStyle(fontSize: Get.width * 0.06, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Icon(Icons.settings, color: Colors.white, size: Get.width * 0.07),
                ],
              ),

              SizedBox(height: Get.height * 0.02),

              /// **Row with 4 Temperature Sections**
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TemperatureWidget(title: "C.W. In", temperature: 24.5),
                  TemperatureWidget(title: "C.W. Out", temperature: 28.3),
                  TemperatureWidget(title: "Suction", temperature: 12.8),
                  // TemperatureWidget(title: "Discharge", temperature: 35.2),
                ],
              ),
            ],
          ),
        
      
    );
  }
}
class TemperatureWidget extends StatelessWidget {
  final String title;
  final double temperature;

  const TemperatureWidget({
    required this.title,
    required this.temperature,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Heading
        Text(
          title,
          style: TextStyle(fontSize: Get.width * 0.045, fontWeight: FontWeight.bold, color: Colors.white),
        ),

        SizedBox(height: Get.height * 0.01),

        /// Icon + Temperature Value
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.thermostat, color: Colors.blue, size: Get.width * 0.07),
            SizedBox(width: Get.width * 0.02),
            Text(
              "${temperature.toStringAsFixed(1)}°C",
              style: TextStyle(fontSize: Get.width * 0.045, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}