
Search the Unified Medical Language System (UMLS). For more details on the [REST API](https://documentation.uts.nlm.nih.gov/rest/home.html)


##Import


```
using NLM.UMLS
```


<a id='Search-by-term-1'></a>

## Search by term


Search UMLS using the Rest API. The user needs approved credentials and a query dictionary. Sign up for credentials [here](https://uts.nlm.nih.gov//license.html)


<a id='To-create-credentials-1'></a>

### To create credentials


```
 import NLM.UMLS:Credentials
 credentials = Credentials(user, psswd)
 ```

### To compose the query

 ```
 query = Dict("string"=>term, "searchType"=>"exact" )
 ```

### To search all concepts associeted with the indicated term

 ```
 all_results= search_umls(credentials, query)
 ```

###To retrieve the CUI for the rest match

```


cui = best_match_cui(all_results, term)


```

### Get UMLS concepts associated with a CUI

```


all_concepts = get_concepts(c, cui) ``` ––––––––––––-
