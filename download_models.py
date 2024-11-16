# from transformers import AutoModel, AutoTokenizer
# model = AutoModel.from_pretrained("xlm-roberta-large")
# tokenizer = AutoTokenizer.from_pretrained("xlm-roberta-large")



# Load model directly
from transformers import AutoTokenizer, AutoModelForMaskedLM

tokenizer = AutoTokenizer.from_pretrained("facebook/xlm-roberta-xl")
model = AutoModelForMaskedLM.from_pretrained("facebook/xlm-roberta-xl")
