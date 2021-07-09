class Motoristas {
  final int id;
  final String nome;
  final String email;
  final int cpfMotorista;
  final int rgMotorista;
  final int telefone;
  final String placa;
  final String modelo;
  final String cor;
  final String senha;
  final int cnh;

  Motoristas(
      this.id,
      this.nome,
      this.email,
      this.cpfMotorista,
      this.rgMotorista,
      this.telefone,
      this.placa,
      this.modelo,
      this.cor,
      this.senha,
      this.cnh);

  String toString() {
    return 'Usuario{id: $id, nome: $nome, email:$email, cpf_usuario: $cpfMotorista, rg_usuario: $rgMotorista, telefone: $telefone, placa: $placa, modelo: $modelo, cor:$cor, senha:$senha, cnh:$cnh}';
  }
}
