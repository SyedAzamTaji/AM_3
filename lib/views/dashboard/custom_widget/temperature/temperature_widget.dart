import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class TemperatureWidget extends StatelessWidget {
  final String title;
  final String setpoint;
  final String high;
  final String low;
  const TemperatureWidget(
      {super.key,
      required this.title,
      required this.setpoint,
      required this.high,
      required this.low});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: Get.width * 0.4,
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        width: Get.width * 0.45,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
              SizedBox(height: Get.height*0.02),
            // Icon(icon, size: 40, color: color),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  // height: Get.height * 0.059,
                  // width: Get.width * 0.12,
                  child: CircularProgressIndicator(
                    value: (double.parse(setpoint) / 100),
                    strokeWidth: 4,
                    backgroundColor: Colors.white54,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                  ),
                ),
                
                Text(
                  "${(double.parse(setpoint)).toInt()}°C", // Show percentage
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, 

                    
                  ),
                ),
              ],
            ),
            // Center(
            //   child: SizedBox(
            //     height: Get.height * 0.095,
            //     // width: 70,
            //     child: Lottie.asset(
            //       'assets/images/thermometer.json', // Correct path
            //       width: 200,
            //       height: 200,
            //       fit: BoxFit.contain,
            //     ),
            //   ),
            // ),
            // Icon(Icons.thermostat,size: 70,color: Colors.red,),

            // Text(
            //   "$setpoint°C",
            //   style: const TextStyle(fontSize: 14, color: Colors.white),
            //   textAlign: TextAlign.center,
            // ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.green.withValues(alpha: 0.8),
              ),
              width: Get.width * 1,
              height: Get.height * 0.055,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text('Low: ',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold)),
                        Text(low,
                            style: const TextStyle(
                              fontSize: 13,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('High: ',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold)),
                        Text(high,
                            style: const TextStyle(
                              fontSize: 13,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}