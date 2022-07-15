enum ApiUrlPathConstants {
  firebaseAuthMainUrl('https://identitytoolkit.googleapis.com/v1/'),
  signIn('accounts:signInWithPassword'),
  signUp('accounts:signUp'),

  mainUrl('https://bloggy-api.herokuapp.com/'),
  post('posts'),
  comment('comments');

  final String path;
  const ApiUrlPathConstants(this.path);

  String withBaseUrl() {
    return '$mainUrl/$path';
  }

  String withId(int id) {
    return '$path/$id';
  }
}
