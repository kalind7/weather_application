import 'package:flutter/material.dart';
import 'package:weather_app/widgets/export_widgets.dart';

import '../provider/export_provider.dart';
import '../screens/export_screens.dart';

class WeatherDetailWidgets {
  static Widget containerPart(context, WeatherProvider weatherProv) {
    return Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade200,
                Colors.blue.shade500,
                Colors.blue.shade800
              ]),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60)),
        ),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white)),
                    child: const Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const GoogleMapPage()));
                  },
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 28,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    HomePageWidgets.iconUrl(context, weatherProv),
                    height: 125,
                    width: 125,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Today',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(
                            height: 7.5,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text:
                                  '${weatherProv.weatherModel?.list?[weatherProv.currentIndex].main?.temp}\u00B0',
                              style: const TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text:
                                  '/${weatherProv.weatherModel?.list?[weatherProv.currentIndex].main?.tempMin}\u00B0',
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.white60,
                                  fontWeight: FontWeight.normal),
                            ),
                          ])),
                          const SizedBox(
                            height: 10,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: weatherProv
                                      .weatherModel
                                      ?.list?[weatherProv.currentIndex]
                                      .weather
                                      ?.first
                                      .main ??
                                  '',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white54),
                            ),
                            TextSpan(
                              text: HomePageWidgets.capitalize(
                                  ' - ${weatherProv.weatherModel?.list?[weatherProv.currentIndex].weather?.first.description ?? ''}'),
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white54),
                            ),
                          ]))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            HomePageWidgets.dividerAndIcons(weatherProv)
          ],
        )));
  }
}
