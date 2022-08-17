package models

import (
	"fmt"

	_ "github.com/lib/pq"

	"github.com/jinzhu/gorm"
	"github.com/joho/godotenv"
)

var db *gorm.DB //database

func init() {

	e := godotenv.Load() //Load .env file
	if e != nil {
		fmt.Print(e)
	}

	// Connection stringi yaratılır
	dbUri := fmt.Sprintf("postgres://ippxwurvsbnhky:0580a59e57041a224dd37033eb2931afd513d218d1ffee7106c3021042d963ad@ec2-52-51-3-22.eu-west-1.compute.amazonaws.com:5432/d6tsas22b6l7p4")

	// Eğer Heroku üzerinde bir PostgreSQL'e sahipseniz, bu ayarlamaları yapmak yerine doğrudan
	// heroku tarafından verilen database url'i kullanabilirsiniz
	// dbUri := fmt.Sprintf("postgres://xxxxx@xxx.compute.amazonaws.com:5432/ddjkb1easq2mec") // Database url

	fmt.Println(dbUri)

	conn, err := gorm.Open("postgres", dbUri)
	if err != nil {
		fmt.Print(err)
	}

	db = conn
	db.Debug().AutoMigrate(&Account{})
	db.Debug().AutoMigrate(&Students{}) //Database migration
}

// returns a handle to the DB object
func GetDB() *gorm.DB {
	return db
}
