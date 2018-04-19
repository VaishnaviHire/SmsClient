import React from 'react';
import { NavLink } from 'react-router-dom';
import { NavItem } from 'reactstrap';
import { connect } from 'react-redux';
import utils from '../util';

function Nav(props){
	if(!utils.is_empty(props.token)){
	return(
		<nav className="navbar navbar-dark bg-dark navbar-expand mainbar">
      <span className="navbar-brand">
        SMS Client
      </span>
      <ul className="navbar-nav mr-auto">
        <NavItem>
          <NavLink to="/" exact={true} activeClassName="active" className="nav-link">Home</NavLink>
        </NavItem>
        <NavItem>
          <NavLink to="/inbox" href="#" className="nav-link">Inbox</NavLink>
        </NavItem>
        <NavItem>
          <NavLink to="/newmessage" href="#" className="nav-link">New Message</NavLink>
        </NavItem>
    	<NavItem>
          <NavLink to="/sentmessages" href="#" className="nav-link">Sent Messages</NavLink>
        </NavItem>
      </ul>
      <span className="navbar-text username">
                {props.user.name}
        </span>

      <span className="navbar-text">
	<a href="javascript:void(0)" className="nav-link" onClick={() => {utils.logout();utils.redirect("/"); } }>Logout</a>
      </span>
    </nav>


	 <!-- menu button for phones -->
           <div class = "social drop col-xs-offset-4 col-xs-2 col-sm-offset-7">
             <button type="button" class="ik fa fa-caret-down" data-toggle="collapse" data-target="#navbar">
                <span class= "sr-only"></span>
                <span class="icon-bar"></span>
             </button>
           </div>

           <!-- collapsed menu -->
             <div id = "navbar" class= "collapse">
                  <br/>
                  <br/>
    <nav className="navbar navbar-dark bg-dark navbar-expand mainbar">
      <span className="navbar-brand">
        SMS Client
      </span>
      <ul className="navbar-nav mr-auto">
        <NavItem>
          <NavLink to="/" exact={true} activeClassName="active" className="nav-link">Home</NavLink>
        </NavItem>
        <NavItem>
          <NavLink to="/inbox" href="#" className="nav-link">Inbox</NavLink>
        </NavItem>
        <NavItem>
          <NavLink to="/newmessage" href="#" className="nav-link">New Message</NavLink>
        </NavItem>
        <NavItem>
          <NavLink to="/sentmessages" href="#" className="nav-link">Sent Messages</NavLink>
        </NavItem>
      </ul>
      <span className="navbar-text username">
                {props.user.name}
        </span>

      <span className="navbar-text">
        <a href="javascript:void(0)" className="nav-link" onClick={() => {utils.logout();utils.redirect("/"); } }>Logout</a>
      </span>
    </nav>

            </div>
	);
	}
	return (
    <nav className="navbar navbar-dark bg-dark navbar-expand">
      <span className="navbar-brand">
        SMS Client
      </span>
      <ul className="navbar-nav mr-auto">
        <NavItem>
          <NavLink to="/" exact={true} activeClassName="active" className="nav-link">Home</NavLink>
        </NavItem>
        <NavItem>
          <NavLink to="/register" href="#" className="nav-link">Register</NavLink>
        </NavItem>
      </ul>
      <span className="navbar-text">
      </span>
    </nav>
  );
}

function state2props(state){
	return {
		token: state.token,
		user: state.user
	};
}

export default connect(state2props)(Nav);
