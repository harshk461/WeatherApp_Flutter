import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_app/screens/home.dart';
import "string_extension.dart";

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Weatherify",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Image(
                  image: AssetImage("assets/images/logo.png"),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: search,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 5.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Colors.lime,
                        width: 3.0,
                      ),
                    ),
                    labelText: "Search",
                    hintText: "City...",
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                    onPressed: () async {
                      double lat, lon;
                      String city = search.text.trim();
                      try {
                        String apiID = '51a7d9a178839c5234c77542f46d6975';
                        String url =
                            'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiID';

                        Response response = await get(Uri.parse(url));
                        Map inital_data = jsonDecode(response.body);
                        lat = inital_data['coord']['lat'];
                        lon = inital_data['coord']['lon'];

                        String url2 =
                            'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiID';

                        Response final_reponse = await get(Uri.parse(url2));
                        Map data = jsonDecode(final_reponse.body);
                        Map<String, dynamic> final_data = {
                          "temp": num.parse(
                                  (inital_data['main']['temp'] - 273.15)
                                      .toString())
                              .toStringAsFixed(2),
                          "city": city.capitalize(),
                          "wind": inital_data['wind']['speed'],
                          "pressure": inital_data['main']['pressure'],
                          "humidity": inital_data['main']['humidity'],
                          "icon": inital_data['weather'][0]['icon'],
                          "hourly_data": [
                            {
                              "temp": num.parse(
                                      (data["list"][1]["main"]["temp"] - 273.15)
                                          .toString())
                                  .toStringAsFixed(2),
                              "icon": data["list"][1]["weather"][0]["icon"],
                              "time":
                                  "${DateTime.parse(data['list'][1]['dt_txt']).hour}:${DateTime.parse(data['list'][1]['dt_txt']).minute}",
                            },
                            {
                              "temp": num.parse(
                                      (data["list"][2]["main"]["temp"] - 273.15)
                                          .toString())
                                  .toStringAsFixed(2),
                              "icon": data["list"][2]["weather"][0]["icon"],
                              "time":
                                  "${DateTime.parse(data['list'][2]['dt_txt']).hour}:${DateTime.parse(data['list'][2]['dt_txt']).minute}",
                            },
                            {
                              "temp": num.parse(
                                      (data["list"][3]["main"]["temp"] - 273.15)
                                          .toString())
                                  .toStringAsFixed(2),
                              "icon": data["list"][3]["weather"][0]["icon"],
                              "time":
                                  "${DateTime.parse(data['list'][3]['dt_txt']).hour}:${DateTime.parse(data['list'][3]['dt_txt']).minute}",
                            },
                          ],
                        };
                        DateTime tempDate =
                            DateTime.parse(data["list"][0]["dt_txt"]);

                        print(tempDate.hour);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(city: final_data)));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Input Correct Data")));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(150.0, 50.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 22.0,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
