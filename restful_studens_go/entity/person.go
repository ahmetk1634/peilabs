package entity

// Person object for REST(CRUD)
type Person struct {
	ID        int    `json:"id"`
	FirstName string `json:"firstName"`
	LastName  string `json:"lastName"`
	Note      int    `json:"note"`
}
