const express = require('express');
require('dotenv').config();

const clientesRouter = require('./routes/clientes');
const produtosRouter = require('./routes/produtos');
const usuariosRouter = require('./routes/usuarios');
const pedidosRouter = require('./routes/pedidos');

const app = express();


// Permite receber JSON
app.use(express.json());


// Rotas de clientes
app.use('/clientes', clientesRouter);


// Rotas de produtos
app.use('/produtos', produtosRouter);


// Rotas de usuários
app.use('/usuarios', usuariosRouter);


// Rotas de pedidos
app.use('/pedidos', pedidosRouter);


// Rota para verificar se a API está funcionando
app.get('/', (req, res) => {
    res.json({
        mensagem: 'API funcionando!'
    });
});


// Rota não encontrada
app.use((req, res) => {
    res.status(404).json({
        mensagem: 'Rota não encontrada.'
    });
});


// Porta do servidor
const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Servidor rodando na porta ${PORT}`);
});