import 'package:get/get.dart';
import 'package:quiz_maker/models/response_model.dart';
import 'package:quiz_maker/services/auth_service.dart';

class SignInController extends GetxController{
  final _authService = AuthService();

  var isLoading = false;

  Future<ResponseModel> signIn(email, password)async{
    isLoading = true;
    update();
    final _response = await _authService.signIn(email, password);
    isLoading = false;
    update();

    return _response;
  }

  Future<ResponseModel> signUp(email, password)async{
    isLoading = true;
    update();
    final _response = await _authService.signUp(email, password);
    isLoading = false;
    update();

    return _response;
  }
}
