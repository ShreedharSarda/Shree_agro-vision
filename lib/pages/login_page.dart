import 'package:drone/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatelessWidget {
  // Inject our auth contorller into the login view
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/login.json",
            ),
            "Hi There!".text.white.semiBold.xl5.make(),
            SizedBox(
              height: 15,
            ),
            ButtonTheme(
              minWidth: 250,
              buttonColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.black, width: 5),
              ),
              child: RaisedButton(
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: HStack([
                  "Login with".text.xl2.semiBold.make(),
                  " Google".text.xl2.red500.bold.make(),
                ]),
                onPressed: () {
                  // Call the sign in method
                  authController.signInWithGoogle();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
