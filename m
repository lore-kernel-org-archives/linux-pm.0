From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 03/10] x86: assembly,
	use SYM_FUNC_END for functions
Date: Wed, 22 Mar 2017 08:29:16 +0100
Message-ID: <20170322072916.GB13904@gmail.com>
References: <9ea5e137-61f9-dccc-bb9d-ac3ff86e5867@suse.cz>
 <20170320123222.15453-1-jslaby@suse.cz>
 <20170320123222.15453-3-jslaby@suse.cz>
 <20170321144841.oeaqqarhgzyhehth@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <20170321144841.oeaqqarhgzyhehth@treble>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, linux-pm@vger.kernel.org, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, mingo@redhat.com, Pavel Machek <pavel@ucw.cz>, hpa@zytor.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-pm@vger.kernel.org

CiogSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQHJlZGhhdC5jb20+IHdyb3RlOgoKPiBPbiBNb24s
IE1hciAyMCwgMjAxNyBhdCAwMTozMjoxNVBNICswMTAwLCBKaXJpIFNsYWJ5IHdyb3RlOgo+ID4g
IEVOVFJZKGZ0cmFjZV9jYWxsZXIpCj4gPiAgCS8qIHNhdmVfbWNvdW50X3JlZ3MgZmlsbHMgaW4g
Zmlyc3QgdHdvIHBhcmFtZXRlcnMgKi8KPiA+IEBAIC0xODQsMTEgKzE4NCwxMiBAQCBHTE9CQUwo
ZnRyYWNlX2VwaWxvZ3VlKQo+ID4gIEdMT0JBTChmdHJhY2VfZ3JhcGhfY2FsbCkKPiA+ICAJam1w
IGZ0cmFjZV9zdHViCj4gPiAgI2VuZGlmCj4gPiArU1lNX0ZVTkNfRU5EKGZ0cmFjZV9jYWxsZXIp
Cj4gPiAgCj4gPiAgLyogVGhpcyBpcyB3ZWFrIHRvIGtlZXAgZ2FzIGZyb20gcmVsYXhpbmcgdGhl
IGp1bXBzICovCj4gPiAgV0VBSyhmdHJhY2Vfc3R1YikKPiA+ICAJcmV0cQo+ID4gLUVORChmdHJh
Y2VfY2FsbGVyKQo+ID4gK1NZTV9GVU5DX0VORChmdHJhY2VfY2FsbGVyKQo+IAo+IFRoaXMgZ2l2
ZXMgZnRyYWNlX2NhbGxlcigpIHR3byBlbmRzLgoKU3VjaCBlcnJvcnMgdG9vIGNvdWxkIGJlIGRl
dGVjdGVkIGF1dG9tYXRpY2FsbHkgdmlhIG9ianRvb2wgb3Igc29tZSBvdGhlciBzeW1ib2wgCmRl
YnVnIG1lY2hhbmlzbS4KClRoZSByZWFzb24gaXQgbWlnaHQgYmUgYSBnb29kIGZpdCBmb3Igb2Jq
dG9vbCBpcyB0byBtYWtlIHRoZSBjaGVja2luZyBvcHRpb25hbCAobm8gCm5lZWQgdG8gYnVyZGVu
IGEgcmVndWxhciBidWlsZCB3aXRoIGl0KSwgcGx1cyBvYmp0b29sIGFscmVhZHkgbG9va3MgYXQg
dGhlIC5vIGZyb20gCmZpcnN0IHByaW5jaXBsZXMgLSBhIHN5bWJvbCBjaGVja2luZyBzdWItZnVu
Y3Rpb25hbGl0eSBjb3VsZCBhbmFseXplIHRoZSBzeW1ib2wgCm5hbWVzIGluIHRoZSBzYW1lIHBh
c3MuCgpJZiB3ZSB3YW50IHRvIGNvbXBsaWNhdGUgdGhpbmdzIHdpdGggQ0ZJIHRoZW4gd2UgYWJz
b2x1dGVseSBzaG91bGQgaW5jcmVhc2UgdGhlIApxdWFsaXR5IG9mIG91ciBzeW1ib2wgbmFtZXMg
c3BhY2UuCgpUaGFua3MsCgoJSW5nbwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KWGVuLWRldmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVu
Lm9yZwpodHRwczovL2xpc3RzLnhlbi5vcmcveGVuLWRldmVsCg==
