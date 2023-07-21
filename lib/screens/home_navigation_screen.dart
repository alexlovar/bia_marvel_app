import 'package:flutter/material.dart';
import 'package:marvel_app/screens/explore_series_screen/explore_series_screen.dart';

class HomeNavigationView extends StatefulWidget {
  const HomeNavigationView({super.key});

  @override
  State<HomeNavigationView> createState() => _HomeNavigationViewState();
}

class _HomeNavigationViewState extends State<HomeNavigationView> {

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: ExploreSeriesView(),
    );
  }
}
