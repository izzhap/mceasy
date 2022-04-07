class CutiModel {
  int? no;
  int lama_cuti;
  String? nomor_induk;
  String keterangan;
  DateTime? tanggal_cuti;

  CutiModel({
    this.no,
    required this.lama_cuti,
    this.nomor_induk,
    required this.keterangan,
    this.tanggal_cuti,
  });

  factory CutiModel.fromLocalJson(Map<String, dynamic> json) {
    if (!json.containsKey('nomor_induk')) {
      throw Exception('Tidak boleh kosong');
    }
    if (!json.containsKey('nama')) {
      throw Exception('Tidak boleh kosong');
    }
    if (!json.containsKey('alamat')) {
      throw Exception('Tidak boleh kosong');

    }

    return CutiModel(
      no: json['no'],
      lama_cuti: json['lama_cuti'] ?? 0,
      nomor_induk: json['nomor_induk'],
      keterangan: json['keterangan'] ?? "-",
      tanggal_cuti: json['tanggal_cuti'] != null
          ? DateTime.tryParse(json['tanggal_cuti'])
          : null,
    );
  }

  Map<String, dynamic> toLocalJson() {
    return {
      'no': no,
      'lama_cuti': lama_cuti,
      'nomor_induk': nomor_induk,
      'keterangan': keterangan,
      'tanggal_cuti': tanggal_cuti?.toIso8601String(),

    };
  }

  Map<String, dynamic> toRemoteJson() {
    return {
      'no': no,
      'lama_cuti': lama_cuti,
      'nomor_induk': nomor_induk,
      'keterangan': keterangan,
    };
  }
}
