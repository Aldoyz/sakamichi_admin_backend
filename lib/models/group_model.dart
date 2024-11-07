import 'package:postgres/postgres.dart';
import 'package:sakamichi_admin/database/tables.dart';

class Group {
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
  String? logo_url;

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
    required this.logo_url,
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
    String? logo_url,
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
      logo_url: logo_url ?? this.logo_url,
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
      logo_url: json['logo_url'] as String?,
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
        'logo_url': logo_url,
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
      'logo_url': logo_url,
    };
  }

  
}
