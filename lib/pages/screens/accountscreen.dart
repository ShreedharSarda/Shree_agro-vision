import 'package:cached_network_image/cached_network_image.dart';
import 'package:drone/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

class Accountscreen extends StatelessWidget {
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Vx.green900,
                      width: 3.5,
                    ),
                    borderRadius: BorderRadius.circular(100)),
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    authController.firebaseUser.photoURL,
                  ),
                  radius: 80,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: Get.width * .8,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Username:\n${authController.firebaseUser.displayName}"
                      .text
                      .xl3
                      .extraBold
                      .make(),
                  SizedBox(
                    height: 20,
                  ),
                  "Email:\n${authController.firebaseUser.email}"
                      .text
                      .xl3
                      .extraBold
                      .make(),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ButtonTheme(
              minWidth: 320,
              buttonColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: RaisedButton(
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                child: "Sign Out".text.xl4.white.make(),
                onPressed: () {
                  // Call the sign in method
                  authController.signOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
