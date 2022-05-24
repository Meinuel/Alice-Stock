  Future updateApi() async {
    String response = '';
    await Future.delayed(const Duration(seconds: 5), () {
      response = 'Ok';
    });
    return response;
  } 