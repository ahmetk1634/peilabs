package main

import (
	"database/sql"
	"log"
	"net/http"
)

type Students struct {
	Id     int
	Name   string
	Result int
}

func dbConn() (db *sql.DB) {
	dbDriver := "mysql"
	dbUser := "root"
	dbPass := "123456"
	dbName := "goblog"
	db, err := sql.Open(dbDriver, dbUser+":"+dbPass+"@/"+dbName)
	if err != nil {
		panic(err.Error())
	}
	return db
}

func Index(w http.ResponseWriter, r *http.Request) {
	db := dbConn()
	selDB, err := db.Query("SELECT * FROM Students ORDER BY id DESC")
	if err != nil {
		panic(err.Error())
	}
	emp := Students{}
	res := []Students{}
	for selDB.Next() {
		var id, result int
		var name string
		err = selDB.Scan(&id, &name, &result)
		if err != nil {
			panic(err.Error())
		}
		emp.Id = id
		emp.Name = name
		emp.Result = result
		res = append(res, emp)
	}
	defer db.Close()
}

func Show(w http.ResponseWriter, r *http.Request) {
	db := dbConn()
	nId := r.URL.Query().Get("id")
	selDB, err := db.Query("SELECT * FROM Students WHERE id=?", nId)
	if err != nil {
		panic(err.Error())
	}
	emp := Students{}
	for selDB.Next() {
		var id, result int
		var name string
		err = selDB.Scan(&id, &name, &result)
		if err != nil {
			panic(err.Error())
		}
		emp.Id = id
		emp.Name = name
		emp.Result = result
	}
	defer db.Close()
}

func Edit(w http.ResponseWriter, r *http.Request) {
	db := dbConn()
	nId := r.URL.Query().Get("id")
	selDB, err := db.Query("SELECT * FROM Students WHERE id=?", nId)
	if err != nil {
		panic(err.Error())
	}
	emp := Students{}
	for selDB.Next() {
		var id, result int
		var name string
		err = selDB.Scan(&id, &name, &result)
		if err != nil {
			panic(err.Error())
		}
		emp.Id = id
		emp.Name = name
		emp.Result = result
	}
	defer db.Close()
}

func Insert(w http.ResponseWriter, r *http.Request) {
	db := dbConn()
	if r.Method == "POST" {
		name := r.FormValue("name")
		result := r.FormValue("result")
		insForm, err := db.Prepare("INSERT INTO Students(name, result) VALUES(?,?)")
		if err != nil {
			panic(err.Error())
		}
		insForm.Exec(name, result)
		log.Println("INSERT: Name: " + name + " | Result: " + result)
	}
	defer db.Close()
	http.Redirect(w, r, "/", 301)
}

func Update(w http.ResponseWriter, r *http.Request) {
	db := dbConn()
	if r.Method == "POST" {
		name := r.FormValue("name")
		result := r.FormValue("result")
		id := r.FormValue("uid")
		insForm, err := db.Prepare("UPDATE Students SET name=?, result=? WHERE id=?")
		if err != nil {
			panic(err.Error())
		}
		insForm.Exec(name, result, id)
		log.Println("UPDATE: Name: " + name + " | Result: " + result)
	}
	defer db.Close()
	http.Redirect(w, r, "/", 301)
}

func Delete(w http.ResponseWriter, r *http.Request) {
	db := dbConn()
	emp := r.URL.Query().Get("id")
	delForm, err := db.Prepare("DELETE FROM Students WHERE id=?")
	if err != nil {
		panic(err.Error())
	}
	delForm.Exec(emp)
	log.Println("DELETE")
	defer db.Close()
	http.Redirect(w, r, "/", 301)
}

func main() {
	log.Println("Server started on: http://localhost:8080")
	http.HandleFunc("/", Index)
	http.HandleFunc("/show", Show)
	http.HandleFunc("/edit", Edit)
	http.HandleFunc("/insert", Insert)
	http.HandleFunc("/update", Update)
	http.HandleFunc("/delete", Delete)
	http.ListenAndServe(":8080", nil)
}
