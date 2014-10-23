library('RUnit')

source('cachematrix.R')

test.suite <- defineTestSuite("cachematrix",
                              dirs = file.path("."))

test.result <- runTestSuite(test.suite)

printTextProtocol(test.result)