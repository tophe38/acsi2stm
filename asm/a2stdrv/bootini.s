; ACSI2STM Atari hard drive emulator
; Copyright (C) 2019-2022 by Jean-Matthieu Coulon

; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <https://www.gnu.org/licenses/>.

; ACSI2STM integrated driver
; Wrapper for boot loaded driver. Checks if already installed.

bootini	; Check if the driver is already installed
.nxtvec	move.l	bios.vector.w,a0
	cmp.l	#'XBRA',-12(a0)
	bne.b	.notins

	cmp.l	#'A2ST',-8(a0)
	bne.b	.na2st

	pea	0(pc)                   ; Already installed: free memory
	gemdos	Mfree,6                 ;
	rts                             ; then exit

.na2st	move.l	-4(a0),a0
	bra.b	.nxtvec

.notins	; Fall through the rest of the code

; vim: ff=dos ts=8 sw=8 sts=8 noet colorcolumn=8,41,81 ft=asm tw=80
