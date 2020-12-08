import 'package:drone/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/auth_controller.dart';

void main() {
  runApp(
    GetMaterialApp(
      home: App(),
    ),
  );
}

class App extends StatelessWidget {
  // Inject auth controller to View.
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authController.checkUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error Processing');
        }
        if (snapshot.hasData) {
          // Snapshot contains which view to load beased on the logic in the Controller
          return snapshot.data;
        }
        return LoadingWidget();
      },
    );
  }
}
