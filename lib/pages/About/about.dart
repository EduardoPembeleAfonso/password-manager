import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/pages/Drawer/drawer.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  void initState() {
    super.initState();
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
        body: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 800,
                    height: 180,
                    child: Lottie.asset('assets/lotties/animation_login.json'),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 25),
                        child: Column(
                          children: [
                            Text(
                              'KeyKeep',
                              style: GoogleFonts.oswald(
                                textStyle:
                                    Theme.of(context).textTheme.displayLarge,
                                fontSize: 30.0,
                                color: const Color(0xFF3c4950),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                                '   O KeyKeep é um aplicativo de gerenciamento de senha, uma ferramenta poderosa que o vai ajudar a armazenar e gerenciar as suas senhas.',
                                style: GoogleFonts.poppins(
                                    color: Colors.black38,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400)),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              '   O aplicativo permite que você crie senhas fortes e únicas para cada conta, sem precisar memorizá-las. E também oferece um recurso de verificação de senha que verifica a força e a segurança das suas senhas salvas.',
                              style: GoogleFonts.poppins(
                                  color: Colors.black38,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //       vertical: 0.0, horizontal: 25.0),
                      //   width: MediaQuery.of(context).size.width * 2,
                      //   height: 45,
                      //   child: ElevatedButton(
                      //     onPressed: null,
                      //     style: ButtonStyle(
                      //         backgroundColor: const MaterialStatePropertyAll(
                      //             Color(0xFF00a093)),
                      //         foregroundColor: const MaterialStatePropertyAll(
                      //             Color(0xFF272f32)),
                      //         shape: MaterialStatePropertyAll(
                      //             RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.circular(8.0),
                      //                 side: const BorderSide(
                      //                     color: Color(0xFF00a093)))),
                      //         textStyle:
                      //             const MaterialStatePropertyAll(TextStyle(
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.bold,
                      //         ))),
                      //     child: Text(
                      //       "Login",
                      //       style: GoogleFonts.oswald(
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.w400),
                      //     ),
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
