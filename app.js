import express from 'express';
import  electricalRouter  from './routes/ElectricalAnalysisRouter.js';
import { jsonErrorMiddleware } from './jsonErrorMiddleware.js';
import cors from 'cors';


const app = express();
const port = 3000;
app.use(cors());

app.use(express.json());

app.use('/electrical_analysis', electricalRouter);


app.use((req, res) => {
  res.status(404).send({ error: 'Ruta no encontrada' })
})

app.listen(port, () => {
  console.log(`La aplicación está escuchando en el puerto ${port}`);
});














