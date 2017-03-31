import 'whatwg-fetch';

/**
 * Parses the JSON returned by a network request
 *
 * @param  {object} response A response from a network request
 *
 * @return {object}          The parsed JSON from the request
 */
function parseJSON(response) {
  return new Promise((resolve) => response.json()
    .then((data) => resolve({
      ok: response.ok,
      status: response.status,
      statusText: response.statusText,
      data,
    })));
}

/**
 * Requests a URL, returning a promise
 *
 * @param  {string} url       The URL we want to request
 * @param  {object} [options] The options we want to pass to "fetch"
 *
 * @return {object}           The response data
 */
export default function request(url, options) {
  return fetch(url, options)
    .then(parseJSON)
    .then((response) => {
      if (response.ok) {
        return response.data;
      }

      const error = new Error(response.statusText);
      error.response = response;
      throw error;
    });
}
