const polyID = require('./pidPlatform');
const ethers = require('ethers');

export default async (req, res) => {

  const { address } = req.body;

  const token = await polyID.signin();

}