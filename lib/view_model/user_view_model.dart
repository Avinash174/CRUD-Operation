import 'package:crud_operation/model/user_model.dart';
import 'package:crud_operation/repository/user_repository.dart';

class UserViewModel {
  final _rep = UserRepo();

  Future<UserModel> fetchUserDetails() async {
    final response = await _rep.fetchUserDetails();
    return response;
  }
}
