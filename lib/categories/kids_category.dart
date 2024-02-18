import 'package:flutter/material.dart';

import '../utilities/category_list.dart';
import '../widgets/category_widgets.dart';

class KidsCategory extends StatelessWidget {
  const KidsCategory({super.key});

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
                    headerLabel: 'Kids',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 60,
                        children:
                            List.generate(homeandgarden.length - 1, (index) {
                          return SubcategoryModel(
                            mainCategoryName: 'kids',
                            subCategoryName: homeandgarden[index + 1],
                            assetName: 'images/kids/kids$index.jpg',
                            subCategoryLabel: kids[index + 1],
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
            child: SlideBar(maincategoryName: 'Kids'),
          )
        ],
      ),
    );
  }
}
