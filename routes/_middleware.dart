import 'package:dart_frog/dart_frog.dart';
import 'package:dotenv/dotenv.dart';
import 'package:postgres/src/connection.dart';
import 'package:sakamichi_admin/database/connection.dart';
import 'package:sakamichi_admin/middleware/db_connection_middleware.dart';
import 'package:sakamichi_admin/middleware/group_middleware.dart';
import 'package:sakamichi_admin/middleware/member_middleware.dart';
import 'package:sakamichi_admin/utils/constant.dart';

Handler middleware(Handler handler) {
  final connection = Connection();
  return handler
      .use(requestLogger())
      .use(dbConnection(connection))
      .use(groupService(connection))
      .use(memberService(connection));
}
