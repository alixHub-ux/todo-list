import 'package:flutter/material.dart';

/// Application-wide constants including colors, strings, and database table names
class AppConstants {

  AppConstants._();

  // ============ COLORS ============
  
  // Primary Colors
  /// Main burgundy/dark red color - RougeBordeau (#710014)
  static const Color primaryColor = Color(0xFF710014);
  
  /// White color - Blanc (#f2f1ed)
  static const Color whiteColor = Color(0xFFf2f1ed);
  
  /// Black color for buttons and text - Noir (#161616)
  static const Color blackColor = Color(0xFF161616);
  
  /// Violet/Purple color - VioletClair (#6b05b4)
  static const Color violetColor = Color(0xFF6b05b4);
  
  /// Green color - Vert (#05a11d)
  static const Color greenColor = Color(0xFF05a11d);
  
  /// Dark violet color - VioletDark (#290b34)
  static const Color violetDarkColor = Color(0xFF290b34);
  
  // Functional Colors
  /// Background color for the app
  static const Color backgroundColor = Color(0xFFF5F5F5);
  
  /// Grey color for inactive states
  static const Color greyColor = Colors.grey;
  
  /// Light grey for text fields background
  static Color greyLightColor = Colors.grey.shade100;
  
  /// Medium grey for borders
  static Color greyMediumColor = Colors.grey.shade400;
  
  /// Success green color (using custom green)
  static const Color successColor = greenColor;
  
  /// Error red color (using primary burgundy)
  static const Color errorColor = primaryColor;
  
  /// Warning/Edit purple color (using violet)
  static const Color warningColor = violetColor;
  
  /// Error background color
  static Color errorBackgroundColor = Colors.red.shade50;
  
  /// Error border color
  static Color errorBorderColor = Colors.red.shade300;
  
  /// Error text color
  static Color errorTextColor = Colors.red.shade700;

  // ============ GRADIENTS ============
  
  /// Primary gradient for headers
  static final LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, primaryLightColor],
  );
  
  /// Dark gradient for task counter card
  static final LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, primaryDarkColor],
  );

  // ============ BORDER RADIUS ============
  
  /// Standard border radius for cards
  static const double borderRadiusSmall = 8.0;
  
  /// Medium border radius for dialogs
  static const double borderRadiusMedium = 15.0;
  
  /// Large border radius for buttons and text fields
  static const double borderRadiusLarge = 25.0;
  
  /// Extra large border radius for headers
  static const double borderRadiusExtraLarge = 150.0;

  // ============ SPACING ============
  
  /// Extra small spacing (5px)
  static const double spacingXS = 5.0;
  
  /// Small spacing (10px)
  static const double spacingS = 10.0;
  
  /// Medium spacing (15px)
  static const double spacingM = 15.0;
  
  /// Large spacing (20px)
  static const double spacingL = 20.0;
  
  /// Extra large spacing (30px)
  static const double spacingXL = 30.0;
  
  /// Extra extra large spacing (40px)
  static const double spacingXXL = 40.0;

  // ============ FONT SIZES ============
  
  /// Small text size
  static const double fontSizeSmall = 14.0;
  
  /// Medium text size
  static const double fontSizeMedium = 16.0;
  
  /// Large text size
  static const double fontSizeLarge = 18.0;
  
  /// Extra large text size (for titles)
  static const double fontSizeXL = 20.0;
  
  /// Huge text size (for headers)
  static const double fontSizeHuge = 28.0;
  
  /// Logo text size
  static const double fontSizeLogo = 32.0;
  
  /// Counter text size
  static const double fontSizeCounter = 40.0;

  // ============ FONT WEIGHTS ============
  
  /// Light font weight
  static const FontWeight fontWeightLight = FontWeight.w300;
  
  /// Regular font weight
  static const FontWeight fontWeightRegular = FontWeight.w400;
  
  /// Medium font weight
  static const FontWeight fontWeightMedium = FontWeight.w500;
  
  /// Bold font weight
  static const FontWeight fontWeightBold = FontWeight.bold;

  // ============ SIZES ============
  
  /// Logo circle size
  static const double logoSize = 120.0;
  
  /// Logo border width
  static const double logoBorderWidth = 3.0;
  
  /// Header height
  static const double headerHeight = 200.0;
  
  /// Button height
  static const double buttonHeight = 50.0;
  
  /// Text field height (implicit through padding)
  static const double textFieldHeight = 50.0;
  
  /// Icon size standard
  static const double iconSize = 30.0;

  // ============ PADDING ============
  
  /// Standard horizontal padding
  static const double paddingHorizontal = 30.0;
  
  /// Standard vertical padding
  static const double paddingVertical = 16.0;
  
  /// Small padding
  static const double paddingSmall = 12.0;
  
  /// Medium padding
  static const double paddingMedium = 15.0;
  
  /// Large padding
  static const double paddingLarge = 20.0;

  // ============ STRINGS ============
  
  // App Name
  static const String appName = 'Lyst';
  
  // Authentication Strings
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
  
  // Task Strings
  static const String gestionnaireLyst = 'Gestionnaire Lyst';
  static const String tachesTotales = 'Tâches totales';
  static const String debutezEnregistrement = "Débutez l'enregistrement d'une\nnouvelle tâche";
  static const String modifierLaTache = 'Modifier la tâche';
  static const String nom = 'Nom';
  static const String date = 'Date';
  static const String enregistrer = 'Enregistrer';
  static const String modifier = 'Modifier';
  static const String faireLeMenuage = 'Faire le ménage';
  
  // Error Messages
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
  
  // Success Messages
  static const String inscriptionReussie = 'Inscription réussie!';
  static const String connexionReussie = 'Connexion réussie!';
  static const String tacheAjoutee = 'Tâche ajoutée avec succès';
  static const String tacheModifiee = 'Tâche modifiée avec succès';
  static const String tacheSupprimee = 'Tâche supprimée avec succès';

  // ============ DATABASE CONSTANTS ============
  
  /// Database name
  static const String databaseName = 'lyst.db';
  
  /// Database version
  static const int databaseVersion = 1;
  
  // Table Names
  static const String tableUsers = 'users';
  static const String tableTasks = 'tasks';
  
  // Users Table Columns
  static const String columnUserId = 'id';
  static const String columnUserEmail = 'email';
  static const String columnUserPassword = 'password';
  static const String columnUserCreatedAt = 'created_at';
  
  // Tasks Table Columns
  static const String columnTaskId = 'id';
  static const String columnTaskUserId = 'user_id';
  static const String columnTaskName = 'name';
  static const String columnTaskDate = 'date';
  static const String columnTaskIsCompleted = 'is_completed';
  static const String columnTaskCreatedAt = 'created_at';

  // ============ VALIDATION CONSTANTS ============
  
  /// Minimum password length
  static const int minPasswordLength = 6;
  
  /// Email regex pattern
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  // ============ DATE FORMAT ============
  
  /// Date format pattern (DD/MM/YYYY)
  static const String dateFormatPattern = 'dd/MM/yyyy';
  
  /// Time format pattern
  static const String timeFormatPattern = 'HH:mm';
  
  /// DateTime format pattern
  static const String dateTimeFormatPattern = 'dd/MM/yyyy HH:mm';
  
  static var primaryLightColor;
  static var primaryDarkColor;
}
