// import 'dart:async';
// import 'dart:ui';
// import 'package:get/get.dart';

// class SliderController extends GetxController {
//   RxDouble temperature = 50.0.obs;
//   // RxDouble lowTemp = 20.0.obs;
//   // RxDouble highTemp = 80.0.obs;

//   Timer? _debounce;

//   void updateTemperature(double newTemp) {
//     if (newTemp >= 0 && newTemp <= 100) {
//       if (_debounce?.isActive ?? false) _debounce!.cancel();
//       _debounce = Timer(Duration(milliseconds: 16), () {
//         temperature.value = lerpDouble(temperature.value, newTemp, 0.5)!;
//       });
//     }
//   }
// }