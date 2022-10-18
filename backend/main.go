package main

import (
	"database/sql"
	"fmt"
	"net/http"
	"os"
	_ "strconv"
	_ "strings"

	"github.com/joho/godotenv"

	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
)

var db *sql.DB

func GetDatabase() *sql.DB {
	err := godotenv.Load()
	if err != nil {
		fmt.Println(err)
	}

	url := os.Getenv("URL")

	db, err := sql.Open("mysql", url)
	if err != nil {
		panic(err)
	} else {
		fmt.Println("Database connected")
	}
	return db
}

type User struct {
	User_name   string
	Created_at  string
	Updated_at  string
	Sotek_count int
	Id          int64
	Clicks      int
}

func main() {
	db = GetDatabase()

	router := gin.Default()
	router.SetTrustedProxies(nil)

	router.GET("/", HomeHandler)
	router.GET("/users", GetUsers)
	router.GET("/getUser", GetUser)
	router.GET("/create", Create)
	router.GET("/addSotek", AddSotek)
	router.GET("/addScore", AddScore)
	//router.POST("/products", CreateProduct)

	// Run the router
	//port := os.Getenv("PORT")
	//router.Run("0.0.0.0:" + port)
	router.Run()

}
func HomeHandler(c *gin.Context) {

	c.String(http.StatusOK, "AAAAAAAAAAAAAAAAAAAAAAAAAAAaa")
}
func GetUsers(c *gin.Context) {

	query := "SELECT * FROM leaderboard"

	res, err := db.QueryContext(c, query)
	fmt.Println(res)
	defer res.Close()
	if err != nil {
		fmt.Println("(GetUsers) db.Query", err)
	}
	users := []User{}
	for res.Next() {
		var user User
		err := res.Scan(&user.Id, &user.User_name, &user.Clicks, &user.Sotek_count, &user.Created_at, &user.Updated_at)
		if err != nil {
			fmt.Println("(GetProducts) res.Scan", err)
		}
		users = append(users, user)
	}

	c.JSON(http.StatusOK, users)
}

func Create(c *gin.Context) {

	username := c.Query("username")
	clicks := c.Query("clicks")

	// This query has multiple `?` parameter placeholders
	query := `INSERT INTO leaderboard (user_name, clicks) VALUES (?, ?)`
	// The `Exec` function takes in a query, as well as the values for
	//     the parameters in the order they are defined
	_, err := db.Exec(query, username, clicks)
	if err != nil {
		fmt.Println("(CreateProduct) db.Exec", err)
	}

	c.JSON(http.StatusOK, "JO")
}

func AddSotek(c *gin.Context) {

	username := c.Query("username")

	query := "SELECT * FROM leaderboard WHERE user_name=?"

	res := db.QueryRow(query, username)
	var user User
	err := res.Scan(&user.Id, &user.User_name, &user.Clicks, &user.Sotek_count, &user.Created_at, &user.Updated_at)
	if err != nil {
		fmt.Println("(AddSotek) res.Scan", err)
	}

	query2 := "UPDATE leaderboard SET sotek_count=? WHERE user_name=?"
	_, err = db.Exec(query2, user.Sotek_count+1, username)
	if err != nil {
		fmt.Println("(AddSotek) db.Exec", err)
	}

	c.JSON(http.StatusOK, "JO")
}
func AddScore(c *gin.Context) {

	username := c.Query("username")
	clicks := c.Query("clicks")

	query := "SELECT * FROM leaderboard WHERE user_name=?"

	res := db.QueryRow(query, username)
	if res.Err() != nil {
		query2 := `INSERT INTO leaderboard (user_name, clicks) VALUES (?, ?)`
		// The `Exec` function takes in a query, as well as the values for
		//     the parameters in the order they are defined
		_, err := db.Exec(query2, username, clicks)
		if err != nil {
			fmt.Println("(CreateProduct) db.Exec", err)
		}
		c.JSON(http.StatusOK, "JO")

	} else {
		query3 := "UPDATE leaderboard SET clicks=? WHERE user_name=?"
		_, err := db.Exec(query3, clicks, username)
		if err != nil {
			fmt.Println("(AddScore) db.Exec", err)
		}

		c.JSON(http.StatusOK, "JO")
	}
}
func GetUser(c *gin.Context) {

	username := c.Query("username")

	query := "SELECT * FROM leaderboard WHERE user_name=?"

	res := db.QueryRow(query, username)
	var user User
	err := res.Scan(&user.Id, &user.User_name, &user.Clicks, &user.Sotek_count, &user.Created_at, &user.Updated_at)
	if err != nil {
		fmt.Println("(GetUser) res.Scan", err)
	}

	c.JSON(http.StatusOK, user)
}
