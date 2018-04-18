import React from 'react';
import { Button, Form, FormGroup, Label, Input, FormText, NavItem } from 'reactstrap';
import { Redirect } from 'react-router-dom';
import { connect } from 'react-redux';
import utils from '../util'
import api from '../api';


function MessageForm(props){

	let phones = props.phones.map((uu) => <option key={uu.id} value={uu.phone_number}>{uu.phone_number}</option>);

	function update(ev){
		let tgt = $(ev.target);

    		let data = {};
		data[tgt.attr('name')] = tgt.val();
		data['user_id'] = props.user.id;
		let action = {
      			type: 'NEW_MESSAGE',
      			message: data,
    		};
		props.dispatch(action);
	}


	function submit_message(){
		if(utils.is_empty(props.message.to_number)){
			alert("To (number) is required");
			return;
		}
		else if(utils.is_empty(props.message.message)){
			alert("Messsage Body is required");
			return;
		}
		api.add_message(props.message);
		
	}


	if(props.redirect.can_redirect)
		return <Redirect to={props.redirect.redirect_to} />
	else
		return (<div className="">
				<h1> Send Message </h1>
				<Form>
					<FormGroup>
						<Label for="to_number">To (number)</Label>
						<Input type="select"  name="to_number" id="to_number" value={props.message.to_number} onChange={update} >
						<option value="">Select Sender</option>
						{ phones }
					</Input>
					</FormGroup>
					<FormGroup>
          					<Label for="descr">Message Body</Label>
	          				<Input type="textarea" value={props.message.message} name="message" id="descr" onChange={update}/>
	        			</FormGroup>
					<Input type="hidden" name="user_id" value={props.user.id} />
					<Button onClick={submit_message}>Submit</Button>
				</Form>
			</div>);
}

function state2props(state){
	return {
		message: state.message,
		phones: state.phones,
		user: state.user,
		redirect: state.redirect
	};
}

export default connect(state2props)(MessageForm);
