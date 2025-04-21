-- Reload modules easily (use :lua R("module.name"))
function R(name)
    require("plenary.reload").reload_module(name)
end
