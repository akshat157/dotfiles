-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

hl.window_rule({
  name = "thunar.Rename",
  match = {
    class = "thunar",
    title = "^(Rename.*)$",
  },
  float = true,
  center = true
})

hl.window_rule({
  name = "Spotify",
  match = {
    class = "Spotify"
  },
  workspace = 3,
  float = true,
  size = { 1600, 900 },
  center = true,
})
