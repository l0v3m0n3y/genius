# genius
song text api genius.com nim-lang
# Example
```nim
import asyncdispatch, genius, json

let data = waitFor search_song("hope")

# Display only song results
if data.hasKey("response") and data["response"].hasKey("sections"):
  for section in data["response"]["sections"]:
    let sectionType = section{"type"}.getStr("unknown")
    
    if sectionType == "song" or sectionType == "top_hit":  # Focus on song sections
      echo "=== SONGS ==="
      
      if section.hasKey("hits"):
        for hit in section["hits"]:
          if hit.hasKey("result"):
            let result = hit["result"]
            let itemType = result{"_type"}.getStr("unknown")
            
            if itemType == "song":  # Only process actual songs
              let apiPath = result{"api_path"}.getStr("")
              let title = result{"title"}.getStr("Unknown Title")
              let artist = result{"artist_names"}.getStr("Unknown Artist")
              let songId = result{"id"}.getInt()
              let url = result{"url"}.getStr("")
              
              echo "  - API Path: ", apiPath
              echo "    Title: ", title
              echo "    Artist: ", artist  
              echo "    ID: ", songId
              echo "    URL: ", url
              echo ""
```

# Launch (your script)
```
nim c -d:ssl -r  your_app.nim
```
