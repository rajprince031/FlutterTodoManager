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

exports.deleteItem = async (req,res) => {
    try{
    const {Id} = req.params;
    console.log("Hello, I  am backend I am going to print id :- ",Id);

    let response = await ToDoServices.deleteToDoItem(Id);
    console.log("Printing the response for deletiing item ",response);

    if(response) res.status(200).json({status:true,message:'Item deleted successfully'});

    else res.status(404).json({status:false,message:'item not found'});  
    
    }catch(error){
        res.status(500).json({status:false,message:`error while deleting the item ${error}`});
    }
}

exports.updateItem = async (req,res) =>{
    const item = req.body;
    const {Id}= req.params;
    try{
        console.log("I am backend updating department :- ", item);
        console.log("I am backend updating department printing Id:- ", Id);
        let response = await ToDoServices.updateToDoItem(Id,item);
        console.log("printing response that are come from DB--->",response);
        if(response) res.status(200).json({status:true,message:'item updated successfully'});
        else res.send(404).json({status:false,message:"error while try to update the item on DB"});
    }catch(err){
        console.log("I am printing the error :- ",err);
    }

  
}

exports.checkMark = async (req,res) => {
    const item = req.body;
    const {Id} = req.params;
    try{
        let response = await ToDoServices.checkMarkDB(Id,item.taskStatus);
        if(response) res.statusCode(200).json({status:true,message:'item mark as complete'});
        else res.send(404).json({status:false,message:'error while trying to mark the task'});
    }catch(error){
        console.log('error in check mark :- ',error);
    }
}