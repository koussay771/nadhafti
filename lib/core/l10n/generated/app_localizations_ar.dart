// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'نظافتي';

  @override
  String get onboarding_skip => 'تخطي';

  @override
  String get onboarding_next => 'التالي';

  @override
  String get onboarding_getStarted => 'ابدأ الآن';

  @override
  String get onboarding1_title => 'استمتع ببيتك النظيف';

  @override
  String get onboarding1_subtitle =>
      'محترفو التنظيف يضمنون لك بيتًا لامعًا دائمًا';

  @override
  String get onboarding2_title => 'احجز بسهولة';

  @override
  String get onboarding2_subtitle => 'بلمسة زر واحدة، حدد موعد تنظيفك القادم';

  @override
  String get onboarding3_title => 'خدمة سريعة';

  @override
  String get onboarding3_subtitle =>
      'احصل على تنظيف في أقرب وقت ممكن وبأفضل جودة';

  @override
  String get auth_login => 'تسجيل الدخول';

  @override
  String get auth_signup => 'إنشاء حساب';

  @override
  String get auth_email => 'البريد الإلكتروني';

  @override
  String get auth_password => 'كلمة المرور';

  @override
  String get auth_confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get auth_firstName => 'الاسم الأول';

  @override
  String get auth_lastName => 'اللقب';

  @override
  String get auth_phone => 'رقم الهاتف';

  @override
  String get auth_forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get auth_noAccount => 'ليس لديك حساب؟ ';

  @override
  String get auth_hasAccount => 'لديك حساب بالفعل؟ ';

  @override
  String get auth_signupLink => 'سجّل الآن';

  @override
  String get auth_loginLink => 'تسجيل الدخول';

  @override
  String get auth_termsAccept => 'أوافق على الشروط وسياسة الخصوصية';

  @override
  String get auth_socialComingSoon => 'قريبًا';

  @override
  String get auth_welcome => 'مرحبًا بك في نظافتي 👋';

  @override
  String get auth_welcomeSubtitle => 'احجز خدمة التنظيف المثالية لبيتك';

  @override
  String home_greeting(String name) {
    return 'مرحبًا، $name! 👋';
  }

  @override
  String get home_locationBadge => 'المنستير، تونس';

  @override
  String get home_hero_headline => 'خلّ بيتك يلمع اليوم!';

  @override
  String get home_cta => 'احجز الآن';

  @override
  String get location_title => 'اختر الموقع';

  @override
  String get location_search_hint => 'ابحث عن عنوانك...';

  @override
  String get location_savedAddresses => 'العناوين المحفوظة';

  @override
  String get location_chooseOnMap => 'اختر على الخريطة';

  @override
  String get location_unavailable_title => 'غير متاح في منطقتك';

  @override
  String get location_unavailable_body =>
      'نحن نخدم حاليًا المنستير وضواحيها. سنصل إليك قريبًا!';

  @override
  String get property_title => 'اختر العقار';

  @override
  String get property_empty_title => 'لا يوجد عقار بعد';

  @override
  String get property_empty_body => 'أضف عقارك الأول لبدء الحجز';

  @override
  String get property_add => 'إضافة عقار';

  @override
  String get property_type_apartment => 'شقة';

  @override
  String get property_type_house => 'منزل';

  @override
  String get property_type_villa => 'فيلا';

  @override
  String get property_type_office => 'مكتب';

  @override
  String get property_rooms => 'غرف النوم';

  @override
  String get property_bathrooms => 'الحمامات';

  @override
  String get property_size => 'المساحة (م²)';

  @override
  String get property_notes => 'ملاحظات إضافية';

  @override
  String get property_save => 'حفظ العقار';

  @override
  String get property_nickname => 'اسم العقار (اختياري)';

  @override
  String get booking_title => 'اختر الباقة';

  @override
  String get booking_standard => 'تنظيف عادي';

  @override
  String get booking_deep => 'تنظيف عميق';

  @override
  String get booking_moveInOut => 'تنظيف عند الانتقال';

  @override
  String get booking_office => 'تنظيف مكتب';

  @override
  String get booking_selectDate => 'اختر التاريخ والوقت';

  @override
  String get booking_confirm => 'تأكيد الحجز';

  @override
  String booking_price(String price) {
    return '$price دت';
  }

  @override
  String get profile_title => 'الملف الشخصي';

  @override
  String get profile_save => 'حفظ التغييرات';

  @override
  String get profile_editAvatar => 'تغيير الصورة';

  @override
  String get settings_title => 'الإعدادات';

  @override
  String get settings_profile => 'الملف الشخصي';

  @override
  String get settings_myProperties => 'عقاراتي';

  @override
  String get settings_myLocations => 'مواقعي';

  @override
  String get settings_terms => 'شروط الخدمة';

  @override
  String get settings_privacy => 'سياسة الخصوصية';

  @override
  String get settings_contact => 'تواصل معنا';

  @override
  String get settings_switchToCleaner => 'التحويل إلى حساب عامل تنظيف';

  @override
  String get settings_logout => 'تسجيل الخروج';

  @override
  String get settings_deleteAccount => 'حذف الحساب';

  @override
  String get settings_deleteAccount_confirm =>
      'هل أنت متأكد من حذف حسابك؟ هذا الإجراء لا يمكن التراجع عنه.';

  @override
  String get settings_language => 'اللغة';

  @override
  String get settings_language_ar => 'العربية';

  @override
  String get settings_language_fr => 'Français';

  @override
  String get common_next => 'التالي';

  @override
  String get common_back => 'رجوع';

  @override
  String get common_cancel => 'إلغاء';

  @override
  String get common_save => 'حفظ';

  @override
  String get common_delete => 'حذف';

  @override
  String get common_confirm => 'تأكيد';

  @override
  String get common_loading => 'جارٍ التحميل...';

  @override
  String get common_retry => 'إعادة المحاولة';

  @override
  String get common_error_generic =>
      'حدث خطأ غير متوقع. الرجاء المحاولة مجددًا.';

  @override
  String get common_currency => 'دت';
}
