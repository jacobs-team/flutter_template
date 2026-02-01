/// Environment values provided at build/run time.
///
/// See  `launch.json` which injects `env.json`
abstract class EnvironmentConfig {
  /// Base URL for the API.
  static const apiDomain = String.fromEnvironment(
    'API_DOMAIN',
    defaultValue: 'https://coffee.alexflipnote.dev',
  );
}
