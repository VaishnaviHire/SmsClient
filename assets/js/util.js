import store from './store';

class Utils{
	is_empty(val){
		if(val == undefined || val == null || val == "")
			return true;
		return false;
	}
	
	redirect(path){
		let data = {};
		data.can_redirect = true;
		data.redirect_to = path;
		store.dispatch({
			type: 'REDIRECT',
			redir: data
		});
	}
	clear_redirect(path="/"){
		store.dispatch({
			type:'CLEAR_REDIRECT'
		});
		return path;
	}
	logout(){
		store.dispatch({type:"LOGOUT"});
	}
}

export default new Utils();
