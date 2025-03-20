import 'package:app/controller/mqtt_controller/mqtt_controller.dart';
import 'package:app/views/dashboard/custom_widget/pressure/pressure_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Pressures extends StatelessWidget {
  Pressures({super.key});
  final MqttController controller = Get.find<MqttController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                        Icons.air_outlined,
                        size: 30,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'PRESSURES',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(onTap: (){
_showDialogLow(context, "LOW PRESSURE", controller);
              },
                child: Pressurewidget(
                  title: "LOW PRESSURE",
                  high: controller.psig1setlow.value.toString(),
                  low: controller.psig1sethigh.value.toString(),
                  setpoint: controller.psig1.value.toString(),
                ),
              ),
              GestureDetector(onTap: (){
                     _showDialogHigh(context, "HIGH PRESSURE", controller);
              },
                child: Pressurewidget(
                  title: "HIGH PRESSURE",
                  high: controller.psig2setlow.value.toString(),
                  low: controller.psig2sethigh.value.toString(),
                  setpoint: controller.psig2.value.toString(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
         GestureDetector(onTap: (){
           _showDialogoil(context, "OIL PRESSURE", controller);
         },
           child: Pressurewidget(
                  title: "OIL PRESSURE",
                  high: controller.psig3setlow.value.toString(),
                  low: controller.psig3sethigh.value.toString(),
                  setpoint: controller.psig3.value.toString(),
                ),
         ),
        ],
      ),
    );
  }
  
  void _showDialogLow(
      BuildContext context, String title, MqttController controller) {
    final highValue = controller.psig1setlow.value;
    final lowValue = controller.psig1sethigh.value;
    final setValue = controller.psig1;

    final highController = TextEditingController(text: highValue.toString());
    final lowController = TextEditingController(text: lowValue.toString());
    final setController = TextEditingController(text: setValue.toString());

    bool isEditable = false;
    final passwordController = TextEditingController(text: '1234');

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Set Levels for $title'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isEditable
                      ? TextField(
                          controller: highController,
                          decoration:
                              const InputDecoration(labelText: 'High Level'),
                          keyboardType: TextInputType.number,
                        )
                      : Text('High Level: $highValue'),
                  isEditable
                      ? TextField(
                          controller: lowController,
                          decoration:
                              const InputDecoration(labelText: 'Low Level'),
                          keyboardType: TextInputType.number,
                        )
                      : Text('Low Level: $lowValue'),
                  isEditable
                      ? TextField(
                          controller: setController,
                          decoration:
                              const InputDecoration(labelText: 'Set Level'),
                          keyboardType: TextInputType.number,
                        )
                      : Text('Set Level: $setValue'),
                ],
              ),
              actions: [
                if (!isEditable)
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Enter Password to Edit'),
                            content: TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration:
                                  const InputDecoration(labelText: 'Password'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  if (passwordController.text == '1234') {
                                    setState(() {
                                      isEditable = true;
                                    });
                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Incorrect password')),
                                    );
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('OK'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Edit'),
                  ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                if (isEditable)
                  TextButton(
                    onPressed: () {
                      final newHighValue = highController.text;
                      final newLowValue = lowController.text;
                      final newSetValue = setController.text;

                      if (double.tryParse(newHighValue) == null ||
                          double.tryParse(newLowValue) == null ||
                          double.tryParse(newSetValue) == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please enter valid numbers')),
                        );
                        return;
                      }

                      controller.updateContainerValuesLP(
                          newLowValue, newHighValue);
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
              ],
            );
          },
        );
      },
    );
  }
  
  void _showDialogHigh(
      BuildContext context, String title, MqttController controller) {
    final highValue = controller.psig2setlow.value;
    final lowValue = controller.psig2sethigh.value;
    final setValue = controller.psig2.value;

    final highController = TextEditingController(text: highValue.toString());
    final lowController = TextEditingController(text: lowValue.toString());
    final setController = TextEditingController(text: setValue.toString());

    bool isEditable = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Set Levels for $title'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isEditable
                      ? TextField(
                          controller: highController,
                          decoration:
                              const InputDecoration(labelText: 'High Level'),
                          keyboardType: TextInputType.number,
                        )
                      : Text('High Level: $highValue'),
                  isEditable
                      ? TextField(
                          controller: lowController,
                          decoration:
                              const InputDecoration(labelText: 'Low Level'),
                          keyboardType: TextInputType.number,
                        )
                      : Text('Low Level: $lowValue'),
                  isEditable
                      ? TextField(
                          controller: setController,
                          decoration:
                              const InputDecoration(labelText: 'Set Level'),
                          keyboardType: TextInputType.number,
                        )
                      : Text('Set Level: $setValue'),
                ],
              ),
              actions: [
                if (!isEditable)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isEditable = true;
                      });
                    },
                    child: const Text('Edit'),
                  ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                if (isEditable)
                  TextButton(
                    onPressed: () {
                      final newHighValue = highController.text;
                      final newLowValue = lowController.text;
                      final newSetValue = setController.text;

                      if (double.tryParse(newHighValue) == null ||
                          double.tryParse(newLowValue) == null ||
                          double.tryParse(newSetValue) == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please enter valid numbers')),
                        );
                        return;
                      }

                      controller.updateContainerValuesHP(
                          newHighValue, newLowValue);
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
              ],
            );
          },
        );
      },
    );
  }
  void _showDialogoil(
      BuildContext context, String title, MqttController controller) {
    final highValue = controller.psig3setlow.value;
    final lowValue = controller.psig3sethigh.value;
    final setValue = controller.psig3;

    final highController = TextEditingController(text: highValue.toString());
    final lowController = TextEditingController(text: lowValue.toString());
    final setController = TextEditingController(text: setValue.toString());

    bool isEditable = false;
    final passwordController = TextEditingController(text: '1234');

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Set Levels for $title'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isEditable
                      ? TextField(
                          controller: highController,
                          decoration:
                              const InputDecoration(labelText: 'High Level'),
                          keyboardType: TextInputType.number,
                        )
                      : Text('High Level: $highValue'),
                  isEditable
                      ? TextField(
                          controller: lowController,
                          decoration:
                              const InputDecoration(labelText: 'Low Level'),
                          keyboardType: TextInputType.number,
                        )
                      : Text('Low Level: $lowValue'),
                  isEditable
                      ? TextField(
                          controller: setController,
                          decoration:
                              const InputDecoration(labelText: 'Set Level'),
                          keyboardType: TextInputType.number,
                        )
                      : Text('Set Level: $setValue'),
                ],
              ),
              actions: [
                if (!isEditable)
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Enter Password to Edit'),
                            content: TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration:
                                  const InputDecoration(labelText: 'Password'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  if (passwordController.text == '1234') {
                                    setState(() {
                                      isEditable = true;
                                    });
                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Incorrect password')),
                                    );
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('OK'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Edit'),
                  ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                if (isEditable)
                  TextButton(
                    onPressed: () {
                      final newHighValue = highController.text;
                      final newLowValue = lowController.text;
                      final newSetValue = setController.text;

                      if (double.tryParse(newHighValue) == null ||
                          double.tryParse(newLowValue) == null ||
                          double.tryParse(newSetValue) == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please enter valid numbers')),
                        );
                        return;
                      }

                      controller.updateOilPressure(newLowValue, newHighValue);
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}