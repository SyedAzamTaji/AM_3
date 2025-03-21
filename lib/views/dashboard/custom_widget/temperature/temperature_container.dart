import 'package:app/controller/mqtt_controller/mqtt_controller.dart';
import 'package:app/views/dashboard/custom_widget/temperature/temperature.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class TemperatureContainer extends StatelessWidget {
  final MqttController _mqttController=Get.find<MqttController>();
   TemperatureContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      
         Container(
          
          width: Get.width * 0.95, 
          height: Get.height * 0.24, 
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(Get.width * 0.03),
          ),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              /// Header Row (Title + Settings Icon)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Temperatures",
                      style: TextStyle(fontSize: Get.width * 0.06, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    GestureDetector(  onTap: (){
                      Get.to(()=>Temperature());
                    },
                      child: Icon(Icons.settings, color: Colors.white, size: Get.width * 0.07)),
                  ],
                ),
              ),
         
              SizedBox(height: Get.height * 0.02),
         
              /// **Row with 4 Temperature Sections**
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TemperatureWidget(title: "C.W. In", temperature: _mqttController.temp1.value),SizedBox(width: Get.width*0.02,),
                  TemperatureWidget(title: "C.W. Out", temperature: _mqttController.temp2.value),SizedBox(width: Get.width*0.02,),
                  TemperatureWidget(title: "Suction", temperature: _mqttController.temp3.value),SizedBox(width: Get.width*0.02,),
                  TemperatureWidget(title: "Discharge", temperature: _mqttController.temp4.value),
                ],
              ),
            ],
          ),
                 
               
             );
  }
}
class TemperatureWidget extends StatelessWidget {
  final String title;
  final int temperature;

  const TemperatureWidget({
    required this.title,
    required this.temperature,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: Get.height *0.13,
                  width: Get.width*0.2,
                  decoration: BoxDecoration(
                    // boxShadow: [BoxShadow( color: Colors.green.shade100,blurRadius: 2,spreadRadius: 2),],
                    borderRadius:BorderRadius.all(Radius.circular(10)),
                    color: Colors.green.withValues(alpha: 0.2),
                  ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start
      ,
        children: [
      SizedBox(height: 10,),
          Text(
            title,
            style: TextStyle(fontSize: Get.width * 0.04, fontWeight: FontWeight.bold, color: Colors.white),
          ),
      
          SizedBox(height: Get.height * 0.01),
      
          /// Icon + Temperature Value
          Icon(Icons.thermostat, color: Colors.blue, size: Get.width * 0.07),
          SizedBox(width: Get.width * 0.02),
          Text(
            "${temperature.toStringAsFixed(1)}°C",
            style: TextStyle(fontSize: Get.width * 0.045, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}