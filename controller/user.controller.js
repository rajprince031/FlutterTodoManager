const UserService = require ('../services/user.services')

exports.register = async(req,res,next)=>{
    try{
        const {email,password} = req.body;

        const successRes = await UserService.registerUser(email,password);
        
        res.json({status:true,success:"User Registeration successfully"});
    }catch(err){
        throw err;
    }
}

exports.login = async (req,res,next)=>{
    try{
        const{email,password} = req.body;
        const user = await UserService.checkUser(email);

        if(!user){
            throw new Error("User doesn't exist");
        }

        const isMatch = await user.comparePassword(password);

        if(!isMatch){
             throw new Error("Password was Incorrect");
        }
        let tokenData = {_id:user._id,email:user.email};
        const token = await UserService.generateToken(tokenData,"secretKey",'1h');
        res.status(200).json({status:true,token:token});

    }catch(error){
        throw error;
    }
}