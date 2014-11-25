$(document).ready ->
  $("#demosMenu").change ->
    window.location.href = $(this).find("option:selected").attr("id") + ".html"
    return

  return
