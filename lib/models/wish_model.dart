import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/product_class.dart';
import '../providers/wish_provider.dart';

class WishlistModel extends StatelessWidget {
  const WishlistModel({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: SizedBox(
          height: 110,
          child: Row(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Image.network(
                  product.imagesUrl.first,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.price.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Provider.of<Wish>(context, listen: false)
                                      .removeItem(product);
                                },
                                icon: const Icon(Icons.delete_forever),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Provider.of<Cart>(context, listen: false)
                                              .getItems
                                              .firstWhereOrNull((element) =>
                                                  element.documentId ==
                                                  product.documentId) !=
                                          null ||
                                      product.qty == 0
                                  ? const SizedBox()
                                  : IconButton(
                                      onPressed: () {
                                        Provider.of<Cart>(context,
                                                        listen: false)
                                                    .getItems
                                                    .firstWhereOrNull(
                                                        (element) =>
                                                            element
                                                                .documentId ==
                                                            product
                                                                .documentId) !=
                                                null
                                            ? print('in cart')
                                            : Provider.of<Cart>(context,
                                                    listen: false)
                                                .addItem(
                                                product.name,
                                                product.price,
                                                1,
                                                product.qntty,
                                                product.imagesUrl,
                                                product.documentId,
                                                product.suppId,
                                              );
                                        Provider.of<Wish>(context,
                                                listen: false)
                                            .removeItem(product);
                                      },
                                      icon: const Icon(Icons.add_shopping_cart),
                                    ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
