import 'package:postgres/postgres.dart';
import 'package:sakamichi_admin/models/member_model.dart';

class MemberService {
  MemberService(this.connection);

  final PostgreSQLConnection connection;

  Future<void> insert(Member data) async {
    await Member.insert(connection, data.copyWith());
  }

  Future<void> update(int id, Member data) async {
    await Member.update(connection, data, id);
  }

  Future<void> delete(int id) async {
    await Member.delete(connection, id);
  }

  Future<List<Member>?> listAll() async {
    final member = await Member.listAll(connection);
    return member;
  }

  Future<List<Member>?> listByGroup(int groupId) async {
    final member = await Member.listByGroup(connection, groupId);
    return member;
  }

  Future<Member?> selectOne(int id) async {
    final member = await Member.selectOne(connection, id);
    return member;
  }

  Future<List<Member>?> searchByName(String name) async {
    final member = await Member.searchByName(connection, name);
    return member;
  }
}
