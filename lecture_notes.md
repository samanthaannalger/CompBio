

# Lecture Notes

Samantha Alger  
January 17, 2017  

###1/17/17
#####Goals
* think on paper
* computational tools
* core programming methods
* speaking skills

Lab- Wednesdays: 1-3:30

##Git Hub

Working locally on your computer, you will push or pull versions to and from GitHub. (push sync to do both). Then, you can ‘commit’ to create a version that you can later return to if needed. 

If your code is not working, you can use the ‘Revert’ button and Git will send you back to the last commit (previous version of your code). 

##Homework:
####Send NG an email when done setting up your repository:

* github webpage site
* github repository
* Fun Fact- something about me that is memorable

##1/19/17

###Thinking on Paper!!

####Inductive method
observation->hypothesis->prediciton->observation

####Hypothesis-Deductive method
Observation with multiple hypotheses and test predictions and refute predictions. 

Very uncommon to see people progressing this way. Our starting viewpoint is instead, "Nature is complex". So we shy away from stating simple hypotheses and we see this is in the ecology literature. For example: "relative importance of factors x, y, and z". We don't usually see a quantification of the relative importance of these factors. But, we do see a "complex mix of biotic, abiotic, and historical factors". Another that is popping up is "context-dependent". Of course everything is context dependent. None of these get at a clear hypothesis. Nick calls this "Tangled Bank Fever". 

We do not make good progress by embracing this complexity initially.

####4 tools for 'thinking on paper'

* path diagram (cause and effect flow chart)
* logic tree
* look up table or DIP switch
* mock data

##1-24-2017

Plain-text files-WYSIWYW (what you see is what you want/need)
WYSIWYG (what you see is what you get)

####plain-text types:  
*   LaTex- has thousands of typesetting commands, complex
*   markdown- very simple version of LaTex (dozen commands instead of thousands of commands)
    * Rmarkdown- we can mix in lines of R code and get it to run (filename.Rmd)
           we can "*knit*" to make file: .pdf, .html, or .docx

    yaml- "yet another markdown language" at the top of the page (meta data information)

###to knit: use Cntrl + Shift + k

##To learn markdown language-
* Help ->Markdown Quick Reference!


###First Markdown Trial


This text has *italics*.

This text is **bold**.

#Header 1

##Header 2

##Header 3

#####Header a million

A friend once said:

>It's always better to give
>than to receive.

These   words   are widely    spaced

One line  
Next line  
Third line  


lists are super easy!!!   

* first item  
* second item  
     + what?!  
     + double what?!  

Yo! let's use a link:  

[Alex's website](http://stars2come.com/wp-content/uploads/2010/03/100_3841-300x225.jpg)^[yeah, he's kind of a big deal]

Here he is in all of his glory...  
![in all his glory](Burnham.jpg)

footnote at the bottom of the page^[FOOTNOTE!]

> quoted text is formatted this way

| First Header | Second Header |
| ------------ | ------------- |
| Content Cell | Content Cell  |
| Content Cell | Content Cell  |

`plaintext` shows this way

```
All the text that we add in here will be exactly like plain text, and not converted to markdown language. Now I can     put      big     ol'     giant    spaces    

```
###Back to markdown formatting

in line r code 6.1415927


##To automatically insert R chuck, Use command + alt + i:

```r
#Use comments profusely in your code!

Time <- seq(1,10) #seq makes integer sequence
print(Time)       #show contents
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10
```

```r
Resp <- runif(10) #random uniform- create 10 random numbers froma uniform distribution
print(Resp)
```

```
##  [1] 0.13162424 0.01511958 0.94760908 0.14207037 0.69921591 0.55392035
##  [7] 0.03449676 0.28231024 0.02073081 0.30594125
```

```r
plot(x=Time, y=Resp, type="b")
```

![](lecture_notes_files/figure-docx/unnamed-chunk-1-1.png)<!-- -->


##Build an equation   
###in line equation
Put an equation (between dollar signs) $a = b + c$

Set equation on its own line with this:   
$$a = b + c$$

##1-26-17

###Subscripts in LaTex

$$H_0 = Z_{a + b}$$

In Markdown, we say H~0~

Superscripts

$$S = cA^z$$

Combining elements

$$S=cA^z_1 = z_{2 = x_0}$$

Special symbols and fraction

$$\alpha = \frac{\beta}{\gamma + \delta_x}$$

Using the backslash

$$\backslash \alpha \le b \backslash$$

Summation sign

$$z = \sum_{i=1}^X{K}$$

Rendering plaintext in LaTex

$$P(\mbox{Occurence Of Species A}) = Z$$



```r
            #```{r, echo=FALSE} (removes the R code)
            #eval=FALSE (keeps record of code it  will print, but will not run inside that chunk)
plot(runif(20))
```

![](lecture_notes_files/figure-docx/unnamed-chunk-2-1.png)<!-- -->

```r
print(seq(1,5))
```

```
## [1] 1 2 3 4 5
```

##2/2/17

Data Frame:

*   file

*   rows- smallest possible sampling unit

*   columns: attributes of samples

*   all elements in a column areof one "type"

*   all columns of same length

*   missing values should consistently get "NA"

*   variable names: no spaces, special characters

*   First variable: ID variable- consequative number (1,2,3...)

*   Long format- each row is the smallest unit- SEE Nick's notes on transforming matrix into long format using reshape package

*   Metadata

*   embed metadata in datatfile:

    *   title, data, author

    *   author email, author address, author website,

                    ______________-

                    ​

    *   ownership, collaborators, funding sources

    *   repository: one or more lines for GitHub or where dataset can be accessed

    *   citations: pubs that cite or use these data

                    _______

                    ​

    *   sampling locations: one or more lines about where data were collected, GPS coordinates should be in data columns

    *   sampling times: When data where collected

    *   variable description: single row for every colun saying what variable is and what units are measured in

    *   missing data: one or more lines for each variable describing why values are missing

                    ______________________________

                    ​

    *   data track changes log: Use section to record any changes to the data set after is is created. 

    *   (This could also be tracked in GitHub commits)

                    _____________________________

                    Start of Data

                    ______

                    GitIgnore can keep datafiles from being uploaded to GitHub

                  ## 2017-2-7

                  metacharacters- a handful of expressions that allow you to search for something other than a simple character.

                  "escaping the metacharacter":  Use a blackslash before the character:  \

                  ####List of useful meta characters (Wild Cards)

                a single "word" character, (all caps, all lower case, 0-9, _) 

                ​```
                \w
                ​```
                
                a single number character (0-9)
                
                ​```
                \d
                ​```
                
                a single tab space
                
                ​```
                \t
                ​```
                
                a single tab space or line break
                
                ​```
                \s
                ​```
                
                a single line break
                
                ​```
                \n
                ​```
                
                any single letter, digit, space, symbol, end of line
                
                ​```
                \.
                ​```
                
                ___________
                
                Real world application**
                
                repairing a pdf
                
                find:
                
                ​```
                \. \s
                ​```
                
                replace:
                
                ​```
                \. \n
                ​```
                
                _________
                
                #### Negated WildCards
                
                By making it capital, give me anything that is 'not' in that list...
                
                So, every WildCard has a complementary version...
                
                ​
                
                Matches anything that is not a single word character
                
                ​```
                \W
                ​```
                
                Matches things that are not a single number
                
                ​```
                \D
                ​```
                
                ### Custom Character Sets
                
                ​
                
                ​```
                [A-Za-z]
                ​```
                
                If working with DNA sequences...
                
                ​```
                [ACTG]
                ​```
                
                ###Negated Character Sets
                
                Anything but a capital letter
                
                ​```
                [^A-Z]
                ​```
              
              Equal to \W
              
              ​```
              [^A-Za-z0-9]
              ​```
              
              Anything except a tab = \T
              
              ​```
              [^\t]
              ​```
              
              ### Quantifiers
              
              1 or more consecutive word characters
              
              ​```
              \w+
              ​```
              
              0 or more consecutive word characters
              
              ​```
              \w*
              ​```
              
              exactly 3 consecuative word characters
              
              ​```
              \w{3}
              ​```
              
              exactly 3, 4, or 5 matches
              
              ​```
              \w{3,5}
              ​```
              
              3 or more matches
              
              ​```
              \w{3,}
              ​```
              
              ​```
              [ACTG]{3}
              ​```
              
              0 or more consecutive spaces
              
              ​```
              \s*
              ​```
              
              ________
              
              ​
              
              #### Real world example
              
              crow, raven  ,grackle,starling ,  robin
              
              find:
              
              ​```
              \s*,\s
              ​```
              
              replace
              
              ​```
              ,
              ​```
              
              sentence becomes:
              
              crow,raven,grackle,starling,robin
              
              ______
              
              parentheses indicate portions that you want to keep:
              
              find:
              
              ​```
              (\w+),\s*(\w+).*
              ​```
              
              replace:
              
              ​```
              \2 # \1
              ​```
              
              This:
              
              x, MyWord OtherJunk. ,
              13, MyWord2,OtherStuff,,
              x13, MyThirdWord,    MoreTrash!#
              xxx,LastWord    x.
              
              Becomes:
              
              MyWord # x
              MyWord2 # 13
              MyThirdWord # x13
              LastWord # xxx
              
              ​
            
            ___________
            
            ### 2017-02-09
            
            ​```
            \w{1,3}
            ​```
            
            include words that have 1-3 characters
            
            #### Regular Expressions continued: Boundary stakes
            
            indicate before or after, not after the character itself
            
            ​```
            ^
            ​```
            
            start of line
            
            ​```
            $
            ​```
            
            end of line
            
            ​```
            \b
            ​```
            
            beginning or ending of a word
            
            example: \ba\b (only will find words that begin and end with the letter a)

        ```json
            \B
        ```

            NOT a beginning or ending of a word

            example: \Ba\B will get only a's that are in the middle of a word. 

            ​

            _________

            input:

            ​```
            WordA,OneWord,WordZ
            
            WordA,Two Words,WordZ
            
            WordA,Three More Words,WordZ
            
            WordA,Four Or More Words,WordZ
            ​```
            
            find:
            
            ​```
            ^\w+,((\w+ )*\w+),\w+$
            ​```
            
            replace:
            
            ​```
            \1
            ​```
            
            output:
            
            ​```
            OneWord
            Two Words
            Three More Words
            Four Or More Words
            ​```

_________



input

```
WordA,OneWord,WordZ
WordA,Two Words,WordZ
WordA,Three More Words,WordZ
WordA,Four Or More Words,WordZ
```

find:

```
^\w+,([^,]+),\w+$
```

replace:

```
\1
```

output:

```
OneWord
Two Words
Three More Words
Four Or More Words
```

________

#### To find non-digit characters in a file...

```
LC1 11101 gbb
LC2 200o1 xxx
LC4 l0001 xxx
LC3 30401 xxx
```

input:

```
^(\w+ \d*\D+\S* \w+)$
```

find:

```
BadLine: \1
```

replace:

```
BadLine: \1
```

output:

```
LC1 11101 gbb
BadLine: LC2 200o1 xxx
BadLine: LC4 l0001 xxx
LC3 30401 xxx
```

_________

#### Starting with R...

### 2017-02-14

Disadvantages:

* interpreted code
* lazy evaluation
  * x<- 5
  * x<-"Burlington"
* functions hard to learn
* poorly documented
* unreliable packages
* problem with big data
  * solutions: functions that use c code (to be faster), Julia (open source and free- similar to R, operates like a compiled language so it is faster)

## Dimensions

| Dimensions   | Homogenous    | Heterogenous |
| ------------ | ------------- | ------------ |
| 1-Dimensions | Atomic Vector | List         |
| 2-Dimensions | Matrix        | Dataframe    |
| n-Dimensions | (array)       |              |



#### Types of Atomic Vectors

* character strings
* integers- numeric variable
* double- numeric variable
* logic- TRUE, FALSE
* (factor)




___________

### 2017-2-21

