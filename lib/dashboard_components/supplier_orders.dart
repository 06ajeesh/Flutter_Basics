import 'package:flutter/material.dart';
import 'package:multi_store_app2/dashboard_components/preparing_orders.dart';
import 'package:multi_store_app2/dashboard_components/shipping_orders.dart';
import 'package:multi_store_app2/widgets/appbar_widgets.dart';
import 'package:multi_store_app2/dashboard_components/delivered_orders.dart';

class SupplierOrders extends StatelessWidget {
  const SupplierOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const AppBarTitle(title: ' Orders'),
          centerTitle: true,
          leading: const AppBarBackButton(),
          bottom: const TabBar(
            indicatorColor: Colors.black,
            indicatorWeight: 5,
            tabs: [
              RepeatedTab(label: 'Preparing'),
              RepeatedTab(label: 'Shipping'),
              RepeatedTab(label: 'Delivered'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Preparing(),
            Shipping(),
            Delivered(),
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
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
