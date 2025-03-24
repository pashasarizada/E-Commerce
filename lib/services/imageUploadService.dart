// lib/services/image_upload_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageUploadService {
  static const String apiKey = 'be21cc03d7a999c289d56baa00bd844e';

  static Future<String?> uploadImage(XFile file) async {
    final bytes = await File(file.path).readAsBytes();
    final base64Image = base64Encode(bytes);

    final response = await http.post(
      Uri.parse('https://api.imgbb.com/1/upload?key=$apiKey'),
      body: {
        'image': base64Image,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['url'];
    } else {
      print('imgbb hata: ${response.body}');
      return null;
    }
  }
}
