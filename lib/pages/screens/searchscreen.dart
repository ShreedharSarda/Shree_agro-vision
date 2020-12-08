import 'dart:io';
import 'package:drone/controllers/json_controller.dart';
import 'package:drone/models/fruit_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  File _image;
  int counter = -1;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      counter++;
    });
  }

  @override
  void initState() {
    counter = -1;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          HStack([
            "Image".text.xl6.extraBold.black.make(),
            "Info".text.xl6.extraBold.green600.make(),
          ]),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                color: Colors.black,
                width: Get.width * .7,
                height: Get.height * .468,
                child: Center(
                  child: _image == null
                      ? "Select an Image".text.xl2.white.bold.make()
                      : Image.file(
                          _image,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: getImage,
            iconSize: 45,
            icon: Icon(Icons.camera),
          ),
          _image == null
              ? Container()
              : InkWell(
                  onTap: () {
                    getBottomSheet(context);
                  },
                  child: VxBox(
                    child: "Get Info".text.xl3.bold.white.makeCentered(),
                  ).gray800.width(Get.width * .7).rounded.p12.make(),
                )
        ],
      ),
    );
  }

  getBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/csvjson.json'),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<Fruits> fruits = fruitsFromJson(snapshot.data.toString());
                if (fruits.isEmpty) {
                  return Center(child: new CircularProgressIndicator());
                } else {
                  return VStack([
                    HStack([
                      "Fruit: ".text.bold.xl2.make(),
                      fruits[counter].fruits.text.italic.xl2.make(),
                    ]),
                    SizedBox(
                      height: 7,
                    ),
                    HStack([
                      "Fruit Disease: ".text.bold.xl2.make(),
                      fruits[counter].fruitDiseases.text.italic.xl2.make(),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Tip:  ".text.bold.xl2.make(),
                        Expanded(
                            child: fruits[counter]
                                .message
                                .text
                                .maxLines(5)
                                .overflow(TextOverflow.ellipsis)
                                .italic
                                .xl2
                                .make()),
                      ],
                    ),
                  ]).box.p20.make();
                }
              });
        });
  }
}
