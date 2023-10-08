import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/bloc/bloc_auth/auth_bloc.dart';


// pages
import 'package:password_manager/pages/SignIn/sign_in.dart';

// repos
import 'package:password_manager/data/repositories/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => AuthRepository(),
        child: BlocProvider(
          create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context)),
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SignIn(),
          ),
        ));
  }
}
