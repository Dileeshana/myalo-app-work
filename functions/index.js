const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.getQuestions = functions.https.onRequest(async (request, response) => {
    try {
        const db = admin.database();
        const questionsRef = db.ref('questions');

        questionsRef.once('value', (snapshot) => {
            let questions = snapshot.val();
            response.send({ questions });
        });

    } catch (error) {
        console.error('Error retrieving questions:', error);
        response.status(500).send({ error: 'Failed to fetch questions.' });
    }
});


exports.predictIllness = functions.https.onRequest((request, response) => {
    // Extract answers from request
    const answers = request.body.answers; // assuming answers are sent as a dictionary with QID:AID pairs
    
    // Apply rule-based logic
    const predictedIllness = applyRules(answers);
    
    // Respond with predicted illness
    response.send({ illness: predictedIllness });
});

function applyRules(answers) {
    // This is the simple rule logic we defined earlier; you might want to enhance this based on your data
    // answers are expected to be in the format {QID: AID, ...}
    
    // Example: For QID: 1, if AID is 2, then it might indicate "Social Anxiety"
    if (answers["1"] === "2" && answers["2"] === "2") {
        return "social anxiety";
    } else if (answers["19"] === "2" && answers["20"] === "2") {
        return "acrophobia";
    } else if (answers["8"] === "2" && answers["9"] === "2") {
        return "schizophrenia";
    } else {
        return "unknown";  // Default case
    }
}


