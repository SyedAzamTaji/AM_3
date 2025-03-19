import 'package:flutter/material.dart';
import 'package:get/get.dart';



class BuildWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;
  final String heading;
  final Color color;

  const BuildWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
    required this.heading,
    required this.color,
  });

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  onPressed: onTap,
                  icon: const Icon(Icons.settings,size: 30, color: Colors.grey),
                ),
              ],
            ),
            
            Row(
              children: [
            Icon(Icons.device_thermostat, color: Colors.redAccent, size: 30),
              Text(
                  label,
                  style:
                      const TextStyle(color: Colors.white70, fontSize: 18),
                ),
            ],),
               Text(
                        "          $value",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
        
             
      
          
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     // Container(
            //     //   child: Text(
            //     //     label,
            //     //     style:
            //     //         const TextStyle(color: Colors.white70, fontSize: 14),
            //     //   ),
            //     // ),
            //     Expanded(
            //       flex: 3,
            //       child: Row(
            //         children: [
            //           // Icon(icon, color: color, size: 24),
            //           const SizedBox(width: 8),
            //           Text(
            //             value,
            //             style: const TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 18,
            //                 fontWeight: FontWeight.bold),
            //           ),
            //         ],
            //       ),
                ]),
              
            ),
          
        );
      
    
  }
}


