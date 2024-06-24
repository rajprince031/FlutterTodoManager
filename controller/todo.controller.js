const ToDoServices = require("../services/todo.services");

exports.createTodo = async (req,res,next)=>{
    try{
    const {userId,title,description} = res.body;

    let todo = await ToDoServices.createTodo(userId,title,description);

    res.json({status:true,success:todo});
    }catch(err){
    console.log("Error in todo.controller");
    next(err);
    }
}

exports.getUserData = async (req,res,next) =>{
    try{
        const {userId} = req.body;
        let todoData = await ToDoServices.getUserData(userId);

        res.json({status:true,success:todoData});
    }catch(err){
        console.log(err);
    }
}