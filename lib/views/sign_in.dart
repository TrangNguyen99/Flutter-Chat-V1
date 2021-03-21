import 'package:flutter/material.dart';
import 'package:test1/services/auth.dart';
import 'package:test1/views/search.dart';
import 'package:test1/widgets/app_bar.dart';

class SignInScreen extends StatefulWidget {
  final toggle;

  SignInScreen({this.toggle});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  signIn() async {
    if (formKey.currentState.validate()) {
      String email = emailController.text;
      String password = passwordController.text;

      setState(() {
        isLoading = true;
      });

      String signInError = await signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (signInError == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SearchScreen(),
          ),
        );
      } else {
        setState(() {
          isLoading = false;
        });

        final snackBar = SnackBar(
          content: Text(signInError),
          duration: Duration(seconds: 5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          validator: (val) {
                            return val.isEmpty ? 'Vui lòng nhập email!' : null;
                          },
                          decoration: InputDecoration(hintText: 'Email'),
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (val) {
                            return val.isEmpty
                                ? 'Vui lòng nhập mật khẩu!'
                                : null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(hintText: 'Mật khẩu'),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: signIn,
                    child: Text('Đăng nhập'),
                  ),
                  ElevatedButton(
                    onPressed: widget.toggle,
                    child: Text('Đăng ký'),
                  ),
                ],
              ),
            ),
    );
  }
}
