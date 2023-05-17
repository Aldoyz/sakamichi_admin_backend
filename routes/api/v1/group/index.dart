import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:sakamichi_admin/controller/group_controller.dart';
import 'package:sakamichi_admin/models/general_response.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.get) {
    return GroupController.listAllGroup(context);
  } else if (context.request.method == HttpMethod.post) {
    return GroupController.addGroup(context);
  } else {
    return Response.json(
      statusCode: HttpStatus.methodNotAllowed,
      body: GeneralResponse(
        status: false,
        message: 'Method Not Allowed',
      ),
    );
  }
}
