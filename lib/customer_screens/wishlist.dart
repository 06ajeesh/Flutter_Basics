import 'package:flutter/material.dart';
import 'package:multi_store_app2/providers/wish_provider.dart';
import 'package:multi_store_app2/widgets/alert_dialog.dart';
import 'package:multi_store_app2/widgets/appbar_widgets.dart';
import 'package:provider/provider.dart';
import '../models/wish_model.dart';

class WishlistScreen extends StatefulWidget {
  final Widget? back;

  const WishlistScreen({super.key, this.back});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(
          title: 'WishList',
        ),
        centerTitle: true,
        leading: widget.back,
        actions: [
          context.watch<Wish>().getWishItems.isEmpty
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    MyAlertDialog.showMyDialog(
                      context: context,
                      title: "Clear WishList",
                      content: "Are you sure",
                      tapNo: () {
                        Navigator.pop(context);
                      },
                      tapYes: () {
                        context.read<Wish>().clearWishList();
                        Navigator.pop(context);
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.black,
                  ),
                )
        ],
      ),
      body: context.watch<Wish>().getWishItems.isNotEmpty
          ? const WishItems()
          : const EmptyWishList(),
    );
  }
}

class EmptyWishList extends StatelessWidget {
  const EmptyWishList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your WishList is Empty',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}

class WishItems extends StatelessWidget {
  const WishItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Wish>(
      builder: (context, wish, child) {
        return ListView.builder(
          itemCount: wish.count,
          itemBuilder: (context, index) {
            final product = wish.getWishItems[index];
            return WishlistModel(product: product);
          },
        );
      },
    );
  }
}
