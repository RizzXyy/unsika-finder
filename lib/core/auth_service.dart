import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static const _allowedDomain = 'student.unsika.ac.id';

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: '179669913661-4fcahrm8kco5284hhiqan58nclhjiefp.apps.googleusercontent.com',
  );

  /// Stream user login state
  static Stream<User?> get userStream => _auth.authStateChanges();

  /// Current user
  static User? get currentUser => _auth.currentUser;

  /// Login dengan email & password (wajib @student.unsika.ac.id)
  static Future<String?> loginWithEmail(String email, String password) async {
    if (!email.trim().endsWith('@$_allowedDomain')) {
      return 'Hanya akun @student.unsika.ac.id yang diizinkan';
    }
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return null; // sukses
    } on FirebaseAuthException catch (e) {
      return _mapError(e.code);
    }
  }

  /// Register dengan email & password (wajib @student.unsika.ac.id)
  static Future<String?> registerWithEmail(String email, String password) async {
    if (!email.trim().endsWith('@$_allowedDomain')) {
      return 'Hanya akun @student.unsika.ac.id yang diizinkan';
    }
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return null; // sukses
    } on FirebaseAuthException catch (e) {
      return _mapError(e.code);
    }
  }

  /// Login dengan Google (wajib @student.unsika.ac.id)
  static Future<String?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return 'Login dibatalkan';

      // Validasi domain
      if (!googleUser.email.endsWith('@$_allowedDomain')) {
        await _googleSignIn.signOut();
        return 'Hanya akun @student.unsika.ac.id yang diizinkan.\n'
            'Akun kamu: ${googleUser.email}';
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      return null; // sukses
    } on FirebaseAuthException catch (e) {
      return _mapError(e.code);
    } catch (e) {
      return 'Terjadi kesalahan: $e';
    }
  }

  /// Logout
  static Future<void> logout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  static String _mapError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Akun tidak ditemukan';
      case 'wrong-password':
        return 'Password salah';
      case 'invalid-credential':
        return 'Email atau password salah';
      case 'email-already-in-use':
        return 'Email sudah terdaftar';
      case 'weak-password':
        return 'Password minimal 6 karakter';
      case 'too-many-requests':
        return 'Terlalu banyak percobaan. Coba lagi nanti';
      default:
        return 'Terjadi kesalahan ($code)';
    }
  }
}
