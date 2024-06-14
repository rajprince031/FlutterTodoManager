const ToDoServices = require("../services/todo.services");

exports.createTodo = async (req,res,next)=>{
    try{
    const {userId,title,description} = req.body;

    let todo = await ToDoServices.createTodo(userId,title,description);

    res.json({status:true,success:todo});
    }catch(err){
    console.log("Error in todo.controller");
    next(err);
    }
}