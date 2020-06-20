const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.myFunction = functions.firestore
  .document('chat/{message}')
  .onCreate((snapshot, context) => {
    const username = snapshot.data().username;
    const type = snapshot.data().type;
    var body = '';

    switch (type) {
      case 'IMAGE_MESSAGE_TYPE':
        body = username + ' send a new photo';
        break;
      case 'STICKER_MESSAGE_TYPE':
        body = username + ' send a sticker';
        break;
      default:
        body = snapshot.data().text;
    }

    return admin.messaging().sendToTopic('chat', {
      notification: {
        title: username,
        body: body,
        clickAction: 'FLUTTER_NOTIFICATION_CLICK',
      },
    });
  });
