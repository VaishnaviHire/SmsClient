import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import { Provider, connect } from 'react-redux';
import { PersistGate } from 'redux-persist/lib/integration/react'
import {store, persistor} from '../store';
import Nav from './nav';
import NavItem from './nav';
import NavLink from './nav';
import UserRegForm from './user_register';
import LoginForm from './loginform';
import MessageForm from './message_form';
import api from '../api';
import utils from '../util';
import SentMessages from './sent_messages';
import ReceivedMessages from './received_messages';
import { browserHistory } from 'react-router'
import {ReduxRouter, syncHistoryWithStore, routerReducer } from 'react-router-redux'
import PhonebookForm from './phonebook_form'


export default function sms_init() {
  
	let root = document.getElementById('root');

        ReactDOM.render(
		<Provider store={store}>
                  <PersistGate loading={<div />} persistor={persistor}>
		<Sms state={store.getState()}/>
                </PersistGate>
		</Provider>, root);
	api.get_phones();
	api.get_received_messages();
	api.get_sent_messages();
        
}


let Sms = connect((state) => state)((props) => {

   // let content = <LoginForm />;

    if (!utils.is_empty(props.token)){
                
		utils.clear_redirect(); 	

    return (
      <Router >
        <div>
          <Nav />
          <Route path="/" exact={true} render={() => 
            <div>
							<h2> Welcome to SMS Client, {props.user.name}</h2>
            </div>
          } />
	  <Route path="/register" exact={true} render = {() =>
				<UserRegForm />
			}
	  />
	  <Route path="/newmessage" exact={true} render = {() =>
			<MessageForm />
	  }
	  />
	  <Route path="/sentmessages" exact={true} render = {() =>
                        <SentMessages />
          }
          />
  	  <Route path="/inbox" exact={true} render = {() =>
                        <ReceivedMessages />
          }
          />
             <Route path="/phonebook" exact={true} render = {() =>
                        <PhonebookForm />
          }
          />

        </div>
      </Router>
    );
  }

else{

return (<div> 
 
    <nav className="navbar navbar-dark bg-dark navbar-expand">
   <span className="navbar-brand">
        SMSClient
      </span>
        <a href= "/"> <span className="navbar-brand">
        Home
      </span></a>

      <ul className="navbar-nav mr-auto">
           
      </ul>
      <LoginForm />
      
      <span className="navbar-text">
      </span>
    </nav>
  <h2> Welcome to Sms-Client</h2>
  <br />
  <h3> New User? </h3>
  <UserRegForm />
  
 </div>);
}

});
