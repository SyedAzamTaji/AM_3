// import 'package:app/controller/mqtt_controller/mqtt_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AmpereScreen extends StatelessWidget {
//   const AmpereScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final MqttController _mqttController = Get.find<MqttController>();

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.transparent,
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.green, Colors.green],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 60),

//               // Title container
//               Center(
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.3),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         Icons.electric_bolt_sharp,
//                         size: 30,
//                         color: Colors.red,
//                       ),
//                       SizedBox(width: 10),
//                       Text(
//                         'Ampere',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),

//               // Info cards
//               Obx(
//                 () => Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _buildInfoCard(
//                       set: "${_mqttController.amp2.value}",
//                       low: "${_mqttController.amp1high.value}",
//                       high: "${_mqttController.amp1low.value}",
//                       context: context,
//                       icon: Icons.electric_bolt_sharp,
//                       color: Colors.blue,
//                       title: 'Phase 1',
//                       onTap: () => _showDialogph1(
//                           context,
//                           'Phase 1',
//                           "${_mqttController.amp2.value}",
//                           "${_mqttController.amp1high.value}",
//                           "${_mqttController.amp1low.value}",
//                           _mqttController.updateContainerValuesAmpereph1),
//                     ),
//                     _buildInfoCard(
//                         set: "${_mqttController.amp3.value}",
//                         low: "${_mqttController.amp2high.value}",
//                         high: "${_mqttController.amp2low.value}",
//                         context: context,
//                         icon: Icons.electric_bolt_sharp,
//                         color: Colors.orange,
//                         title: 'Phase 2',
//                         onTap: () => _showDialogph2(
//                             context,
//                             'Phase 2',
//                             "${_mqttController.amp3.value}",
//                             "${_mqttController.amp2high.value}",
//                             "${_mqttController.amp2low.value}",
//                             _mqttController.updateContainerValuesAmpereph2)),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 30),

//               Obx(
//                 () => Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _buildInfoCard(
//                         set: "${_mqttController.amp1.value}",
//                         low: "${_mqttController.amp3high.value}",
//                         high: "${_mqttController.amp3low.value}",
//                         context: context,
//                         icon: Icons.electric_bolt_sharp,
//                         color: Colors.green,
//                         title: 'Phase 3',
//                         onTap: () => _showDialogph3(
//                             context,
//                             'Phase 3',
//                             "${_mqttController.amp1.value}",
//                             "${_mqttController.amp3high.value}",
//                             "${_mqttController.amp3low.value}",
//                             _mqttController.updateContainerValuesAmpereph3)),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoCard({
//     required BuildContext context,
//     required IconData icon,
//     required Color color,
//     required String title,
//     required String high,
//     required String low,
//     required String set,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.3),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         width: MediaQuery.of(context).size.width * 0.4,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 40, color: color),
//             const SizedBox(height: 10),
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 10),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('High: $high', style: const TextStyle(fontSize: 12)),
//                   Text('Low: $low', style: const TextStyle(fontSize: 12)),
//                   Text('Temp.: $set', style: const TextStyle(fontSize: 12)),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void _showDialogph1(BuildContext context, String title, String set,
//       String low, String high, Function(String, String) onUpdate) {
//     final TextEditingController highController =
//         TextEditingController(text: high);
//     final TextEditingController lowController =
//         TextEditingController(text: low);
//     // final TextEditingController setController =
//     //     TextEditingController(text: set);

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Set Levels for $title'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "TEMPERATURE : $set",
//                 style:
//                     const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               TextField(
//                 controller: highController,
//                 decoration: const InputDecoration(labelText: 'High Level'),
//                 keyboardType: TextInputType.number,
//               ),
//               TextField(
//                 controller: lowController,
//                 decoration: const InputDecoration(labelText: 'Low Level'),
//                 keyboardType: TextInputType.number,
//               ),
//               // TextField(
//               //   controller: setController,
//               //   decoration: const InputDecoration(labelText: 'Set Level'),
//               //   keyboardType: TextInputType.number,
//               // ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 onUpdate(highController.text, lowController.text);
//                 Navigator.pop(context);
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showDialogph2(BuildContext context, String title, String set,
//       String low, String high, Function(String, String) onUpdate) {
//     final TextEditingController highController =
//         TextEditingController(text: high);
//     final TextEditingController lowController =
//         TextEditingController(text: low);
//     // final TextEditingController setController =
//     //     TextEditingController(text: set);

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Set Levels for $title'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "TEMPERATURE : $set",
//                 style:
//                     const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               TextField(
//                 controller: highController,
//                 decoration: const InputDecoration(labelText: 'High Level'),
//                 keyboardType: TextInputType.number,
//               ),
//               TextField(
//                 controller: lowController,
//                 decoration: const InputDecoration(labelText: 'Low Level'),
//                 keyboardType: TextInputType.number,
//               ),
//               // TextField(
//               //   controller: setController,
//               //   decoration: const InputDecoration(labelText: 'Set Level'),
//               //   keyboardType: TextInputType.number,
//               // ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 onUpdate(highController.text, lowController.text);
//                 Navigator.pop(context);
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showDialogph3(BuildContext context, String title, String set,
//       String low, String high, Function(String, String) onUpdate) {
//     final TextEditingController highController =
//         TextEditingController(text: high);
//     final TextEditingController lowController =
//         TextEditingController(text: low);
//     // final TextEditingController setController =
//     //     TextEditingController(text: set);

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Set Levels for $title'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "TEMPERATURE : $set",
//                 style:
//                     const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               TextField(
//                 controller: highController,
//                 decoration: const InputDecoration(labelText: 'High Level'),
//                 keyboardType: TextInputType.number,
//               ),
//               TextField(
//                 controller: lowController,
//                 decoration: const InputDecoration(labelText: 'Low Level'),
//                 keyboardType: TextInputType.number,
//               ),
//               // TextField(
//               //   controller: setController,
//               //   decoration: const InputDecoration(labelText: 'Set Level'),
//               //   keyboardType: TextInputType.number,
//               // ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 onUpdate(highController.text, lowController.text);
//                 Navigator.pop(context);
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


import 'package:app/controller/mqtt_controller/mqtt_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmphereScreen extends StatelessWidget {
  const AmphereScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final MqttController mqttController = Get.find<MqttController>();
    final MqttController mqttController = Get.put(MqttController());


    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Container(
        decoration:  BoxDecoration(
         color: Colors.black
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
    
              // Title container
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha:  0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.electric_bolt_sharp,
                        size: 30,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Amperes',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,color: Colors.white
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
    
              // Info cards
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoCard(
                      set: "${mqttController.amp2.value}",
                      low: "${mqttController.amp1high.value}",
                      high: "${mqttController.amp1low.value}",
                      context: context,
                      icon: Icons.electric_bolt_sharp,
                      color: Colors.blue,
                      title: 'Phase 1',
                      onTap: () => _showDialogph1(
                          context,
                          'Phase 1',
                          "${mqttController.amp2.value}",
                          "${mqttController.amp1high.value}",
                          "${mqttController.amp1low.value}",
                          mqttController.updateContainerValuesAmpereph1),
                    ),
                    _buildInfoCard(
                        set: "${mqttController.amp3.value}",
                        low: "${mqttController.amp2high.value}",
                        high: "${mqttController.amp2low.value}",
                        context: context,
                        icon: Icons.electric_bolt_sharp,
                        color: Colors.orange,
                        title: 'Phase 2',
                        onTap: () => _showDialogph2(
                            context,
                            'Phase 2',
                            "${mqttController.amp3.value}",
                            "${mqttController.amp2high.value}",
                            "${mqttController.amp2low.value}",
                            mqttController.updateContainerValuesAmpereph2)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
    
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoCard(
                        set: "${mqttController.amp1.value}",
                        low: "${mqttController.amp3high.value}",
                        high: "${mqttController.amp3low.value}",
                        context: context,
                        icon: Icons.electric_bolt_sharp,
                        color: Colors.green,
                        title: 'Phase 3',
                        onTap: () => _showDialogph3(
                            context,
                            'Phase 3',
                            "${mqttController.amp1.value}",
                            "${mqttController.amp3high.value}",
                            "${mqttController.amp3low.value}",
                            mqttController.updateContainerValuesAmpereph3)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String title,
    required String high,
    required String low,
    required String set,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(height: Get.width * 0.4 ,
        decoration: BoxDecoration(
         color: Colors.grey.withValues(alpha:  0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        width: Get.width * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ SizedBox(height: Get.height*0.01),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,color: Colors.white
              ),
              textAlign: TextAlign.center,
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
                    value: (double.parse(set) / 100),
                    strokeWidth: 4,
                    backgroundColor: Colors.white54,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                  ),
                ),
                
                Text(
                  "${(double.parse(set)).toInt()}%", // Show percentage
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Change color as needed
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height*0.027),

            Container(
              decoration: BoxDecoration(

                 borderRadius: BorderRadius.circular(12),
              color: Colors.green.withValues(alpha: 0.8),
              ),
            width: Get.width*1,
            height: Get.height*0.055,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Row(children: [
                      Text('Low: ',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                             Text(low,
                        style: const TextStyle(
                            fontSize: 13,)),
                  ],),
                          Row(children: [  Text('High: ',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),Text(high,
                        style: const TextStyle(
                            fontSize: 13,)),],)
                    // Text('Temp.: $set',
                    //     style: const TextStyle(
                    //         fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showDialogph1(BuildContext context, String title, String set,
      String low, String high, Function(String, String) onUpdate) {
    final TextEditingController highController =
        TextEditingController(text: high);
    final TextEditingController lowController =
        TextEditingController(text: low);
    // final TextEditingController setController =
    //     TextEditingController(text: set);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Set Levels for $title'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "TEMPERATURE : $set",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: highController,
                decoration: const InputDecoration(labelText: 'High Level'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: lowController,
                decoration: const InputDecoration(labelText: 'Low Level'),
                keyboardType: TextInputType.number,
              ),
              // TextField(
              //   controller: setController,
              //   decoration: const InputDecoration(labelText: 'Set Level'),
              //   keyboardType: TextInputType.number,
              // ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onUpdate(highController.text, lowController.text);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showDialogph2(BuildContext context, String title, String set,
      String low, String high, Function(String, String) onUpdate) {
    final TextEditingController highController =
        TextEditingController(text: high);
    final TextEditingController lowController =
        TextEditingController(text: low);
    // final TextEditingController setController =
    //     TextEditingController(text: set);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Set Levels for $title'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "TEMPERATURE : $set",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: highController,
                decoration: const InputDecoration(labelText: 'High Level'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: lowController,
                decoration: const InputDecoration(labelText: 'Low Level'),
                keyboardType: TextInputType.number,
              ),
              // TextField(
              //   controller: setController,
              //   decoration: const InputDecoration(labelText: 'Set Level'),
              //   keyboardType: TextInputType.number,
              // ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onUpdate(highController.text, lowController.text);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showDialogph3(BuildContext context, String title, String set,
      String low, String high, Function(String, String) onUpdate) {
    final TextEditingController highController =
        TextEditingController(text: high);
    final TextEditingController lowController =
        TextEditingController(text: low);
    // final TextEditingController setController =
    //     TextEditingController(text: set);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Set Levels for $title'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "TEMPERATURE : $set",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: highController,
                decoration: const InputDecoration(labelText: 'High Level'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: lowController,
                decoration: const InputDecoration(labelText: 'Low Level'),
                keyboardType: TextInputType.number,
              ),
              // TextField(
              //   controller: setController,
              //   decoration: const InputDecoration(labelText: 'Set Level'),
              //   keyboardType: TextInputType.number,
              // ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onUpdate(highController.text, lowController.text);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}