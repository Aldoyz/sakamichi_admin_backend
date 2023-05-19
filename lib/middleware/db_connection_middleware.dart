import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import 'package:sakamichi_admin/database/connection.dart';
import 'package:sakamichi_admin/models/general_response.dart';

Middleware dbConnection(Connection connection) {
  return (handler) {
    return (context) async {
      try {
        await connection.openConnections();
        final response = await handler(context);
        await connection.closeConnections();
        await connection.releaseConnection(connection.getConnection());
        return response;
      } catch (e) {
        return Response.json(
          statusCode: HttpStatus.badRequest,
          body: GeneralResponse(
            status: false,
            message: '$e',
          ),
        );
      }
    };
  };
}
