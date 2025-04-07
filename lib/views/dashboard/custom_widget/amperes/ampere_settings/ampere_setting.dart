import 'package:app/controller/mqtt_controller/mqtt_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:app/controller/slider_controller/slider_controller.dart';

//yaha phase 1 tha change hogaya hay sb phase ek hi ma agay hay.
class AmpereSetting extends StatelessWidget {
  AmpereSetting({ Key? key,
  }) : super(key: key);
  final MqttController _mqttController = Get.find<MqttController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF002B36), Color(0xFF005662)],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(Get.width * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Current Setting",
                  style: TextStyle(
                    fontSize: Get.width * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: Get.height * 0.02),

                SizedBox(height: Get.height * 0.02),

                Expanded(
                  child: SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                      size: Get.width * 0.75,
                      startAngle: 150,
                      angleRange: 240,
                      customWidths: CustomSliderWidths(
                        progressBarWidth: Get.width * 0.015,
                        trackWidth: Get.width * 0.015,
                        // handlerSize: Get.width * 0.03,
                      ),
                      customColors: CustomSliderColors(
                        trackColor: Colors.white.withValues(alpha: 0.3),
                        progressBarColors: [
                          Colors.green,
                          Colors.lightGreenAccent
                        ],
                        dotColor: Colors.white,
                      ),
                    ),
                    min: 0,
                    max: 100,
                    initialValue: _mqttController.amp2.value.toDouble(),
                    onChange: null,
                    // (double value) {
                    //   _mqttController.updateSuctionCurrent(value);
                    // },
                    // onChangeEnd: (double value) {
                    //   _mqttController.buildJsonPayload;
                    // },
                    innerWidget: (double value) => Center(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.greenAccent.withValues(alpha: 0.8),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Text(
                          "${_mqttController.amp2.value.toDouble().toStringAsFixed(0)} Amp",
                          style: TextStyle(
                            fontSize: Get.width * 0.07,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                            shadows: [
                              Shadow(
                                blurRadius: 15,
                                color: Colors.greenAccent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: Get.height * 0.03),

               
                // _buildSlider("Low Ampere", Colors.blue),
                _buildSlider2("High Ampere", Colors.red),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSlider(String title, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: Get.width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.1,
                ),
              ),
              Obx(
                () => Text(
                  "${_mqttController.amp1high.value.toDouble().toStringAsFixed(0)} AMP",
                  style: TextStyle(
                    fontSize: Get.width * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ],
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(Get.context!).copyWith(
            thumbColor: color,
            activeTrackColor: color,
            inactiveTrackColor: Colors.white.withValues(alpha: 0.3),
            overlayColor: color.withValues(alpha: 0.3),
          ),
          child: Obx(
            () => Slider(
              value: _mqttController.amp1high.value.toDouble(),
              min: 0,
              max: 100,
              divisions: 100,
              onChanged: (double value) {
                _mqttController.updatePhase1lp(value);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSlider2(String title, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: Get.width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.1,
                ),
              ),
              Obx(
                () => Text(
                  "${_mqttController.amp1low.value.toDouble().toStringAsFixed(0)} AMP",
                  style: TextStyle(
                    fontSize: Get.width * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ],
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(Get.context!).copyWith(
            thumbColor: color,
            activeTrackColor: color,
            inactiveTrackColor: Colors.white.withValues(alpha: 0.3),
            overlayColor: color.withValues(alpha: 0.3),
          ),
          child: Obx(
            () => Slider(
              value: _mqttController.amp1low.value.toDouble(),
              min: 0,
              max: 100,
              divisions: 100,
              onChanged: (double value) {
                _mqttController.updatePhase1hp(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}
