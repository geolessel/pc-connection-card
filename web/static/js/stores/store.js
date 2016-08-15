import { createStore } from "redux"
import AdminReducers from "../reducers/admin"
const store = createStore(AdminReducers)
module.exports = { store }
