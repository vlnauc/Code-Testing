from abc import abstractmethod
from pyspark.ml import Transformer as MlTransformer
from pipeline.common.components import Transformer

class SparkTranformer(Transformer, MlTransformer):
    """
    Class repre
    """

    def tranform(self, dataset):
        return MlTransformer.traform(self, dataset)

    @abstractmethod
    def _tranform(self, dataset):
        """
        Interface for tranform
        :return:
        """
