import 'package:postgres/postgres.dart';

import 'package:sakamichi_admin/models/group_model.dart';

class GroupService {
  GroupService(this.connection);

  final PostgreSQLConnection connection;

  Future<void> insert(Group data) async {
    await Group.insert(connection as PostgreSQLConnection, data.copyWith());
  }

  Future<Group?> selectOne(int id) async {
    final data = await Group.selectOne(connection as PostgreSQLConnection, id);
    return data;
  }

  Future<List<Group>?> listAll() async {
    final group = await Group.listAll(connection as PostgreSQLConnection);
    return group;
  }

  Future<void> update(int id, Group data) async {
    await Group.update(connection as PostgreSQLConnection, data, id);
  }

  Future<void> delete(int id) async {
    await Group.delete(connection as PostgreSQLConnection, id);
  }
}
