import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/api/api_call.dart';
import 'package:weather_app/models/export_models.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel? weatherModel;

  int currentIndex = 0;

  List<ListElement> weatherWithDate = [];

  toggleIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }

  Future fetchWeatherDatas({double? lat, double? long}) async {
    var allWeatherDatas =
        await ApiCall.getWeatherDatas(latitude: lat, longitude: long);

    // if (allWeatherDatas != null) {
    // }
    weatherModel = allWeatherDatas;

    weatherWithDate = allWeatherDatas?.list
            ?.where((element) =>
                DateFormat('yyyy-MM-dd').format(DateTime.parse(
                    element.dtTxt ?? DateTime.now().toString())) ==
                DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(DateTime.now().toString())))
            .toList() ??
        [];
    notifyListeners();
  }
}
