# The schemas in use at khaaliJaeb

Issuer id : `e2f85c32-c18c-49f0-a47b-066661361b71`

## User signup

```js
// This claim is issued upon completion of age check and obtaining the relevant nft
{
  "schema": "isAbove16",
  "mandatoryExpiration": false,
  "attributes": [
    {
      "name": "employeeID",
      "type": "number",
      "description": "The token ID of the Employee ERC721 contract"
    },
    {
      "name": "ageVerified",
      "type": "boolean",
      "description": "Whether the employee is above the age threshold"
    }
  ]
}
// ID : '6893fa09-8328-458f-97a2-7ccd56935a62'
```

## Employer Signup

```js
// This claim is issued upon submitting a github link and upload to ipfs; id is provisional
{
  "schema": "hasGithubUpload",
  "mandatoryExpiration": false,
  "attributes": [
    {
      "name": "organisationID",
      "type": "number",
      "description": "The token ID in the Organisation ERC721 contract"
    },
    {
      "name": "githubLinked",
      "type": "boolean",
      "description": "Whether the organisation has a valid github link"
    }
  ]
}
// ID : '65644fa6-8fba-4025-a1e6-514e6a8bdfb0'
```

```js
// This claim is issued upon a successful mint of the organisation nft
{
  "schema": "employerRecord",
  "mandatoryExpiration": false,
  "attributes": [
    {
      "name": "employeeID",
      "type": "number",
      "description": "The token ID of the Employee ERC721 contract"
    },
    {
      "name": "organisationID",
      "type": "number",
      "description": "The token ID in the Organisation ERC721 contract"
    }
  ]
}
// ID : ''
```

```js
// This claim is issued upon a successful mint of the organisation nft
{
  "schema": "employerRoleRecord",
  "mandatoryExpiration": false,
  "attributes": [
    {
      "name": "organisationID",
      "type": "number",
      "description": "The token ID in the Organisation ERC721 contract"
    },
    {
      "name": "isOrgAdmin",
      "type": "boolean",
      "description": "Set to true when an organisation nft is successfully minted"
    }
  ]
}
// ID : '9f2cba82-94a5-400a-bd1b-ab0052bf4abd'
```

## Posting a Job

```js
//
{
  
}
// ID : ''