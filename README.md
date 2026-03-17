# File structure
File structure should be:
CGE_MODEL <- root folder, should be name of CGE model such as MINIMAL, ORANIG, ORANI, CRUSOE
```
├───model <- `tab` file should in here
├───shock 
│   ├───shock1 <- each shock `cmf` file should have a separate folder
│   ├───shock2
│   └───shock3
```

# Run the CGE model in CMD
Open model `.tab` file in model directory. Do the `TABSTI` to comply the model
In `shockn` folder, open `cmf` file, define the shock. Then, with using TABmate go to File > CMD prompt in current folder. In CMD run this command:
```
..\model\[NAME OF TAB FILE WITHOUT EXTENSION] -cmf [์NAME OF CMF FILE WITHOUT EXTENSION]
```
