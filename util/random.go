package util

import (
	"math/rand"
	"strings"
	"time"
)

const (
	alphabet = "abcdefghijklmnopqrstuvwxyz"
)

func init() {
	rand.Seed(time.Now().UnixNano())
}

func RandInt64(min, max int64) int64 {
	return min + rand.Int63n(max-min+1) //rand.Int63()
}

func RandomString(n int) string {
	var b strings.Builder
	for i := 0; i < n; i++ {
		b.WriteByte(alphabet[rand.Intn(len(alphabet))])
	}
	return b.String()
}

func RandomOwner() string {
	return RandomString(6)
}

func RandomMoney() int64 {
	return RandInt64(0, 1000)
}

func RandomCurrency() string {
	currencies := []string{"EUR", "USD", "CAD"}
	k := len(currencies)
	return currencies[rand.Intn(k)]
}

func RandomEmail() string {
	return RandomString(6) + "@example.com"
}
