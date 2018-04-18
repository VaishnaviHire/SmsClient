import React from 'react';
import { Form, FormGroup, NavItem, Input, Button } from 'reactstrap';
import { connect } from 'react-redux';
import api from '../api';

function LoginForm(props){
	//function update(ev) {
		/*
		let tgt = $(ev.target)
		let logindata = {}
		logindata[tgt.attr('name')]=*/
	function create_token(ev){
		console.log('login');
		api.user_login(props.login);
	}
	function update(ev){
		let tgt = $(ev.target);
    		let data = {};
	    	data[tgt.attr('name')] = tgt.val();
    		props.dispatch({
      			type: 'USER_LOGIN',
      			logindata: data,
    		});
	
	}
	console.log(props);
		return (<div className="navbar-text">
    <Form inline>
      <FormGroup>
        <Input type="text" name="name" placeholder="name or phone"
               value={props.login.name} onChange={update} />
      </FormGroup>
      <FormGroup>
        <Input type="password" name="pass" placeholder="password"
               value={props.login.pass} onChange={update} />
      </FormGroup>
      <Button onClick={create_token}>Log In</Button>
    </Form>
  </div>);
}
//);

function state2props(state) {
  return {
    login: state.login
  };
}

export default connect(state2props)(LoginForm);
