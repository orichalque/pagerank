### Project for LSDM (Large Scale Data Management)

## This folder countains 3 pagerank implementations and a parser . Run the commands in a shell

# Pig

- Run: ``` pig -x local pagerank.pig ```

# Python

- Run: ``` pig -x local -embedded jython pagerank.py ```

# Scala

- Run: 
``` spark-shell ```
``` :load pagerank.scala ```
                        
# Parser 

- Install the html parser Beautiful Soup locally with: ``` python3 install.py --local" inside the beautifulSoup folder

- Run ```python3 commoncrawl-to-pigformat.py ``` to generate the etl-file.txt 
