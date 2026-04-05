import 'package:flutter/material.dart';
import '../login/login_scren.dart';
import './on_boarding_data.dart';
import 'package:flutter/services.dart';
import 'dart:math';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const Color kYellow = Color(0xFFFFC107);

  void _nextPage() {
    if (_currentPage < onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _goToHome();
    }
  }

  void _goToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    final mq  = MediaQuery.of(context);
    final sw  = mq.size.width;
    final sh  = mq.size.height;

    final double imgHeight   = sh * 0.46;
    final double hPad        = sw * 0.07;
    final double titleSize   = sw * 0.055;
    final double subSize     = sw * 0.035;
    final double skipSize    = sw * 0.033;
    final double btnSize     = sw * 0.145;
    final double btnIconSize = sw * 0.055;
    final double spacingTop  = sh * 0.025;
    final double spacingMid  = sh * 0.008;
    final double spacingBottom = sh * 0.04;
    final double spacingBtn  = sh * 0.012;

    // progress: شاشة 0 → 0.33، شاشة 1 → 0.66، شاشة 2 → 1.0
    final double progress =
        (_currentPage + 1) / onboardingPages.length;

    // "تخطى" تظهر في كل الشاشات ما عدا الأخيرة

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [


            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: imgHeight,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemCount: onboardingPages.length,
                  itemBuilder: (_, i) => Image.asset(
                    onboardingPages[i].imagePath,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: imgHeight,
                  ),
                ),
              ),
            ),

            // ── النص والزرار ───────────────────────────────────────────
            Expanded(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: hPad),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: spacingTop),

                      // العنوان
                      Text(
                        onboardingPages[_currentPage].title,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: titleSize,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1A1A1A),
                          height: 1.4,
                        ),
                      ),

                      SizedBox(height: spacingMid),

                      // الـ subtitle
                      Text(
                        onboardingPages[_currentPage].subtitle,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: subSize,
                          color: const Color(0xFF999999),
                          height: 1.65,
                        ),
                      ),

                      const Spacer(),

                      // ── الزرار مع دايرة Progress ──────────────────────
                      Center(
                        child: GestureDetector(
                          onTap: _nextPage,
                          child: Builder(builder: (_) {
                            // gap بين الزرار والـ ring
                            final double gap        = sw * 0.025;
                            final double strokeW    = sw * 0.010;
                            final double ringSize   = btnSize + gap * 2 + strokeW * 2;

                            return SizedBox(
                              width: ringSize,
                              height: ringSize,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // دايرة الـ progress (برة بمسافة)
                                  AnimatedProgressRing(
                                    progress: progress,
                                    size: ringSize,
                                    strokeWidth: strokeW,
                                    activeColor: kYellow,
                                    inactiveColor: const Color(0xFFE0E0E0),
                                  ),

                                  // الزرار الداخلي
                                  Container(
                                    width: btnSize,
                                    height: btnSize,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kYellow,
                                      boxShadow: [
                                        BoxShadow(
                                          color: kYellow.withOpacity(0.35),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      _currentPage == onboardingPages.length - 1
                                          ? Icons.check_rounded               // ✓ آخر شاشة
                                          : Icons.arrow_back_ios_new_rounded, // سهم
                                      color: Colors.white,
                                      size: btnIconSize,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),

                      // زرار "تخطى" – كل الشاشات ما عدا الأخيرة
                      if (_currentPage < onboardingPages.length - 1) ...[
                        SizedBox(height: spacingBtn),
                        Center(
                          child: TextButton(
                            onPressed: _goToHome,
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF999999),
                              padding: EdgeInsets.symmetric(
                                horizontal: sw * 0.06,
                                vertical: sh * 0.008,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'تخطى',
                              style: TextStyle(
                                fontSize: skipSize,
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ] else
                        SizedBox(height: spacingBtn + skipSize + 4),

                      SizedBox(height: spacingBottom),
                    ],
                  ),
                ),
              ),
            ),
          
        ]),
      ),
    );
  }
}

// ─── دايرة Progress متحركة ────────────────────────────────────────────────────

class AnimatedProgressRing extends StatefulWidget {
  final double progress;      // 0.0 → 1.0
  final double size;
  final double strokeWidth;
  final Color activeColor;
  final Color inactiveColor;

  const AnimatedProgressRing({
    super.key,
    required this.progress,
    required this.size,
    required this.strokeWidth,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  State<AnimatedProgressRing> createState() => _AnimatedProgressRingState();
}

class _AnimatedProgressRingState extends State<AnimatedProgressRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  double _oldProgress = 0;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _anim = Tween<double>(
      begin: widget.progress,
      end: widget.progress,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    _oldProgress = widget.progress;
    _ctrl.forward();
  }

  @override
  void didUpdateWidget(AnimatedProgressRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _anim = Tween<double>(
        begin: _oldProgress,
        end: widget.progress,
      ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
      _oldProgress = widget.progress;
      _ctrl
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => CustomPaint(
        size: Size(widget.size, widget.size),
        painter: _RingPainter(
          progress: _anim.value,
          strokeWidth: widget.strokeWidth,
          activeColor: widget.activeColor,
          inactiveColor: widget.inactiveColor,
        ),
      ),
    );
  }
}

// ─── CustomPainter للـ ring ───────────────────────────────────────────────────

class _RingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color activeColor;
  final Color inactiveColor;

  _RingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paintBg = Paint()
      ..color = inactiveColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final paintFg = Paint()
      ..color = activeColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // الجزء الرمادي (الكامل)
    canvas.drawCircle(center, radius, paintBg);

    // الجزء الأصفر (progress) – يبدأ من الأعلى (-π/2)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      paintFg,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.progress != progress;
}