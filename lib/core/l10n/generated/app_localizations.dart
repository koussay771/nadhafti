import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('fr'),
  ];

  /// No description provided for @appName.
  ///
  /// In ar, this message translates to:
  /// **'نظافتي'**
  String get appName;

  /// No description provided for @onboarding_skip.
  ///
  /// In ar, this message translates to:
  /// **'تخطي'**
  String get onboarding_skip;

  /// No description provided for @onboarding_next.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get onboarding_next;

  /// No description provided for @onboarding_getStarted.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ الآن'**
  String get onboarding_getStarted;

  /// No description provided for @onboarding1_title.
  ///
  /// In ar, this message translates to:
  /// **'استمتع ببيتك النظيف'**
  String get onboarding1_title;

  /// No description provided for @onboarding1_subtitle.
  ///
  /// In ar, this message translates to:
  /// **'محترفو التنظيف يضمنون لك بيتًا لامعًا دائمًا'**
  String get onboarding1_subtitle;

  /// No description provided for @onboarding2_title.
  ///
  /// In ar, this message translates to:
  /// **'احجز بسهولة'**
  String get onboarding2_title;

  /// No description provided for @onboarding2_subtitle.
  ///
  /// In ar, this message translates to:
  /// **'بلمسة زر واحدة، حدد موعد تنظيفك القادم'**
  String get onboarding2_subtitle;

  /// No description provided for @onboarding3_title.
  ///
  /// In ar, this message translates to:
  /// **'خدمة سريعة'**
  String get onboarding3_title;

  /// No description provided for @onboarding3_subtitle.
  ///
  /// In ar, this message translates to:
  /// **'احصل على تنظيف في أقرب وقت ممكن وبأفضل جودة'**
  String get onboarding3_subtitle;

  /// No description provided for @auth_login.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get auth_login;

  /// No description provided for @auth_signup.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب'**
  String get auth_signup;

  /// No description provided for @auth_email.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get auth_email;

  /// No description provided for @auth_password.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get auth_password;

  /// No description provided for @auth_confirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get auth_confirmPassword;

  /// No description provided for @auth_firstName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الأول'**
  String get auth_firstName;

  /// No description provided for @auth_lastName.
  ///
  /// In ar, this message translates to:
  /// **'اللقب'**
  String get auth_lastName;

  /// No description provided for @auth_phone.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف'**
  String get auth_phone;

  /// No description provided for @auth_forgotPassword.
  ///
  /// In ar, this message translates to:
  /// **'نسيت كلمة المرور؟'**
  String get auth_forgotPassword;

  /// No description provided for @auth_noAccount.
  ///
  /// In ar, this message translates to:
  /// **'ليس لديك حساب؟ '**
  String get auth_noAccount;

  /// No description provided for @auth_hasAccount.
  ///
  /// In ar, this message translates to:
  /// **'لديك حساب بالفعل؟ '**
  String get auth_hasAccount;

  /// No description provided for @auth_signupLink.
  ///
  /// In ar, this message translates to:
  /// **'سجّل الآن'**
  String get auth_signupLink;

  /// No description provided for @auth_loginLink.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get auth_loginLink;

  /// No description provided for @auth_termsAccept.
  ///
  /// In ar, this message translates to:
  /// **'أوافق على الشروط وسياسة الخصوصية'**
  String get auth_termsAccept;

  /// No description provided for @auth_socialComingSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريبًا'**
  String get auth_socialComingSoon;

  /// No description provided for @auth_welcome.
  ///
  /// In ar, this message translates to:
  /// **'مرحبًا بك في نظافتي 👋'**
  String get auth_welcome;

  /// No description provided for @auth_welcomeSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'احجز خدمة التنظيف المثالية لبيتك'**
  String get auth_welcomeSubtitle;

  /// No description provided for @nav_home.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get nav_home;

  /// No description provided for @nav_bookings.
  ///
  /// In ar, this message translates to:
  /// **'الحجوزات'**
  String get nav_bookings;

  /// No description provided for @nav_map.
  ///
  /// In ar, this message translates to:
  /// **'الخريطة'**
  String get nav_map;

  /// No description provided for @nav_settings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get nav_settings;

  /// No description provided for @home_greeting.
  ///
  /// In ar, this message translates to:
  /// **'مرحبًا، {name}! 👋'**
  String home_greeting(String name);

  /// No description provided for @home_subtitle.
  ///
  /// In ar, this message translates to:
  /// **'جاهزون لتنظيف بيتك بأعلى معايير الجودة والراحة'**
  String get home_subtitle;

  /// No description provided for @home_locationBadge.
  ///
  /// In ar, this message translates to:
  /// **'المنستير، تونس'**
  String get home_locationBadge;

  /// No description provided for @home_hero_headline.
  ///
  /// In ar, this message translates to:
  /// **'خلّ بيتك يلمع اليوم! ✨'**
  String get home_hero_headline;

  /// No description provided for @home_cta.
  ///
  /// In ar, this message translates to:
  /// **'احجز الآن'**
  String get home_cta;

  /// No description provided for @home_top_service.
  ///
  /// In ar, this message translates to:
  /// **'خدمة رقم 1 في المنستير'**
  String get home_top_service;

  /// No description provided for @home_instant_booking.
  ///
  /// In ar, this message translates to:
  /// **'حجز فوري في أقل من دقيقة مع عاملات محترفات'**
  String get home_instant_booking;

  /// No description provided for @home_services_title.
  ///
  /// In ar, this message translates to:
  /// **'باقات التنظيف'**
  String get home_services_title;

  /// No description provided for @home_services_subtitle.
  ///
  /// In ar, this message translates to:
  /// **'أسعار ثابتة وشفافة'**
  String get home_services_subtitle;

  /// No description provided for @home_popular_badge.
  ///
  /// In ar, this message translates to:
  /// **'الأكثر طلبًا 🔥'**
  String get home_popular_badge;

  /// No description provided for @home_hours_duration.
  ///
  /// In ar, this message translates to:
  /// **'حوالي {hours} ساعات عمل'**
  String home_hours_duration(int hours);

  /// No description provided for @home_trust_title.
  ///
  /// In ar, this message translates to:
  /// **'لماذا تختار نظافتي؟'**
  String get home_trust_title;

  /// No description provided for @home_trust_1_title.
  ///
  /// In ar, this message translates to:
  /// **'عاملات موثوقات وذوات خبرة'**
  String get home_trust_1_title;

  /// No description provided for @home_trust_1_sub.
  ///
  /// In ar, this message translates to:
  /// **'تم التحقق من الهوية والخبرة المهنية لجميع العاملات'**
  String get home_trust_1_sub;

  /// No description provided for @home_trust_2_title.
  ///
  /// In ar, this message translates to:
  /// **'أسعار واضحة ودون مفاجآت'**
  String get home_trust_2_title;

  /// No description provided for @home_trust_2_sub.
  ///
  /// In ar, this message translates to:
  /// **'الدفع عند إتمام الخدمة بكل شفافية وأمان'**
  String get home_trust_2_sub;

  /// No description provided for @home_trust_3_title.
  ///
  /// In ar, this message translates to:
  /// **'ضمان الرضا 100%'**
  String get home_trust_3_title;

  /// No description provided for @home_trust_3_sub.
  ///
  /// In ar, this message translates to:
  /// **'إذا لم تكن راضيًا عن النتيجة، سنعيد تنظيف الجزء مجانًا'**
  String get home_trust_3_sub;

  /// No description provided for @location_title.
  ///
  /// In ar, this message translates to:
  /// **'اختر الموقع'**
  String get location_title;

  /// No description provided for @location_search_hint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن عنوانك...'**
  String get location_search_hint;

  /// No description provided for @location_savedAddresses.
  ///
  /// In ar, this message translates to:
  /// **'العناوين المحفوظة'**
  String get location_savedAddresses;

  /// No description provided for @location_chooseOnMap.
  ///
  /// In ar, this message translates to:
  /// **'اختر على الخريطة'**
  String get location_chooseOnMap;

  /// No description provided for @location_unavailable_title.
  ///
  /// In ar, this message translates to:
  /// **'غير متاح في منطقتك'**
  String get location_unavailable_title;

  /// No description provided for @location_unavailable_body.
  ///
  /// In ar, this message translates to:
  /// **'نحن نخدم حاليًا المنستير وضواحيها. سنصل إليك قريبًا!'**
  String get location_unavailable_body;

  /// No description provided for @property_title.
  ///
  /// In ar, this message translates to:
  /// **'اختر العقار'**
  String get property_title;

  /// No description provided for @property_empty_title.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد عقار بعد'**
  String get property_empty_title;

  /// No description provided for @property_empty_body.
  ///
  /// In ar, this message translates to:
  /// **'أضف عقارك الأول لبدء الحجز'**
  String get property_empty_body;

  /// No description provided for @property_add.
  ///
  /// In ar, this message translates to:
  /// **'إضافة عقار'**
  String get property_add;

  /// No description provided for @property_type_apartment.
  ///
  /// In ar, this message translates to:
  /// **'شقة'**
  String get property_type_apartment;

  /// No description provided for @property_type_house.
  ///
  /// In ar, this message translates to:
  /// **'منزل'**
  String get property_type_house;

  /// No description provided for @property_type_villa.
  ///
  /// In ar, this message translates to:
  /// **'فيلا'**
  String get property_type_villa;

  /// No description provided for @property_type_office.
  ///
  /// In ar, this message translates to:
  /// **'مكتب'**
  String get property_type_office;

  /// No description provided for @property_rooms.
  ///
  /// In ar, this message translates to:
  /// **'غرف النوم'**
  String get property_rooms;

  /// No description provided for @property_bathrooms.
  ///
  /// In ar, this message translates to:
  /// **'الحمامات'**
  String get property_bathrooms;

  /// No description provided for @property_size.
  ///
  /// In ar, this message translates to:
  /// **'المساحة (م²)'**
  String get property_size;

  /// No description provided for @property_notes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات إضافية'**
  String get property_notes;

  /// No description provided for @property_save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ العقار'**
  String get property_save;

  /// No description provided for @property_nickname.
  ///
  /// In ar, this message translates to:
  /// **'اسم العقار (اختياري)'**
  String get property_nickname;

  /// No description provided for @booking_title.
  ///
  /// In ar, this message translates to:
  /// **'حجز الخدمة'**
  String get booking_title;

  /// No description provided for @booking_select_package_title.
  ///
  /// In ar, this message translates to:
  /// **'باقة التنظيف المختارة'**
  String get booking_select_package_title;

  /// No description provided for @booking_standard.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف عادي'**
  String get booking_standard;

  /// No description provided for @booking_deep.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف عميق'**
  String get booking_deep;

  /// No description provided for @booking_moveInOut.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف عند الانتقال'**
  String get booking_moveInOut;

  /// No description provided for @booking_office.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف مكاتب ومحلات'**
  String get booking_office;

  /// No description provided for @booking_selectDate.
  ///
  /// In ar, this message translates to:
  /// **'اختر التاريخ والوقت'**
  String get booking_selectDate;

  /// No description provided for @booking_choose_date.
  ///
  /// In ar, this message translates to:
  /// **'اختر التاريخ'**
  String get booking_choose_date;

  /// No description provided for @booking_choose_time.
  ///
  /// In ar, this message translates to:
  /// **'اختر التوقيت المناسب'**
  String get booking_choose_time;

  /// No description provided for @booking_addons_title.
  ///
  /// In ar, this message translates to:
  /// **'خدمات إضافية حسب الطلب'**
  String get booking_addons_title;

  /// No description provided for @booking_payment_title.
  ///
  /// In ar, this message translates to:
  /// **'طريقة الدفع'**
  String get booking_payment_title;

  /// No description provided for @booking_payment_cash.
  ///
  /// In ar, this message translates to:
  /// **'الدفع نقدًا عند إتمام الخدمة (Espèces)'**
  String get booking_payment_cash;

  /// No description provided for @booking_payment_cash_desc.
  ///
  /// In ar, this message translates to:
  /// **'تدفع للعاملة مباشرة بعد فحص ومعاينة النظافة'**
  String get booking_payment_cash_desc;

  /// No description provided for @booking_total.
  ///
  /// In ar, this message translates to:
  /// **'المبلغ الإجمالي:'**
  String get booking_total;

  /// No description provided for @booking_confirm_cta.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الحجز الفوري'**
  String get booking_confirm_cta;

  /// No description provided for @booking_change.
  ///
  /// In ar, this message translates to:
  /// **'تغيير'**
  String get booking_change;

  /// No description provided for @booking_success_title.
  ///
  /// In ar, this message translates to:
  /// **'تم تأكيد حجزك بنجاح! 🎉'**
  String get booking_success_title;

  /// No description provided for @booking_num.
  ///
  /// In ar, this message translates to:
  /// **'رقم الحجز:'**
  String get booking_num;

  /// No description provided for @booking_package_label.
  ///
  /// In ar, this message translates to:
  /// **'الباقة:'**
  String get booking_package_label;

  /// No description provided for @booking_date_label.
  ///
  /// In ar, this message translates to:
  /// **'الموعد:'**
  String get booking_date_label;

  /// No description provided for @booking_address_label.
  ///
  /// In ar, this message translates to:
  /// **'العنوان:'**
  String get booking_address_label;

  /// No description provided for @booking_total_label.
  ///
  /// In ar, this message translates to:
  /// **'المجموع:'**
  String get booking_total_label;

  /// No description provided for @booking_return_home.
  ///
  /// In ar, this message translates to:
  /// **'العودة إلى الرئيسية'**
  String get booking_return_home;

  /// No description provided for @booking_confirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الحجز'**
  String get booking_confirm;

  /// No description provided for @booking_price.
  ///
  /// In ar, this message translates to:
  /// **'{price} دت'**
  String booking_price(String price);

  /// No description provided for @profile_title.
  ///
  /// In ar, this message translates to:
  /// **'الملف الشخصي'**
  String get profile_title;

  /// No description provided for @profile_save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ التغييرات'**
  String get profile_save;

  /// No description provided for @profile_editAvatar.
  ///
  /// In ar, this message translates to:
  /// **'تغيير الصورة'**
  String get profile_editAvatar;

  /// No description provided for @settings_title.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settings_title;

  /// No description provided for @settings_profile.
  ///
  /// In ar, this message translates to:
  /// **'الملف الشخصي'**
  String get settings_profile;

  /// No description provided for @settings_myProperties.
  ///
  /// In ar, this message translates to:
  /// **'عقاراتي'**
  String get settings_myProperties;

  /// No description provided for @settings_myLocations.
  ///
  /// In ar, this message translates to:
  /// **'مواقعي'**
  String get settings_myLocations;

  /// No description provided for @settings_terms.
  ///
  /// In ar, this message translates to:
  /// **'شروط الخدمة'**
  String get settings_terms;

  /// No description provided for @settings_privacy.
  ///
  /// In ar, this message translates to:
  /// **'سياسة الخصوصية'**
  String get settings_privacy;

  /// No description provided for @settings_contact.
  ///
  /// In ar, this message translates to:
  /// **'تواصل معنا'**
  String get settings_contact;

  /// No description provided for @settings_switchToCleaner.
  ///
  /// In ar, this message translates to:
  /// **'التحويل إلى حساب عامل تنظيف'**
  String get settings_switchToCleaner;

  /// No description provided for @settings_logout.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get settings_logout;

  /// No description provided for @settings_deleteAccount.
  ///
  /// In ar, this message translates to:
  /// **'حذف الحساب'**
  String get settings_deleteAccount;

  /// No description provided for @settings_deleteAccount_confirm.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من حذف حسابك؟ هذا الإجراء لا يمكن التراجع عنه.'**
  String get settings_deleteAccount_confirm;

  /// No description provided for @settings_language.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get settings_language;

  /// No description provided for @settings_language_ar.
  ///
  /// In ar, this message translates to:
  /// **'العربية'**
  String get settings_language_ar;

  /// No description provided for @settings_language_fr.
  ///
  /// In ar, this message translates to:
  /// **'Français'**
  String get settings_language_fr;

  /// No description provided for @common_next.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get common_next;

  /// No description provided for @common_back.
  ///
  /// In ar, this message translates to:
  /// **'رجوع'**
  String get common_back;

  /// No description provided for @common_cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get common_cancel;

  /// No description provided for @common_save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get common_save;

  /// No description provided for @common_delete.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get common_delete;

  /// No description provided for @common_confirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get common_confirm;

  /// No description provided for @common_loading.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ التحميل...'**
  String get common_loading;

  /// No description provided for @common_retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get common_retry;

  /// No description provided for @common_error_generic.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ غير متوقع. الرجاء المحاولة مجددًا.'**
  String get common_error_generic;

  /// No description provided for @common_currency.
  ///
  /// In ar, this message translates to:
  /// **'دت'**
  String get common_currency;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
