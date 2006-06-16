From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 16 Jun 2006 15:58:32 +0200
Message-ID: <20060616135832.GF1666@elf.ucw.cz>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606141846.55839.david-b@pacbell.net>
	<20060615084153.GC9423@elf.ucw.cz>
	<200606150957.42449.david-b@pacbell.net>
	<20060615180350.GG23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606151125060.5498@g5.osdl.org>
	<1150420919.7725.75.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606151840270.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606151840270.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

T24gxIx0IDE1LTA2LTA2IDE5OjI5OjQ3LCBMaW51cyBUb3J2YWxkcyB3cm90ZToKPiAKPiAKPiBP
biBGcmksIDE2IEp1biAyMDA2LCBCZW5qYW1pbiBIZXJyZW5zY2htaWR0IHdyb3RlOgo+ID4gCj4g
PiBCdXQgaG93IGNhbiB5b3Ugc2F2ZSBhIHNhdGUgYW5kIHVzZSBpdCBmb3IgcmVzdW1lIGlmIHRo
ZSBkZXZpY2UgY2FuCj4gPiBzdGlsbCBvcGVyYXRlIG9uIGZ1cnRoZXIgcmVxdWVzdHMgPyBZb3Vy
IHN0YXRlIHdvbid0IGJlIGNvbnNpc3RlbnQKPiA+IGFueW1vcmUuLi4gdGhlIHN0YXRlIHlvdXIg
cmVzdW1lIGZ1bmN0aW9uIHdpbGwgZ2V0IHdpbGwgX25vdF8gbWF0Y2ggdGhlCj4gPiBsYXN0IGtu
b3duIGhhcmR3YXJlIHN0YXRlLiBQcmV0dHkgYW5ub3lpbmcuCj4gCj4gTm90IGFubm95aW5nIGF0
IGFsbCwgYW5kIHRoZXJlIGlzIGFic29sdXRlbHkgbm8gZGlzY29ubmVjdC4KPiAKPiA+IEFsc28g
dGhhdCBtZWFucyB0aGF0IGZvciB0aGluZ3MgbGlrZSBTVEQgYW5kIGtleGVjLCB5b3Ugc3RpbGwg
bmVlZCBhCj4gPiBzZWNvbmQgc3RlcCAic3VzcGVuZCIgcGhhc2UgdG8gYWN0dWFsbHkgc3RvcCBE
TUFzIHdoaWNoIGludm9sdmUgc3RvcHBpbmcKPiA+IHByb2Nlc3NpbmcuCj4gCj4gVGhhdCdzIHRo
ZSBfcmVhbF8gc3VzcGVuZC4gVGhlIGxhc3QgdGhpbmcgeW91IGRvLiBUaGUgdGhpbmcgeW91IGRv
IF9hZnRlcl8gCj4geW91J3ZlIHNhdmVkIHRoZSBzbmFwc2hvdC4KCkJ1dCBidXQgYnV0IGJ1dCBJ
IG5lZWQgbmVlZCBuZWVkIERNQXMgc3RvcHBlZCB0byBjcmVhdGUgdGhlIGltYWdlLAp0b28uIFNv
IEkgYWN0dWFsbHkgbmVlZCBETUFzIHN0b3BwZWQgdHdvIHRpbWVzIGR1cmluZyBzdXNwZW5kIHRv
IGRpc2ssCm9uY2Ugd2hlbiBjcmVhdGluZyB0aGUgaW1hZ2UsIGFuZCBvbmNlIGFzIHRoZSBsYXN0
IHRoaW5nIEkgZG8uCgpZZXMsIGl0IGlzIGNvbmZ1c2luZywgYnV0IGl0IGFsbG93cyBtZSB0byBo
YXZlIF9hdG9taWNfIGltYWdlLCBhbmQgSQpiZWxpZXZlIHRoYXQgbWVhbnMgaXQgaXMgbGVzcyBj
b25mdXNpbmcgdGhhbiBhbHRlcm5hdGl2ZXMuCgkJCQkJCQkJUGF2ZWwKLS0gCihlbmdsaXNoKSBo
dHRwOi8vd3d3LmxpdmVqb3VybmFsLmNvbS9+cGF2ZWxtYWNoZWsKKGNlc2t5LCBwaWN0dXJlcykg
aHR0cDovL2F0cmV5Lmthcmxpbi5tZmYuY3VuaS5jei9+cGF2ZWwvcGljdHVyZS9ob3JzZXMvYmxv
Zy5odG1sCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LXBtIG1haWxpbmcgbGlzdApsaW51eC1wbUBsaXN0cy5vc2RsLm9yZwpodHRwczovL2xpc3Rz
Lm9zZGwub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcG0K
