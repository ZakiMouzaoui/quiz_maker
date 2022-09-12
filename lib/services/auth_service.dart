import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_maker/models/response_model.dart';
import 'package:quiz_maker/models/user.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? userFromFireBase(user){
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Future<ResponseModel> signIn(email, password) async{
    final _response = ResponseModel();
    try{
      final authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final _user = authResult.user;
      _response.data = userFromFireBase(_user);
    }
    catch(e){
      _response.error = "Invalid credentials. Please try again";
    }

    return _response;
  }

  Future<ResponseModel> signUp(email, password) async{
    final response = ResponseModel();
    try{
      final authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final _user = authResult.user;
      response.data = userFromFireBase(_user);
    }
    catch(e){
      response.error = e.toString().split("]")[1].trim();
    }

    return response;
  }

  Future signOut()async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      return null;
    }
  }
}
