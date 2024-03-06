import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../minor_screens/product_details.dart';
import '../providers/wish_provider.dart';

class ProductModel extends StatefulWidget {
  final QueryDocumentSnapshot products;
  const ProductModel({
    super.key,
    required this.products,
  });

  @override
  State<ProductModel> createState() => _ProductModelState();
}

class _ProductModelState extends State<ProductModel> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProductDetailsScreen(
                prodList: widget.products,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 100,
                    maxHeight: 300,
                    maxWidth: 250,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image(
                      image: NetworkImage(widget.products['prodimages'][0]),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  bottom: 5.0,
                ),
                child: Column(
                  children: [
                    Text(
                      widget.products['prodname'],
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "${widget.products['price'].toStringAsFixed(2)} \$",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        widget.products['sid'] ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.red,
                                  size: 19,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  var existingItemWishlist =
                                      Provider.of<Wish>(context, listen: false)
                                          .getWishItems
                                          .firstWhereOrNull(
                                            (product) =>
                                                product.documentId ==
                                                widget.products['proid'],
                                          );

                                  existingItemWishlist != null
                                      ? Provider.of<Wish>(context,
                                              listen: false)
                                          .removeThis(
                                          widget.products['proid'],
                                        )
                                      : Provider.of<Wish>(context,
                                              listen: false)
                                          .addWishItem(
                                          widget.products['prodname'],
                                          widget.products['price'],
                                          1,
                                          widget.products['instock'],
                                          widget.products['prodimages'],
                                          widget.products['proid'],
                                          widget.products['sid'],
                                        );
                                },
                                icon: Provider.of<Wish>(context, listen: true)
                                            .getWishItems
                                            .firstWhereOrNull(
                                              (product) =>
                                                  product.documentId ==
                                                  widget.products['proid'],
                                            ) !=
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
