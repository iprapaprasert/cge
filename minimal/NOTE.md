# Notes on MINIMAL model

## Set
IO table columns refers to `USER`, which can be divided into 2 types of `USER`---`IND` and `FINALUSER`. By the way, we also defined `IMPUSER` which is a subset of `USER`, where `IMPUSER` refers to industry that cannot import commodities (`IND` + All `FINALUSER` except Export (Export industry cannot reexport)) 

IO table rows can be divided into two inputs---`COM` which can be classified by source of commodities `SRC` and `FAC` which is the primary factor

In summary,

| Set | Dimension | Description |
| :--- | :---: | :---: |
| Column | 
| `IND` | 7 | Industry, `IND` $\subset$ `IMPUSER` |
| `FINALUSER` | 4 | Final User |
| `USER` | 7+4=11 | `IND` $\cup$ `FINALUSER` |
| `IMPUSER` | 6 | `IND` $\cup$ (`FINALUSER` - {"Exports"})    |
| `




## Coefficients
First, the input of the model comes from only input-output table. Note that we values the commodity flows by *producer prices*. Meanwhile, the trade and transport margins have their own industry (TradeTranspt)


We have to prepare data from input-output table into 4 header

| Header | Dimension | Description |
| --- | --- | --- | 
| `USE` | `COM` $\times$ `SRC` $\times$ `USER`  

## List of variables

| Variab