class KaryawanModel {
  int? no;
  String nomor_induk;
  String nama;
  String alamat;
  DateTime? tanggal_lahir;
  DateTime? tanggal_bergabung;

  KaryawanModel({
    this.no,
    required this.nomor_induk,
    required this.nama,
    required this.alamat,
    this.tanggal_lahir,
    this.tanggal_bergabung,
  });

  factory KaryawanModel.fromRemoteJson(Map<String, dynamic> json) {
    return KaryawanModel(
      no: json['no'],
      nomor_induk: json['nomor_induk'],
      nama: json['nama'],
      alamat: json['alamat'],
    );
  }

  factory KaryawanModel.fromLocalJson(Map<String, dynamic> json) {
    if (!json.containsKey('nomor_induk')) {
      throw Exception('Tidak boleh kosong');
    }
    if (!json.containsKey('nama')) {
      throw Exception('Tidak boleh kosong');
    }
    if (!json.containsKey('alamat')) {
      throw Exception('Tidak boleh kosong');

    }

    return KaryawanModel(
      no: json['no'],
      nomor_induk: json['nomor_induk'],
      nama: json['nama'],
      alamat: json['alamat'],
      tanggal_lahir: json['tanggal_lahir'] != null
          ? DateTime.tryParse(json['tanggal_lahir'])
          : null,
      tanggal_bergabung: json['tanggal_bergabung'] != null
          ? DateTime.tryParse(json['tanggal_bergabung'])
          : null,
    );
  }

  Map<String, dynamic> toLocalJson() {
    return {
      'no': no,
      'nomor_induk': nomor_induk,
      'nama': nama,
      'alamat': alamat,
      'tanggal_lahir': tanggal_lahir?.toIso8601String(),
      'tanggal_bergabung': tanggal_bergabung?.toIso8601String(),

    };
  }

  Map<String, dynamic> toRemoteJson() {

    return {
      'no': no,
      'nomor_induk': nomor_induk,
      'nama': nama,
      'alamat': alamat,
    };
  }
}
