import 'package:flutter/material.dart';
import 'package:galaxy_planets/utils/apptheme.dart';
import 'package:galaxy_planets/views/screens/details_screen.dart';
import 'package:galaxy_planets/views/screens/first_screen.dart';
import 'package:galaxy_planets/views/screens/homescreen.dart';
import 'package:galaxy_planets/views/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/provider/planet.dart';
import 'controller/provider/themeprovider.dart';
import 'modals/theme_model.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkTheme = prefs.getBool('isDark') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlanetProvider()),
        ChangeNotifierProvider(create: (context) =>
            ThemeProvider(themeModel: ThemeModel(isDark: isDarkTheme))),
      ],
      builder: (context, _) {
        return MaterialApp(
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode:
          (Provider.of<ThemeProvider>(context).themeModel.isDark == true)
              ? ThemeMode.light
              : ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          initialRoute: 'homepage',
          routes: {
            '/': (context) => SplashScreen(),
            'detail1':(context)=>detail1(),
            'homepage':(context) => Homepage(),
            'details':(context) => Details_screen(),
          },
        );
      },
    ),
  );
}
