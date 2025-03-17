import 'package:app/controller/mqtt_controller/mqtt_controller.dart';
import 'package:app/views/home/amphere_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AverageInfoCard extends StatelessWidget {
  AverageInfoCard({super.key});
  final MqttController _mqttController = Get.find<MqttController>();


  @override
  Widget build(BuildContext context) {
    
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
           width:Get.width * 0.9, 
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
           color: Colors.black.withValues( alpha:  0.5),
            borderRadius: BorderRadius.circular(12),
          ),
            child: Column( crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(
                        "Amperes",
                        style: const TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                       IconButton(
                    onPressed:  () {
            Get.to(() => const AmpereScreen());
          },
                    icon: const Icon(Icons.settings,size: 30, color: Colors.grey),
                  ),
                   ],
                 ),
          
              
                Row(
                  children: [  const SizedBox(
                  width: 10,
                ),
                    const Icon(Icons.electric_bolt_sharp,
                        size: 40, color: Colors.redAccent),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               const Text(
                                                 'CURRENT',
                                                 style: TextStyle(
                                                   fontSize: 16,
                                                   fontWeight: FontWeight.bold,
                                                   color: Colors.white,
                                                 ),
                                                 textAlign: TextAlign.right,
                                               ),
                                               
                                               Obx(() {
                                                 final set1 =
                            int.tryParse(_mqttController.amp2.value.toString()) ??
                                0;
                                                 final set2 =
                            int.tryParse(_mqttController.amp3.value.toString()) ??
                                0;
                            
                                                 final set3 =
                            int.tryParse(_mqttController.amp1.value.toString()) ??
                                0;
                            
                                                 final avgSet = (set1 + set2 + set3) ~/ 3;
                                                 return Text(
                                                   '$avgSet AMP',
                                                   style:
                              const TextStyle(fontSize: 15, color: Colors.white),
                                                 );
                                               }),
                                             ],
                                           ),
                         ),
              ],
            ),
                  ],
                ),
               
          ),
        );
  }
}
