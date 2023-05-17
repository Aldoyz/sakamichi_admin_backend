import 'package:dotenv/dotenv.dart';
import 'package:pool/pool.dart';
import 'package:postgres/postgres.dart';
// import 'package:postgres_pool/postgres_pool.dart';

import 'package:sakamichi_admin/utils/constant.dart';

class Connection {
  
  Connection() {
    assert(poolSize > 0, 'Pool size must be greater than 0');
  }
  
  final int poolSize = 10;
  final String host = dbHost;
  final int port = dbPort;
  final String database = env['database'] ?? dbName;
  final String? username = env['username'];
  final String? password = env['password'];
  final List<PostgreSQLConnection> _connections = [];

  static final DotEnv env = DotEnv()..load();

  Future<void> openConnections() async {
    for (var i = 0; i < poolSize; i++) {
      final connection = PostgreSQLConnection(host, port, database,
          username: username, password: password);
      await connection.open();
      _connections.add(connection);
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
      await connection.close();
    }
  }
  // factory Connection() {
  //   _connection = PostgreSQLConnection(
  //     dbHost,
  //     dbPort,
  //     env['database'] ?? dbName,
  //     username: env['username'],
  //     password: env['password'],
  //   );
  //   return _instance;
  // }

  // Connection._();

  // static final Connection _instance = Connection._();

  // static late PostgreSQLConnection _connection;


  // Future<void> _openConnection() async {
  //   if (_connection.isClosed) {
  //     await _connection.open();
  //     print('Database Connected');
  //   }
  // }

  // Future<void> _closeConnection() async {
  //   if (!_connection.isClosed) {
  //     await _connection.close();
  //     print('Database Disconnected');
  //   }
  // }

  // Future<void> get connect => _openConnection();

  // Future<void> get disconnect => _closeConnection();

  // PostgreSQLConnection get getConnection => _connection;
}
