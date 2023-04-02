import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/export_provider.dart';

import '../widgets/export_widgets.dart';

class WeatherDetailScreen extends StatelessWidget {
  const WeatherDetailScreen({super.key});

  //     static String iconUrl(context, WeatherProvider prov) {
  //   return "http://openweathermap.org/img/w/${prov.weatherModel?.list?.first.weather?.first.icon}.png";
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child:
            Consumer<WeatherProvider>(builder: (context, weatherProv, child) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(7.5, 0, 7.5, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WeatherDetailWidgets.containerPart(context, weatherProv),
                ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: weatherProv.weatherModel?.list?.length,
                    itemBuilder: (context, index) {
                      var datas = weatherProv.weatherModel?.list?[index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('EEE').format(DateTime.parse(
                                datas?.dtTxt ?? DateTime.now().toString())),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Image.network(
                                "http://openweathermap.org/img/w/${datas?.weather?.first.icon}.png",
                                fit: BoxFit.contain,
                                height: 50,
                                width: 50,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.network(
                                    'src',
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.contain,
                                  );
                                },
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                datas?.weather?.first.main ?? '',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                '+${datas?.main?.temp ?? '20'}\u00B0',
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                DateFormat('hh:mm a').format(DateTime.parse(
                                    datas?.dtTxt ?? DateTime.now().toString())),
                                style: const TextStyle(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      );
                    })
              ],
            ),
          );
        }),
      ),
    );
  }
}
