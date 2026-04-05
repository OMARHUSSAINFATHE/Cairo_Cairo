import 'package:cairo_store_1/features/login/login_scren.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _firstCtrl    = TextEditingController();
  final _lastCtrl     = TextEditingController();
  final _emailCtrl    = TextEditingController();
  final _phoneCtrl    = TextEditingController();
  final _passCtrl     = TextEditingController();
  final _confirmCtrl  = TextEditingController();
  bool _obscurePass    = true;
  bool _obscureConfirm = true;

  static const kYellow = Color(0xFFFFC107);
  static const kDark   = Color(0xFF1A1A1A);
  static const kGrey   = Color.fromARGB(255, 37, 35, 35);

  @override
  void dispose() {
    _firstCtrl.dispose(); _lastCtrl.dispose();
    _emailCtrl.dispose(); _phoneCtrl.dispose();
    _passCtrl.dispose();  _confirmCtrl.dispose();
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

                // Language
                Row(children: [
                    Text('تسجيل حساب جديد',
                    style: TextStyle(
                        fontSize: sw * 0.062,
                        fontWeight: FontWeight.w800,
                        color: kDark)),
                   const SizedBox(width: 62),
                  Text('English',
                      style: TextStyle(fontSize: sw * 0.032, color: const Color(0xff264AA6)),),
                 const SizedBox(width: 4),

                 const Icon(Icons.language, size: 16, color: kGrey),
                ]),

                Text('اعمل حساب جديد واستمتع بمزايا حصرية',
                    style: TextStyle(
                        fontSize: sw * 0.034, color: kGrey)),

                SizedBox(height: sh * 0.006),

                Row(children: [
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(context,
                        MaterialPageRoute(
                            builder: (_) => const LoginScreen())),
                    child: Text('تسجيل دخول',
                        style: TextStyle(
                            fontSize: sw * 0.032,
                            color: const Color(0xff264AA6),
                            decoration: TextDecoration.underline, 
                            fontWeight: FontWeight.w600)),
                  ),
                  Text('  لديك حساب؟ ',
                      style: TextStyle(
                          fontSize: sw * 0.032, color: kGrey)),
                ]),

                SizedBox(height: sh * 0.028),

                // الاسم الأول والأخير
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _FieldLabel('الاسم الأول', sw),
                          SizedBox(height: sh * 0.006),
                          _InputField(controller: _firstCtrl, sw: sw),
                        ],
                      ),
                    ),
                    SizedBox(width: sw * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _FieldLabel('الاسم الأخير', sw),
                          SizedBox(height: sh * 0.006),
                          _InputField(controller: _lastCtrl, sw: sw),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: sh * 0.02),

                _FieldLabel('البريد الإلكتروني', sw),
                SizedBox(height: sh * 0.006),
                _InputField(
                    controller: _emailCtrl,
                    suffixIcon: Icon(Icons.email_outlined, color: kGrey, size: sw * 0.05),
                    sw: sw),

                SizedBox(height: sh * 0.02),

                _FieldLabel('رقم التليفون', sw),
                SizedBox(height: sh * 0.006),
                _InputField(
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                    sw: sw),

                SizedBox(height: sh * 0.02),

                _FieldLabel('كلمة السر', sw),
                SizedBox(height: sh * 0.006),
                _InputField(
                  controller: _passCtrl,
                  obscure: _obscurePass,
                  prefixIcon: IconButton(
                    icon: Icon(
                        _obscurePass
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: kGrey,
                        size: sw * 0.05),
                    onPressed: () =>
                        setState(() => _obscurePass = !_obscurePass),
                  ),
                  sw: sw,
                ),

                SizedBox(height: sh * 0.02),

                _FieldLabel('تأكيد كلمة السر', sw),
                SizedBox(height: sh * 0.006),
                _InputField(
                  controller: _confirmCtrl,
                  obscure: _obscureConfirm,
                  prefixIcon: IconButton(
                    icon: Icon(
                        _obscureConfirm
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: kGrey,
                        size: sw * 0.05),
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                  sw: sw,
                ),

                SizedBox(height: sh * 0.032),

                _YellowButton(
                    label: 'تسجيل حساب',
                    sw: sw,
                    sh: sh,
                    onTap: () {}),

                SizedBox(height: sh * 0.022),
                _SocialDivider(sw: sw),
                SizedBox(height: sh * 0.018),
                _SocialRow(sw: sw),
                SizedBox(height: sh * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── _FieldLabel ──────────────────────────────────────────────────────────────

Widget _FieldLabel(String text, double sw) {
  return Text(
    text,
    style: TextStyle(
      fontSize: sw * 0.036,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF1A1A1A),
    ),
  );
}

// ─── _InputField ──────────────────────────────────────────────────────────────

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscure;
  final double sw;
    final TextInputType? keyboardType;

  const _InputField({
    required this.controller,
    required this.sw,
    this.prefixIcon,
    this.suffixIcon,
    this.obscure = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      textDirection: TextDirection.ltr,
      style: TextStyle(fontSize: sw * 0.038, color: const Color(0xFF1A1A1A)),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: sw * 0.04,
          vertical: sw * 0.038,
        ),
        filled: true,
        fillColor: const Color(0xFFF7F7F7),
        prefixIcon: prefixIcon ,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFFC107), width: 1.5),
        ),
      ),
    );
  }
}

// ─── _YellowButton ───────────────────────────────────────────────────────────

class _YellowButton extends StatelessWidget {
  final String label;
  final double sw;
  final double sh;
  final VoidCallback onTap;

  const _YellowButton({
    required this.label,
    required this.sw,
    required this.sh,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: sh * 0.065,
        decoration: BoxDecoration(
          color: const Color(0xffEEC53D),
          borderRadius: BorderRadius.circular(0),
          boxShadow: [
            BoxShadow(
              color: const Color(0xffEEC53D).withOpacity(0.35),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: sw * 0.042,
              fontWeight: FontWeight.w700,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── _SocialDivider ───────────────────────────────────────────────────────────

class _SocialDivider extends StatelessWidget {
  final double sw;
  const _SocialDivider({required this.sw});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFE0E0E0))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.03),
          child: Text(
            'او سجل من خلال',
            style: TextStyle(
                fontSize: sw * 0.032, color: const Color(0xFF999999)),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFE0E0E0))),
      ],
    );
  }
}

// ─── _SocialRow ───────────────────────────────────────────────────────────────

class _SocialRow extends StatelessWidget {
  final double sw;
  const _SocialRow({required this.sw});

  @override
  Widget build(BuildContext context) {
    return Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
      GestureDetector(
      onTap: () {
        // Google login
      },
      child: Image.asset(
        'assets/images/google.png',
        width: 26,
      ),
    ),
   SizedBox(width: 20),
    GestureDetector(
      onTap: () {
        // Facebook login
      },
      child: Image.asset(
        'assets/images/facebook.png',
        width: 26,
      ),
    ),
   
  ],
);
  
  }
}

class _SocialBtn extends StatelessWidget {
  final IconData icon;
  final double sw;
  final VoidCallback onTap;

  const _SocialBtn({
    required this.icon,
    required this.sw,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: sw * 0.13,
        height: sw * 0.13,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE0E0E0), width: 1.5),
          color: Colors.white,
        ),
        child: Icon(icon, size: sw * 0.06, color: const Color(0xFF555555)),
      ),
    );
  }
}