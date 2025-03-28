import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialogs {
  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Try again'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
 
}

class PasswordDialog{
 void showPasswordDialog(Widget Page) {
    TextEditingController passwordController = TextEditingController();

    Get.defaultDialog(
      title: "Enter Password",
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Password",
              ),
            ),
          ),
        ],
      ),
      textConfirm: "Open",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      onConfirm: () {
        if (passwordController.text == "1234") {
          Get.back(); 
          Get.to(() => Page, transition: Transition.fade);
        } else {
          Get.snackbar(
            "Error",
            "Incorrect Password",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
    );
  }
}