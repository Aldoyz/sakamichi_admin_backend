import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:sakamichi_admin/controller/group_controller.dart';
import 'package:sakamichi_admin/models/general_response.dart';

FutureOr<Response> onRequest(RequestContext context, String id) async {
  if (context.request.method == HttpMethod.get) {
    return GroupController.getGroup(context, int.parse(id));
  } else if (context.request.method == HttpMethod.put) {
    return GroupController.updateGroup(context, int.parse(id));
  } else if (context.request.method == HttpMethod.delete) {
    return GroupController.deleteGroup(context, int.parse(id));
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
