import 'package:local_auth/local_auth.dart';

class AuthRepository {
final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;


  Future<void> signIn() async {
    try {
      
      return ;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signOut() async {
    try {
      return ;
    } catch (e) {
      throw Exception(e);
    }
  }

}
