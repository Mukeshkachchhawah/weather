import 'dart:convert';

import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:weather/modal/data_modal.dart';
import 'package:weather/ui_helper.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<DataModals> mdata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mdata = getData();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current date and time
    var now = DateTime.now();

    // Format the date and time using the `intl` package
    final formattedDate = DateFormat.yMd().format(now); // Format: 10/14/2023
    final formattedTime = DateFormat.Hm().format(now); // Format: 15:25

    // Get the current month
    final month = DateFormat.MMMM().format(now); // Full month name: October

    return Scaffold(
        backgroundColor: Colors.yellow,
        body: FutureBuilder(
          /// use futureBuilder 
          future: mdata,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    /// animation widget us internet error
                    "Internet Error",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                );
              } else if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.menu,
                                size: 25,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 130),
                                child: Text(
                                  "${snapshot.data!.sys!.country}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://cdn-icons-png.flaticon.com/512/4308/4308620.png"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ],
                          ),
                          mHidght(),
                          Container(
                            height: 50,
                            width: 400,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black),
                            child: Center(
                              child: Text(
                                "${formattedDate}, ${formattedTime}, ${month}",
                                // "Monday 28, November",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          mHidght(),
                          Text(
                            "${snapshot.data!.clouds}",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          // mHidght(),
                          Text(
                            "${snapshot.data!.main!.temp}",
                            style: TextStyle(
                                fontSize: 100, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      mHidght(),
                      Text(
                        "Daily Summary",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      mHidght(),
                      Text("Now it feels likes +35^o, actually +31^o"),
                      Text("it feels hot because of the direct sun. Today."),
                      Text(
                          "the temperature us felt in the range from +31^o to 27^o ."),
                      mHidght(),
                      Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            DailySummary(
                                IconType.continueAnimation,
                                "${snapshot.data!.wind!.speed}",
                                "Wind",
                                AnimateIcons.menu),
                            DailySummary(
                                IconType.continueAnimation,
                                "${snapshot.data!.main!.humidity}",
                                "Humudlty",
                                AnimateIcons.walk),
                            DailySummary(
                                IconType.continueAnimation,
                                "${snapshot.data!.visibility}",
                                "Visiblity",
                                AnimateIcons.eye),
                          ],
                        ),
                      ),
                      mHidght(),
                      Text(
                        "Weekly forecast",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      mHidght(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WeeklyForecast(),
                          WeeklyForecast(),
                          WeeklyForecast(),
                          WeeklyForecast(),
                        ],
                      )
                    ],
                  ),
                );
              }
              return Container();
            }
          },
        ));
  }

  Widget DailySummary(IconType icontypes, String text, String text1,
      AnimateIcons animationIcons) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AnimateIcon(
          key: UniqueKey(),
          onTap: () {},
          iconType: icontypes,
          height: 70,
          width: 70,
          color: Colors.white,
          animateIcon: animationIcons,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        Text(text1, style: TextStyle(color: Colors.red))
      ],
    );
  }

  Widget WeeklyForecast() {
    return Container(
      height: 140,
      width: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Text("25^o"), Icon(Icons.car_crash), Text('23 jun')],
      ),
    );
  }

  /// get dummy api functoin getData
  Future<DataModals> getData() async {
    Uri mUrl = Uri.parse(

        /// dummy api get url
        "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=9b43443bbc145c7ed11a453adbc249ee");
    var response = await http.get(mUrl);

    /// chack responese code ==200
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return DataModals.fromJson(json);
    } else {
      return DataModals();
    }
  }
}
