// import push sdk
import * as PushAPI from "@pushprotocol/restapi";
import * as ethers from "ethers";
import type { NextApiRequest, NextApiResponse } from 'next'

type Data = {
    name: string
}

export default function handler(
    req: NextApiRequest,
    res: NextApiResponse<Data>
) {
    const { PK, from, to, data } = req.body;
    console.log(req.body)
    const Pkey = `0x${PK}`;
    const signer = new ethers.Wallet(Pkey);

    signer.getAddress().then((address) => {

        const sendNotification = async () => {
            try {
                const apiResponse = await PushAPI.payloads.sendNotification({
                    signer,
                    type: 1, // broadcast
                    identityType: 2, // direct payload
                    notification: {
                        title: `[message] notification TITLE:`,
                        body: `[message]`
                    },
                    payload: {
                        title: `[sdk-test] payload title`,
                        body: JSON.stringify({
                            from: from,
                            to: to,
                            data: data
                        }),
                        cta: '',
                        img: ''
                    },
                    // recipients: 'eip155:5:' + to, // your channel address
                    channel: 'eip155:5:' + address, // your channel address
                    env: 'staging'
                });


                // apiResponse?.status === 204, if sent successfully!

                if (apiResponse?.status === 204) {
                    res.status(200).json({ name: 'Success' })
                } else {
                    res.status(400).json({ name: 'Error' })
                }
            } catch (err) {
                console.error('Error: ', err);
                res.status(500)
            }
        }
        sendNotification();
    })
}
