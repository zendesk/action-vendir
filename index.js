const core = require('@actions/core')
const io = require('@actions/io')
const { exec } = require('@actions/exec')
const https = require('https')
const path = require('path')

const fetchReleases = async () => {
  const version = core.getInput('version')
  const versionPath = version == 'latest' ? 'latest' : `tags/${version}`
  const url = `https://api.github.com/repos/k14s/vendir/releases/${versionPath}`

  core.info(`Fetching Vendir release from ${url}`)

  let release

  try {
    release = JSON.parse(await get(url))
  } catch (error) {
    core.setFailed(
      `Failed to fetch releases from GitHub API, providing a token may help.\nError: ${error}`
    )
    return
  }

  const vendirAsset = release.assets.find(asset =>
    asset.name == 'vendir-linux-amd64'
  )

  return vendirAsset.browser_download_url
}

const get = url => {
  return new Promise((resolve, reject) => {
    const headers = {
      'User-Agent': 'action-vendir Github action',
    }

    const token = core.getInput('token')

    if (token) {
      headers['Authorization'] = `token ${token}`
    }

    const request = https.get(url, { headers })

    request.on('response', res => {
      let data = ''

      res.on('data', chunk => {
        data += chunk
      })

      res.on('end', () => {
        if (res.statusCode == 200) {
          resolve(data)
        } else {
          reject(data)
        }
      })
    })

    request.on('error', err => {
      reject(err)
    })
  })
}

const run = async () => {
  const token = core.getInput('token')
  const locked = core.getInput('locked')
  const vendirFile = core.getInput('vendir_file')

  try {
    const url = await fetchReleases()
    await exec(path.join(__dirname, 'execute-vendir.sh'), [url, token, locked, vendirFile])
  } catch (error) {
    core.setFailed(`Action failed with error: ${error}`)
  }
}

run()
