import 'package:image_picker/image_picker.dart';

Future loadImagesGallery() async {
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  if (image != null && image.path.isNotEmpty) {
    return image;
  }
}

Future loadImagesCamera() async {
  var image = await ImagePicker.pickImage(source: ImageSource.camera);
  if (image != null && image.path.isNotEmpty) {
    return image;
  }
}
