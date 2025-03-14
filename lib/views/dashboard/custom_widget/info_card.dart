import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const InfoCard({
    Key? key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height * 0.13,
        width: Get.width * 0.43,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Icon(icon, size: 40, color: color),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



// class BuildWidget extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;
//   final VoidCallback onTap;
//   final String heading; 
//     final Color color;

  
//      BuildWidget({super.key, required this.icon, required this.label, required this.value, required this.onTap, required this.heading, required this.color, });

//   @override
//   Widget build(BuildContext context) {
//     return
//        Container(
//         width: 300, 
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.black87,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "$heading",
//                   style: TextStyle(color: Colors.lightBlue, fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//             IconButton(onPressed: (){}, icon: Icon(Icons.settings,color: Colors.grey,))
//               ],
//             ),
          
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Icon(icon, color:color, size: 18),
//         SizedBox(width: 4),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(label, style: TextStyle(color: Colors.white70, fontSize: 12)),
//             Text(value, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
//           ],
//         ),
//               ],
//             ),
          
//           ],
//         ),
//         );
//   }
// }  


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
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
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

