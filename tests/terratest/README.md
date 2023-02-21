# Usage
The go libraries are compiled at the root folder of metric-filter-alarm module with below commands:

```
~/../$ go mod init alarm
~/../$ go mod tidy
```


To run the tests execute the following:

```
~/../terraform-aws-metric-filter-alarm/tests/terratest$ go test -v -timeout 30m alarm_test.go
```
