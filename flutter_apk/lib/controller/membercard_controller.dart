import 'package:flutter_apk/model/membercard_model.dart';
import 'package:flutter_apk/db/sql_helper.dart';

class MembercardController {
  final SQLHelper _sqlHelper;

  MembercardController({required SQLHelper sqlHelper})
      : _sqlHelper = sqlHelper;

  Future<List<MembercardModel>> login(String username, String password) async {
    final membercardList =
        await SQLHelper.getUserLoginmembercard(username, password);
    return membercardList.map((membercard) => MembercardModel.fromMap(membercard)).toList();
  }
}
