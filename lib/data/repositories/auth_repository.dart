import 'dart:async';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

class AuthRepository {
  final LocalAuthentication auth = LocalAuthentication();
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  Future<void> signIn() async {
    bool authenticated = false;
    try {
      _isAuthenticating = true;
      _authorized = 'Authenticating';
      authenticated = await auth.authenticate(
          localizedReason: 'Por favor escolha o seu método de autenticação.',
          options: const AuthenticationOptions(
            stickyAuth: true,
          ),
          authMessages: const <AuthMessages>[
            AndroidAuthMessages(
              signInTitle:
                  'Oops! A autenticação é necessaria para aceder a sua conta!',
              cancelButton: 'Cancelar',
            ),
          ]);

      _isAuthenticating = false;
    } on PlatformException catch (e) {
      print(e);
      _isAuthenticating = false;
      _authorized = 'Error - ${e.toString()}';
      return;
    }

    _authorized = authenticated ? 'Authorized' : 'Not Authorized';
    print(_authorized);
  }

  Future<void> signOut() async {
    print('SignOut');
  }
}
