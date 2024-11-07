import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:sakamichi_admin/controller/upload_controller.dart';
import 'package:sakamichi_admin/models/general_response.dart';

Future<Response> onRequest(RequestContext context) async {
  // final DotEnv env = DotEnv()..load();
  // final accessToken = env['dropboxAccessToken'] as String;
  // final key = env['dropboxKey'] as String;
  // final secret = env['dropboxSecret'] as String;

  if (context.request.method == HttpMethod.post) {
    return UploadController.uploadFile(context);
  } else {
    return Response.json(body: {'error', 'zonk'});
  }
}
