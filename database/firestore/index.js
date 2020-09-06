'use strict';

const db = require('./driver');
const STATUS = require('../../constants/ide-request-constants');

const collection = 'IDERequestsTest';

/**
 * @type {{
 * saveRequest: (function(): string),
 * saveOutput: (function(id: string, output: {stdout: string, stderr: string, status?: string}): Promise<*>)
 * findRequestById: (function(id: string): boolean|{id: string, stdout: string, stderr: string, status: string})
 * }}
 */
module.exports = {
  saveRequest: async () => {
    const doc = await db.collection(collection).add({});
    return doc.id;
  },

  saveOutput: async (id, output) => {
    const docRef = db.collection(collection).doc(id);
    const doc = await docRef.get();

    if (!doc.exists) {
      return false;
    }

    return docRef.set({
      stdout: output.stdout || '',
      stderr: output.stderr || '',
      status: STATUS.SUCCESS
    });
  },

  findRequestById: async id => {
    const docRef = db.collection(collection).doc(id);
    const doc = await docRef.get();

    if (!doc.exists) {
      return false;
    }

    return doc.data();
  }
};
