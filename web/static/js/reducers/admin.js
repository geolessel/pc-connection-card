import { combineReducers } from "redux"

function settings(state = {name: ""}, action) {
  switch(action.type) {
  case "UPDATE_NAME":
    return { name: action.name }
  default:
    return state
  }
}

const AdminReducers = combineReducers({
  settings
})

export default AdminReducers
