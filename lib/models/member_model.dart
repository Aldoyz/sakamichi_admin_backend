import 'package:postgres/postgres.dart';
import 'package:sakamichi_admin/database/tables.dart';

class Member {
  static String table = Tables.member;
  int? id;
  String? romaji_name;
  String? kanji_name;
  String? kana_name;
  List<String>? nickname;
  DateTime? birth_date;
  String? birth_place;
  String? blood_type;
  int? age;
  double? height;
  String? agency;
  List<String>? social_networks;
  int? group_id;
  String? group_name;
  String? team;
  String? debuted;
  List<String>? lightstick_colors;

  Member({
    required this.id,
    required this.romaji_name,
    required this.kanji_name,
    required this.kana_name,
    required this.nickname,
    required this.birth_date,
    required this.birth_place,
    required this.blood_type,
    required this.age,
    required this.height,
    required this.agency,
    required this.social_networks,
    required this.group_id,
    required this.group_name,
    required this.team,
    required this.debuted,
    required this.lightstick_colors,
  });

  Member copyWith({
    int? id,
    String? romaji_name,
    String? kanji_name,
    String? kana_name,
    List<String>? nickname,
    DateTime? birth_date,
    String? birth_place,
    String? blood_type,
    int? age,
    double? height,
    String? agency,
    List<String>? social_networks,
    int? group_id,
    String? group_name,
    String? team,
    String? debuted,
    List<String>? lightstick_colors,
  }) =>
      Member(
        id: id ?? this.id,
        romaji_name: romaji_name ?? this.romaji_name,
        kanji_name: kanji_name ?? this.kanji_name,
        kana_name: kana_name ?? this.kana_name,
        nickname: nickname ?? this.nickname,
        birth_date: birth_date ?? this.birth_date,
        birth_place: birth_place ?? this.birth_place,
        blood_type: blood_type ?? this.blood_type,
        age: age ?? this.age,
        height: height ?? this.height,
        agency: agency ?? this.agency,
        social_networks: social_networks ?? this.social_networks,
        group_id: group_id ?? this.group_id,
        group_name: group_name ?? this.group_name,
        team: team ?? this.team,
        debuted: debuted ?? this.debuted,
        lightstick_colors: lightstick_colors ?? this.lightstick_colors,
      );

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json['id'] as int?,
        romaji_name: json['romaji_name'] as String?,
        kanji_name: json['kanji_name'] as String?,
        kana_name: json['kana_name'] as String?,
        nickname: json['nickname'] != null
            ? List<String>.from(json['nickname'] as List<dynamic>)
            : null,
        birth_date: json['birth_date'] != null
            ? DateTime.parse(json['birth_date'].toString())
            : null,
        birth_place: json['birth_place'] as String?,
        blood_type: json['blood_type'] as String?,
        age: json['age'] as int?,
        height: json['height'] != null
            ? double.parse(json['height'].toString())
            : null,
        agency: json['agency'] as String?,
        social_networks: json['social_networks'] != null
            ? List<String>.from(json['social_networks'] as List<dynamic>)
            : null,
        group_id: json['group_id'] as int?,
        group_name: json['group_name'] as String?,
        team: json['team'] as String?,
        debuted: json['debuted'] as String?,
        lightstick_colors: json['lightstick_colors'] != null
            ? List<String>.from(json['lightstick_colors'] as List<dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'romaji_name': romaji_name,
        'kanji_name': kanji_name,
        'kana_name': kana_name,
        'nickname': nickname != null ? List<dynamic>.from(nickname!) : null,
        'birth_date':
            "${birth_date?.year.toString().padLeft(4, '0')}-${birth_date?.month.toString().padLeft(2, '0')}-${birth_date?.day.toString().padLeft(2, '0')}",
        'birth_place': birth_place,
        'blood_type': blood_type,
        'age': age,
        'height': height,
        'agency': agency,
        'social_networks': social_networks != null
            ? List<dynamic>.from(social_networks!)
            : null,
        'group_id': group_id,
        'group_name': group_name,
        'team': team,
        'debuted': debuted,
        'lightstick_colors': lightstick_colors != null
            ? List<dynamic>.from(lightstick_colors!)
            : null,
      };

  Map<String, dynamic> toDatabase() {
    return <String, dynamic>{
      'id': id,
      'romaji_name': romaji_name,
      'kanji_name': kanji_name,
      'kana_name': kana_name,
      'nickname': List<dynamic>.from(nickname!),
      'birth_date':
          "${birth_date?.year.toString().padLeft(4, '0')}-${birth_date?.month.toString().padLeft(2, '0')}-${birth_date?.day.toString().padLeft(2, '0')}",
      'birth_place': birth_place,
      'blood_type': blood_type,
      'age': age,
      'height': height,
      'agency': agency,
      'social_networks': List<dynamic>.from(social_networks!),
      'group_id': group_id,
      'group_name': group_name,
      'team': team,
      'debuted': debuted,
      'lightstick_colors': List<dynamic>.from(lightstick_colors!),
    };
  }

  static Future<void> insert(
    PostgreSQLConnection connection,
    Member? data,
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

  static Future<void> update(
    PostgreSQLConnection connection,
    Member? data,
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
      } else if (key == 'kana_name') {
        if (data.kana_name != null && data.kana_name != '') {
          values += "$key = '$value'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      } else if (key == 'nickname') {
        if (data.nickname != null && data.nickname!.isNotEmpty) {
          values += "$key = '${data.nickname!.join(', ')}'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      } else if (key == 'birth_date') {
        if (data.birth_date != null) {
          values += "$key = '$value'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      } else if (key == 'birth_place') {
        if (data.birth_place != null && data.birth_place != '') {
          values += "$key = '$value'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      } else if (key == 'blood_type') {
        if (data.blood_type != null && data.blood_type != '') {
          values += "$key = '$value'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      } else if (key == 'age') {
        if (data.age != null && data.age != 0) {
          values += "$key = '$value'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      } else if (key == 'height') {
        if (data.height != null && data.height != 0) {
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
      } else if (key == 'social_networks') {
        if (data.social_networks != null && data.social_networks!.isNotEmpty) {
          values += "$key = '${data.nickname!.join(', ')}'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      } else if (key == 'group_id') {
        if (data.group_id != null && data.group_id != 0) {
          values += "$key = '$value'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      } else if (key == 'group_name') {
        if (data.group_name != null && data.group_name != '') {
          values += "$key = '$value'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      } else if (key == 'team') {
        if (data.team != null && data.team != '') {
          values += "$key = '$value'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      } else if (key == 'debuted') {
        if (data.debuted != null && data.debuted != '') {
          values += "$key = '$value'";
          final currentIndex =
              nonNullEntries?.indexWhere((entry) => entry.key == key);
          final lastIndex = nonNullEntries!.length - 1;
          if (currentIndex != lastIndex && nonNullEntries.isNotEmpty) {
            values += ', ';
          }
        }
      } else if (key == 'lightstick_colors') {
        if (data.lightstick_colors != null &&
            data.lightstick_colors!.isNotEmpty) {
          values += "$key = '${data.nickname!.join(', ')}'";
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
    await connection.query('DELETE FROM "$table" where id = $id');
  }

  static Future<List<Member>> listAll(
    PostgreSQLConnection connection,
  ) async {
    final result = await connection.mappedResultsQuery('SELECT * FROM "$table" '
        'ORDER BY romaji_name, group_id ASC');
    final data = result.map((e) => Member.fromJson(e[table]!)).toList();
    return data;
  }

  static Future<List<Member>> listByGroup(
    PostgreSQLConnection connection,
    int groupId,
  ) async {
    final result = await connection.mappedResultsQuery('SELECT * FROM "$table" '
        'WHERE group_id = $groupId '
        'ORDER BY romaji_name ASC');
    final data = result.map((e) => Member.fromJson(e[table]!)).toList();
    return data;
  }

  static Future<Member> selectOne(
    PostgreSQLConnection connection,
    int id,
  ) async {
    final result = await connection.mappedResultsQuery('SELECT * FROM "$table" '
        'WHERE id = $id');
    final data = result.map((e) => Member.fromJson(e[table]!)).toList();
    return data.first;
  }

  static Future<List<Member>> searchByName(
    PostgreSQLConnection connection,
    String name,
  ) async {
    final result = await connection.mappedResultsQuery('SELECT * FROM "$table" '
        'WHERE LOWER(romaji_name) like \'%$name%\' '
        'OR LOWER(kanji_name) like \'%$name%\' OR LOWER(kana_name) like \'%$name%\'');
    final data = result.map((e) => Member.fromJson(e[table]!)).toList();
    return data;
  }
}
