class MemberCardModel {
  int? kodeMember;
  String? name, alamat, tanggalLahir, jenisKelamin, username, password;

  MemberCardModel(
      {this.kodeMember,
      this.name,
      this.alamat,
      this.tanggalLahir,
      this.jenisKelamin,
      this.username,
      this.password});

  factory MemberCardModel.fromJson(Map<String, dynamic> json) {
    return MemberCardModel(
        kodeMember: json['kode_member'],
        name: json['name'],
        alamat: json['alamat'],
        tanggalLahir: json['tanggal_lahir'],
        jenisKelamin: json['jenis_kelamin'],
        username: json['username'],
        password: json['password']);
  }
}
