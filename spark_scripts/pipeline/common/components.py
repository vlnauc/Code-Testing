from abc import abstractmethod

class Component:
    module = None
    def __init__(self):
        pass

class Transformer(Component):
    module = 'tranformers'

    def __init__(self, transform_config, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.transform_config = transform_config

    @abstractmethod
    def tranform(self, dataset):
        """
        performs tranformation ...
        """

