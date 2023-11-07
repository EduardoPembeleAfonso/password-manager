import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/pages/Drawer/drawer.dart';
import 'package:local_auth/local_auth.dart';

// my states
import 'package:password_manager/bloc/bloc_auth/auth_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('SignIn'),
        toolbarHeight: 0,
      ),
      extendBody: true,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => const MenuDrawer(pageId: 1,))));
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is UnAuthenticated) {
              return Container(
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 800,
                          height: 200,
                          child: Lottie.asset(
                              'assets/lotties/animation_login.json'),
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              child: Column(
                                children: [
                                  Text(
                                    'Olá, seja bem-vindo!',
                                    style: GoogleFonts.oswald(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                      fontSize: 30.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text('Para a segurança da sua conta, por',
                                      style: GoogleFonts.raleway(
                                          color: Colors.black38,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400)),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'favor faça login.',
                                    style: GoogleFonts.raleway(
                                        color: Colors.black38,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 25.0),
                              width: MediaQuery.of(context).size.width * 2,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  _authenticate(context);
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                            Color(0xFF00a093)),
                                    foregroundColor:
                                        const MaterialStatePropertyAll(
                                            Color(0xFF272f32)),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            side: const BorderSide(
                                                color: Color(0xFF00a093)))),
                                    textStyle: const MaterialStatePropertyAll(
                                        TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ))),
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.oswald(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  // my functions
  void _authenticate(context) {
    BlocProvider.of<AuthBloc>(context).add(
      SignInRequested(),
    );
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
