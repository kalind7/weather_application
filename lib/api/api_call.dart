import 'package:dio/dio.dart';

import '../models/export_models.dart';

class ApiCall {
  static Future<WeatherModel?> getWeatherDatas(
      {double? latitude, double? longitude}) async {
    var url = 'https://api.openweathermap.org/data/2.5/forecast';

    Dio dio = Dio();

    try {
      var response = await dio.get(url, queryParameters: {
        'lat': latitude ?? 27.708496,
        'lon': longitude ?? 85.34657,
        'appid': '3961a8edb095591f19de8fb19990e859',
        'units': 'metric',
        'cnt': 40
      });

      print('*****************');
      print(response.realUri.path);
      print(response.realUri);

      print(response.statusCode);
      print(response.data);

      return WeatherModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
