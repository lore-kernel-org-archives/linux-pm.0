From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 18:52:19 +0200
Message-ID: <20060615165219.GD23859@elf.ucw.cz>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606141948.23107.david-b@pacbell.net>
	<20060615083921.GB9423@elf.ucw.cz>
	<200606150943.05188.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200606150943.05188.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

T24gxIx0IDE1LTA2LTA2IDA5OjQzOjA0LCBEYXZpZCBCcm93bmVsbCB3cm90ZToKPiBPbiBUaHVy
c2RheSAxNSBKdW5lIDIwMDYgMTozOSBhbSwgUGF2ZWwgTWFjaGVrIHdyb3RlOgo+ID4gCj4gPiA+
IEFjdHVhbGx5IGl0IHdvdWxkIGJlIGludGVyZXN0aW5nIHRvIGhlYXIgY291bnRlci1hcmd1bWVu
dHMgdG8gdGhpcwo+ID4gPiBwb3NpdGlvbjoKPiA+ID4gCj4gPiA+IAlXZSBhbHJlYWR5IEhBVkUg
dGhhdCB0d28tcGhhc2UgdGhpbmcgZ29pbmcgb24sIGF0Cj4gPiA+IAlsZWFzdCBmb3Igc3dzdXNw
LiAgSW4gcGhhc2UgSSBhIFBNX0VWRU5UX0ZSRUVaRQo+ID4gPiAJZ2V0cyBzZW50LiAgVGhlbiBp
biBwaGFzZSBJSSBhIFBNX0VWRU5UX1NVU1BFTkQgZ2V0cwo+ID4gPiAJdHJpZXMgdG8gcmVhbGx5
IHN1c3BlbmQgdGhpbmdzLgo+ID4gPiAKPiA+ID4gT25lIGNvdW50ZXItYXJndW1lbnQgbWlnaHQg
YmUgdGhhdCAicGhhc2UgSS41IHJlc3VtZXMgdGhvc2UgZGV2aWNlcyIKPiA+ID4gaXMgYSBwcm9i
bGVtLiAgQW5vdGhlciBtaWdodCBiZSB0aGF0ICJGUkVFWkUgc2hvdWxkIG5vdCBiZSBzZW50IHRv
Cj4gPiA+IHRoZSBjb25zb2xlKHMpLCB0aGUgc3dhcCBkZXZpY2UsIG9yIHRoZWlyIHBhcmVudHMi
LiAgSSBzdXNwZWN0IHRoZXJlCj4gPiA+IGFyZSBhIGZldyBtb3JlIGlzc3VlcyBtaXhlZCB1cCBp
biB0aGVyZSB0b28uCj4gPiAKPiA+IFRoaXMgaXMgRkFROgo+IAo+IFdoaWNoIHNlZW1zIHRvIHN1
Z2dlc3QgdGhhdCB5b3UgYXJlIEZyZXF1ZW50bHkgZ2l2aW5nIGEgdXNlbGVzcwo+IEFuc3dlciB0
byB0aGUgUXVlc3Rpb24gLi4uIGFuZCBpbiB0aGlzIGNhc2UsIG5vdCB0aGUgcXVlc3Rpb24KPiB3
aGljaCB3YXMgYXNrZWQuICAKCk9rYXksIHNvIHdoYXQgaXMgdGhlIHF1ZXN0aW9uIHlvdSBhcmUg
YXNraW5nPwoKPiA+IFE6IEkgZG8gbm90IHVuZGVyc3RhbmQgd2h5IHlvdSBoYXZlIHN1Y2ggc3Ry
b25nIG9iamVjdGlvbnMgdG8gaWRlYSBvZgo+ID4gc2VsZWN0aXZlIHN1c3BlbmQuCj4gCj4gTm90
IGEgcXVlc3Rpb24sIGFuZCBpdCdzIG5vdCBjbGVhciB3aG8gInlvdSIgaXMuICBQcmVzdW1hYmx5
LCAiUGF2ZWwiPwo+IFBsdXMgaXQgZG9lc24ndCByZWxhdGUgdG8gdGhlIHBvc2l0aW9uIHNrZXRj
aGVkIGFib3ZlLgoKRmVlbCBmcmVlIHRvIHN1Ym1pdCBkb2N1bWVudGF0aW9uIHBhdGNoLgoJCQkJ
CQkJCQlQYXZlbAotLSAKKGVuZ2xpc2gpIGh0dHA6Ly93d3cubGl2ZWpvdXJuYWwuY29tL35wYXZl
bG1hY2hlawooY2Vza3ksIHBpY3R1cmVzKSBodHRwOi8vYXRyZXkua2FybGluLm1mZi5jdW5pLmN6
L35wYXZlbC9waWN0dXJlL2hvcnNlcy9ibG9nLmh0bWwKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4LXBtQGxp
c3RzLm9zZGwub3JnCmh0dHBzOi8vbGlzdHMub3NkbC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1wbQo=
