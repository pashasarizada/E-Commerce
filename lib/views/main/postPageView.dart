import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/imageUploadService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecom/services/productService.dart';
class PostPageView extends StatefulWidget {
  const PostPageView({super.key});

  @override
  State<PostPageView> createState() => _PostPageViewState();
}

class _PostPageViewState extends State<PostPageView> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationController = TextEditingController();

  final List<XFile> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  final currentUser = FirebaseAuth.instance.currentUser;

  bool _isUploading = false;

  Future<void> _pickImages() async {
    if (_selectedImages.length >= 3) return;

    final picked = await _picker.pickMultiImage();

    if (picked != null) {
      setState(() {
        _selectedImages.addAll(picked.take(3 - _selectedImages.length));
      });
    }
  }
  Future<void> _submitProduct() async {
    final title = _titleController.text.trim();
    final desc = _descriptionController.text.trim();
    final price = _priceController.text.trim();
    final location = _locationController.text.trim();

    if (_selectedImages.isEmpty || title.isEmpty || desc.isEmpty || price.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen tüm zorunlu alanları doldurun.')),
      );
      return;
    }

    try {
      setState(() => _isUploading = true);

      List<String> imageUrls = [];

      for (var image in _selectedImages) {
        final url = await ImageUploadService.uploadImage(image);
        if (url != null) imageUrls.add(url);
      }

      await ProductService().addProduct(
        title: title,
        description: desc,
        price: double.parse(price),
        location: location.isEmpty ? null : location,
        imageUrls: imageUrls,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ürün başarıyla yayınlandı!')),
      );

      _titleController.clear();
      _descriptionController.clear();
      _priceController.clear();
      _locationController.clear();
      setState(() => _selectedImages.clear());

    } catch (e) {
      print('HATA: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata oluştu: $e')),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Put It on Sale'),automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: _pickImages,
                  child: Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: const Icon(Icons.add_a_photo),
                  ),
                ),
                const SizedBox(width: 10),
                ..._selectedImages.map((img) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.file(
                    File(img.path),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                )),
              ],
            ),
            const SizedBox(height: 20),

            // FORM
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Başlık'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Açıklama'),
              maxLines: 3,
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Fiyat'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Konum (opsiyonel)'),
            ),
            const SizedBox(height: 20),

            _isUploading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _submitProduct,
              child: const Text('Yayınla'),
            ),
          ],
        ),
      ),
    );
  }
}
