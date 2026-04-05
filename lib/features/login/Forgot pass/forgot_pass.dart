import 'package:cairo_store_1/features/login/verify_otp.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailCtrl = TextEditingController();

  static const Color kYellow = Color(0xFFFFC107);
  static const Color kGrey   = Color(0xFF999999);
  static const Color kDark   = Color(0xFF1A1A1A);

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sw   = MediaQuery.of(context).size.width;
    final sh   = MediaQuery.of(context).size.height;
    final hPad = sw * 0.07;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: hPad),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: sh * 0.04),

                // ── Back Button ────────────────────────────────────────
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: sw * 0.10,
                    height: sw * 0.10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: const Color(0xFFE0E0E0), width: 1.2),
                    ),
                    child: Icon(Icons.arrow_forward_ios_rounded,
                        size: sw * 0.04, color: kDark),
                  ),
                ),

                SizedBox(height: sh * 0.035),

                // ── Title ──────────────────────────────────────────────
                Text('إستعادة كلمة المرور 🔐',
                    style: TextStyle(
                        fontSize: sw * 0.056,
                        fontWeight: FontWeight.w800,
                        color: kDark)),

                SizedBox(height: sh * 0.012),

                Text(
                  'دخل بريدك الإلكتروني أو رقم هاتفك المسجل في التطبيق وسنرسم إيميل حتى دخول',
                  style: TextStyle(
                      fontSize: sw * 0.034,
                      color: kGrey,
                      height: 1.6),
                ),

                SizedBox(height: sh * 0.04),

                // ── Email Label ────────────────────────────────────────
                Text('البريد الإلكتروني',
                    style: TextStyle(
                        fontSize: sw * 0.036,
                        fontWeight: FontWeight.w600,
                        color: kDark)),

                SizedBox(height: sh * 0.008),

                // ── Email Field ────────────────────────────────────────
                TextField(
                  controller: _emailCtrl,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      fontSize: sw * 0.038, color: kDark),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined,
                        color: kGrey, size: sw * 0.05),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: sw * 0.04,
                        vertical: sw * 0.038),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Color(0xFFE0E0E0), width: 1.2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: kYellow, width: 1.5),
                    ),
                  ),
                ),

                SizedBox(height: sh * 0.04),

                // ── Send Button ────────────────────────────────────────
                GestureDetector(
                  onTap: () => Navigator.push(context,
                            MaterialPageRoute(
                                builder: (_) => const VerifyOtp() )),
                  child: Container(
                    width: double.infinity,
                    height: sh * 0.065,
                    decoration: BoxDecoration(
                      color: kYellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text('إرسال الكود',
                        style: TextStyle(
                            fontSize: sw * 0.042,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                  ),
                ),

                SizedBox(height: sh * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}