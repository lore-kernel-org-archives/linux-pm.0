From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 23:02:19 -0700
Message-ID: <200606152302.20944.david-b@pacbell.net>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606150943.05188.david-b@pacbell.net>
	<20060615165219.GD23859@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060615165219.GD23859@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

T24gVGh1cnNkYXkgMTUgSnVuZSAyMDA2IDk6NTIgYW0sIFBhdmVsIE1hY2hlayB3cm90ZToKPiBP
biDEjHQgMTUtMDYtMDYgMDk6NDM6MDQsIERhdmlkIEJyb3duZWxsIHdyb3RlOgo+ID4gT24gVGh1
cnNkYXkgMTUgSnVuZSAyMDA2IDE6MzkgYW0sIFBhdmVsIE1hY2hlayB3cm90ZToKPiA+ID4gCj4g
PiA+ID4gQWN0dWFsbHkgaXQgd291bGQgYmUgaW50ZXJlc3RpbmcgdG8gaGVhciBjb3VudGVyLWFy
Z3VtZW50cyB0byB0aGlzCj4gPiA+ID4gcG9zaXRpb246Cj4gPiA+ID4gCj4gPiA+ID4gCVdlIGFs
cmVhZHkgSEFWRSB0aGF0IHR3by1waGFzZSB0aGluZyBnb2luZyBvbiwgYXQKPiA+ID4gPiAJbGVh
c3QgZm9yIHN3c3VzcC4gIEluIHBoYXNlIEkgYSBQTV9FVkVOVF9GUkVFWkUKPiA+ID4gPiAJZ2V0
cyBzZW50LiAgVGhlbiBpbiBwaGFzZSBJSSBhIFBNX0VWRU5UX1NVU1BFTkQgZ2V0cwo+ID4gPiA+
IAl0cmllcyB0byByZWFsbHkgc3VzcGVuZCB0aGluZ3MuCj4gPiA+ID4gCj4gPiA+ID4gT25lIGNv
dW50ZXItYXJndW1lbnQgbWlnaHQgYmUgdGhhdCAicGhhc2UgSS41IHJlc3VtZXMgdGhvc2UgZGV2
aWNlcyIKPiA+ID4gPiBpcyBhIHByb2JsZW0uICBBbm90aGVyIG1pZ2h0IGJlIHRoYXQgIkZSRUVa
RSBzaG91bGQgbm90IGJlIHNlbnQgdG8KPiA+ID4gPiB0aGUgY29uc29sZShzKSwgdGhlIHN3YXAg
ZGV2aWNlLCBvciB0aGVpciBwYXJlbnRzIi4gIEkgc3VzcGVjdCB0aGVyZQo+ID4gPiA+IGFyZSBh
IGZldyBtb3JlIGlzc3VlcyBtaXhlZCB1cCBpbiB0aGVyZSB0b28uCj4gPiA+IAo+ID4gPiBUaGlz
IGlzIEZBUToKPiA+IAo+ID4gV2hpY2ggc2VlbXMgdG8gc3VnZ2VzdCB0aGF0IHlvdSBhcmUgRnJl
cXVlbnRseSBnaXZpbmcgYSB1c2VsZXNzCj4gPiBBbnN3ZXIgdG8gdGhlIFF1ZXN0aW9uIC4uLiBh
bmQgaW4gdGhpcyBjYXNlLCBub3QgdGhlIHF1ZXN0aW9uCj4gPiB3aGljaCB3YXMgYXNrZWQuICAK
PiAKPiBPa2F5LCBzbyB3aGF0IGlzIHRoZSBxdWVzdGlvbiB5b3UgYXJlIGFza2luZz8KCldoYXQg
eW91IHF1b3RlZCBhYm92ZSB3YXMgdGhlIHRvcGljIC4uLiBub3QgcHJlY2lzZWx5IGEgcXVlc3Rp
b24sCm1vcmUgb2YgYSAiY29tcGFyZSBhbmQgY29udHJhc3QiIHdoYXQgd2UgaGF2ZSB0b2RheSB3
aXRoIHdoYXQgTGludXMKd2FzIHRhbGtpbmcgYWJvdXQuCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1wbSBtYWlsaW5nIGxpc3QKbGludXgtcG1A
bGlzdHMub3NkbC5vcmcKaHR0cHM6Ly9saXN0cy5vc2RsLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LXBtCg==
