initial = 
    LOAD 'data/etl-file.txt'
    USING PigStorage('\t') 
    AS ( url: chararray, pagerank: float, links:{ link:tuple(url: chararray) } );

flattened_pgrnk = 
    FOREACH initial 
    GENERATE 
        pagerank / COUNT ( links ) AS pagerank, 
        FLATTEN ( links ) AS to_url;

grouped_pgrnk = 
	FOREACH ( COGROUP flattened_pgrnk BY to_url, initial BY url INNER )
	GENERATE 
		group AS url, 
        	0.2+0.5*SUM(flattened_pgrnk.pagerank) AS pagerank, 
        	FLATTEN ( initial.links ) AS links;
  
STORE grouped_pgrnk 
    INTO './result-pig' 
    USING PigStorage('\t');

