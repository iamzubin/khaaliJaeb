export async function signin() {
  const credentials = {
    'email': process.env.PID_USERNAME,
    'password': process.env.PID_PASSWORD
  }
  const res = await fetch('https://api-staging.polygonid.com/v1/orgs/sign-in', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(credentials)
  });

  const data = await res.json();
  console.log(data)
  return data.token;
}

export const ISSUER_ID = 'e2f85c32-c18c-49f0-a47b-066661361b71';

export const SCHEMAS = {
  'isAbove16': {
    'id': 'c84004d6-ac6f-4012-848d-1e6e0d11769f',
    'hash': '09e0c7be9fb9c8146f9a47c03570c6b7'
  },
  'hasGithubUpload': {
    'id': '65644fa6-8fba-4025-a1e6-514e6a8bdfb0',
    'hash': 'afeb024548ab368422328b88077d7531'
  },
  'employerRecord': {
    'id': '7b97fe6b-acd1-4444-bfff-75b6bc2dcf94',
    'hash': 'efe4d3d584241891626dd774f2a189b8'
  },
  'employerRoleRecord': {
    'id': '9f2cba82-94a5-400a-bd1b-ab0052bf4abd',
    'hash': 'dc984740eebfbdb82b6bc77b67baa017'
  }
}
