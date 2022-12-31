class MembercardModel {
  final int kodeMemberModel;
  final String namaMemberModel;
  final String tanggalLahirMemberModel;
  final String alamatMemberModel;
  final String jenisKelaminMemberModel;
  final String usernameMemberModel;
  final String passwordMemberModel;

  MembercardModel({
    required this.kodeMemberModel,
    required this.namaMemberModel,
    required this.tanggalLahirMemberModel,
    required this.alamatMemberModel,
    required this.jenisKelaminMemberModel,
    required this.usernameMemberModel,
    required this.passwordMemberModel,
  });
  static MembercardModel fromMap(Map<String, dynamic> map) {
    return MembercardModel(
      kodeMemberModel: map['kode_member'],
      namaMemberModel: map['nama'],
      tanggalLahirMemberModel: map['tanggal_lahir'],
      alamatMemberModel: map['alamat'],
      jenisKelaminMemberModel: map['jenis_kelamin'],
      usernameMemberModel: map['username'],
      passwordMemberModel: map['password'],
    );
  }
}
