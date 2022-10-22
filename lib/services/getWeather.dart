import 'dart:convert';
import 'package:http/http.dart';

class getWeather {
  String location;
  String temp;
  String icon;
  Map<String, dynamic> result;
  getWeather(
      {required this.location,
      required this.temp,
      required this.icon,
      required this.result});

  Future<void> weather() async {
    try {
      String apiID = '51a7d9a178839c5234c77542f46d6975';
      String url =
          'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiID';
      Response response = await get(Uri.parse(url));
      Map data = jsonDecode(response.body);
    } catch (e) {}
  }
}
