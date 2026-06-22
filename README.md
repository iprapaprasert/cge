# File structure
File structure should be:
CGE_MODEL <- root folder, should be name of CGE model such as MINIMAL, ORANIG, ORANI, CRUSOE
```
├───model <- `tab` file should in here
├───command 
│   ├───shock1 <- each command `cmf` file should have a separate folder
│   ├───shock2
│   └───shock3
```

# Run the CGE model in CMD
Open model `.tab` file in model directory. Do the `CHECK` and `TABCODE` to comply the model.

In `shock` folder, open `cmf` file, define the shock. Then, with using TABmate go to File > CMD prompt in current folder. In CMD run this command:
```
..\..\model\[NAME OF TAB FILE WITHOUT EXTENSION] -cmf [์NAME OF CMF FILE WITH EXTENSION]
```
