import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/src/connection.dart';
import 'package:sakamichi_admin/database/connection.dart';
import 'package:sakamichi_admin/services/group_service.dart';

Middleware groupService(Connection connection) {
  return provider<GroupService>((_) {
    return GroupService(connection.getConnection());
  });
}
