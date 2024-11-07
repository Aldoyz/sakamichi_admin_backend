import 'package:postgres/postgres.dart';

import 'package:sakamichi_admin/models/group_model.dart';
import 'package:sakamichi_admin/repository/group_repository.dart';

class GroupService {
  GroupService(this.connection);

  final PostgreSQLConnection connection;

  Future<void> insert(Group data) async {
    await GroupRepository.insert(connection, data.copyWith());
  }

  Future<Group?> selectOne(int id) async {
    final data = await GroupRepository.selectOne(connection, id);
    return data;
  }

  Future<List<Group>?> listAll() async {
    final group = await GroupRepository.listAll(connection);
    return group;
  }

  Future<void> update(int id, Group data) async {
    await GroupRepository.update(connection, data, id);
  }

  Future<void> delete(int id) async {
    await GroupRepository.delete(connection, id);
  }
}
