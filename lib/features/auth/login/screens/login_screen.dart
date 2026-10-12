
// import 'package:flutter/material.dart';
//
// import '../../../../core/widgets/custom_text_field.dart';
// import '../../../../core/widgets/primary_button.dart';
// import '../../../../core/theme.dart';
// import '../../../main_navigation/screens/main_navigation_screen.dart';
// import '../../sign_up/screens/sign_up_screen.dart';
import '../services/Login_services.dart';
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late final TextEditingController emailController;
//   late final TextEditingController passwordController;
//
//   @override
//   void initState() {
//     emailController = TextEditingController();
//     passwordController = TextEditingController();
//
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.background,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(32.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(height: 60),
//                 Icon(Icons.shopping_bag, size: 80, color: AppTheme.primary),
//                 const SizedBox(height: 32),
//                 Text(
//                   'Welcome Back!',
//                   style: Theme.of(context).textTheme.displayLarge
//                       ?.copyWith(fontSize: 32),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Login to continue your shopping',
//                   style: Theme.of(context).textTheme.bodyMedium
//                       ?.copyWith(fontSize: 16),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 64),
//                 CustomTextField(
//                   controller: emailController,
//                   hintText: 'Email Address',
//                   prefixIcon: Icons.email_outlined,
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     }
//                     if (!value.contains('@')) {
//                       return 'Please enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 CustomTextField(
//                   controller: passwordController,
//                   hintText: 'Password',
//                   prefixIcon: Icons.lock_outline,
//                   isPassword: true,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your password';
//                     }
//                     if (value.length < 6) {
//                       return 'Password must be at least 6 characters';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     'Forgot Password?',
//                     style: TextStyle(
//                       color: AppTheme.primary,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//                 PrimaryButton(
//                   text: 'Login',
//                   onPressed: () {
//                     if (_formKey.currentState?.validate() ?? false) {
//                       Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(
//                           builder: (context) => MainNavigationScreen(),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 24),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text('Don\'t have an account? '),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pushReplacement(
//                           context,
//                           PageRouteBuilder(
//                             pageBuilder: (
//                               context,
//                               animation,
//                               secondaryAnimation,
//                             ) => const SignUpScreen(),
//                             transitionsBuilder:
//                                 (
//                                   context,
//                                   animation,
//                                   secondaryAnimation,
//                                   child,
//                                 ) {
//                                   return FadeTransition(
//                                     opacity: animation,
//                                     child: child,
//                                   );
//                                 },
//                           ),
//                         );
//                       },
//                       child: Text(
//                         'Sign Up',
//                         style: TextStyle(
//                           color: AppTheme.primary,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../services/Login_services.dart';
import '../services/Login_services.dart';
import '../services/Login_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void _handleLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    try {
      final user = await _authService.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      setState(() => _isLoading = false);

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم تسجيل الدخول بنجاح!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل تسجيل الدخول، تأكد من الإيميل أو كلمة المرور')),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: $e')),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل الدخول'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال البريد الإلكتروني';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'كلمة المرور',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال كلمة المرور';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _handleLogin,
                  child: const Text(
                    'تسجيل الدخول',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}