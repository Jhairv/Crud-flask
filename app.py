from flask import Flask, render_template, request
import psycopg2
from werkzeug.utils import redirect 


conexion = psycopg2.connect(host='localhost',user='postgres',password='1234',database='outter')

cursor = conexion.cursor()

app = Flask(__name__)

@app.route('/', methods=['POST','GET'])
def index():
    if request.method == 'POST':
        cedula=request.form['cedula']
        nombreC=request.form['nombreC']
        dirC=request.form['dirC']
        emailC=request.form['emailC']
        telC=request.form['telC']
        idD=request.form['idD']
        nomD=request.form['nomD']
        dirD=request.form['dirD']
        emailD = request.form['emailD']
        telD = request.form['telD']
        idP = request.form['idP']
        idC = request.form['idC']
        desP = request.form['desP']
        uniP = request.form['uniP']
        pesoP = request.form['pesoP']
        estadoP = request.form['estadoP']
        sql='select InsertIntables (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)'
        values = (cedula, nombreC, dirC, emailC, telC, idD, nomD, dirD, emailD, telD, idP, idC, desP, uniP, pesoP, estadoP)
        cursor.execute(sql, values)
        conexion.commit()
        return redirect('/')
    if request.method == 'GET':
        sql = "select id_paquete, descripcion_paquete, estado_paquete, nom_cliente, nom_destinatario, dir_destinatario, nom_conductor, marca_vehiculo, placa_transporte from paquete as p inner join clientes as cl on p.fk_id_cliente= cl.id_cliente inner join conductores as c on p.fk_id_conductor = c.id_conductor inner join destinatario as d on fk_id_destinatario = d.id_destinatario inner join conductores_transportes as ct on ct.id_conductores = c.id_conductor inner join transportes as t on t.id_transporte = ct.id_transportes where p.estado_paquete = 'Registrado'"
        cursor.execute(sql)
        paquetes = cursor.fetchall()
        conexion.commit()
        return render_template('create.html', paquetes = paquetes)
    return render_template('create.html')

@app.route('/conductores')

def conductores():
    sql = 'select  nom_conductor, marca_vehiculo, placa_transporte, estado from conductores inner join conductores_transportes on id_conductor = id_conductores inner join transportes on id_transportes = id_transporte'
    cursor.execute(sql)
    conductoress = cursor.fetchall()
    conexion.commit()
    return render_template('conductores.html', conductores = conductoress)

@app.route('/enviados')

def enviados():
    sql = "select  id_paquete, descripcion_paquete, estado_paquete, nom_cliente, nom_destinatario, dir_destinatario, nom_conductor, marca_vehiculo, placa_transporte from paquete as p inner join clientes as cl on fk_id_cliente = id_cliente inner join conductores as c on p.fk_id_conductor = c.id_conductor inner join destinatario as d on fk_id_destinatario = d.id_destinatario inner join conductores_transportes as ct on ct.id_conductores = c.id_conductor inner join transportes as t on t.id_transporte = ct.id_transportes where p.estado_paquete = 'Enviado'"
    cursor.execute(sql)
    paquetes = cursor.fetchall()
    conexion.commit()
    return render_template('enviados.html', paquetes = paquetes)

@app.route('/edit/<id>', methods=['GET', 'POST'])
def edit(id):
    sql = "select id_cliente, nom_cliente, dir_cliente, email_cliente, telefono_cliente, id_destinatario, nom_destinatario, dir_destinatario, email_destinatario, telefono_destinatario, id_paquete,descripcion_paquete, unidad_medida,peso_producto, estado_paquete, id_conductor  from clientes as cl  inner join paquete as p on p.fk_id_cliente = cl.id_cliente inner join conductores as c on p.fk_id_conductor = c.id_conductor inner join destinatario as d on p.fk_id_destinatario = d.id_destinatario inner join conductores_transportes as ct on ct.id_conductores = c.id_conductor inner join transportes as t on t.id_transporte = ct.id_transportes where p.id_paquete=%s"
    cursor.execute(sql, id)
    paquetes = cursor.fetchall()
    conexion.commit()
    return render_template('edit.html', paquetes = paquetes)

@app.route('/update', methods=['POST'])
def update():
    _cedula = request.form['cedula']
    _nombreC = request.form['nombreC']
    _dirC = request.form['dirC']
    _emailC = request.form['emailC']
    _telC = request.form['telC']
    _idD = request.form['idD']
    _nomD = request.form['nomD']
    _dirD = request.form['dirD']
    _emailD = request.form['emailD']
    _telD = request.form['telD']
    _idP = request.form['idP']
    _idC = request.form['idC']
    _desP = request.form['desP']
    _uniP = request.form['uniP']
    _pesoP = request.form['pesoP']
    _estadoP = request.form['estadoP']
    sql = 'select updateintables(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)'
    values = (_cedula, _nombreC, _dirC, _emailC, _telC, _idD, _nomD,_dirD, _emailD, _telD, _idP, _idC, _desP, _uniP, _pesoP, _estadoP)
    cursor.execute(sql, values)
    conexion.commit()
    return redirect('/')

@app.route('/destroy/<id>')
def destroy(id):
    cursor.execute('delete from paquete where id_paquete = %s', id)
    conexion.commit()
    return redirect('/')

    
