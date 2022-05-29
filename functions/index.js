var admin = require("firebase-admin");
var functions = require("firebase-functions");
// var serviceAccount = require("E:/Downloads/porter-app-c648e-86368d42faff.json");

admin.initializeApp();

const messaging = admin.messaging();



exports.sendToTopic = 
        functions.firestore.document('task/{id}').onCreate((snapshot,context) => {
            const data = snapshot.data();
            const task = data.taskData;

            console.log(`task: ${task.taskName}`);
            
            notifpayload = {
                notification: {
                    title: "New Task!",
                    body: `${task.taskName} is created, from ${task.startLocation} to ${task.destination} and need to be completed by ${task.scheduleDate}`
                    ,clickAction: "FLUTTER_NOTIFICATION_CLICK"
                },
            };  
            
            let response = messaging.sendToTopic("tasks",notifpayload);
            console.log(response);
        
            return response;
        });
        
