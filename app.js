import express from 'express';
import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

const app = express();
const port = 3000;

dotenv.config();

const db = mysql.createPool({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
    
});


const connectDB = async () => {
    try {
        const connection = await db.getConnection();
        console.log('Conexion exitosa con la base de datos');
        connection.release();
    } catch (error) {
        console.error('Error en la conexion con la base de datos', error);
    }
    
}


app.get('/potenciaActivaDeUnDia', async (req, res) => {
   
    try {
        connectDB();
        const potencias = await getPotencia();
        return res.status(201).json(potencias);

    } catch (error) {
        return res.status(500).json({message: `Error al obtener los datos  ${error.message} `});
     }
    
});

async function getPotencia(){
    let fechaInicio = '2025-03-17 00:00:00';
    let fechaFin = '2025-03-17 23:59:59';

    const [potencias] = await db.query(
        `SELECT 
            id, 
            sensor_id, 
            potencia * corriente * factor_potencia AS potencia_activa
        FROM 
            mediciones 
        WHERE 
            fecha_hora BETWEEN ? AND ?`,
        [fechaInicio, fechaFin]
      );
  
    return potencias;
}

app.get('/energiaConsumida', (req, res) => {
    let potenciaActiva = 220.67 * 5.58 * 0.96;
    let tiempo = 24; // horas
    let energiaConsumida = potenciaActiva * tiempo;
    console.log("La energia consumida es: " + energiaConsumida + " Wh");
});

export const calcEnergia = ({ potenciaW, durationHours = 1 }) => {

    const potenciaKW = potenciaW / 1000; // W → kW
  
    const energía = potenciaKW * durationHours;
  
    return Number(energía.toFixed(3));
  
  };

app.get('/', (req, res) => {
  res.send('¡Hola Mundo desde Express!');
});

app.listen(port, () => {
  console.log(`La aplicación está escuchando en el puerto ${port}`);
});














