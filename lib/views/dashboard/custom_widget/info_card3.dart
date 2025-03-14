import 'package:app/controller/mqtt_controller/mqtt_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoCard3 extends StatelessWidget {
final String heading;

  final String image;
  final Color color;
  final String title;

  InfoCard3({
    super.key,
    required this.image,
    required this.color,
    required this.title, required this.heading,
  });
final MqttController _mqttController = Get.find<MqttController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Retrieve values from the controller
      final setValue = _mqttController.psig2.value;
      final highValue = _mqttController.psig2setlow.value;

      // Determine the border color based on the set value
      Color borderColor;
      double? set = double.tryParse(setValue.toString());
      double? high = double.tryParse(highValue.toString());

      if (set != null && high != null) {
        if (set >= high) {
          borderColor = Colors.red;
        } else if (set >= high - 10) {
          borderColor = Colors.orange;
        } else {
          borderColor = Colors.green;
        }
      } else {
        borderColor = Colors.grey;
      }

      return
        Padding(
       padding: const EdgeInsets.all(8.0),
        child: Container(
        width:Get.width * 0.9, 
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(12),
        ),
          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  heading,
                  style: const TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed:  () {
          _showDialog(context, title, _mqttController);
        },
                  icon: const Icon(Icons.settings,size: 30, color: Colors.grey),
                ),
              ],
            ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    image,
                    width: 40,
                    height: 40,
                    color: color,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '$setValue PSI',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
      
    });
  }

  void _showDialog(
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
}

