export 'package:chatbot/widgets.dart';
import 'package:image_picker/image_picker.dart';

class CustomWidgets {
  static Future<List<XFile>> pickImageFromGallery() async {
    final picker = ImagePicker();
    final List<XFile> pickedImages = await picker.pickMultiImage();
    return pickedImages;
  }
}
