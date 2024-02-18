import 'package:flutter/material.dart';
import '../utilities/category_list.dart';
import '../widgets/category_widgets.dart';

class HomeGardenCategory extends StatelessWidget {
  const HomeGardenCategory({super.key});

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
                    headerLabel: 'Home',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 60,
                        children:
                            List.generate(homeandgarden.length - 1, (index) {
                          return SubcategoryModel(
                            mainCategoryName: 'Home and Garden',
                            subCategoryName: homeandgarden[index + 1],
                            assetName: 'images/homegarden/home$index.jpg',
                            subCategoryLabel: homeandgarden[index + 1],
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
            child: SlideBar(maincategoryName: 'Home and Garden'),
          )
        ],
      ),
    );
  }
}
