class Arbitro {
  late int idPersona;
  late int idArbitro;
  late String nombre;
  late String primerApellido;
  late String segundoApellido;
  late String fechaNacimiento;
  late String sexo;
  late String telefono;
  late String telefono2;
  late String correo;
  late double costoArbitraje;
  late int idCategoria;
  late int idTipoArbotro;
  late int estatus;

  Arbitro(
      this.idPersona,
      this.idArbitro,
      this.nombre,
      this.primerApellido,
      this.segundoApellido,
      this.fechaNacimiento,
      this.sexo,
      this.telefono,
      this.telefono2,
      this.correo,
      this.costoArbitraje,
      this.idCategoria,
      this.idTipoArbotro,
      this.estatus);
}
