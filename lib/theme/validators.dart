final isPhoneNumber = RegExp(
  r'^(?:0|(?:\+94))(?:[ ])?(\d{2})(?:[ ])?(\d{7})$',
  multiLine: false,
);

final passwordValidator = RegExp(
  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
  multiLine: false,
);
