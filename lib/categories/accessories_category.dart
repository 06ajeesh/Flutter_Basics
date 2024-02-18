import 'package:flutter/material.dart';

import '../utilities/category_list.dart';
import '../widgets/category_widgets.dart';

class AccessoriesCategory extends StatelessWidget {
  const AccessoriesCategory({super.key});

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
              width: MediaQuery.of(context).size.width * 0.74,
              child: ListView(
                children: [
                  const CategoryHeaderLabel(
                    headerLabel: 'Accessories',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 60,
                        children:
                            List.generate(accessories.length - 1, (index) {
                          return SubcategoryModel(
                            mainCategoryName: 'Electronics',
                            subCategoryName: accessories[index + 1],
                            assetName:
                                'images/accessories/accessories$index.jpg',
                            subCategoryLabel: accessories[index + 1],
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
            child: SlideBar(maincategoryName: 'Accessories'),
          )
        ],
      ),
    );
  }
}
