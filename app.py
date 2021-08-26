from flask import Flask, render_template
import psycopg2 


conexion = psycopg2.connect(host='localhost',user='postgres',password='1234',database='CRUD')

cursor = conexion.cursor()

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('create.html')

@app.route('/conductores')

def conductores():
    sql = 'select id_conductor, nom_conductor, num_licencia,  id_transporte, marca_vehiculo, placa_transporte from conductores as c inner join conductores_transportes as ct on c.id_conductor = ct.id_conductores inner join transportes as t on t.id_transporte = ct.id_transportes'
    cursor.execute(sql)
    conductoress = cursor.fetchall()
    conexion.commit()
    return render_template('conductores.html', conductores = conductoress)


