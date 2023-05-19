import 'package:dart_frog/dart_frog.dart';
import 'package:sakamichi_admin/database/connection.dart';
import 'package:sakamichi_admin/services/member_service.dart';

Middleware memberService(Connection connection) {
  return provider<MemberService>((_) {
    return MemberService(connection.getConnection());
  });
}
