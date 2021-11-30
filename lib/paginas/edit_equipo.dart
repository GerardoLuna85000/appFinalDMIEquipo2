
import 'package:equipo2/modelos/equipo.dart';
import 'package:equipo2/providers/equipo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditEquipo extends StatefulWidget {
  final Equipo? equipo;
  const EditEquipo([this.equipo]);

  @override
  _EditEquipoState createState() => _EditEquipoState();
}

class _EditEquipoState extends State<EditEquipo> {

  final marcaController = TextEditingController();
  final modeloController = TextEditingController();
  final nserieController = TextEditingController();
  final aliasController = TextEditingController();
  final asignadoController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    marcaController.dispose();
    modeloController.dispose();
    nserieController.dispose();
    aliasController.dispose();
    asignadoController.dispose();
    super.dispose();

  }

  @override
  void initState() {
    if (widget.equipo == null){
      //Equipo Nuevo
      marcaController.text = "";
      modeloController.text = "";
      nserieController.text = "";
      aliasController.text = "";
      asignadoController.text = "";
      Future.delayed(Duration.zero, () {
        final equipoProvider = Provider.of<EquipoProvider>(this.context, listen: false); //add this en context
        equipoProvider.loadValues(Equipo());
      });
    } else {
      //update or delete equipo
      marcaController.text = widget.equipo!.marca.toString();
      modeloController.text = widget.equipo!.modelo.toString();
      nserieController.text = widget.equipo!.nserie.toString();
      aliasController.text = widget.equipo!.alias.toString();
      asignadoController.text = widget.equipo!.asignado.toString();
      Future.delayed(Duration.zero, () {
        final equipoProvider =
              Provider.of<EquipoProvider>(this.context, listen: false);  //add this en context
        equipoProvider.loadValues(widget.equipo);
        });
      }
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    final equipoProvider = Provider.of<EquipoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Equipo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: marcaController,
              decoration: InputDecoration(hintText: 'Marca'),
              onChanged: (value) {
                equipoProvider.setMarca(value);
              },
            ),
            TextField(
              controller: modeloController,
              decoration: InputDecoration(hintText: 'Modelo del equipo'),
              onChanged: (value) {
                equipoProvider.setModelo(value);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: nserieController,
              decoration: InputDecoration(hintText: 'No. Serie del equipo'),
              onChanged: (value) {
                equipoProvider.setNserie(value);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: aliasController,
              decoration: InputDecoration(hintText: 'Alias'),
              onChanged: (value) {
                equipoProvider.setAlias(value);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: asignadoController,
              decoration: InputDecoration(hintText: 'Responsable'),
              onChanged: (value) {
                equipoProvider.setAsignado(value);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              child: Text('Guardar'),
              onPressed: () {
                equipoProvider.saveEquipo();
                Navigator.of(context).pop();
              },
            ),
            (widget.equipo != null)
                ? ElevatedButton(
                    child: Text('Eliminar'),
                    onPressed: () {
                      equipoProvider
                          .deleteEquipo(widget.equipo!.equipoId);
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}