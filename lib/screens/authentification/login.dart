import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppConstants.connexionReussie)),
      );
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Top header with background color and decorative drawings
          Container(
            height: media.height * 0.38,
            color: AppConstants.primaryColor,
            child: Stack(
              children: [
                // Decorative drawing image (left)
                Positioned(
                  left: -40,
                  top: -40,
                  child: Image.asset(
                    'assets/images/Drawing.png',
                    width: 220,
                    fit: BoxFit.contain,
                  ),
                ),

                // Header title
                const SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingHorizontal, vertical: 12),
                    child: Text(
                      AppConstants.connexion,
                      style: TextStyle(
                        color: AppConstants.whiteColor,
                        fontSize: 26,
                        fontWeight: AppConstants.fontWeightBold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Main content (form) - positioned to overlap header
          Positioned(
            top: media.height * 0.28,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingHorizontal),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppConstants.paddingLarge),
                    decoration: BoxDecoration(
                      color: AppConstants.whiteColor,
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusExtraLarge),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(25),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 8),
                          const Text(
                            AppConstants.bienvenueSurLyst,
                            style: TextStyle(
                              fontSize: AppConstants.fontSizeLarge,
                              fontWeight: AppConstants.fontWeightBold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: AppConstants.spacingL),

                          // Email
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: AppConstants.email,
                              prefixIcon: const Icon(Icons.email, color: AppConstants.primaryColor),
                              filled: true,
                              fillColor: AppConstants.whiteColor,
                              contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
                                borderSide: BorderSide(color: AppConstants.greyMediumColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
                                borderSide: BorderSide(color: AppConstants.primaryColor),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppConstants.erreurEmailVide;
                              } else if (!RegExp(AppConstants.emailPattern).hasMatch(value)) {
                                return AppConstants.erreurEmailInvalide;
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: AppConstants.spacingM),

                          // Password
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              hintText: AppConstants.motDePasse,
                              prefixIcon: const Icon(Icons.lock, color: AppConstants.primaryColor),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: AppConstants.greyMediumColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              filled: true,
                              fillColor: AppConstants.whiteColor,
                              contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
                                borderSide: BorderSide(color: AppConstants.greyMediumColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
                                borderSide: BorderSide(color: AppConstants.primaryColor),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppConstants.erreurMotDePasseVide;
                              } else if (value.length < AppConstants.minPasswordLength) {
                                return AppConstants.erreurMotDePasseCourt;
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: AppConstants.spacingL),

                          // Button
                          SizedBox(
                            height: AppConstants.buttonHeight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppConstants.blackColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusExtraLarge),
                                ),
                              ),
                              onPressed: _login,
                              child: const Text(
                                AppConstants.seConnecter,
                                style: TextStyle(
                                  color: AppConstants.whiteColor,
                                  fontSize: AppConstants.fontSizeLarge,
                                  fontWeight: AppConstants.fontWeightBold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: AppConstants.spacingM),

                          // Redirect to register
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(AppConstants.vousNeDisposezPas),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(context, '/register'),
                                child: const Text(
                                  AppConstants.inscription,
                                  style: TextStyle(
                                    color: AppConstants.violetColor,
                                    fontWeight: AppConstants.fontWeightBold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
