import 'package:flutter/material.dart';
import 'package:multi_store_app2/galleries/men_gallery.dart';
import 'package:multi_store_app2/galleries/women_gallery.dart';

import '../galleries/accessories_gallery.dart';
import '../galleries/bags_gallery.dart';
import '../galleries/beauty_gallery.dart';
import '../galleries/electronics_gallery.dart';
import '../galleries/hoemgarden_gallery.dart';
import '../galleries/kids_gallery.dart';
import '../galleries/shoes_galley.dart';
import '../widgets/fake_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    // Simulate some asynchronous operation (e.g., fetching data)
    Future.delayed(
        const Duration(
          milliseconds: 5,
        ), () {
      setState(() {
        isLoading = false; // Set loading to false when data is loaded
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade100.withOpacity(0.7),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const FakeSearch(),
          centerTitle: true,
          bottom: const TabBar(
              isScrollable: true,
              indicatorColor: Colors.black,
              indicatorWeight: 5,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                RepeatedTab(
                  label: 'Men',
                ),
                RepeatedTab(
                  label: 'Women',
                ),
                RepeatedTab(
                  label: 'Shoes',
                ),
                RepeatedTab(
                  label: 'Bags',
                ),
                RepeatedTab(
                  label: 'Electronics',
                ),
                RepeatedTab(
                  label: 'Accessories',
                ),
                RepeatedTab(
                  label: 'Home & Garden',
                ),
                RepeatedTab(
                  label: 'Kids',
                ),
                RepeatedTab(
                  label: 'Beauty',
                ),
              ]),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const TabBarView(
                children: [
                  MensGalleryScreen(),
                  WomenGalleryScreen(),
                  ShoesGalleryScreen(),
                  BagsGalleryScreen(),
                  ElectronicsGalleryScreen(),
                  AccessoriesGalleryScreen(),
                  HomegardenGalleryScreen(),
                  KidsGalleryScreen(),
                  BeautyGalleryScreen(),
                ],
              ),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({super.key, required this.label});
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label,
        style: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}
