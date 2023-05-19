import 'package:postgres/postgres.dart';

import 'package:sakamichi_admin/models/group_model.dart';

class GroupService {
  GroupService(this.connection);

  final PostgreSQLConnection connection;

  Future<void> insert(Group data) async {
    await Group.insert(connection, data.copyWith());
  }

  Future<Group?> selectOne(int id) async {
    final data = await Group.selectOne(connection, id);
    return data;
  }

  Future<List<Group>?> listAll() async {
    final group = await Group.listAll(connection);
    return group;
  }

  Future<void> update(int id, Group data) async {
    await Group.update(connection, data, id);
  }

  Future<void> delete(int id) async {
    await Group.delete(connection, id);
  }
}
