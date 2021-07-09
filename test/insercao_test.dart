import 'package:flutter_test/flutter_test.dart';
import 'package:xpress/database/Motorista.dart';
import 'package:xpress/database/Usuario.dart';
import 'package:xpress/tela_motorista.dart';

void main() {
  test('inserção na tabela de usuários', () {
    final usuario = Usuario(1, 'ana', 12345, 1515, 'admin@admin.com', '64235');
    expect(usuario.email, 'admin@admin.com');
  });

  test('inserção na tabela de motorista', () {
    final motorista = Motoristas(
        1,
        'motorista',
        'motorista@teste.com',
        123456789621,
        412563789,
        40028922,
        'DWS8954',
        'Chevrolet',
        'Vermelho',
        'testeSenhaMotorista#',
        1452369752);
    expect(motorista.nome, 'motorista');
    expect(motorista.senha, 'testeSenhaMotorista#');
  });

  test('VALIDACAO SENHA', () {
    final motorista = Motorista();

    expect(motorista.valida_senha('1234'), false);
  });
  test('VALIDACAO CPF', () {
    final motorista = Motorista();
    expect(motorista.valida_cpf('434'), false);
  });
  test('VALIDACAO TELEFONE', () {
    final motorista = Motorista();

    expect(motorista.valida_telefone('1290000000000'), false);
  });
  test('VALIDACAO CAMPO VAZIO', () {
    final motorista = Motorista();

    expect(
        motorista.valida_vazio('natalia', '', '12992525561', '', '356398259',
            'placa', 'modelo', 'cor', '123456789', '987654321'),
        false);
  });
}
