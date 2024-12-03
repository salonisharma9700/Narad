from flask import Flask, request, jsonify
import numpy as np
from transformers import pipeline, AutoTokenizer, AutoModelForSeq2SeqLM
from sentence_transformers import SentenceTransformer
from flask_cors import CORS
# Initialize Flask app
app = Flask(__name__)
CORS(app)

  # Enable CORS for all routes
@app.route('/')
def home():
    return "Hello, Flask!"

# Load the BART-based summarization model and tokenizer
model_name = "saloni9700/bart-sbert-faiss-summarizer"
tokenizer = AutoTokenizer.from_pretrained(model_name, use_auth_token="")
model = AutoModelForSeq2SeqLM.from_pretrained(model_name, use_auth_token="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")

# Load Sentence-BERT model for vectorization (if you are using FAISS)
sbert_model = SentenceTransformer('all-MiniLM-L6-v2')

# Function to chunk text
def chunk_text(text, chunk_size=512):
    words = text.split()
    return [' '.join(words[i:i + chunk_size]) for i in range(0, len(words), chunk_size)]

# Function to vectorize chunks
def vectorize_chunks(chunks, model):
    return np.array([model.encode(chunk) for chunk in chunks])

# Function to generate summary using the BART summarization pipeline
def generate_summary(chunks, model_pipeline, custom_prompt=None):
    if custom_prompt is None:
        custom_prompt = "Summarize the following content into main points and a brief summary. Ensure the summary is factual and concise:\n\n"
    
    prompt = custom_prompt + "\n".join(chunks)
    response = model_pipeline(prompt, max_length=300, truncation=True)
    return response[0]['summary_text']

# API route for summarization
@app.route('/summarize', methods=['POST'])
def predict():
    data = request.json
    article = data.get('article')
    custom_prompt = data.get('prompt', None)
    
    if not article:
        return jsonify({"error": "No article provided"}), 400
    
    # Step 1: Chunk the article
    chunks = chunk_text(article)
    
    # Step 2: Vectorize the chunks using Sentence-BERT
    embeddings = vectorize_chunks(chunks, sbert_model)
    
    # Step 3: Use the BART-based summarization model
    summarization_pipeline = pipeline("summarization", model=model, tokenizer=tokenizer)
    summary = generate_summary(chunks, summarization_pipeline, custom_prompt)
    
    return jsonify({"summary": summary})

# if __name__ == '__main__':
#     print("Starting Flask server...")
#     app.run(debug=True, host='0.0.0.0')
if __name__ == '__main__':
    import os
    # Use a dynamic port or default to 5000
    port = int(os.environ.get("PORT", 5000))
    # Run Flask app on all available network interfaces (0.0.0.0)
    app.run(debug=True, host='0.0.0.0', port=port)
