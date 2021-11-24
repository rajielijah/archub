import 'package:archub/provider/job_provider.dart';
import 'package:archub/provider/user_post.dart';
import 'package:archub/screen/authentication/forget_password.dart';
import 'package:archub/screen/authentication/reset_password.dart';
import 'package:archub/screen/authentication/signup.dart';
import 'package:archub/screen/dashboard/dashboard.dart';
// import 'packa ge:archub/screen/authentication/reset_password.dart';
// import 'package:archub/screen/authentication/signup.dart';
// import 'package:archub/screen/authentication/verifyToken.dart';
// import 'package:archub/screen/dashboard/Account/account_setting.dart';
// import 'package:archub/screen/dashboard/Account/profile.dart';
// import 'package:archub/screen/dashboard/Account/reset_password.dart';
// import 'package:archub/screen/dashboard/Notification/notification_screen.dart';
// import 'package:archub/screen/dashboard/SocialMedia/social_media.dart';
// import 'package:archub/screen/dashboard/about.dart';
// import 'package:archub/screen/dashboard/dashboard.dart';
// import 'package:archub/screen/dashboard/home/report_post.dart';
// import 'package:archub/screen/dashboard/home/storeView/storePage.dart';
// import 'package:archub/screen/dashboard/home/widget/info_detail.dart';
// import 'package:archub/screen/dashboard/home/widget/post_detail.dart';
// import 'package:archub/screen/dashboard/job/job.dart';
// import 'package:archub/screen/dashboard/job/job2.dart';
// import 'package:archub/screen/dashboard/job/widget/job_widget.dart';
// import 'package:archub/screen/dashboard/notification%20copy/notifications_screen.dart';
// import 'package:archub/screen/dashboard/post/post.dart';
// import 'package:archub/screen/splashscreen1.dart';
import 'package:archub/splashcreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'constant.dart';
import 'provider/auth.dart';
import 'screen/authentication/login.dart';
// import 'screen/dashboard/Account/edit_profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) {
            return Auth();
          },
        ),
        ChangeNotifierProvider(
          create: (ctx) {
            return UserPost();
          },
        ),
        ChangeNotifierProvider(
          create: (ctx) {
            return JobProvider();
          },
        ),
      ],
      child: Consumer<Auth>(builder: (ctx, auth, _) {
        return GetMaterialApp(
          title: 'Archub',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: auth.isAuth == true
              ? Dashboard(0)
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapShot) =>
                      authResultSnapShot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : LoginScreen()),
          routes: {
            kLoginScreen: (ctx) => LoginScreen(),
            KSignUpScreen: (ctx) => SignUpScreen(),
            KDashboard: (ctx) => Dashboard(0),
            // KPostDetail: (ctx) => PostDetail(),
            // KJobWidget: (ctx) => JobWidget(),
            // KInfoDetail: (ctx) => InfoDetail(),
            // KNotificationScreeen: (ctx) => NotificationScreeen(),
            // KAccountSetting: (ctx) => AccountSetting(),
            // KSocailMedia: (ctx) => SocailMedia(),
            // KPostScreen: (ctx) => PostScreen(),
            // KJobScreen: (ctx) => JobScreen(),
            // KVerification: (ctx) => VerificationScreen(),
            // KSplash2: (ctx) => Splash2Screen(),
            KForgetpassScreen: (ctx) => ForgetpassScreen(),
            // kAboutScreen: (ctx) => AboutScreen(),
            // KEditProfile: (ctx) => EditProfile(),
            // KResetPasswordScreen: (ctx) => ResetPasswordScreen(),
            // KProfileScreen: (ctx) => ProfileScreen(),
            // KJobApplication: (ctx) => JobApplication(),
            // KNotificationsScreen: (ctx) => NotificationsScreen(),
            // KReportPort: (ctx) => ReportPort(),
            KResetPasswordScreens: (ctx) => ResetPasswordScreens(),
          },
        );
      }),
    );
  }
}
