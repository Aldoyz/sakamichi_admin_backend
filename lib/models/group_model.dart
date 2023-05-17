import 'package:postgres/postgres.dart';
import 'package:sakamichi_admin/database/tables.dart';

class Group {
  static String table = Tables.group;
  int? id;
  String? romaji_name;
  String? kanji_name;
  DateTime? debut_date;
  DateTime? disband_date;
  String? agency;
  String? label;
  String? debut_single;
  String? producer;
  String? official_site;

  Group({
    this.id,
    required this.romaji_name,
    required this.kanji_name,
    required this.debut_date,
    required this.disband_date,
    required this.agency,
    required this.label,
    required this.debut_single,
    required this.producer,
    required this.official_site,
  });

  Group copyWith({
    int? id,
    String? romaji_name,
    String? kanji_name,
    DateTime? debut_date,
    DateTime? disband_date,
    String? agency,
    String? label,
    String? debut_single,
    String? producer,
    String? official_site,
  }) {
    return Group(
      id: id ?? this.id,
      romaji_name: romaji_name ?? this.romaji_name,
      kanji_name: kanji_name ?? this.kanji_name,
      debut_date: debut_date ?? this.debut_date,
      disband_date: disband_date ?? this.disband_date,
      agency: agency ?? this.agency,
      label: label ?? this.label,
      debut_single: debut_single ?? this.debut_single,
      producer: producer ?? this.producer,
      official_site: official_site ?? this.official_site,
    );
  }

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'] as int?,
      romaji_name: json['romaji_name'] as String?,
      kanji_name: json['kanji_name'] as String?,
      debut_date: json['debut_date'] != null
          ? DateTime.parse(json['debut_date'].toString())
          : null,
      disband_date: json['disband_date'] != null
          ? DateTime.parse(json['disband_date'].toString())
          : null,
      agency: json['agency'] as String?,
      label: json['label'] as String?,
      debut_single: json['debut_single'] as String?,
      producer: json['producer'] as String?,
      official_site: json['official_site'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'romaji_name': romaji_name,
        'kanji_name': kanji_name,
        'debut_date':
            '${debut_date?.year.toString().padLeft(4, '0')}-${debut_date?.month.toString().padLeft(2, '0')}-${debut_date?.day.toString().padLeft(2, '0')}',
        'disband_date': disband_date != null
            ? '${disband_date?.year.toString().padLeft(4, '0')}-${disband_date?.month.toString().padLeft(2, '0')}-${disband_date?.day.toString().padLeft(2, '0')}'
            : null,
        'agency': agency,
        'label': label,
        'debut_single': debut_single,
        'producer': producer,
        'official_site': official_site,
      };

  Map<String, dynamic> toDatabase() {
    return <String, dynamic>{
      'id': id,
      'romaji_name': romaji_name,
      'kanji_name': kanji_name,
      'debut_date':
          '${debut_date?.year.toString().padLeft(4, '0')}-${debut_date?.month.toString().padLeft(2, '0')}-${debut_date?.day.toString().padLeft(2, '0')}',
      'disband_date': disband_date != null
          ? '${disband_date?.year.toString().padLeft(4, '0')}-${disband_date?.month.toString().padLeft(2, '0')}-${disband_date?.day.toString().padLeft(2, '0')}'
          : null,
      'agency': agency,
      'label': label,
      'debut_single': debut_single,
      'producer': producer,
      'official_site': official_site,
    };
  }

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
      'INSERT INTO "$table" ($keys) '
      'VALUES ($values)',
      substitutionValues: data?.toJson(),
    );
  }

  static Future<Group> selectOne(
    PostgreSQLConnection connection,
    int id,
  ) async {
    final result = await connection.mappedResultsQuery(
      'SELECT * FROM "$table" '
      'WHERE id = $id',
    );
    final data = result.map((e) => Group.fromJson(e[table]!)).toList();
    return data.first;
  }

  static Future<List<Group>> listAll(
    PostgreSQLConnection connection,
  ) async {
    final result = await connection
        .mappedResultsQuery('SELECT * FROM "$table" ORDER BY id ASC');
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
      }
    });

    await connection.query(
      'UPDATE "$table" '
      'SET $values '
      'WHERE id = $id',
    );
  }

  static Future<void> delete(
    PostgreSQLConnection connection,
    int id,
  ) async {
    await connection.query('DELETE FROM "$table" WHERE id = $id');
  }
}
