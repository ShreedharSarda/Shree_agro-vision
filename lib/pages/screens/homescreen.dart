import 'package:drone/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class Homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            HStack([
              "Agro".text.xl6.extraBold.black.make(),
              "Vision".text.xl6.extraBold.green600.make(),
            ]).box.makeCentered(),
            Lottie.asset("assets/drone.json", width: Get.width),
            InkWell(
              onTap: () => getBottomSheet(context, "About Us", trackContent),
              child: VxBox(
                child: HStack([
                  Icon(
                    Icons.info_rounded,
                    color: Colors.white,
                    size: 55,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  "About Us"
                      .toUpperCase()
                      .text
                      .white
                      .extraBold
                      .xl3
                      .makeCentered()
                ]),
              )
                  .width(Get.width * .92)
                  .green700
                  .rounded
                  .p16
                  .margin(EdgeInsets.symmetric(horizontal: 15))
                  .make(),
            ),
            InkWell(
              onTap: () =>
                  getBottomSheet(context, "Contact Us", contactContent),
              child: VxBox(
                child: HStack([
                  Icon(
                    Icons.contact_page,
                    color: Colors.white,
                    size: 55,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  "Contact"
                      .toUpperCase()
                      .text
                      .white
                      .extraBold
                      .xl3
                      .makeCentered()
                ]),
              )
                  .width(Get.width * .92)
                  .yellow500
                  .rounded
                  .p16
                  .margin(EdgeInsets.all(15))
                  .make(),
            )
          ],
        ),
      ),
    );
  }

  getBottomSheet(context, String title, String content) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(15),
          child: Wrap(
            children: [
              title.text.xl4.extraBold.make(),
              SizedBox(
                height: 15,
              ),
              content.text.xl3.make(),
            ],
          ),
        );
      },
    );
  }
}
