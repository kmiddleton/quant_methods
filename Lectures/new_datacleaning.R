
---
  title: "Data Cleaning"
subtitle: "Quantitative Methods in Life Sciences"
author: 'Elizabeth King, Kevin Middleton and Lauren Sullivan'
output:
  ioslides_presentation:
  fig_width: 7
css: styles.css
csl: evolution.csl
bibliography: Multivariate.bib
---

  ```{r setup, echo=FALSE, message=FALSE}
library(tidyverse)
library(readxl)
library(cowplot)
theme_set(theme_cowplot())
```




##SPLIT HERE


<span style="color:pink">I WOULD LIKE TO SPLIT THIS HERE AND MAKE A NEW ONE FOR DATA CLEANING WITH ALL THE TIDY STUFF.  I WOULD BASICALLY JUST ADD ON ALL THIS TO THE DATA CLEANING ONE THAT I THINK SHOULD GO NEXT (new 02-3)</span>



  ## New tools: Selecting, filtering, aggregating

  - [tidyr](https://cran.r-project.org/web/packages/tidyr/index.html)
- [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html)
- Both load with `tidyverse`

Tutorials:

  - http://seananderson.ca/2014/09/13/dplyr-intro.html
- https://rpubs.com/bradleyboehmke/data_wrangling

```{r}
library("tidyverse")
```

## tidyr

tidyr is most useful for moving data between "wide" and "long" formats:

  - `gather()`: wide to long
- `spread()`: long to wide

Utility functions for existing variables:

  - `separate()`: splitting variables (1 column to >1)
- `unite()`: joining variables (>1 columns to 1)

## Wide data

```{r echo=FALSE}
set.seed(5)
LS <- tibble(
  Line = rep(1:2, each = 2),
  Diet = rep(c("C", "H"), times = 2),
  Lifespan = rpois(4, 35),
  Fecundity = rpois(4, 100)
)
```

```{r}
LS
```

## Long data

```{r}
LS %>% gather(variable, value, -Line, -Diet)
```

## Combine existing variables: tidyr

```{r}
LS <- LS %>% unite(col = "ID", Diet, Line,
                   sep = "_", remove = FALSE)
LS
```

`remove = FALSE` means that the pre-existing variables are not removed.

## Main functions in dplyr

- `mutate()`: create new columns
- `glimpse()`: like `str()`
- `select()`: like `[ , ]` for columns
- `filter()`: like `subset()` or `[ , ]` with conditions
- `summarize()` with `group_by()`: like `aggregate()`
- `arrange()`: sorting
- `join()`: merging `data.frames`

Functions can (should) be chained together with `%>%`

- "Pipe" the result of the lefthand expression to the righthand expression.

## `glimpse()` is like `str()`

```{r}
glimpse(M)
```

## Calculate new variables: dplyr

```{r eval=FALSE}
M <- M %>%
  mutate(log10_DamMass = log10(DamMass))
```

- Assigning `M` back to itself just adds the column `log10DamMass` to the end of the `data.frame`.

## `mutate()` or not?

`mutate()` lets you add many new variables at once.

```{r eval=FALSE}
M$log10_WnMass <- log10(M$WnMass)
M$log10_DamMass <- log10(M$DamMass)
```

vs.

```{r}
M <- M %>%
  mutate(log10_WnMass = log10(WnMass),
         log10_DamMass = log10(DamMass))
```

## Selecting columns: dplyr

```{r}
M %>% select(Sex, WnMass, DamID)
```

## Chaining operations

```{r}
M %>% select(starts_with("wn")) %>% glimpse()
```

For more information and examples: `?select`

`starts_with()`, `ends_with()`, `contains()`, `matches()`, `num_range()`, `one_of()`, `everything()`

## Benefits of chaining operations

1. Cleaner code, reads like a sentence
- Be wary of long, opaque, chains (comment, comment, comment)
2. (Often) avoid saving intermediate objects.
- Select, filter, and plot in one step

## Filtering: dplyr

```{r}
M %>% filter((WnMass < 6 | WnMass > 19) & Sex == 0)
```

## Sorting: dplyr

```{r}
M %>% filter((WnMass < 6 | WnMass > 19) & Sex == 0) %>%
  arrange(WnMass)
```

## Selecting and filtering

```{r}
M %>% filter((WnMass < 6 | WnMass > 19) & Sex == 0) %>%
  select(MouseID, DamID, WnMass)
```
## Quiz 02-2

On Canvas, complete quiz 02-2.

Move on to lecture 02-3.
