import React from 'react';
import { Redirect } from 'react-router-dom';
import { Table, Button } from 'reactstrap';
import { connect } from 'react-redux';

function SentMessages(props){
	let messageList = props.messages.filter((t) => t.user_id == props.user.id).map((t) => <tr><td>{t.to_number}</td><td>{t.message}</td></tr>);
	if(props.redirect.can_redirect)
		return <Redirect to={props.redirect.redirect_to} />
	else
	return(
		<Table>
			<thead>
				<tr>
					<td>To (number)</td>
					<td>Message Body</td>
				</tr>
			</thead>
			<tbody>
				{ messageList}
			</tbody>
		</Table>
	);
}

function state2props(state){
	return {
		messages: state.messages,
		user: state.user,
		redirect: state.redirect
	};
}

export default connect(state2props)(SentMessages);
//export default SentMessages;
