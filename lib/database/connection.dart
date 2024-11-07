import 'package:dotenv/dotenv.dart';
import 'package:postgres/postgres.dart';

class Connection {
  Connection() {
    assert(poolSize > 0, 'Pool size must be greater than 0');
  }

  final int poolSize = 10;
  final String host = env['host'] as String;
  final int port = int.parse(env['port'].toString());
  final String database = env['database'] as String;
  final String username = env['username'] as String;
  final String password = env['password'] as String;
  final List<PostgreSQLConnection> _connections = [];

  static final DotEnv env = DotEnv()..load();

  Future<void> openConnections() async {
    for (var i = 0; i < poolSize; i++) {
      final connection = PostgreSQLConnection(host, port, database,
          username: username, password: password);
      await connection.open();
      if (connection.isClosed) {
        throw Exception('Connection is closed');
      } else {
        _connections.add(connection);
      }
    }
  }

  PostgreSQLConnection getConnection() {
    if (_connections.isEmpty) {
      throw Exception('Connection pool is empty');
    }
    return _connections.removeLast();
  }

  Future<void> releaseConnection(PostgreSQLConnection connection) async {
    _connections.add(connection);
  }

  Future<void> closeConnections() async {
    for (var connection in _connections) {
      if (!connection.isClosed) {
        await connection.close();
      }
    }
  }
}
