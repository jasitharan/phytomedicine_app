import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phytomedicine_app/models/auth_model.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Auth? _userFromFirebaseUser(User? user) {
    return user != null ? Auth(uid: user.uid, email: user.email!) : null;
  }

  // auth change user  stream
  Stream<Auth?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await user?.updateDisplayName(name);
      return _userFromFirebaseUser(user);
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      User? user = _auth.currentUser;

      if (user!.providerData[0].providerId == 'google.com') {
        await _googleSignIn.disconnect();
      }

      await _auth.signOut();

      return 1;
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  Future signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      var result = await _auth.signInWithCredential(credential);
      User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      // print(e.message);
      return null;
    }
  }

  // sign in with email and password
  Future forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 1;
    } catch (e) {
      //  print(e.toString());
      return null;
    }
  }

  Future changeEmail(
      {required String oldEmail,
      required String newEmail,
      required String password}) async {
    try {
      User? user = _auth.currentUser;
      final authResult = await user?.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: oldEmail, password: password),
      );
      await authResult?.user?.updateEmail(newEmail);
      return _userFromFirebaseUser(authResult?.user);
    } catch (e) {
      return e.toString().split('] ').last;
    }
  }

  Future changePassword(
      {required String email,
      required String oldPassword,
      required String newPassword}) async {
    try {
      User? user = _auth.currentUser;
      final authResult = await user?.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: email, password: oldPassword),
      );
      await authResult?.user?.updatePassword(newPassword);
      return _userFromFirebaseUser(authResult?.user);
    } catch (e) {
      return e.toString().split('] ').last;
    }
  }

  Future<User?> signInWithApple({List<Scope> scopes = const []}) async {
    // 1. perform the sign-in request
    final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential!;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken!),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode!),
        );
        final userCredential = await _auth.signInWithCredential(credential);
        final firebaseUser = userCredential.user!;
        if (scopes.contains(Scope.fullName)) {
          final fullName = appleIdCredential.fullName;
          if (fullName != null &&
              fullName.givenName != null &&
              fullName.familyName != null) {
            final displayName = '${fullName.givenName} ${fullName.familyName}';
            await firebaseUser.updateDisplayName(displayName);
          }
        }
        return firebaseUser;
      case AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        return null;
      default:
        return null;
    }
  }
}
