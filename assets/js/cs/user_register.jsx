import React from 'react';
import { Form, FormGroup, NavItem, Input, Button } from 'reactstrap';
import { Redirect, withRouter } from 'react-router-dom';
import { connect } from 'react-redux';
import utils from '../util'
import api from '../api';

function UserRegForm(props){
	function update(ev){
		let tgt = $(ev.target);
                let data = {};
                data[tgt.attr('name')] = tgt.val();
                props.dispatch({
                        type: 'NEW_USER_CHANGE',
                        newuser: data,
                });		
	}
	function add_user(){
		if(utils.is_empty(props.newuser.name)){
                        alert("Name is required");
                        return;
                }
		else if(utils.is_empty(props.newuser.phone)){
			alert("Phone is required");
			return;
		}
                else if(utils.is_empty(props.newuser.password) || utils.is_empty(props.newuser.confpass)){
                        alert("Password is required");
                        return;
                }
                else if(props.newuser.password != props.newuser.confpass){
                        alert("The passwords field should match");
                        return;
                }
		api.add_user(props.newuser);
		//return <Redirect to="/" />
		//window.location="/";
	}
	if (props.redirect.can_redirect){
		
		return <Redirect to={utils.clear_redirect(props.redirect.redirect_to)} />
	}
	else	
	return (
   <div className="navbar-text">
    <Form >
      <FormGroup>
        <Input type="text" name="name" placeholder="John Doe"
               value={props.newuser.name} onChange={update} />
      </FormGroup>
      <FormGroup>
        <Input required type="text" name="phone" placeholder="+11234567890"
               value={props.newuser.phone} onChange={update} />
      </FormGroup>

      <FormGroup>
        <Input type="password" name="password" placeholder="your password"
               value={props.newuser.password} onChange={update} />
      </FormGroup>
      <FormGroup>
        <Input type="password" name="confpass" placeholder="re-type your password"
               value={props.newuser.confpass} onChange={update} />
      </FormGroup> 
      <Button onClick={add_user}>Register</Button>
    </Form>
  </div>);
}

function state2props(state){
	return {
		newuser: state.newuser,
		redirect: state.redirect
	};
}

export default withRouter(connect(state2props)(UserRegForm));
