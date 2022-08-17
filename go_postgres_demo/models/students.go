package models

import (
	u "GoRestProject/utils"
	"os"

	"github.com/dgrijalva/jwt-go"
	"github.com/jinzhu/gorm"
)

type Students struct {
	gorm.Model
	Id     string `json:"id"`
	Name   string `json:"name"`
	Result string `json:"result"`
	Token2 string `json:"token";sql:"-"`
}

type Token2 struct {
	UserId   uint
	Username string
	jwt.StandardClaims
}

func (student *Students) CreateStudent() map[string]interface{} {
	tk := &Token{UserId: student.ID}
	token := jwt.NewWithClaims(jwt.GetSigningMethod("HS256"), tk)
	tokenString, _ := token.SignedString([]byte(os.Getenv("token_password")))
	student.Token2 = tokenString
	GetDB().Create(student)
	response := u.Message(true, "Hesap başarıyla yaratıldı!")
	response["student"] = student
	return response
}
