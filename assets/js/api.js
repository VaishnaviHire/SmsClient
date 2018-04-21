import React from 'react';
import {store} from './store';
import utils from './util';
import { Redirect } from 'react-router-dom';


class Server{
	add_user(data){
		$.ajax("/api/v1/users",{
			method:"post",
			dataType:"json",
			contentType:"application/json; charset=UTF-8",
			data: JSON.stringify({user:data}),
			success: (resp) =>{
				console.log("From api add_user", resp, utils.is_empty(resp.errors));
				if(utils.is_empty(resp.errors)){
					store.dispatch({
				  	type:'CLEAR_NEW_USER'
					});
					alert('User added successfully');
					//window.location = "/";
					this.request_tasks();
					this.get_users();		
					utils.redirect("/");
				}
			},
		});
	}
	user_login(login){
		$.ajax("/api/v1/token",{
                        method:"post",
                        dataType:"json",
                        contentType:"application/json; charset=UTF-8",
                        data: JSON.stringify(login),
                        success: (resp) =>{
                                if(utils.is_empty(resp.error)){
                                        store.dispatch({
                                        type:'SET_TOKEN',
					token: resp.token
                                        });
					store.dispatch({
						type: 'LOGIN',
						user: resp.user
					});
					utils.redirect("/");
                                }
				else{
					alert(resp.error);
				}
				store.dispatch({type:'CLEAR_LOGIN'});
                        },
                });

	}
	add_message(data){
		$.ajax("/api/v1/messages",{
                        method:"post",
                        dataType:"json",
                        contentType:"application/json; charset=UTF-8",
                        data: JSON.stringify({message:data}),
                        success: (resp) =>{
				store.dispatch({
                                        type:'CLEAR_MESSAGE'
                                });
				store.dispatch({type:'ADD_MESSAGE', message: resp});
                                alert('Message added successfully');
                                utils.redirect("/");
			}
		});
	
	}
	get_phones(){
		$.ajax("api/v1/phones",{
			method:"get",
			dataType:"json",
			contentType:"application/json; charset=UTF-8",
			success: (resp) =>{
				store.dispatch({
					type:'FETCH_PHONES',
					phones: resp.data
				});
			}
		});
	}
	get_sent_messages(){
                $.ajax("api/v1/messages",{
                        method:"get",
                        dataType:"json",
                        contentType:"application/json; charset=UTF-8",
                        success: (resp) =>{
                                store.dispatch({
                                        type:'FETCH_MESSAGES',
                                        messages: resp.data
                                });
                        }
                });
        }
	get_received_messages(){
                $.ajax("api/v1/receivedmessage",{
                        method:"get",
                        dataType:"json",
                        contentType:"application/json; charset=UTF-8",
                        success: (resp) =>{
                                store.dispatch({
                                        type:'FETCH_RECEIVE',
                                        received_messages: resp.data
                                });
                        }
                });
        }
}

export default new Server();
