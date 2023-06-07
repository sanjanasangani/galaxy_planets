import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../modals/planetmodel.dart';

class PlanetProvider extends ChangeNotifier{
  String? data;
  List<PlanetModel> Planet = [];

  Future<void> FormJson() async {
    data = await rootBundle.loadString("assets/json/planet.json");
    List decodeList = jsonDecode(data!) ;
    Planet =
        decodeList.map((e) => PlanetModel.fromMap(data: e)).toList();
    notifyListeners();

  }

}