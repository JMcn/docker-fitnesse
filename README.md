# docker-fitnesse
docker wrapper for fitnesse, wit ability to run specific tests

```
docker run -ti -v $(pwd)/example:/opt/fitnesse/FitNesseRoot/FitNesse/ex  -v $(pwd)/dummyTest:/opt/fitnesse/testFiles --env TEST_PATH=/opt/fitnesse/testFiles/target otaykalo/befit:v1  -c "FitNesse.ex?test&format=text"
```

