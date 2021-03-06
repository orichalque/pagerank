// Script to run one iteration of the pagerank algorithm in Spark with Scala
import java.io._

case class Row(url : String, pagerank: Double, urls: Array[String])

case class Data(data:String)

val start = System.currentTimeMillis()

val rawData = sc.textFile("data/etl-file.txt")

val data = rawData.map(line => {
	val fields = line.split("\t")
	val urls = fields(2).substring(1, fields(2).length - 1)
	.split(",")
	Row(fields(0), fields(1).toDouble, urls)
//	Data(fields(2))
})


val contributions = data.flatMap { case Row(url, pagerank, urls) => urls.map(url => (url, pagerank / urls.length)) }

val results = contributions.reduceByKey((x, y) => x + y).mapValues(v => 0.2 + 0.5*v) 

val stop = System.currentTimeMillis()

results.foreach(println)

println(stop - start+"ms")


