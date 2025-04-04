import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Pressurewidget extends StatelessWidget {
  final String title;
  final String setpoint;
  final String? high;
  final String? low;

  const Pressurewidget({
    super.key,
    required this.title,
    required this.setpoint,
    this.high,
    this.low,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: Get.width * 0.49,
        width: Get.width * 0.4,
        decoration: BoxDecoration(
          color: Colors.grey.withAlpha(80),
          borderRadius: BorderRadius.circular(12),
        ),
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
            SizedBox(height: Get.height * 0.042),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  child: CircularProgressIndicator(
                    value: (double.parse(setpoint) / 1000),
                    strokeWidth: 4,
                    backgroundColor: Colors.white54,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                  ),
                ),
                Text(
                  "${(double.parse(setpoint)).toInt()} P",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.04),
            if (low != null || high != null)
              Container(
                width: Get.width * 1,
                height: Get.height * 0.055,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green.withOpacity(0.8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: (low != null && high != null)
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    children: [
                      if (low != null)
                        Row(
                          children: [
                            const Text('Low: ',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            Text(low!,
                                style: const TextStyle(fontSize: 13)),
                          ],
                        ),
                      if (high != null)
                        Row(
                          children: [
                            const Text('High: ',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            Text(high!,
                                style: const TextStyle(fontSize: 13)),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
