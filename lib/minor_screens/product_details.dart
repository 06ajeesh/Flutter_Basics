import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:multi_store_app2/main_screens/cart.dart';
import 'package:multi_store_app2/minor_screens/visit_store.dart';
import 'package:multi_store_app2/widgets/appbar_widgets.dart';
import 'package:multi_store_app2/widgets/snackBar.dart';
import 'package:multi_store_app2/widgets/yellow_button.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../providers/wish_provider.dart';
import 'full_screen_view.dart';
import 'package:collection/collection.dart';
import 'package:badges/badges.dart' as badges;

class ProductDetailsScreen extends StatefulWidget {
  final prodList;
  const ProductDetailsScreen({super.key, required this.prodList});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
      .collection('products')
      .where('maincateg', isEqualTo: widget.prodList['maincateg'])
      .where('subcateg', isEqualTo: widget.prodList['subcateg'])
      .snapshots();

  late List<dynamic> imagesList = widget.prodList['prodimages'];
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var existingItemCart = context.read<Cart>().getItems.firstWhereOrNull(
        (product) => product.documentId == widget.prodList['proid']);
    return Material(
      child: SafeArea(
        child: ScaffoldMessenger(
          key: _scaffoldKey,
          child: Scaffold(
            backgroundColor: Colors.grey.shade300,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FullScreenView(imagesList: imagesList),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: Swiper(
                            pagination: const SwiperPagination(
                              builder: SwiperPagination.fraction,
                              alignment: Alignment(0, 0.6),
                            ),
                            itemBuilder: (context, index) {
                              return Image(
                                image: NetworkImage(imagesList[index]),
                              );
                            },
                            itemCount: imagesList.length,
                          ),
                        ),
                        Positioned(
                          left: 15,
                          top: 20,
                          child: CircleAvatar(
                            backgroundColor: Colors.yellow,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back_ios_new),
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 15,
                          top: 20,
                          child: CircleAvatar(
                            backgroundColor: Colors.yellow,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.share),
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      8,
                      8,
                      8,
                      50,
                    ),
                    child: Text(
                      widget.prodList['prodname'].toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'INR ',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            widget.prodList['price'].toStringAsFixed(2),
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          var existingItemWishlist = context
                              .read<Wish>()
                              .getWishItems
                              .firstWhereOrNull((product) =>
                                  product.documentId ==
                                  widget.prodList['proid']);

                          existingItemWishlist != null
                              ? context
                                  .read<Wish>()
                                  .removeThis(widget.prodList['proid'])
                              : context.read<Wish>().addWishItem(
                                    widget.prodList['prodname'],
                                    widget.prodList['price'],
                                    1,
                                    widget.prodList['instance'],
                                    widget.prodList['prodimages'],
                                    widget.prodList['proid'],
                                    widget.prodList['sid'],
                                  );
                        },
                        icon: context
                                    .watch()<Wish>()
                                    .getWishItems
                                    .firstWhereOrNull((product) =>
                                        product.documentId ==
                                        widget.prodList['proid']) !=
                                null
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 30,
                              )
                            : const Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.red,
                                size: 30,
                              ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          '${widget.prodList['instance']} pieces are available',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const ProdDetailsHeader(label: ' Item Description'),
                  Text(
                    widget.prodList['proddesc'],
                    textScaler: const TextScaler.linear(1.1),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey.shade800,
                    ),
                  ),
                  const ProdDetailsHeader(label: ' Similar Items '),
                  SizedBox(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _productsStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }

                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text(
                              'This Category \n \n has no items yet',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 26,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Acme',
                                letterSpacing: 1.5,
                              ),
                            ),
                          );
                        }

                        return SingleChildScrollView(
                          child: StaggeredGridView.countBuilder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            crossAxisCount: 2,
                            itemBuilder: (context, index) {
                              return ProductModel(
                                products: snapshot.data!.docs[index],
                              );
                            },
                            staggeredTileBuilder: (index) {
                              return const StaggeredTile.fit(1);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            bottomSheet: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VisitStore(suppId: widget.prodList['sid']),
                            ));
                      },
                      icon: const Icon(Icons.store),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(
                              back: AppBarBackButton(
                                buttonColor: Colors.black87,
                              ),
                            ),
                          ),
                        );
                      },
                      icon: badges.Badge(
                        showBadge: context.read<Cart>().getItems.isEmpty
                            ? false
                            : true,
                        badgeStyle: const badges.BadgeStyle(
                          padding: EdgeInsets.all(3),
                          shape: badges.BadgeShape.square,
                        ),
                        badgeAnimation: const badges.BadgeAnimation.rotation(
                            loopAnimation: true),
                        badgeContent: Text(
                          context.watch<Cart>().getItems.length.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        child: const Icon(Icons.shopping_cart),
                      ),
                      // icon: const Icon(Icons.shopping_cart),
                    ),
                  ],
                ),
                YellowButton(
                  label: existingItemCart != null
                      ? 'Added to cart'.toUpperCase()
                      : 'Add To Cart'.toUpperCase(),
                  width: 0.4,
                  onPressed: () {
                    existingItemCart != Null
                        ? MyMessageHandler.showSnackBar(
                            _scaffoldKey, "This item is already in your cart")
                        : context.read<Cart>().addItem(
                              widget.prodList['prodname'],
                              widget.prodList['price'],
                              1,
                              widget.prodList['instance'],
                              widget.prodList['prodimages'],
                              widget.prodList['proid'],
                              widget.prodList['sid'],
                            );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//

class ProdDetailsHeader extends StatelessWidget {
  final String label;
  const ProdDetailsHeader({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.yellow.shade900,
              thickness: 1,
            ),
          ),
          Text(
            label,
            style: TextStyle(
                color: Colors.yellow.shade900,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.yellow.shade900,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
