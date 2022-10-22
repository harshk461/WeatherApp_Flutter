// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/screens/search.dart';
import "string_extension.dart";

class Home extends StatefulWidget {
  final Map<String, dynamic> city;
  const Home({super.key, required this.city});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> final_data = {};
  @override
  void initState() {
    // TODO: implement initState
    print(widget.city);
    setState(() {
      final_data = widget.city;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "Weather Forecast",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100.0,
                height: 50.0,
                margin: const EdgeInsets.only(bottom: 15.0),
                child: const Image(
                  image:
                      NetworkImage('http://openweathermap.org/img/wn/50n.png'),
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                final_data['temp'].toString(),
                style: const TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                final_data['city'],
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DetailContainer(
                    type: 'left',
                    Color1: Colors.orange.shade400,
                    Color2: Colors.deepOrange.shade600,
                    icon: final_data['hourly_data'][0]['icon'],
                    temp: final_data['hourly_data'][0]['temp'].toString(),
                    time: final_data['hourly_data'][0]['time'],
                  ),
                  DetailContainer(
                    type: 'center',
                    Color1: Colors.purple.shade300,
                    Color2: Colors.deepPurple.shade600,
                    icon: final_data['hourly_data'][1]['icon'],
                    temp: final_data['hourly_data'][1]['temp'].toString(),
                    time: final_data['hourly_data'][1]['time'],
                  ),
                  DetailContainer(
                    type: 'right',
                    Color1: Colors.blueGrey.shade800,
                    Color2: Colors.grey.shade900,
                    icon: final_data['hourly_data'][2]['icon'],
                    temp: final_data['hourly_data'][2]['temp'].toString(),
                    time: final_data['hourly_data'][2]['time'],
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Additional Info...",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            RowDetail(
                                title: "Wind",
                                data: final_data['wind'].toString()),
                            const SizedBox(
                              height: 10.0,
                            ),
                            RowDetail(
                                title: "Pressure",
                                data: final_data['pressure'].toString()),
                          ],
                        ),
                        Column(
                          children: [
                            RowDetail(
                                title: "Humidity",
                                data: final_data['humidity'].toString()),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const RowDetail(title: "Wind", data: "21km/h"),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0.0),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Search(),
                    ),
                  );
                },
                icon: const FaIcon(FontAwesomeIcons.house),
                label: const Text(
                  "Home",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.cloud_sync_rounded),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const FaIcon(FontAwesomeIcons.sun),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DetailContainer extends StatelessWidget {
  final String type;
  final Color Color1;
  final Color Color2;
  final String time;
  final String temp;
  final String icon;
  const DetailContainer({
    Key? key,
    required this.type,
    required this.Color1,
    required this.Color2,
    required this.icon,
    required this.time,
    required this.temp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double left = 0, right = 0;
    if (type == 'left') {
      left = 50;
      right = 0;
    }
    if (type == 'no') {
      left = 0;
      right = 0;
    }
    if (type == 'right') {
      left = 0;
      right = 50;
    }

    return Container(
      height: 170.0,
      width: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
              color: Color1,
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            height: 170.0,
            width: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color2,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(left),
                topRight: Radius.circular(right),
                bottomLeft: const Radius.circular(20.0),
                bottomRight: const Radius.circular(20.0),
              ),
            ),
            width: 100.0,
            height: 90.0,
          ),
          Container(
            height: 200.0,
            width: 100.0,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 70.0,
                  height: 70.0,
                  child: Image(
                    image: NetworkImage(
                        'http://openweathermap.org/img/wn/$icon.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  temp,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RowDetail extends StatelessWidget {
  final String title;
  final String data;

  const RowDetail({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            data,
            style: const TextStyle(
              fontSize: 21.0,
            ),
          )
        ],
      ),
    );
  }
}
