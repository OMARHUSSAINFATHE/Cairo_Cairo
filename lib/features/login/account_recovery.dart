import 'package:cairo_store_1/features/login/verify_otp.dart';
import 'package:cairo_store_1/features/login/widget/input_field.dart';
import 'package:flutter/material.dart';

class AccountRecovery extends StatefulWidget {
  const AccountRecovery({super.key});

  @override
  State<AccountRecovery> createState() => _AccountRecoveryState();
}

class _AccountRecoveryState extends State<AccountRecovery> {
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;
  static const Color kYellow = Color(0xFFFFC107);
  static const Color kGrey   = Color(0xFF999999);
  static const Color kDark   = Color(0xFF1A1A1A);

  @override
  void dispose() {
    _passwordCtrl.dispose();
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
                Text('إستعادة الحساب 🔓',
                    style: TextStyle(
                        fontSize: sw * 0.056,
                        fontWeight: FontWeight.w800,
                        color: kDark)),

                SizedBox(height: sh * 0.012),

                Text(
                  'أدخل كلمة السر الجديده ',
                  style: TextStyle(
                      fontSize: sw * 0.034,
                      color: kGrey,
                      height: 1.6),
                ),

                SizedBox(height: sh * 0.04),

                // ── New password ────────────────────────────────────────
                Text('كلمة السر الجديدة ',
                    style: TextStyle(
                        fontSize: sw * 0.036,
                        fontWeight: FontWeight.w600,
                        color: kDark)),

                SizedBox(height: sh * 0.008),

                 InputField(
                  controller: _passwordCtrl,
                  obscure: _obscure,
                  prefixIcon: IconButton(
                    icon: Icon(
                        _obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: kGrey,
                        size: sw * 0.05),
                    onPressed: () =>
                        setState(() => _obscure = !_obscure),
                  ),
                  sw: sw,
                ),
                SizedBox(height: sh * 0.04),
                Text('تأكيد كلمة السر الجديدة ',
                    style: TextStyle(
                        fontSize: sw * 0.036,
                        fontWeight: FontWeight.w600,
                        color: kDark)),

                SizedBox(height: sh * 0.008),

                 InputField(
                  controller: _passwordCtrl,
                  obscure: _obscure,
                  prefixIcon: IconButton(
                    icon: Icon(
                        _obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: kGrey,
                        size: sw * 0.05),
                    onPressed: () =>
                        setState(() => _obscure = !_obscure),
                  ),
                  sw: sw,
                ),
                
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
                    child: Text('تأكيد',
                        style: TextStyle(
                            fontSize: sw * 0.042,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromARGB(255, 0, 0, 0))),
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