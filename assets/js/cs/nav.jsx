import React from 'react';
import { NavLink } from 'react-router-dom';
import { NavItem } from 'reactstrap';
import { connect } from 'react-redux';
import utils from '../util';

function Nav(props){
	if(!utils.is_empty(props.token)){
	return(
    <nav className="navbar navbar-dark bg-dark navbar-expand ">
      <span className="navbar-brand">
        SMS Client
      </span>
      <ul className="navbar-nav mr-auto hide">
        <NavItem>
          <NavLink to="/" exact={true} activeClassName="active" className="nav-link hide">Home</NavLink>
        </NavItem>
        <NavItem>
          <NavLink to="/inbox" href="#" className="nav-link hide">Inbox</NavLink>
        </NavItem>
        <NavItem>
          <NavLink to="/newmessage" href="#" className="nav-link hide">New Message</NavLink>
        </NavItem>
    	<NavItem>
          <NavLink to="/sentmessages" href="#" className="nav-link hide">Sent Messages</NavLink>
        </NavItem>
      </ul>
      <span className="navbar-text hide">
        {props.user.name}
      </span>
	

      <div className = "social drop col-xs-offset-4 col-xs-2 col-sm-offset-7">
        <button type="button" className="ik fa fa-caret-down" data-toggle="collapse" data-target="#navbar-show">
          <span className= "sr-only"></span>
          <span className="icon-bar"></span>
        </button>
      </div>
      
      <!-- collapsed menu -->
      <div id = "navbar-show" className= "collapse">
        <br/>
        <br/>

        <ul className="navbar-nav mr-">
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
      </div>

      <span className="navbar-text">
        <a href="javascript:void(0)" className="nav-link" onClick={() => {utils.logout();utils.redirect("/"); } }>Logout</a>
      </span>
    </nav>

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
