const fs = require('fs');
const path = require('path');
const admin = require('firebase-admin');

async function run() {
  const inputPath = process.argv[2] || path.join(__dirname, 'firestore_seed_template.json');

  if (!fs.existsSync(inputPath)) {
    throw new Error(`Seed file not found: ${inputPath}`);
  }

  const raw = fs.readFileSync(inputPath, 'utf8');
  const data = JSON.parse(raw);

  admin.initializeApp({
    credential: admin.credential.applicationDefault(),
    projectId: process.env.FIREBASE_PROJECT_ID,
  });

  const db = admin.firestore();

  let writes = 0;

  for (const [collectionName, documents] of Object.entries(data)) {
    if (!documents || typeof documents !== 'object') {
      continue;
    }

    for (const [docId, docData] of Object.entries(documents)) {
      await db.collection(collectionName).doc(docId).set(docData, { merge: true });
      writes += 1;
      console.log(`✔ Seeded ${collectionName}/${docId}`);
    }
  }

  console.log(`\nDone. Total documents seeded: ${writes}`);
}

run().catch((error) => {
  console.error('Seeding failed:', error.message);
  process.exit(1);
});
