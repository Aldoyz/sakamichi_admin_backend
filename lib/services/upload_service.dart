import 'dart:convert';
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as http;

Future<String> uploadImage(String imageFile, String imagePath) async {
  final DotEnv env = DotEnv()..load();
  final albumHash = env['sakamichiAlbumHash'] as String;
  final currentAccessToken = env['imgurAccessToken'] as String;
  final filePath = imagePath + imageFile;
  try {
    final url = Uri.parse('https://api.imgur.com/3/image');
    final request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer $currentAccessToken';
    request.fields['album'] = albumHash;
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      filePath,
    ));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      print(responseBody);
      final json = jsonDecode(responseBody);
      print(json);
      final imageUrl = json['data']['link'];
      print(imageUrl);
      return imageUrl.toString();
    } else {
      return 'Upload failed';
    }
  } catch (e) {
    return e.toString();
  }
}
