// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Nadhafti';

  @override
  String get onboarding_skip => 'Passer';

  @override
  String get onboarding_next => 'Suivant';

  @override
  String get onboarding_getStarted => 'Commencer';

  @override
  String get onboarding1_title => 'Profitez de votre maison propre';

  @override
  String get onboarding1_subtitle =>
      'Nos pros du ménage garantissent une maison impeccable';

  @override
  String get onboarding2_title => 'Réservez facilement';

  @override
  String get onboarding2_subtitle =>
      'En un clic, planifiez votre prochain nettoyage';

  @override
  String get onboarding3_title => 'Service rapide';

  @override
  String get onboarding3_subtitle =>
      'Faites nettoyer votre maison où vous voulez, le plus vite possible';

  @override
  String get auth_login => 'Se connecter';

  @override
  String get auth_signup => 'Créer un compte';

  @override
  String get auth_email => 'Email';

  @override
  String get auth_password => 'Mot de passe';

  @override
  String get auth_confirmPassword => 'Confirmer le mot de passe';

  @override
  String get auth_firstName => 'Prénom';

  @override
  String get auth_lastName => 'Nom';

  @override
  String get auth_phone => 'Téléphone';

  @override
  String get auth_forgotPassword => 'Mot de passe oublié ?';

  @override
  String get auth_noAccount => 'Pas de compte ? ';

  @override
  String get auth_hasAccount => 'Déjà un compte ? ';

  @override
  String get auth_signupLink => 'S\'inscrire';

  @override
  String get auth_loginLink => 'Se connecter';

  @override
  String get auth_termsAccept =>
      'J\'accepte les conditions et la politique de confidentialité';

  @override
  String get auth_socialComingSoon => 'Bientôt disponible';

  @override
  String get auth_welcome => 'Bienvenue sur Nadhafti 👋';

  @override
  String get auth_welcomeSubtitle =>
      'Réservez le service de nettoyage parfait pour votre maison';

  @override
  String home_greeting(String name) {
    return 'Bonjour, $name! 👋';
  }

  @override
  String get home_locationBadge => 'Monastir, Tunisie';

  @override
  String get home_hero_headline => 'Faites briller votre maison !';

  @override
  String get home_cta => 'Réserver maintenant';

  @override
  String get location_title => 'Choisir un emplacement';

  @override
  String get location_search_hint => 'Rechercher une adresse...';

  @override
  String get location_savedAddresses => 'Adresses enregistrées';

  @override
  String get location_chooseOnMap => 'Choisir sur la carte';

  @override
  String get location_unavailable_title => 'Non disponible dans votre zone';

  @override
  String get location_unavailable_body =>
      'Nous couvrons actuellement Monastir et ses environs. Nous arrivons bientôt !';

  @override
  String get property_title => 'Choisir un bien';

  @override
  String get property_empty_title => 'Aucun bien pour l\'instant';

  @override
  String get property_empty_body =>
      'Ajoutez votre premier bien pour commencer à réserver';

  @override
  String get property_add => 'Ajouter un bien';

  @override
  String get property_type_apartment => 'Appartement';

  @override
  String get property_type_house => 'Maison';

  @override
  String get property_type_villa => 'Villa';

  @override
  String get property_type_office => 'Bureau';

  @override
  String get property_rooms => 'Chambres';

  @override
  String get property_bathrooms => 'Salles de bain';

  @override
  String get property_size => 'Surface (m²)';

  @override
  String get property_notes => 'Notes supplémentaires';

  @override
  String get property_save => 'Enregistrer le bien';

  @override
  String get property_nickname => 'Nom du bien (optionnel)';

  @override
  String get booking_title => 'Choisir un forfait';

  @override
  String get booking_standard => 'Nettoyage Standard';

  @override
  String get booking_deep => 'Nettoyage Profond';

  @override
  String get booking_moveInOut => 'Nettoyage Déménagement';

  @override
  String get booking_office => 'Nettoyage Bureau';

  @override
  String get booking_selectDate => 'Choisir la date et l\'heure';

  @override
  String get booking_confirm => 'Confirmer la réservation';

  @override
  String booking_price(String price) {
    return '$price DT';
  }

  @override
  String get profile_title => 'Mon profil';

  @override
  String get profile_save => 'Enregistrer les modifications';

  @override
  String get profile_editAvatar => 'Changer la photo';

  @override
  String get settings_title => 'Paramètres';

  @override
  String get settings_profile => 'Mon profil';

  @override
  String get settings_myProperties => 'Mes biens';

  @override
  String get settings_myLocations => 'Mes adresses';

  @override
  String get settings_terms => 'Conditions d\'utilisation';

  @override
  String get settings_privacy => 'Politique de confidentialité';

  @override
  String get settings_contact => 'Nous contacter';

  @override
  String get settings_switchToCleaner => 'Devenir agent de nettoyage';

  @override
  String get settings_logout => 'Se déconnecter';

  @override
  String get settings_deleteAccount => 'Supprimer le compte';

  @override
  String get settings_deleteAccount_confirm =>
      'Êtes-vous sûr de vouloir supprimer votre compte ? Cette action est irréversible.';

  @override
  String get settings_language => 'Langue';

  @override
  String get settings_language_ar => 'العربية';

  @override
  String get settings_language_fr => 'Français';

  @override
  String get common_next => 'Suivant';

  @override
  String get common_back => 'Retour';

  @override
  String get common_cancel => 'Annuler';

  @override
  String get common_save => 'Enregistrer';

  @override
  String get common_delete => 'Supprimer';

  @override
  String get common_confirm => 'Confirmer';

  @override
  String get common_loading => 'Chargement...';

  @override
  String get common_retry => 'Réessayer';

  @override
  String get common_error_generic =>
      'Une erreur inattendue s\'est produite. Veuillez réessayer.';

  @override
  String get common_currency => 'DT';
}
