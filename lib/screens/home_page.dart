import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/screens/detail_screen.dart';

import '../widgets/export_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(7.5, 0, 7.5, 10),
          child:
              Consumer<WeatherProvider>(builder: (context, weatherProv, child) {
            return weatherProv.weatherModel?.list?.isEmpty ?? true
                ? const Center(
                    child: Padding(
                    padding: EdgeInsets.only(top: 300),
                    child: CircularProgressIndicator(),
                  ))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomePageWidgets.stackedContainer(context, weatherProv),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Today\'s weather',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const WeatherDetailScreen()));
                              },
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: const [
                                  Text(
                                    'View all',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white30),
                                  ),
                                  SizedBox(
                                    width: .5,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.white30,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      HomePageWidgets.horizontalBuilder(weatherProv)
                    ],
                  );
          }),
        ),
      ),
    );
  }
}
