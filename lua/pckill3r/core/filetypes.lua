-- Filetype extensions
vim.filetype.add({
  extension = {
    templ = "templ",
  },
  pattern = {
    -- [".*%.component%.html"] = "html", 
    -- [".*%.template%.html"] = "html",
    -- [".*%.container%.html"] = "html",
    [".*%.component%.html"] = "htmlangular",
    [".*%.template%.html"] = "htmlangular",
    [".*%.container%.html"] = "htmlangular",
  },
})
