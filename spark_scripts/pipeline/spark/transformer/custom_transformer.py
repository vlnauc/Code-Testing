from pipeline.spark.transformer.spark_tranformer import SparkTranformer

#class CustomTransformer(SparkTranformer):
class CustomTransformer(SparkTranformer):    
    """
    Custom tranformer
    """

    #def _tranform(self, dataset):
    def _tranform(self):
        print ("*")
        #dataset.show()
    
        #return dataset
