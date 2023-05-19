import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:sakamichi_admin/controller/member_controller.dart';
import 'package:sakamichi_admin/models/general_response.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    return MemberController.addMember(context);
  } else if (context.request.method == HttpMethod.get) {
    final params = context.request.uri.queryParameters;
    final name = params['name'];
    if (name != null) {
      return MemberController.searchByName(context, name);
    } else {
      return MemberController.listAll(context);
    }
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
