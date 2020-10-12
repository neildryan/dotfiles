" MIT License. Copyright (c) 2013-2020 Bailey Ling et al.
" vim: et ts=2 sts=2 sw=2 tw=80

scriptencoding utf-8

" For this, the dogrun.vim, theme, this is defined as
let g:airline#themes#dogrun#palette = {}

" Keys in the dictionary are composed of the mode, and if specified the
" override.  For example:
"   * g:airline#themes#dogrun#palette.normal
"       * the colors for a statusline while in normal mode
"   * g:airline#themes#dogrun#palette.normal_modified
"       * the colors for a statusline while in normal mode when the buffer has
"         been modified
"   * g:airline#themes#dogrun#palette.visual
"       * the colors for a statusline while in visual mode
"
" Values for each dictionary key is an array of color values that should be
" familiar for colorscheme designers:
"   * [guifg, guibg, ctermfg, ctermbg, opts]
" See "help attr-list" for valid values for the "opt" value.
"
" Each theme must provide an array of such values for each airline section of
" the statusline (airline_a through airline_z).  A convenience function,
" airline#themes#generate_color_map() exists to mirror airline_a/b/c to
" airline_x/y/z, respectively.

" let s:airline_b_normal   = [ '#282a3a' , '#4b4e6d' , 255 , 238 ]
" The dogrun.vim theme:
let s:airline_a_normal   = [ '#929be5' , '#424453' , 104, 235]
let s:airline_b_normal   = [ '#727bc5' , '#323443' , 255 , 238 ]
let s:airline_c_normal   = [ '#929be5' , '#222433' , 85  , 234 ]
let g:airline#themes#dogrun#palette.normal = airline#themes#generate_color_map(s:airline_a_normal, s:airline_b_normal, s:airline_c_normal)

" Here we define overrides for when the buffer is modified.  This will be
" applied after g:airline#themes#dogrun#palette.normal, hence why only certain keys are
" declared.
" let g:airline#themes#dogrun#palette.normal_modified = {
"       \ 'airline_c': [ '#ffffff' , '#5f005f' , 255     , 53      , ''     ] ,
"       \ }

let s:airline_a_insert = [ '#73c1a9' , '#424453' , 17  , 45  ]
let s:airline_b_insert = [ '#73c1a9' , '#333443' , 255 , 27  ]
let g:airline#themes#dogrun#palette.insert = airline#themes#generate_color_map(s:airline_a_insert, s:airline_b_insert, s:airline_c_normal)
"
let g:airline#themes#dogrun#palette.insert_paste = {
      \ 'airline_a': [ s:airline_a_insert[0]   , '#d78700' , s:airline_a_insert[2] , 172     , ''     ] ,
      \ }

let g:airline#themes#dogrun#palette.terminal = airline#themes#generate_color_map(s:airline_a_insert, s:airline_b_insert, s:airline_c_normal)

let s:airline_a_replace = ['#f56574', '#424453', s:airline_b_insert[2] , 124]
let s:airline_b_replace = ['#f56574', '#424453', s:airline_b_insert[2] , 124]
let g:airline#themes#dogrun#palette.replace = airline#themes#generate_color_map(s:airline_a_replace, s:airline_b_replace, s:airline_c_normal)

let s:airline_a_visual = [ '#c173c1' , '#424453' , 232 , 214 ]
let s:airline_b_visual = [ '#c173c1' , '#333443' , 232 , 202 ]
let g:airline#themes#dogrun#palette.visual = airline#themes#generate_color_map(s:airline_a_visual, s:airline_b_visual, s:airline_c_normal)

let s:airline_a_inactive = [ '#4e4e4e' , '#1c1c1c' , 239 , 234 , '' ]
let s:airline_b_inactive = [ '#4e4e4e' , '#262626' , 239 , 235 , '' ]
let s:airline_c_inactive = [ '#6e6e6e' , '#232433' , 239 , 236 , '' ]
let g:airline#themes#dogrun#palette.inactive = airline#themes#generate_color_map(s:airline_a_inactive, s:airline_b_inactive, s:airline_c_inactive)

" Accents are used to give parts within a section a slightly different look or
" color. Here we are defining a "red" accent, which is used by the 'readonly'
" part by default. Only the foreground colors are specified, so the background
" colors are automatically extracted from the underlying section colors. What
" this means is that regardless of which section the part is defined in, it
" will be red instead of the section's foreground color. You can also have
" multiple parts with accents within a section.
let g:airline#themes#dogrun#palette.accents = {
      \ 'red': [ '#ff0000' , '' , 160 , ''  ]
      \ }


" Here we define the color map for ctrlp.  We check for the g:loaded_ctrlp
" variable so that related functionality is loaded if the user is using
" ctrlp. Note that this is optional, and if you do not define ctrlp colors
" they will be chosen automatically from the existing palette.
"
if get(g:, 'loaded_ctrlp', 0)
  let g:airline#themes#dogrun#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
        \ [ '#d7d7ff' , '#5f00af' , 189 , 55  , ''     ],
        \ [ '#ffffff' , '#875fd7' , 231 , 98  , ''     ],
        \ [ '#5f00af' , '#ffffff' , 55  , 231 , 'bold' ])
endif
