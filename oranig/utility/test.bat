
REM Build model
    tablo -pgs ORANIG
REM Solve model using GEMSIM: Short-Run closure
    gemsim -cmf ORANIGSR.CMF
    if errorlevel 1 goto err
REM Solve model using GEMSIM: Long-Run closure
    gemsim -cmf ORANIGLR.CMF
    if errorlevel 1 goto err

dir/od *.har
dir/od *.sl4
echo JOB DONE OK
goto endbat
:err
echo ERROR
:endbat