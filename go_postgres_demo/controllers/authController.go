package controllers

import (
	"GoRestProject/models"
	u "GoRestProject/utils"
	"encoding/json"
	"net/http"
)

var CreateAccount = func(w http.ResponseWriter, r *http.Request) {

	account := &models.Account{}
	err := json.NewDecoder(r.Body).Decode(account) // İstek gövdesi decode edilir, hatalı ise hata döndürülür
	if err != nil {
		u.Respond(w, u.Message(false, "Geçersiz istek. Lütfen kontrol ediniz!"))
		return
	}

	resp := account.Create() // Hesap yaratılır
	u.Respond(w, resp)
}

var Authenticate = func(w http.ResponseWriter, r *http.Request) {

	account := &models.Account{}
	err := json.NewDecoder(r.Body).Decode(account) // İstek gövdesi decode edilir, hatalı ise hata döndürülür
	if err != nil {
		u.Respond(w, u.Message(false, "Geçersiz istek. Lütfen kontrol ediniz!"))
		return
	}

	resp := models.Login(account.Email, account.Password) // Giriş yapılır
	u.Respond(w, resp)
}

var CreateNewStudent = func(w http.ResponseWriter, r *http.Request) {

	student := &models.Students{}
	err := json.NewDecoder(r.Body).Decode(student)
	if err != nil {
		u.Respond(w, u.Message(false, "Geçersiz istek. Lütfen kontrol ediniz!"))
		return
	}
	resp := student.CreateStudent()
	u.Respond(w, resp)
}
