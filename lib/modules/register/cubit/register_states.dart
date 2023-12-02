abstract class RegisterStates{}

class RegisterInitialStates extends RegisterStates{}

class RegisterSuccessStates extends RegisterStates{}

class RegisterLodingStates extends RegisterStates{}

class RegisterErrorStates extends RegisterStates{
  final String error;
  RegisterErrorStates({required this.error});

}

class RegisterChangeVisibilityStates extends RegisterStates{}

class RegisterCreateErrorStates extends RegisterStates{}

class RegisterCreateSuccessStates extends RegisterStates{}