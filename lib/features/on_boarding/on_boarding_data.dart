class OnboardingData {
  final String title;
  final String subtitle;
  final String imagePath; // asset path
  final bool isLast;

  const OnboardingData({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.isLast = false,
  });
}

/// قائمة شاشات الـ Onboarding
/// ضع صور الـ assets في المسارات دي:
///   assets/images/onboarding_1.png
///   assets/images/onboarding_2.png
///   assets/images/onboarding_3.png
final List<OnboardingData> onboardingPages = [
  const OnboardingData(
    title: 'توصيل سريع وآمن',
    subtitle: 'توصل لحد باب بيتك في أسرع وقت وبأمان تام',
    imagePath: 'assets/images/image1.png',
  ),
  const OnboardingData(
    title: 'شراء بثقة',
    subtitle: 'ادفع وادعم متاجرنا لحد ما طلبك يوصل',
    imagePath: 'assets/images/image2.png',
  ),
  const OnboardingData(
    title: 'أفضل الأجهزة لبيتك',
    subtitle: 'اختيارات من براندات موثوقة وبجودة تقدر تعتمد عليها',
    imagePath: 'assets/images/image3.png',
    isLast: true,
  ),
];