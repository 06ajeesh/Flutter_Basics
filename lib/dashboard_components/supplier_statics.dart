import 'package:flutter/material.dart';
import 'package:multi_store_app2/widgets/appbar_widgets.dart';

class Statics extends StatelessWidget {
  const Statics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Statics'),
        leading: const AppBarBackButton(),
        centerTitle: true,
      ),
    );
  }
}
