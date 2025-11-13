import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../utils/validators.dart';
import '../../database/user_database.dart';
import '../../modele/user_model.dart';
import 'login.dart';
import '../taches/tache.dart';

/// Registration screen for new users.
/// Uses the same bottom-card visual as the login screen and keeps
/// the confirm-password field at the top of the card (per UX request).
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  final UserDao _userDao = UserDao();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    // Validate email
    final emailError = Validators.validateEmail(_emailController.text);
    if (emailError != null) {
      setState(() {
        _errorMessage = emailError;
        _isLoading = false;
      });
      return;
    }

    // Validate password
    final passwordError = Validators.validatePassword(_passwordController.text);
    if (passwordError != null) {
      setState(() {
        _errorMessage = passwordError;
        _isLoading = false;
      });
      return;
    }

    // Confirm password validation (confirm is at top of card per request)
    if (_confirmPasswordController.text.isEmpty) {
      setState(() {
        _errorMessage = AppConstants.erreurMotDePasseVide;
        _isLoading = false;
      });
      return;
    }

    if (_confirmPasswordController.text != _passwordController.text) {
      setState(() {
        _errorMessage = AppConstants.erreurMotDePasseNonCorrespondant;
        _isLoading = false;
      });
      return;
    }

    try {
      final sanitizedEmail = Validators.sanitizeEmail(_emailController.text);

      // Check if email already exists
      if (await _userDao.emailExists(sanitizedEmail)) {
        setState(() {
          _errorMessage = AppConstants.erreurEmailExiste;
          _isLoading = false;
        });
        return;
      }

      final user = User(
        email: sanitizedEmail,
        password: _passwordController.text,
        createdAt: DateTime.now(),
      );

      final id = await _userDao.insert(user);
      user.id = id;

      // After successful registration, return to the login screen so the user can sign in
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      body: Column(
        children: [
          // Header area similar to login
          Container(
            height: media.height * 0.38,
            width: double.infinity,
            color: AppConstants.primaryColor,
            child: Stack(
              children: [
                Positioned(
                  right: -40,
                  top: -10,
                  child: Image.asset('assets/images/Drawing.png', width: 400),
                ),

                const SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.paddingHorizontal,
                      vertical: 12,
                    ),
                    child: Text(
                      AppConstants.inscription,
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

          // Bottom white card that fills the remaining area
          Expanded(
            child: Container(
              height: media.height * 0.72,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppConstants.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: AppConstants.spacingM),
                    // Email
                    _buildTextField(
                      controller: _emailController,
                      hintText: AppConstants.email,
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppConstants.spacingM),

                    // Password
                    _buildTextField(
                      controller: _passwordController,
                      hintText: AppConstants.motDePasse,
                      icon: Icons.lock_outline,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: AppConstants.spacingM),

                    // Confirm password first as requested
                    _buildTextField(
                      controller: _confirmPasswordController,
                      hintText: AppConstants.confirmerMotDePasse,
                      icon: Icons.lock_outline,
                      obscureText: _obscureConfirmPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingXL),

                    if (_errorMessage != null)
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: AppConstants.spacingL,
                        ),
                        padding: const EdgeInsets.all(
                          AppConstants.paddingSmall,
                        ),
                        decoration: BoxDecoration(
                          color: AppConstants.errorBackgroundColor,
                          borderRadius: BorderRadius.circular(
                            AppConstants.borderRadiusSmall,
                          ),
                          border: Border.all(
                            color: AppConstants.errorBorderColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: AppConstants.errorTextColor,
                            ),
                            const SizedBox(width: AppConstants.spacingS),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: TextStyle(
                                  color: AppConstants.errorTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    SizedBox(
                      width: double.infinity,
                      height: AppConstants.buttonHeight,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.blackColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppConstants.borderRadiusLarge,
                            ),
                          ),
                        ),
                        child: _isLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppConstants.whiteColor,
                                  ),
                                ),
                              )
                            : Text(
                                AppConstants.sInscrire,
                                style: TextStyle(
                                  fontSize: AppConstants.fontSizeMedium,
                                  color: AppConstants.whiteColor,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: AppConstants.spacingL),

                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 4,
                        children: [
                          Text(
                            AppConstants.vousAvezDejaUnCompte,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 13,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              AppConstants.seConnecter,
                              style: TextStyle(
                                color: AppConstants.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey.shade600, size: 20),
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
