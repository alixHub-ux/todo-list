import 'package:flutter/material.dart';

/// Application-wide constants including colors, strings, and database table names
class AppConstants {
  AppConstants._();

  // ============ COLORS ============

  // Primary Colors
  /// Main burgundy/dark red color - RougeBordeau (#710014)
  static const Color primaryColor = Color(0xFF710014);

  /// Lighter shade of primary color
  static const Color primaryLightColor = Color(0xFFA83246);

  /// Darker shade of primary color
  static const Color primaryDarkColor = Color(0xFF4E0010);

  /// White color - Blanc (#f2f1ed)
  static const Color whiteColor = Color(0xFFF2F1ED);

  /// Black color for buttons and text - Noir (#161616)
  static const Color blackColor = Color(0xFF161616);

  /// Violet/Purple color - VioletClair (#6b05b4)
  static const Color violetColor = Color(0xFF6B05B4);

  /// Green color - Vert (#05a11d)
  static const Color greenColor = Color(0xFF05A11D);

  /// Dark violet color - VioletDark (#290b34)
  static const Color violetDarkColor = Color(0xFF290B34);

  // Functional Colors
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color greyColor = Colors.grey;
  static Color greyLightColor = Colors.grey.shade100;
  static Color greyMediumColor = Colors.grey.shade400;
  static const Color successColor = greenColor;
  static const Color errorColor = primaryColor;
  static const Color warningColor = violetColor;
  static Color errorBackgroundColor = Colors.red.shade50;
  static Color errorBorderColor = Colors.red.shade300;
  static Color errorTextColor = Colors.red.shade700;

  // ============ GRADIENTS ============
  static final LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, primaryLightColor],
  );

  static final LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, primaryDarkColor],
  );

  // ============ BORDER RADIUS ============
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 15.0;
  static const double borderRadiusLarge = 25.0;
  static const double borderRadiusExtraLarge = 150.0;

  // ============ SPACING ============
  static const double spacingXS = 5.0;
  static const double spacingS = 10.0;
  static const double spacingM = 15.0;
  static const double spacingL = 20.0;
  static const double spacingXL = 30.0;
  static const double spacingXXL = 40.0;

  // ============ FONT SIZES ============
  static const double fontSizeSmall = 14.0;
  static const double fontSizeMedium = 16.0;
  static const double fontSizeLarge = 18.0;
  static const double fontSizeXL = 20.0;
  static const double fontSizeHuge = 28.0;
  static const double fontSizeLogo = 32.0;
  static const double fontSizeCounter = 40.0;

  // ============ FONT WEIGHTS ============
  static const FontWeight fontWeightLight = FontWeight.w300;
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightBold = FontWeight.bold;

  // ============ SIZES ============
  static const double logoSize = 120.0;
  static const double logoBorderWidth = 3.0;
  static const double headerHeight = 200.0;
  static const double buttonHeight = 50.0;
  static const double textFieldHeight = 50.0;
  static const double iconSize = 30.0;

  // ============ PADDING ============
  static const double paddingHorizontal = 30.0;
  static const double paddingVertical = 16.0;
  static const double paddingSmall = 12.0;
  static const double paddingMedium = 15.0;
  static const double paddingLarge = 20.0;

  // ============ STRINGS ============
  static const String appName = 'Lyst';
  static const String inscription = 'Inscription';
  static const String connexion = 'Connexion';
  static const String email = 'Email';
  static const String motDePasse = 'Mot de passe';
  static const String confirmerMotDePasse = 'Confirmer mot de passe';
  static const String sInscrire = "S'inscrire";
  static const String seConnecter = 'Se connecter';
  static const String bienvenueSurLyst = 'Bienvenue sur Lyst!';
  static const String vousAvezDejaUnCompte = 'Vous avez déjà un compte? ';
  static const String vousNeDisposezPas = "Vous ne disposez pas d'un compte? ";
  static const String gestionnaireLyst = 'Gestionnaire Lyst';
  static const String tachesTotales = 'Tâches totales';
  static const String debutezEnregistrement = "Débutez l'enregistrement d'une\nnouvelle tâche";
  static const String modifierLaTache = 'Modifier la tâche';
  static const String nom = 'Nom';
  static const String date = 'Date';
  static const String enregistrer = 'Enregistrer';
  static const String modifier = 'Modifier';
  static const String faireLeMenage = 'Faire le ménage';

  // ============ MESSAGES ============
  static const String erreurEmailVide = 'Veuillez entrer votre email';
  static const String erreurEmailInvalide = 'Veuillez entrer un email valide';
  static const String erreurMotDePasseVide = 'Veuillez entrer un mot de passe';
  static const String erreurMotDePasseCourt = 'Le mot de passe doit contenir au moins 6 caractères';
  static const String erreurMotDePasseNonCorrespondant = 'Les mots de passe ne correspondent pas';
  static const String erreurEmailExiste = 'Cet email est déjà utilisé';
  static const String erreurIdentifiantsIncorrects = 'Email ou mot de passe incorrect';
  static const String erreurNomTacheVide = 'Veuillez entrer un nom pour la tâche';
  static const String erreurConnexionBD = 'Erreur de connexion à la base de données';
  static const String erreurInscription = "Erreur lors de l'inscription";
  static const String erreurConnexion = 'Erreur lors de la connexion';

  static const String inscriptionReussie = 'Inscription réussie!';
  static const String connexionReussie = 'Connexion réussie!';
  static const String tacheAjoutee = 'Tâche ajoutée avec succès';
  static const String tacheModifiee = 'Tâche modifiée avec succès';
  static const String tacheSupprimee = 'Tâche supprimée avec succès';

  // ============ DATABASE ============
  static const String databaseName = 'lyst.db';
  static const int databaseVersion = 1;

  static const String tableUsers = 'users';
  static const String tableTasks = 'tasks';

  static const String columnUserId = 'id';
  static const String columnUserEmail = 'email';
  static const String columnUserPassword = 'password';
  static const String columnUserCreatedAt = 'created_at';

  static const String columnTaskId = 'id';
  static const String columnTaskUserId = 'user_id';
  static const String columnTaskName = 'name';
  static const String columnTaskDate = 'date';
  static const String columnTaskIsCompleted = 'is_completed';
  static const String columnTaskCreatedAt = 'created_at';

  // ============ VALIDATION ============
  static const int minPasswordLength = 6;
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  // ============ DATE FORMAT ============
  static const String dateFormatPattern = 'dd/MM/yyyy';
  static const String timeFormatPattern = 'HH:mm';
  static const String dateTimeFormatPattern = 'dd/MM/yyyy HH:mm';
}
