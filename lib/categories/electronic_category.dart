import 'package:flutter/material.dart';
import '../utilities/category_list.dart';
import '../widgets/category_widgets.dart';

class ElectronicsCategory extends StatelessWidget {
  const ElectronicsCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.7,
              child: ListView(
                children: [
                  const CategoryHeaderLabel(
                    headerLabel: 'Electronics',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 60,
                        children:
                            List.generate(electronics.length - 1, (index) {
                          return SubcategoryModel(
                            mainCategoryName: 'Electronics',
                            subCategoryName: electronics[index + 1],
                            assetName:
                                'images/electronics/electronics$index.jpg',
                            subCategoryLabel: electronics[index + 1],
                          );
                        })),
                  )
                ],
              ),
            ),
          ),
          const Positioned(
            right: 0,
            bottom: 0,
            child: SlideBar(maincategoryName: 'Electronics'),
          )
        ],
      ),
    );
  }
}
