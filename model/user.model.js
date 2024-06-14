const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const db = require('../config/db');
const UserService = require('../services/user.services');

const { Schema } = mongoose;

const userSchema = new Schema({
    email:{
        type :String,
        lowercase:true,
        require:true,
        unique:true,
    },
    password:{
        type:String,
        require:true,
    }
});

userSchema.pre('save',async function(){
    try{
        var user = this;
        const salt = await (bcrypt.genSalt(10));
        const hashPass = await bcrypt.hash(user.password,salt);

        user.password = hashPass;
    }catch(err){
        throw err;
    }
});

userSchema.methods.comparePassword = async function(userPassword){
    try{
        const isMatch = await bcrypt.compare(userPassword,this.password);
        return isMatch;
    }catch(error){
        throw error;
    }
}

const userModel = db.model('user',userSchema);
module.exports = userModel;