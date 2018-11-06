# Cocoaheads Swift 4 API Client

API Client Swift package for Melbourne CocoaHeads Events API.

### Generating the API Client

The only prerequisite is to install [openapi-generator], and optionally [swiftformat][swiftformat].

```bash
brew install openapi-generator swiftformat
```

1. Generate the API client code by invoking `openapi-generator` from the root of this project.
2. Optionally cleanup the generated code with `swiftformat`.

```bash
openapi-generator generate -g swift4 -i https://www.melbournecocoaheads.com/api/openapi.json
swiftformat --trimwhitespace always .
```

