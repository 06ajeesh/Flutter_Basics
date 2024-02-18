import 'package:flutter/material.dart';

import '../minor_screens/subcategory_products.dart';

class CategoryHeaderLabel extends StatelessWidget {
  final String headerLabel;

  const CategoryHeaderLabel({super.key, required this.headerLabel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Text(
        headerLabel,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

class SubcategoryModel extends StatelessWidget {
  final String mainCategoryName;
  final String subCategoryName;
  final String assetName;
  final String subCategoryLabel;

  const SubcategoryModel(
      {super.key,
      required this.mainCategoryName,
      required this.subCategoryName,
      required this.assetName,
      required this.subCategoryLabel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubCategoryProducts(
              subcategoryName: subCategoryName,
              maincategoryName: mainCategoryName,
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            height: MediaQuery.of(context).size.width * 0.09,
            child: Image.asset(assetName),
          ),
          Text(
            subCategoryLabel,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SlideBar extends StatelessWidget {
  final String maincategoryName;

  const SlideBar({super.key, required this.maincategoryName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.83,
      width: MediaQuery.of(context).size.width * 0.05,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.brown.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: RotatedBox(
            quarterTurns: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                maincategoryName == 'Beauty'
                    ? const Text('')
                    : const Icon(Icons.keyboard_double_arrow_left_sharp),
                Text(
                  maincategoryName.toUpperCase(),
                  style: const TextStyle(
                    letterSpacing: 6,
                  ),
                ),
                maincategoryName == 'Men'
                    ? const Text('')
                    : const Icon(Icons.double_arrow_outlined),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
