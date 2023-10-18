import 'dart:convert';

import 'package:flutter_project/model/premiumModel.dart';

import '../api/apiService.dart';

class PremiumService {
  String responseJson = "";
  List<PremiumModel> premium = [];
  ApiService api = ApiService();

  Future<void> loadPremium(int? id) async {
    responseJson = await api.getPremium(id);

    List<Map<String, dynamic>> parsedJson =
        jsonDecode(responseJson).cast<Map<String, dynamic>>();
    premium = PremiumModel.fromJsonList(parsedJson);
  }

  List<PremiumModel> getPremiumList() {
    return premium;
  }

  PremiumModel getPremium(int id) {
    for (int i = 0; i < premium.length; i++) {
      if (premium[i].id == id) {
        return premium[i];
      }
    }

    return premium[0];
  }

  Future<void> delete(int? id) async {
    await api.deletePremium(id);
  }

  Future<void> add(String token, PremiumModel premiumModel) async {
    responseJson = await api.addPremium(premiumModel);
  }

  Future<void> edit(String token, PremiumModel premiumModel, int id) async {
    responseJson = await api.editPremium(premiumModel, id);
  }
}
