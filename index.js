const app = require('./app');
const dp = require('./config/db');

const userModel = require('./model/user.model');
const todoModel = require('./model/todo.model')


const port = 3000;

app.get('/',(req,res,next)=>{
    res.send("hello Brother!!!!!...");
});
app.listen(port,()=>{
    console.log(`Server is running this http://localhost:${port}`);
});

