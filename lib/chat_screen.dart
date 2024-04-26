import 'package:chatbot/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

const String _apiKey = 'AIzaSyDMGiYx-cJE2FGXvtgjssOE03HX9-nFYqU';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: const ChatWidget(
        apiKey: _apiKey,
      ),
    );
  }
}

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key, required this.apiKey});
  final String apiKey;

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late final GenerativeModel _model;
  late final GenerativeModel _visionModel;
  late final ChatSession _chat;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocus = FocusNode();
  final List<({Image? image, String? text, bool fromUser})> _generatedContent =
      <({Image? image, String? text, bool fromUser})>[];
  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: widget.apiKey,
    );
    _visionModel = GenerativeModel(
      model: 'gemini-pro-vision',
      apiKey: widget.apiKey,
    );
    _chat = _model.startChat();
  }

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const textFieldDecoration = InputDecoration(
      contentPadding: EdgeInsets.all(15),
      hintText: 'Enter a prompt...',
      hintStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        borderSide: BorderSide(
          width: 2,
          color: Colors.black, // Set the border color here
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        borderSide: BorderSide(
          color: Colors.black, // Set the border color here
        ),
      ),
    );
    ;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _apiKey.isNotEmpty
                  ? ListView.builder(
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        final content = _generatedContent[index];
                        return MessageWidget(
                          text: content.text,
                          isFromUser: content.fromUser,
                          image: content.image,
                        );
                      },
                      itemCount: _generatedContent.length,
                    )
                  : ListView(
                      children: const [
                        Center(
                          child: Text("No API Key Found"),
                        ),
                      ],
                    ),
            ),
            paddedRow(
              textFieldDecoration,
              context,
              _textFieldFocus,
              _textController,
              _sendChatMessage,
              _loading,
              _sendImagePrompt,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _loading = true;
    });

    try {
      _generatedContent.add((image: null, text: message, fromUser: true));
      final response = await _chat.sendMessage(Content.text(message));
      final text = response.text;
      _generatedContent.add((image: null, text: text, fromUser: false));
      if (text == null) {
        _showError("No response from API");
        return;
      } else {
        setState(() {
          _loading = false;
          scrollDown();
        });
      }
    } catch (e) {
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      _textController.clear();
      setState(() {
        _loading = false;
      });
      _textFieldFocus.requestFocus();
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Something Went wrong"),
          content: SingleChildScrollView(
            child: SelectableText(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _sendImagePrompt(String message) async {
    setState(() {
      _loading = true;
    });

    try {
      final imageList = await CustomWidgets.pickImageFromGallery();

      if (imageList.isNotEmpty) {
        final List<Uint8List> imageBytesList = [];
        for (var pickedImage in imageList) {
          final imageBytes = await pickedImage.readAsBytes();
          imageBytesList.add(imageBytes);
        }

        final content = [
          Content.multi([
            TextPart(message),
            for (var imageBytes in imageBytesList)
              DataPart('image/jpeg', imageBytes),
          ])
        ];

        for (int i = 0; i < imageList.length; i++) {
          _generatedContent.add((
            image: Image.memory(imageBytesList[i]),
            text: message,
            fromUser: true
          ));
        }

        var response = await _visionModel.generateContent(content);
        var text = response.text;
        _generatedContent.add((image: null, text: text, fromUser: false));

        if (text == null) {
          _showError('No response from API.');
          return;
        } else {
          setState(() {
            _loading = false;
            scrollDown();
          });
        }
      }
    } catch (e) {
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      _textController.clear();
      setState(() {
        _loading = false;
      });
      _textFieldFocus.requestFocus();
    }
  }

  paddedRow(
      InputDecoration textFieldDecoration,
      BuildContext context,
      FocusNode textFieldFocus,
      TextEditingController textController,
      sendChatMessage,
      bool loading,
      sendImagePrompt) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 3,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autofocus: true,
              focusNode: textFieldFocus,
              decoration: textFieldDecoration,
              keyboardType: TextInputType.emailAddress,
              controller: textController,
              onSubmitted: sendChatMessage,
            ),
          ),
          IconButton(
            onPressed: !loading
                ? () async {
                    sendImagePrompt(textController.text);
                  }
                : null,
            icon: Icon(
              Icons.image,
              color: loading ? Colors.green : Colors.black,
            ),
          ),
          !loading
              ? IconButton(
                  onPressed: () async {
                    sendChatMessage(textController.text);
                  },
                  icon: const Icon(
                    Icons.send_outlined,
                    color: Colors.black,
                  ),
                )
              : const CircularProgressIndicator(),
        ],
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    this.image,
    this.text,
    required this.isFromUser,
  });

  final Image? image;
  final String? text;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
            child: Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6),
                decoration: BoxDecoration(
                  color: isFromUser
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                margin: const EdgeInsets.only(bottom: 8),
                child: Column(children: [
                  if (text case final text?) MarkdownBody(data: text),
                  if (image case final image?) image,
                ]))),
      ],
    );
  }
}
