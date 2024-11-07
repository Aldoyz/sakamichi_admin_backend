import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:http/http.dart' as http;

import 'package:sakamichi_admin/models/general_response.dart';
import 'package:sakamichi_admin/services/upload_service.dart';

class UploadController {
  static Future<Response> uploadFile(
    RequestContext context,
  ) async {
    final formData = await context.request.formData();
    final imageFile = formData.files['image'];
    final imagePath = formData.fields['path'];
    if (imageFile != null && imagePath != null) {
      final fileName = imageFile.name;
      try {
        final imageUrl = await uploadImage(fileName, imagePath);
        return Response(body: imageUrl);
      } catch (e) {
        return Response.json(
          statusCode: HttpStatus.internalServerError,
          body: GeneralResponse(
            status: false,
            message: 'Failed To Upload File',
          ),
        );
      }
    }
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: GeneralResponse(
        status: false,
        message: 'imageFile and/or imagePath is empty',
      ),
    );
  }
}
