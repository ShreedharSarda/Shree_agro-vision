import 'dart:convert';

import 'package:drone/models/fruit_model.dart';

List<Fruits> fruitsFromJson(String str) =>
    List<Fruits>.from(json.decode(str).map((x) => Fruits.fromJson(x)));
