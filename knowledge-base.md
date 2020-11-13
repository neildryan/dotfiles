## Personal Knowledge Base Brainstorming
### Zotero Integration
I'm fine annotating PDFs, but this solution would pull away from Zotero
1. Zotfile is awesome at annotation extraction, so I'd either need to live
without it or try to extract that functionality
    * Extracting functionality seems reasonable, mostly just cloning
    Zotfile and reworking some scripts in `zotfile/pdfextract/extract.js`
    2. Zotero automatically generates bibtex citations and finds citation
    information for PDFs. This is totally awesome and not something that I
    want to live without. I'm fine having `~/wiki/papers` or whatever, but
    getting metadata is really excellent.
      * Maybe there's a way to keep Zotero in workflow? Maybe
      1. Read & Annotate PDF
      2. Load into Zotero, get metadata (Possible with `PyZotero`?)
          - Zotero only does a good job with attachments when added with web
          clipper or Zotero; Zotero doesn't know what to do with
          attachments that come in
          3. Query `PyZotero` for metadata, custom script for annotations
          4. Get metadata, annotations, and link to PDF location in Vim
          5. Summarize the paper (Zettel), include images as desired
      * This could all be wrapped in a Python script that's called by Vim
      * This would keep a Zotero database for no real reason other than
      metadata grabbing (which would also be useful for `citation.vim`)
      * Initial conversion could be done with
      ![PyZotero](https://github.com/urschrei/pyzotero) as well
3. https://github.com/rafaqz/citation.vim integrates with Zotero, for
    inserting citations with bibtex, but still relies on Zotero existing

Alternately, workflow could be:
1. PDF->Zotero; connector works great, gets metadata, no need to reinvent there
2. Annotate PDF, extract annotations with Zotero
3. Script to take all that and throw it in a Zettel for summarization and
   thoughts? PyZotero does this easily, `citation.vim` backend is python and
   works off of Zotero database

I'd to have the following together:
1. Paper metadata (author, title, year, venue, Zotero key)
2. Link to annotated PDF (Zotero can keep things organized, whatever)
3. Neil-written paragraph summary to scaffold understanding
4. Good enough scripting that it's easy to:
  1. Find a PDF by collection (i.e. when read in a class) -- Zotero
  2. Collect several PDFs that I'm citing into a bibtex file (easy with
     `citation.vim`)
  3. Read through Neil summarizations of papers easily, Zettel-style
  4. See paper annotations in Neil summarizations (basically done)

### Thoughts of others
* https://forum.zettelkasten.de/

