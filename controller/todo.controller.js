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

exports.getUserData = async (req,res) =>{
    try{
        const userId = req.query;

        // console.log("I am trying to print userId",userId);
        let todoData = await ToDoServices.getToDoData(userId);
        // console.log('i am at the backend buddy');
        // console.log(`Todos fetched: ${todoData}`);//debug line
        if(todoData.length > 0) {
            // console.log("My length is greater than zero");
            res.json({status:true,success:todoData});
        }else{
            // console.log("My length is zero");
            res.status(404).json({status:true,success:[]});
        }

        
    }catch(err){
        console.error(`Error fetching todos: ${err.message}`); // Debug line
        res.status(500).json({ status: false, message: err.message });
    }
}