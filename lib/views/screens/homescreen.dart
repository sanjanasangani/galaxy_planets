import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/planet.dart';
import '../../controller/provider/themeprovider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? data;
  int i = 0;
  double rotationAngle = 0.0;
  Timer? rotationTimer;

  List<Color> containerColors = [
    Colors.brown,
    Colors.blue,
    Colors.grey,
    Colors.red,
    Colors.orange,
    Colors.orange.shade50,
    Colors.blueAccent,
    Colors.deepPurple
  ];

  @override
  void initState() {
    super.initState();
    startRotation();
    loadJSON();
  }

  loadJSON() async {
    await Provider.of<PlanetProvider>(context, listen: false).FormJson();
  }

  void startRotation() {
    rotationTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {
        rotationAngle += 0.1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              SingleChildScrollView( // Wrap the upper section with SingleChildScrollView
                child: Container(
                  height: _height * 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Let's Explore",
                                  style: TextStyle(fontSize: 28),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Provider.of<ThemeProvider>(context,
                                        listen: false)
                                        .ChangeTheme();
                                  },
                                  icon: Provider.of<ThemeProvider>(context)
                                      .themeModel
                                      .isDark
                                      ? const Icon(Icons.light_mode_outlined)
                                      : const Icon(Icons.dark_mode_rounded),
                                ),
                              ],
                            ),
                            Text(
                              "The milky way galaxy",
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                            const SizedBox(height: 30),
                            TextField(
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.6),
                                hintText: "Search for your Favorite planets",
                                hintStyle: const TextStyle(color: Colors.grey),
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: _height * 0.035,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Most popular",
                                  style: TextStyle(fontSize: _height * 0.025,fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: _height * 0.02,
                                ),
                                const Icon(Icons.arrow_right_alt),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                          Provider.of<PlanetProvider>(context).Planet.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 15,
                            mainAxisExtent: 180,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed("details", arguments: index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: containerColors[
                                  index % containerColors.length],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: _height * 0.01,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: TweenAnimationBuilder(
                                        duration: const Duration(seconds: 2),
                                        tween: Tween<double>(begin: 0, end: 2 * pi),
                                        child: Center(
                                          child: Image.asset(
                                            Provider.of<PlanetProvider>(context)
                                                .Planet[index]
                                                .image,
                                          ),
                                        ),
                                        builder: (BuildContext context,
                                            double value, Widget? widget) {
                                          return Transform.rotate(
                                            angle: rotationAngle,
                                            child: widget,
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 20,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              Provider.of<PlanetProvider>(context)
                                                  .Planet[index]
                                                  .name,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: _height * 0.01,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              Provider.of<PlanetProvider>(context)
                                                  .Planet[index]
                                                  .name1,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.03,
                      ),
                      Row(
                        children: [
                          const Text(
                            "You may also like",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: _height * 0.02,
                          ),
                          const Icon(Icons.arrow_right_alt),
                        ],
                      ),
                      Expanded(
                        flex: 4,
                        child: Transform.scale(
                          scale: 0.9,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 50,
                            ),
                            child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                              Provider.of<PlanetProvider>(context).Planet.length,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 15,
                                mainAxisExtent: 150,
                                crossAxisSpacing: 30
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed("details", arguments: index);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: containerColors[
                                      index % containerColors.length],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: _height * 0.01,
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: TweenAnimationBuilder(
                                            duration:
                                            const Duration(seconds: 2),
                                            tween: Tween<double>(
                                                begin: 0, end: 2 * pi),
                                            child: Center(
                                              child: Image.asset(
                                                Provider.of<PlanetProvider>(
                                                    context)
                                                    .Planet[index]
                                                    .image,
                                                scale: 2,
                                              ),
                                            ),
                                            builder: (BuildContext context,
                                                double value, Widget? widget) {
                                              return Transform.rotate(
                                                angle: rotationAngle,
                                                child: widget,
                                              );
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 10,
                                              left: 10,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  Provider.of<PlanetProvider>(
                                                      context)
                                                      .Planet[index]
                                                      .name,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.01,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 65,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(30), bottom: Radius.circular(30)),
                    child: BottomNavigationBar(
                      backgroundColor: const Color(0xff373966),
                      selectedItemColor: Colors.red,
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: "Hello",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.favorite_border),
                          label: "Favorite",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.settings),
                          label: "Setting",
                        ),
                      ],
                      // Bottom Navigation Bar items and configurations...
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xff191932),
    );
  }
}
