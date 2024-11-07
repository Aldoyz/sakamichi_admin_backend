import 'package:sakamichi_admin/database/tables.dart';

class GroupMapper {
  static String insert(String table, String keys, String values) {
    return 'INSERT INTO "$table" ($keys) VALUES ($values)';
  }

  static String selectOne(String table, int id) {
    return 'SELECT * FROM "$table" WHERE id = $id';
  }

  static String listAll(String table) {
    return 'SELECT * FROM "$table" ORDER BY id ASC';
  }

  static String update(String table, String values, int id) {
    return 'UPDATE "$table" SET $values WHERE id = $id';
  }

  static String delete(String table, int id) {
    return 'DELETE FROM "$table" WHERE id = $id';
  }
}
