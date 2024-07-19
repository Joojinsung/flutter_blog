
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginLogoutButton extends StatelessWidget {
  const LoginLogoutButton({super.key, required this.isLogin, required this.onPressed});
  
  final bool isLogin;
  final VoidCallback onPressed;
  
  
  
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLogin,
        child: IconButton(
          icon: Icon(Icons.logout), onPressed: onPressed,
        ),
    );
  }
}

    