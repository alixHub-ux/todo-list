import 'constants.dart';

/// Utility class for input validation
class Validators {
  // Private constructor to prevent instantiation
  Validators._();

  /// Validates if a string is not empty
  /// Returns null if valid, error message if invalid
  static String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName ne peut pas être vide';
    }
    return null;
  }

  /// Validates email format
  /// Returns null if valid, error message if invalid
  static String? validateEmail(String? value) {
    // Check if empty
    if (value == null || value.trim().isEmpty) {
      return AppConstants.erreurEmailVide;
    }

    // Remove whitespace
    final email = value.trim();

    // Check basic email format
    if (!email.contains('@')) {
      return AppConstants.erreurEmailInvalide;
    }

    // Check for valid email pattern
    final RegExp emailRegex = RegExp(AppConstants.emailPattern);
    if (!emailRegex.hasMatch(email)) {
      return AppConstants.erreurEmailInvalide;
    }

    return null;
  }

  /// Validates password (minimum length)
  /// Returns null if valid, error message if invalid
  static String? validatePassword(String? value) {
    // Check if empty
    if (value == null || value.isEmpty) {
      return AppConstants.erreurMotDePasseVide;
    }

    // Check minimum length
    if (value.length < AppConstants.minPasswordLength) {
      return AppConstants.erreurMotDePasseCourt;
    }

    return null;
  }

  /// Validates password confirmation
  /// Returns null if valid, error message if invalid
  static String? validatePasswordConfirmation(String? password, String? confirmation) {
    // Check if confirmation is empty
    if (confirmation == null || confirmation.isEmpty) {
      return AppConstants.erreurMotDePasseVide;
    }

    // Check if passwords match
    if (password != confirmation) {
      return AppConstants.erreurMotDePasseNonCorrespondant;
    }

    return null;
  }

  /// Validates task name
  /// Returns null if valid, error message if invalid
  static String? validateTaskName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppConstants.erreurNomTacheVide;
    }

    return null;
  }

  /// Checks if email is valid (returns boolean)
  static bool isEmailValid(String email) {
    return validateEmail(email) == null;
  }

  /// Checks if password is valid (returns boolean)
  static bool isPasswordValid(String password) {
    return validatePassword(password) == null;
  }

  /// Checks if passwords match (returns boolean)
  static bool doPasswordsMatch(String password, String confirmation) {
    return password == confirmation;
  }

  /// Validates and sanitizes email (removes whitespace)
  static String sanitizeEmail(String email) {
    return email.trim().toLowerCase();
  }

  /// Validates if a string has minimum length
  static bool hasMinLength(String value, int minLength) {
    return value.length >= minLength;
  }

  /// Validates if a string has maximum length
  static bool hasMaxLength(String value, int maxLength) {
    return value.length <= maxLength;
  }
}