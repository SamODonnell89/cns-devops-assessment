package main

import (
    "fmt"
    "net/http"
    "os"
    "time"
)

func main() {
    serviceURL := os.Getenv("SERVICE_URL")
    if serviceURL == "" {
        fmt.Println("SERVICE_URL environment variable is not set")
        os.Exit(1)
    }

    maxClockDiff := time.Second

    resp, err := http.Get(serviceURL)
    if err != nil {
        fmt.Printf("Error checking service: %v\n", err)
        os.Exit(1)
    }
    defer resp.Body.Close()

    if resp.StatusCode != http.StatusOK {
        fmt.Printf("Service is not responding with OK status\n")
        os.Exit(1)
    }

    serverTime := resp.Header.Get("Date")
    if serverTime == "" {
        fmt.Println("Server did not provide a Date header")
        os.Exit(1)
    }

    serverTimeParsed, err := time.Parse(time.RFC1123, serverTime)
    if err != nil {
        fmt.Printf("Error parsing server time: %v\n", err)
        os.Exit(1)
    }

    clockDiff := time.Now().Sub(serverTimeParsed)
    if clockDiff < 0 {
        clockDiff = -clockDiff
    }

    if clockDiff > maxClockDiff {
        fmt.Printf("Clock desynchronized by more than %v\n", maxClockDiff)
        os.Exit(1)
    }

    fmt.Println("Service is up and clock is synchronized")
}