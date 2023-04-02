import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/iwwa.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/tabler.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/provider/export_provider.dart';
import 'package:weather_app/screens/export_screens.dart';

class HomePageWidgets {
  static String iconUrl(context, WeatherProvider prov) {
    return "http://openweathermap.org/img/w/${prov.weatherModel?.list?[prov.currentIndex].weather?.first.icon}.png";
  }

  static String capitalize(String value) {
    var result = value[0].toUpperCase();
    bool cap = true;
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " " && cap == true) {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
        cap = false;
      }
    }
    return result;
  }

  static Widget appBar(WeatherProvider prov, context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Iconify(
              MaterialSymbols.location_on_outline_rounded,
              color: Colors.white,
              size: 26,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              prov.weatherModel?.city?.name ?? 'Location Name',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            )
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const GoogleMapPage()));
          },
          child: const Icon(
            Icons.search,
            color: Colors.white,
            size: 28,
          ),
        )
      ],
    );
  }

  static Widget stackedContainer(context, WeatherProvider weatherProv) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.25,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
            bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            HomePageWidgets.appBar(weatherProv, context),
            const SizedBox(
              height: 10,
            ),
            Image.network(
              HomePageWidgets.iconUrl(context, weatherProv),
              fit: BoxFit.cover,
              height: 250,
              width: MediaQuery.of(context).size.width - 100,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  'https://plus.unsplash.com/premium_photo-1677593850639-9f1e14e4524b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
                  height: 250,
                  width: MediaQuery.of(context).size.width - 100,
                );
              },
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${weatherProv.weatherModel?.list?[weatherProv.currentIndex].main?.temp ?? 20}\u00B0',
              style: const TextStyle(
                  fontSize: 55,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              HomePageWidgets.capitalize(weatherProv
                      .weatherModel
                      ?.list?[weatherProv.currentIndex]
                      .weather
                      ?.first
                      .description ??
                  ''),
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              DateFormat('EEEE d MMMM').format(DateTime.parse(weatherProv
                      .weatherModel?.list?[weatherProv.currentIndex].dtTxt ??
                  DateTime.now().toString())),
              style: const TextStyle(fontSize: 16, color: Colors.white54),
            ),
            HomePageWidgets.dividerAndIcons(weatherProv),
          ],
        ),
      ),
    );
  }

  static Widget weatherIconAndTextColumn(
      {required Widget icon, required String text, required String type}) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.vertical,
      children: [
        icon,
        const SizedBox(
          height: 7.5,
        ),
        Text(
          text,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          type,
          style: const TextStyle(fontSize: 12, color: Colors.white54),
        )
      ],
    );
  }

  static Widget dividerAndIcons(WeatherProvider weatherProv) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: Colors.white54,
            thickness: .5,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              weatherIconAndTextColumn(
                  icon: const Iconify(
                    Tabler.wind,
                    color: Colors.white,
                  ),
                  text:
                      '${weatherProv.weatherModel?.list?[weatherProv.currentIndex].wind?.speed ?? ''} km/h',
                  type: 'Wind'),
              weatherIconAndTextColumn(
                  icon: const Iconify(
                    Iwwa.humidity,
                    color: Colors.white,
                    size: 28,
                  ),
                  text:
                      '${weatherProv.weatherModel?.list?[weatherProv.currentIndex].main?.humidity ?? ''}%',
                  type: 'Humidity'),
              weatherIconAndTextColumn(
                  icon: const Iconify(
                    Bi.clouds_fill,
                    color: Colors.white,
                  ),
                  text:
                      '${weatherProv.weatherModel?.list?[weatherProv.currentIndex].clouds?.all ?? ''}',
                  type: 'Cloudy'),
            ],
          ),
        ],
      ),
    );
  }

  static Widget horizontalBuilder(WeatherProvider weatherProv) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          scrollDirection: Axis.horizontal,
          itemCount: weatherProv.weatherWithDate.length,
          itemBuilder: (context, index) {
            var datas = weatherProv.weatherWithDate[index];
            return GestureDetector(
              onTap: () {
                weatherProv.toggleIndex(index);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 7.5,
                ),
                padding: weatherProv.currentIndex == index
                    ? const EdgeInsets.symmetric(vertical: 8, horizontal: 20)
                    : const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: weatherProv.currentIndex == index
                        ? Colors.blue.shade700
                        : Colors.black,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Text(
                      '${datas.main?.temp ?? '20'}\u00B0',
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Image.network(
                      "http://openweathermap.org/img/w/${datas.weather?.first.icon}.png",
                      fit: BoxFit.contain,
                      height: 75,
                      width: 75,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          'src',
                          height: 75,
                          width: 75,
                          fit: BoxFit.contain,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 2.5,
                    ),
                    Text(
                      DateFormat.Hm().format(DateTime.parse(
                          datas.dtTxt ?? DateTime.now().toString())),
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
