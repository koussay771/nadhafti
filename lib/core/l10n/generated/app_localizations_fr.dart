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
  String get nav_home => 'Accueil';

  @override
  String get nav_bookings => 'Réservations';

  @override
  String get nav_map => 'Carte';

  @override
  String get nav_settings => 'Paramètres';

  @override
  String home_greeting(String name) {
    return 'Bonjour, $name! 👋';
  }

  @override
  String get home_subtitle =>
      'Prêts à faire briller votre maison avec les meilleurs standards';

  @override
  String get home_locationBadge => 'Monastir, Tunisie';

  @override
  String get home_hero_headline => 'Faites briller votre maison ! ✨';

  @override
  String get home_cta => 'Réserver maintenant';

  @override
  String get home_top_service => 'Service N°1 à Monastir';

  @override
  String get home_instant_booking =>
      'Réservation instantanée en moins d\'une minute avec des professionnelles';

  @override
  String get home_services_title => 'Forfaits de ménage';

  @override
  String get home_services_subtitle => 'Tarifs fixes et transparents';

  @override
  String get home_popular_badge => 'Le plus demandé 🔥';

  @override
  String home_hours_duration(int hours) {
    return 'Environ ${hours}h de travail';
  }

  @override
  String get home_trust_title => 'Pourquoi choisir Nadhafti ?';

  @override
  String get home_trust_1_title => 'Professionnelles fiables et expérimentées';

  @override
  String get home_trust_1_sub =>
      'Identité et expérience vérifiées pour chaque intervenante';

  @override
  String get home_trust_2_title => 'Tarifs clairs sans surprises';

  @override
  String get home_trust_2_sub =>
      'Paiement à la fin de la prestation en toute transparence';

  @override
  String get home_trust_3_title => 'Garantie satisfaction 100%';

  @override
  String get home_trust_3_sub =>
      'Si vous n\'êtes pas satisfait, nous repassons gratuitement';

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
  String get booking_title => 'Réservation';

  @override
  String get booking_select_package_title => 'Forfait sélectionné';

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
  String get booking_choose_date => 'Choisir la date';

  @override
  String get booking_choose_time => 'Choisir l\'horaire';

  @override
  String get booking_addons_title => 'Options supplémentaires';

  @override
  String get booking_payment_title => 'Mode de paiement';

  @override
  String get booking_payment_cash =>
      'Paiement en espèces à la livraison (Espèces)';

  @override
  String get booking_payment_cash_desc =>
      'Payez directement l\'intervenante après inspection du travail';

  @override
  String get booking_total => 'Montant total :';

  @override
  String get booking_confirm_cta => 'Confirmer la réservation';

  @override
  String get booking_change => 'Modifier';

  @override
  String get booking_success_title => 'Réservation confirmée avec succès ! 🎉';

  @override
  String get booking_num => 'N° de réservation :';

  @override
  String get booking_package_label => 'Forfait :';

  @override
  String get booking_date_label => 'Rendez-vous :';

  @override
  String get booking_address_label => 'Adresse :';

  @override
  String get booking_total_label => 'Total :';

  @override
  String get booking_return_home => 'Retour à l\'accueil';

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
