from flask import Flask, jsonify, request
from datetime import datetime

app = Flask(__name__)

# In-memory storage for simplicity. In a real app, you'd use a database.
puzzles = [
    {"id": "1", "type": "caesar", "text": "KHOOR ZRUOG", "difficulty": "easy"},
    {"id": "2", "type": "vigenere", "text": "ZCNIOR SDHVV", "key": "SECRET", "difficulty": "medium"},
]

monthly_challenge = {
    "id": "mc1",
    "type": "playfair",
    "text": "HIDETHEGOLDINTHETREESTUMP",
    "created_at": datetime.now().isoformat()
}

leaderboard = []

@app.route('/check-solution/<puzzle_id>', methods=['POST'])
def check_solution(puzzle_id):
    data = request.json
    user_solution = data.get('solution', '').upper()
    
    puzzle = next((p for p in puzzles if p['id'] == puzzle_id), None)
    if not puzzle:
        return jsonify({"error": "Puzzle not found"}), 404
    
    is_correct = user_solution == puzzle['solution']
    return jsonify({"correct": is_correct})

@app.route('/puzzles', methods=['GET'])
def get_puzzles():
    return jsonify(puzzles)

@app.route('/monthly-challenge', methods=['GET'])
def get_monthly_challenge():
    return jsonify(monthly_challenge)

@app.route('/leaderboard', methods=['GET', 'POST'])
def handle_leaderboard():
    if request.method == 'POST':
        user = request.json
        leaderboard.append(user)
        leaderboard.sort(key=lambda x: x['score'], reverse=True)
        leaderboard = leaderboard[:25]  # Keep only top 25
        return jsonify({"message": "Score added successfully"}), 201
    else:
        return jsonify(leaderboard)

if __name__ == '__main__':
    app.run(debug=True)
