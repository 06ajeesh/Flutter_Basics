import 'package:flutter/material.dart';
import 'package:multi_store_app2/widgets/appbar_widgets.dart';

class FullScreenView extends StatefulWidget {
  final List<dynamic> imagesList;
  const FullScreenView({super.key, required this.imagesList});

  @override
  State<FullScreenView> createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView> {
  final PageController _controller = PageController();
  int indexNumber = 1;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppBarBackButton(),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Text('$indexNumber/${widget.imagesList.length}'),
            ),
            SizedBox(
              height: size.height * 0.5,
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (value) {
                  setState(() {
                    indexNumber = value + 1;
                  });
                },
                itemCount: widget.imagesList.length,
                itemBuilder: (context, index) {
                  return InteractiveViewer(
                    transformationController: TransformationController(),
                    child: Image(
                        image:
                            NetworkImage(widget.imagesList[index].toString())),
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
              child: imageView(),
            )
          ],
        ),
      ),
    );
  }

  Widget imageView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.imagesList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              indexNumber = index;
            });
            _controller.jumpToPage(index);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            width: 250,
            decoration: BoxDecoration(
              border: Border.all(
                width: 4,
                color: Colors.yellow,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                image: NetworkImage(widget.imagesList[index]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
