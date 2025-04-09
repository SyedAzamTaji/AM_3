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

class PasswordDialog {
  final RxBool isObscured =
      true.obs; 

  void showPasswordDialog(Widget Page) {
    TextEditingController passwordController = TextEditingController();

    Get.defaultDialog(
      title: "Enter Password",
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Obx(
              () => TextField(
                controller: passwordController,
                obscureText: isObscured.value,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      isObscured.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      isObscured.value = !isObscured.value; 
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      textConfirm: "Ok",
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
