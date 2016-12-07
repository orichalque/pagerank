previous_pagerank = 
    LOAD 'data/etl-file.txt'
    USING PigStorage('\t') 
    AS ( url: chararray, pagerank: float, links:{ link:tuple(url: chararray) } );

outbound_pagerank = 
    FOREACH previous_pagerank 
    GENERATE 
        pagerank / COUNT ( links ) AS pagerank, 
        FLATTEN ( links ) AS to_url;

new_pagerank = 
	FOREACH ( COGROUP outbound_pagerank BY to_url, previous_pagerank BY url INNER )
	GENERATE 
		group AS url, 
        	0.2+0.5*SUM(outbound_pagerank.pagerank) AS pagerank, 
        	FLATTEN ( previous_pagerank.links ) AS links;

ordered = ORDER new_pagerank BY pagerank DESC;
  
STORE ordered 
    INTO './result-pig' 
    USING PigStorage('\t');

