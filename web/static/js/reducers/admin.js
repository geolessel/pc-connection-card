import { combineReducers } from "redux"

function settings(state = {name: ""}, action) {
  switch(action.type) {
  case "UPDATE_NAME":
    return { name: action.name }
  default:
    return state
  }
}

function options(state = [], action) {
  switch(action.type) {
  case "LOAD_OPTIONS":
    return action.options
  case "NEW_OPTION":
    // TODO: actually get a new structure from the api instead of creating one here
    return [...state, {name: "", workflow_id: "", id: ""}]
  case "CREATE_OPTION":
    console.log(action.option)
    return [...state, action.option]
  case "REMOVE_OPTION":
    const newState = state.filter(s => s.id !== action.option.id)
    return newState
  default:
    return state
  }
}

const AdminReducers = combineReducers({
  settings,
  options
})

export default AdminReducers
