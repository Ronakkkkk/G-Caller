import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';

final okto = Okto(dotenv.env['CLIENT_API_KEY']!, BuildType.sandbox);
