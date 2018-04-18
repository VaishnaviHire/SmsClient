import React from 'react';
import { Redirect } from 'react-router-dom';
import { Table, Button } from 'reactstrap';
import { connect } from 'react-redux';

function ReceivedMessages(props){
	let messageList = props.received_messages.map((t) => <tr><td>{t.to}</td><td>{t.from}</td><td>{t.body}</td></tr>);
	if(props.redirect.can_redirect)
		return <Redirect to={props.redirect.redirect_to} />
	else
	return(
                <Table>
                        <thead>
                                <tr>
                                        <th>To (number)</th>
					<th>From (number)</th>
                                        <th>Message Body</th>
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
                received_messages: state.received_messages,
		redirect: state.redirect
        };
}

export default connect(state2props)(ReceivedMessages);

