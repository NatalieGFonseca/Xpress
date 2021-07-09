class Usuario {
  final int id;
  final String nome;
  final int cpfUsuario;
  final int telefone;
  final String email;
  final String senha;

  Usuario(this.id, this.nome, this.cpfUsuario, this.telefone, this.email,
      this.senha);

  String toString() {
    return 'Usuario{id: $id, nome: $nome, cpf_usuario: $cpfUsuario, telefone: $telefone, email: $email, senha: $senha}';
  }
}
