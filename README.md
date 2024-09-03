# bashlib
A simple but useful single file bash library.

## files

| File             | Description              |
| ---------------- | ------------------------ |
| bashlib.sh       | main lib file            |
| demo.sh          | demo basic usage         |
| script_tpl.sh    | A user script template   |
| config_tpl.sh    | A Config script template |
| test_bashlib.sh  | Test                     |
| test_bashlib2.sh | Test                     |



## demo

```
./demo.sh 
[2024-09-03 03:43:43] [INFO] Starting the demo script...
[2024-09-03 03:43:43] [ERROR] This is an error message.
[2024-09-03 03:43:43] [INFO] Array length: 3
[2024-09-03 03:43:43] [INFO] First element: element1
[2024-09-03 03:43:43] [INFO] Array length after pop: 2
[2024-09-03 03:43:43] [INFO] Value for key1: value1
[2024-09-03 03:43:43] [INFO] All keys: key2 key1
[2024-09-03 03:43:43] [INFO] All values: value2 value1
[2024-09-03 03:43:43] [INFO] Demo script completed.
```

## script_tpl.sh



```
./script_tpl.sh -h
[2024-09-03 06:10:29] [INFO] Starting script...
Usage: ./script_tpl.sh [options]
Options:
  -c, --config <file>    Specify the configuration file
  -l, --log-level <level> Set the log level (DEBUG, INFO, WARN, ERROR)
  -d, --debug            Enable debug mode
  -h, --help             Display this help message
```

use config file:

```
./script_tpl.sh -c config_tpl.sh
[2024-09-03 06:11:41] [INFO] Starting script...
[2024-09-03 06:11:41] [INFO] Loading configuration from config_tpl.sh
hello world
1 2
[2024-09-03 06:11:41] [INFO] Script completed successfully
```

