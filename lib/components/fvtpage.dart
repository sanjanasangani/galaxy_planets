import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/provider/planet.dart';
import '../modals/planetmodel.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<Favourite_Provider>(
        builder: (context, provider, _) {
          List<PlanetModel> favoritePlanets = provider.favourite;
          if (favoritePlanets.isEmpty) {
            return Center(
              child: Text('No favorite planets yet.'),
            );
          } else {
            return ListView.builder(
              itemCount: favoritePlanets.length,
              itemBuilder: (context, index) {
                PlanetModel planet = favoritePlanets[index];
                return ListTile(
                  title: Text(planet.name),
                );
              },
            );
          }
        },
      ),
    );
  }
}
