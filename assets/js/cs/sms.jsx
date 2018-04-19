import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import { Provider, connect } from 'react-redux';

import Nav from './nav';
import UserRegForm from './user_register';
import LoginForm from './loginform';
import MessageForm from './message_form';
import api from '../api';
import utils from '../util';
import SentMessages from './sent_messages';
import ReceivedMessages from './received_messages';

export default function sms_init(store) {
	let root = document.getElementById('root');
	ReactDOM.render(
		<Provider store={store}>
		<Sms state={store.getState()}/>
		</Provider>, root);
	api.get_phones();
	api.get_received_messages();
	api.get_sent_messages();
}

//class Sms extends React.Component {
let Sms = connect((state) => state)((props) => {

    let content = <LoginForm />;
    if (!utils.is_empty(props.token)){
		utils.clear_redirect();	
		content = <h1> Welcome to SMS Client, {props.user.name}</h1>;
	}
  
    return (
      <Router>
        <div>
          <Nav />
          <Route path="/" exact={true} render={() => 
            <div>
		<h1>{ content }</h1>
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
        </div>
      </Router>
    );
  
});
