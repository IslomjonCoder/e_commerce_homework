import 'package:e_commerce_homework/models/token/token_model.dart';
import 'package:e_commerce_homework/repository/api_provider.dart';
import 'package:e_commerce_homework/repository/user_repository.dart';
import 'package:e_commerce_homework/ui/home/home_screen.dart';
import 'package:e_commerce_homework/ui/login/widgets/universal_input.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'Welcome back',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xFF5A5A5D)),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Login to your account',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                        color: Color(0xFF101012)),
                  ),
                ],
              ),
              SizedBox(height: 32),
              UniversalInput(
                  label: 'Username',
                  hint: 'Enter your username',
                  controller: controller1),
              SizedBox(height: 24),
              UniversalInput(
                controller: controller2,
                label: 'Password',
                hint: 'Enter your Password',
                isSecure: true,
              ),
              SizedBox(height: 32),
              Container(
                height: 52,
                width: double.infinity,
                // padding: EdgeInsets.all(16),
                child: ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            Center(child: CircularProgressIndicator()),
                      );
                      TokenModel? result =
                          await UserRepository(apiProvider: ApiProvider())
                              .loginUser(
                                  username: controller1.text,
                                  password: controller2.text);
                      (TokenModel == null)
                          ? ScaffoldMessenger(
                              child: SnackBar(
                                  content: Text('Authorization is failed')))
                          : {
                              Navigator.pop(context),
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ))
                            };
                    },
                    child: Text(
                      'Login now',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    )),
              ),
              SizedBox(height: 20),
              Text(
                '''Example\nusername: donero,\npassword: ewedon''',
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
