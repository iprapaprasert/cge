# The impact of a reduction in the power of tariff rate on imported Clothing and Footwear commodity

Shock the power of import tariff rate of Clothing and Footwear by -10% in standard short-run closure setting.

## General impacts

### The direct impact on ClothingFtw and Textiles industry
With the power of import tariff rate of Clothing and Footwear is decreased by -10%, the imports of Clothing and Footwear (x0imp) expand by 10.3%. By the way, the import of Textiles reduced by -1.18%. Hence, the real output (x1tot) of ClothingFtw is decreased by -3.54% while the real output of textiles is reduced by -0.23%. Moreover, we can see that most tradable commodities expand and most non-tradable commodities are static.

#### Fan decomposition
We can decompose the impact of changing the real output into 3 components---local market effect, domestic share effect and export effect

| fandecomp   | LocalMarket | DomShare | Export | Total |
| ---         | ---         | ---      | ---    | ---   |
| Textiles    | -0.71       | 0.15     | 0.27   | -0.28 |
| ClothingFtw | 0.10        | -5.50    | 1.85   | -3.54 |

### The macro effects

| Description                        | Variable   | Value   |
| ---                                |       ---  |     --- |
| Real household consumption         | x3tot      | 0       |
| Real investment                    | x2tot_i    | 0       |
| Real government demands            | x5tot      | 0       |
| Export volume                      | x4tot      | 0.44    |
| Import volume CIF                  | x0cif_c    | 0.23    |
| Real GDP                           | x0gdpexp   | 0.03    |
| Aggregate capital stock            | x1cap_i    | 0       | 
| Aggregate employment               | employ_i   | 0.05    |
| Absorption price index*            | p0gne      | -0.18   |
| GDP price index                    | p0gdpexp   | 0.19    |
| CPI                                | p3tot      | -0.22   |
| Exports price index                | p4tot      | -0.05   |
| Real devaluation*                  | p0realdev  | 0.19    |
| Average nominal wage               | p1lab_io   | -0.22   |
| Average real wage                  | realwage   | 0       |
| Contribution of BOT to real GDP    | contBOT    | 0.03    |
| Terms of trade*                    | p0toft     | -0.05   |
| Change in aggregate tariff revenue | delV0tar_c | -247.80 |

### Effect on imports
We investigate the impact on real import (`x0imp`). The equation E_x0imp determines real import:
$$
    0.01 \times [TINY + V^{(0)}_\text{IMP}(c)]x^{(0)}_\text{imp}(c) = \sum_u^\text{LOCUSER} \Delta Sale(c,\text{imp},u) \tag{$E_{x^{(0)}_\text{imp}}$}
$$
The equation shows that the percentage change of real import is determined by the ordinary change in sales of imported commodity $c$ to local users. Consider Textiles commodity, we can see that the large drop of sales comes from production, while in ClothingFtw, the large gain is from household consumption.

| `delSale(c,"imp",u)` | Producer | Household | Rest |
| --- | --- | --- |     --- |
| `Textiles` | -35.66 | -1.51 | tiny |
| `ClothingFtw` | 50.15 | 205.25 | tiny |

We will focus on industry analysis in the subsequent parts

## Impact on ClothingFtw
### Import-domestic substitution: Household demand for ClothingFtw
In the last section, we see that the large increase in sales of `ClothingFtw` comes from household consumption. The equation `E_delSaleC` shows that change in sales comes from percentage change in quantity demand of commodity `c` from source `s` by household. Equation `E_x3` determines percentage change in household quantity demand of commodity `c` from source `s`. Equation `E_p3_s` determines percentage change in household price of commodity `c`

```
Equation E_delSale (all,c,COM)(all,s,SRC)
    delSale(c,s,"HouseH") = 0.01*V3BAS(c,s)*x3(c,s);

Equation E_x3 (all,c,COM)(all,s,SRC)
    x3(c,s) - a3(c,s) = x3_s(c) - SIGMA3(c)*[p3(c,s) + a3(c,s) - p3_s(c)];

Equation E_p3_s (all,c,COM)
    p3_s(c) = sum{s, SRC, S3(c,s)*[p3(c,s) + a3(c,s)]};
```
The expansion in household demand `x3(c,s)` comes from (1) the expansion effect (`x3_s`) and (2) the substitution effect (`SIGMA3`). Then, take a look at the decomposition result of the household demand of `ClothingFtw` compared between domestic and imported.

| `x3(c,s)`            | dom       | imp    |
| ---                  | ---       | ---    |
| `x3_s`               | 0.58      | 0.58   |
| `SIGMA3`             | -5.97     | 9.06   |
| Total                | -5.39     | 9.64   |

Evaluate in details
|              | `x3(c,"dom")`| `x3(c,"imp")`|`x3_s`|`p3(c,"dom")` | `p3(c,"imp")` | `p3_s` | `SIGMA3` | `S3(c,"imp")`
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `ClothingFtw`| -5.39 | 9.64 | 0.58 | -0.75 | -4.8 | -2.45 | 3.54 | 0.396 |

In summary, with household's price of domestic `ClothingFtw` has decreased by -0.75% and import `ClothingFtw` has decreased by -4.8%, the real household demand for domestic `ClothingFtw` changed by -5.39% but the demand for imported `ClothingFtw` increased by 9.64%

## Explaining purchasers' prices: Household imports of ClothingFtw
In this section, we explain why imported price of `ClothingFtw` (`p3(c,"imp")`) has decreased.

The equation `E_p3` determines the price of commodity `c` from source `s` faced by household.
```
Equation E_p3 (all,c,COM)(all,s,SRC)
    [V3PUR(c,s) + TINY]*p3(c,s) = [V3BAS(c,s) + V3TAX(c,s)]*[p0(c,s) + t3(c,s)] + sum{m, MAR, V3MAR(c,s,m)*[p0dom(m) + a3mar(c,s,m)]};
```
The percentage change in `p3` is the weighted sum of change in basic value, consumption tax, and margins. The equation uses the weight in terms of `V3PUR`, `V3BAS`, `V3TAX` and `V3MAR`, as stated in the formula for determining coefficient `V3PUR`
```
Coefficient (all,C,COM)(all,s,SRC) V3PUR(c,s)
Formula (all,c,COM)(all,s,SRC)
    V3PUR(c,s) = V3BAS(c,s) + V3TAX(c,s) + sum{m, MAR, V3MAR(c,s,m)};
```
Therefore, weights for each factor contributing to `p3` are (looking at `SALEMAT2` matrix in `MKUP` header, consider only `HouseH`)
| SALEMAT2 of HouseH       | dom       | imp    |
| ---             | ---       | ---    |
| `V3BAS`         | 0.483    | 0.471  |
| `V3MAR`         | 0.516     | 0.526  |
| `V3TAX`         | 0.001     | 0.003  |
| Total           | 1.000     | 1.000  |

Since the percentage change of price of imported `ClothingFtw`, `p0("ClothingFtw","imp")` is -10%. However, the price that household perceive, `p3("ClothingFtw", "imp")` reduced only by -4.8%. This is because the heavy share of margins (i.e. local distribution costs) of 52.6% . Hence, the household price has not decreased as much as we intend.

Note that imported `NonMetlMinrl` has the highest weight of margins (66.2%) in the determination of household price. Similarly, for domestic commodities, `NonMetlMinrl` also have the highest weight of margins (64%).

## Household demand elasticity of composite commodities
Household does substitute between composite commodities. A fall in the price in the composite goods leads to a rise in that commodity household consumption and fall in others. 

ORANIG uses the linear expenditure system to model household demands. The demand of composite commodity is split into two parts---subsistence and supernumerary. The demand elasticity of subsistence part is 0, while demand elasticity of supernumerary part is close to -1. Therefore, the total demand elasticity is the weighted averaged of these two parts.
$$
\text{demand elasticity} = (\text{subsistence share} \times 0) + (\text{supernumerary share} \times -1) = -(\text{supernumerary share})
$$
where the supernumerary share is defined as 
$$
\text{supernumerary share} = \frac{\text{value of supernumerary use of \texttt{ClothingFtw}}}{\text{value of all household use of \texttt{ClothingFtw}}}
$$
ORANIG calls this share (coefficient) `B3LUX`

| SALEMAT2 of HouseH       | x3_s       | p3_s    | demand elasticity = %x / %p | B3LUX
| ---             | ---       | ---    | --- | --- |
| `ClothingFtw` | 0.58 | -2.45 | -0.24 | 0.23

We see that this value of `B3LUX` is close to the calculation of demand elasticity. However, it is not identical as when the price change, not only there is price effect affects the change in demand, but there is income effect too as are proven in Slutsky equation.

## Total demand for domestic ClothingFtw
To sum up, the shock directly changes the household behavior as household is the main user of this commodity by
affecting the imported commodities price (`p0`) and also the household price of imported commodity (`p3`). Then, household shifts towards imported goods away from domestic goods. 

For the same reason, the same story could be applied to other users such as producers, and exporter, while there is no change in investment as investors do not use `ClothingFtw` in investment, government consumption (it is exogenous in short-run)

Hence, we can summarize sales of `ClothingFtw` by source and users:

| delSale | Interm | HouseH | Export | Total |
| ---     | ---    | ---    | ---    | ---   |
| dom     | -64.6  | -182.9 | 84.9   |
| imp     | 50.2   | 205.3  | 0      |
| Total   |        | 1.000  |

Consider domestic `ClothingFtw`, we can see that producers and household demand less, but exporter demand more. However, more demand from exporters cannot fully offset reduced demand from other sectors. Totally, the output of domestic commodity (`x1tot`) reduced by -3.5%

## Transmission from decrease in imported price to decrease domestic price

We have seen that the imported price (`p0imp`) cheaper so that users switched from domestic to import. However, the domestic price also decreased---this moderated the price difference between domestic and imports, and helped to protect demand for the domestic product.

| p0                      | p0dom  | p0imp |
| ---                     | ---    | ---   | 
| ClothingFtw             | -1.43  | -10   |

### Relation between commodity price and industry cost
The output price of `ClothingFtw` industry, `p1tot` has decreased by -1.39%. It is not identical to `p0dom`. The two prices would be identical if
1. All `ClothingFtw` commodity was made by the `ClothingFtw` industry
2. The `ClothingFtw` industry made only the `ClothingFtw` commodity

Check the `MAKE` matrix, and we find that
1. 99.6% of `ClothingFtw` commodity is made by `ClothingFtw` industry
2. 97.1% of `ClothingFtw` industry output is `ClothingFtw`

Later, we will explain why the domestically-produced `ClothinfFtw` cheaper after we explain why `p1tot("ClothingFtw")` decreases.

### Decrease in price of ClothingFtw output from ClothingFtw industry, p1tot
First, the unit cost of production in industry `i` is given by `E_p1cst`
```
Equation E_p1cst (all,i,IND)
    p1cst(i) = [1/V1CST(i)] * [
        sum{c,COM,sum{s,SRC, V1PUR(c,s,i)*p1(c,s,i)}}
        + V1OCT(i)*p1oct(i)
        + V1CAP(i)*p1cap(i)
        + V1LND(i)*p1lnd(i)
        + sum{o,OCC,V1LAB(i,o)*p1lab(i,0)}
    ]
```
In absence of technological change, `p1cst` is equal to `p1tot`. For example,
```
    p1cst("ClothingFtw) = p1tot("ClothingFtw") = -1.39
```
We can decompose the `p1cst`:

| ClothingFtw  | contribution  |
| ---          | ---           | 
| p1           | -1.43 | 
| p1oct        | -1.43 | 
| p1cap        | -1.43 | 
| p1lnd        | -1.43 | 
| p1lab        | -1.43 | 
| Total p1cst  | -1.39 | 

We should see that the `p1` (price of commodity inputs) and `p1cap1` (price of capitals) are much the largest contributions.

#### Breaking down `p1`
Next, we will break down `p1`---total unit cost of commodity inputs in produce `ClothingFtw`. We see that much contribution comes from imported `ClothingFtw`, and the second one is domestic `ClothingFtw`. 

#### Breaking down `p1cap`
Next, we would like to analyze primary factor cost
```
Equation E_p1prim (all,i,IND)
    V1PRIM(i)*p1prim(i) = V1LAB_O(i)*[p1lab_o(i) + a1lab_o(i)] + V1CAP(i)*[p1cap(i) + a1cap(i)] + V1LND(i)*[p1lnd(i) + a1lnd(i)];
```
However, we can simplify as land is irrelevant to the production of `ClothingFtw`, `V1LND("ClothingFtw") = 0`. Note that some industry such as `BroadAcre` and `OtherAgric` that land is relevant.

