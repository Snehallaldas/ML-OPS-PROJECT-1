import os
import pandas as pd
from src.logger import get_logger
from src.custom_exception import CustomException
import yaml
import pandas as pd

logger = get_logger(__name__)

def read_yaml(file_path):
    try:
        if not os.path.exists(file_path):
            raise FileNotFoundError(f"file is not in the given path")
        with open(file_path, 'r') as yaml_file:
            config = yaml.safe_load(yaml_file)
            logger.info("Succesfuly read the yaml filie")
            return config
    except Exception as e:
        logger.error("Errro while reading the yaml file")
        raise CustomException("Fail to read the YAML file", e)
    

def load_data(path):
    try:
        logger.info("Loading data")
        return pd.read_csv(path)
    except Exception as e:
        logger.error("Error loading the data {e}")
        raise CustomException("Failed to load data" , e)