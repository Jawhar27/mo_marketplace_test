enum Env { dev, qa, beta, prod }

Env currentEnv = Env.dev;

bool isDev = currentEnv == Env.dev;

class ApiEndpoints {
  static String baseUrl = currentEnv == Env.dev ? '' : '';
}
