import 'package:postgres/postgres.dart';
import 'package:sakamichi_admin/database/tables.dart';
import 'package:sakamichi_admin/mapper/group_mapper.dart';
import 'package:sakamichi_admin/models/group_model.dart';

class GroupRepository {

  static String table = Tables.group;

  static Future<void> insert(
    PostgreSQLConnection connection,
    Group? data,
  ) async {
    var keys = '';
    var values = '';
    data?.toJson().keys.forEach((key) {
      if (keys != '') {
        keys += ', ';
        values += ', ';
      }
      keys += key;
      values += '@$key';
    });

    await connection.query(
      GroupMapper.insert(table, keys, values),
      substitutionValues: data?.toJson(),
    );
  }

  static Future<Group> selectOne(
    PostgreSQLConnection connection,
    int id,
  ) async {
    final result = await connection.mappedResultsQuery(
      GroupMapper.selectOne(table, id),
    );
    final data = result.map((e) => Group.fromJson(e[table]!)).toList();
    return data.first;
  }

  static Future<List<Group>> listAll(
    PostgreSQLConnection connection,
  ) async {
    final result = await connection
        .mappedResultsQuery(GroupMapper.listAll(table));
    final data = result.map((e) => Group.fromJson(e[table]!)).toList();
    return data;
  }

  static Future<void> update(
    PostgreSQLConnection connection,
    Group? data,
    int id,
  ) async {
    var values = '';
    final nonNullEntries = data
        ?.toJson()
        .entries
        .where((entry) => entry.value != null && entry.value != '')
        .toList();
    data?.toJson().forEach((key, value) {
      if (key == 'id') {
      } else if (key == 'romaji_name') {
        if (data.romaji_name != null && data.romaji_name != '') {
          values += "$key = '$value'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      } else if (key == 'kanji_name') {
        if (data.kanji_name != null && data.kanji_name != '') {
          values += "$key = '$value'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      } else if (key == 'debut_date') {
        if (data.debut_date != null) {
          values += "$key = '$value'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      } else if (key == 'disband_date') {
        if (data.disband_date != null) {
          values += "$key = '$value'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      } else if (key == 'agency') {
        if (data.agency != null && data.agency != '') {
          values += "$key = '$value'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      } else if (key == 'label') {
        if (data.label != null && data.label != '') {
          values += "$key = '$value'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      } else if (key == 'debut_single') {
        if (data.debut_single != null && data.debut_single != '') {
          values += "$key = '$value'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      } else if (key == 'producer') {
        if (data.producer != null && data.producer != '') {
          values += "$key = '$value'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      } else if (key == 'official_site') {
        if (data.official_site != null && data.official_site != '') {
          values += "$key = '$value'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      } else if (key == 'logo_url') {
        if (data.logo_url != null && data.logo_url != '') {
          values += "$key = '$value'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      }
    });

    await connection.query(
      GroupMapper.update(table, values, id),
    );
  }

  static Future<void> delete(
    PostgreSQLConnection connection,
    int id,
  ) async {
    await connection.query(GroupMapper.delete(table, id));
  }
}
