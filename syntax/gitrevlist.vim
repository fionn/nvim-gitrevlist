syn match gitrevlistHash "\<\x\{40}\>\|\<\x\{64}\>" contains=@NoSpell nextgroup=gitrevlistComment skipwhite
syn match gitrevlistComment "#.*$"

hi def link gitrevlistHash Identifier
hi def link gitrevlistComment Comment
