import 'package:cairo_store_1/features/login/account_recovery.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final _otpCtrl = TextEditingController();

  static const Color kYellow = Color(0xFFFFC107);
  static const Color kGrey   = Color(0xFF999999);
  static const Color kDark   = Color(0xFF1A1A1A);

  bool isCompleted = false;
  bool isLoading = false;
  String otpCode = "";

  @override
  void dispose() {
    _otpCtrl.dispose();
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

                /// 🔙 Back Button
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

                /// 🧾 Title
                Text('أدخل الكود 🔐',
                    style: TextStyle(
                        fontSize: sw * 0.056,
                        fontWeight: FontWeight.w800,
                        color: kDark)),

                SizedBox(height: sh * 0.012),

                Text(
                  'تم ارسال الكود الي البريد الالكتروني او رقم الهاتف. ادخل الكود لاستعادة كلمة المرور',
                  style: TextStyle(
                      fontSize: sw * 0.034,
                      color: kGrey,
                      height: 1.6),
                ),

                SizedBox(height: sh * 0.05),

                /// 🔢 PIN INPUTfl
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: _otpCtrl,
                  keyboardType: TextInputType.number,
                  autoDismissKeyboard: true,
                  animationType: AnimationType.fade,

                  textStyle: TextStyle(
                    fontSize: sw * 0.05,
                    fontWeight: FontWeight.bold,
                    color: kDark,
                  ),

                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(12),
                    fieldHeight: sw * 0.14,
                    fieldWidth: sw * 0.12,

                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white,

                    activeColor: kYellow,
                    inactiveColor: const Color(0xFFE0E0E0),
                    selectedColor: kYellow,
                  ),

                  enableActiveFill: true,

                  onChanged: (value) {
                    otpCode = value;
                    setState(() {
                      isCompleted = value.length == 6;
                    });
                  },

                  onCompleted: (value) {
                    otpCode = value;
                  },
                ),

                SizedBox(height: sh * 0.05),

                /// 🚀 Verify Button
                GestureDetector(
                  onTap: isCompleted && !isLoading
                      ? () async {
                          setState(() => isLoading = true);

                          /// 🔗 هنا تحط API
                          await Future.delayed(const Duration(seconds: 2));

                          setState(() => isLoading = false);

                          if (otpCode == "123456") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const AccountRecovery(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("الكود غير صحيح ❌")),
                            );
                          }
                        }
                      : null,

                  child: Container(
                    width: double.infinity,
                    height: sh * 0.065,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? kYellow
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white)
                        : Text(
                            'تأكيد الكود',
                            style: TextStyle(
                              fontSize: sw * 0.042,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),

                SizedBox(height: sh * 0.02),

                /// 🔁 Resend Code
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('لم تستلم الكود ؟',
                          style: TextStyle(
                              fontSize: sw * 0.032,
                              color: kGrey)),
                      SizedBox(width: sw * 0.02),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("تم إعادة إرسال الكود 📩")),
                          );
                        },
                        child: Text('إعادة ارسال الكود',
                            style: TextStyle(
                                fontSize: sw * 0.032,
                                color: Color(0xff264AA6),
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}