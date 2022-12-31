class MembercardModel {
  final int kodeMemberModel;
  final String namaModel;
  final String tanggalLahirModel;
  final String alamatModel;
  final String jenisKelaminModel;
  final String usernameModel;
  final String passwordModel;

  MembercardModel({
    required this.kodeMemberModel,
    required this.namaModel,
    required this.tanggalLahirModel,
    required this.alamatModel,
    required this.jenisKelaminModel,
    required this.usernameModel,
    required this.passwordModel,
  });
    static MembercardModel fromMap(Map<String, dynamic> map) {
    return MembercardModel(
      kodeMemberModel: map['kode_member'],
      namaModel: map['nama'],
      tanggalLahirModel: map['tanggal_lahir'],
      alamatModel: map['alamat'],
      jenisKelaminModel: map['jenis_kelamin'],
      usernameModel: map['username'],
      passwordModel: map['password'],
    );
  }
}



