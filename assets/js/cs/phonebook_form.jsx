import React from 'react';
import { Button, Form, FormGroup, Label, Input, FormText, NavItem } from 'reactstrap';
import { Redirect } from 'react-router-dom';
import { connect } from 'react-redux';
import utils from '../util'
import api from '../api';


function PhonebookForm(props){
        console.log(props)

       // let phones = props.phones.map((uu) => <option key={uu.id} value={uu.phone_number}>{uu.phone_number}</option>);

        function update(ev){
                let tgt = $(ev.target);

                let data = {};
                data[tgt.attr('name')] = tgt.val();
             //  console.log("target", data)
              //  data['user_id'] = props.user.id;
                let action = {
                        type: 'NEW_PHONE',
                        phone: data,
                };
                props.dispatch(action);
        }


        function submit_phone(){
                if(utils.is_empty(props.phone.phone_number)){
                        alert("To (number) is required");
                        return;
                }
                
              api.add_phone(props.phone);

        }


        if(props.redirect.can_redirect)
                return <Redirect to={props.redirect.redirect_to} />
        else
                return (<div className="">
                                <h1> Add Contact Number </h1>
                                <Form>
                                        <FormGroup>
                                                <Label for="phone_number"> Contact Number</Label>
                                                <Input type="text"  name="phone_number" id="phone_number" value={props.phone_number} onChange={update} >
                                               
                                        </Input>
                                        </FormGroup>
                                             
                                       
                                        <Button onClick={submit_phone}>Submit</Button>
                                </Form>
                        </div>);
}

function state2props(state){
       console.log("this is state", state)
        return {
                phone: state.phone,
               
                     
                redirect: state.redirect
        };
}

export default connect(state2props)(PhonebookForm);

