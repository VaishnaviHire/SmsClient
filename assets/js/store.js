import { createStore, combineReducers, compose } from 'redux';
import deepFreeze from 'deep-freeze';
import { persistStore, persistReducer } from 'redux-persist'
import storage from 'redux-persist/lib/storage'
import { syncHistoryWithStore, routerReducer } from 'react-router-redux'
import { browserHistory } from 'react-router'


function messages(state=[], action){
	switch(action.type){
		case 'FETCH_MESSAGES':
			return Object.assign([], state, action.messages);
		default:
			return state;
	}
}

function received_messages(state=[], action){
        switch(action.type){
                case 'FETCH_RECEIVE':
                        return Object.assign([], state, action.received_messages);
                default:
                        return state;
        }
}


function phones(state=[], action){
	switch(action.type){
		case 'FETCH_PHONES':
			return action.phones;
		default:
			return state;
	}
}

function user(state={}, action){
	switch(action.type){
		case 'LOGIN':
			return action.user;
		case 'LOGOUT':
			return {}
		default:
			return state;
	}
}


function token(state=null, action){
	switch(action.type){
		case 'SET_TOKEN':
			return action.token;
		case 'LOGOUT':
			return null;
		default:
			return state;
	}
}

let loginState = {
	name:"",
	pass: "",
	err:""
};

function login(state = loginState, action){
	switch(action.type){
		case 'USER_LOGIN':
			return Object.assign({}, state, action.logindata);
		case 'CLEAR_LOGIN':
			return loginState;
	default:
		return state;
	}
}

let newuserobj = {
	name:"",
	password:"",
	confpass:"",
	phone:""
};

function newuser(state = newuserobj, action){
	switch(action.type){
		case 'NEW_USER_CHANGE':
			return Object.assign({}, state, action.newuser);
		case 'CLEAR_NEW_USER':
			return newuserobj;
		default:
			return state;
	}
}

let redirObj = {
	redirect_to: null,
	can_redirect: false
};
function redirect(state=redirObj, action){
	switch(action.type){
		case 'REDIRECT':
			return Object.assign({}, state, action.redir)
		case 'CLEAR_REDIRECT':
			return redirObj;
		default:
			return state;
	}
}


let newMessageObj = {
	to_number:"",
	message:"",
	user_id:"",
	user:{
		id:undefined
	},
	id:-1
}

function message(state=newMessageObj, action){
	switch(action.type){
		case 'NEW_MESSAGE':
			return Object.assign({}, state, action.message);
		case 'CLEAR_MESSAGE':
			return newMessageObj;
		default:
			return state;
	}
}

let newPhoneObj = {
  phone_number: "",
}



function phone(state=newPhoneObj, action){
        switch(action.type){
                case 'NEW_PHONE':
                        return Object.assign({}, state, action.phone);
                case 'CLEAR_PHONE':
                        return newPhoneObj;
                default:
                        return state;
        }
}

function root_reducer(state0, action){
	console.log("out state",state0);
	let reducer = combineReducers({messages, user, token, login, newuser, redirect, message, phones, received_messages, phone});
	let state1 = reducer(state0, action);
	console.log("After update", state1);
        return state1;
//	return deepFreeze(state1);
}

const persistconfig = {
  key: 'root',
  storage,
};

console.log("config", persistconfig)

const persistedReducer = persistReducer(persistconfig, root_reducer);
console.log("persisted-reducer", persistedReducer)


//attribution : redux-persist package and docs
//https://github.com/rt2zz/redux-persist
// This package is used to make states persistent. It uses localStorage function to store the states

export const store = createStore(persistedReducer);
export const persistor = persistStore(store);

