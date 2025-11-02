import asyncdispatch, httpclient, json, strutils, uri

const api = "https://genius.com/api"
var headers = newHttpHeaders({
    "Connection": "keep-alive",
    "Host": "genius.com",
    "Content-Type": "application/json",
    "accept": "application/json, text/plain, */*"
  })

proc get_referents*(song_id:int): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/referents/" & $song_id & "?text_format=html%2Cmarkdown")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc search_song*(q:string): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/search/multi?experiment=not-eligible&per_page=5&q=" & encodeUrl(q))
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc song_recommendations*(song_id:int): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/songs/" & $song_id & "/recommendations?text_format=html%2Cmarkdown")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc song_contributors*(song_id:int): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/songs/" & $song_id & "/contributors?text_format=html%2Cmarkdown")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc artists_info*(artist_id:int): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/artists/" & $artist_id & "?text_format=html%2Cmarkdown")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc artists_videos*(artist_id:int,page:int=1): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/videos?artist_id=" & $artist_id & "&page=" & $page)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc artists_leaderboard*(artist_id:int,page:int=1): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/artists/" & $artist_id & "?page=" & $page & "&per_page=10")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()
