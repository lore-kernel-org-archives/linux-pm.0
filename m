From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 01/10] x86: assembly, ENTRY for fn,
	GLOBAL for data
Date: Wed, 1 Mar 2017 11:27:54 +0100
Message-ID: <20170301102754.GA13374@gmail.com>
References: <20170217104757.28588-1-jslaby@suse.cz>
 <20170301093855.GA27152@gmail.com>
 <alpine.DEB.2.20.1703011108220.4005@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1703011108220.4005@nanos>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>, Len Brown <len.brown@intel.com>, hpa@zytor.com, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-pm@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, mingo@redhat.com, Pavel Machek <pavel@ucw.cz>, jpoimboe@redhat.com, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

CiogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+IHdyb3RlOgoKPiBPbiBXZWQs
IDEgTWFyIDIwMTcsIEluZ28gTW9sbmFyIHdyb3RlOgo+ID4gCj4gPiAqIEppcmkgU2xhYnkgPGpz
bGFieUBzdXNlLmN6PiB3cm90ZToKPiA+IAo+ID4gPiBUaGlzIGlzIGEgc3RhcnQgb2Ygc2VyaWVz
IHRvIHVuaWZ5IHVzZSBvZiBFTlRSWSwgRU5EUFJPQywgR0xPQkFMLCBFTkQsCj4gPiA+IGFuZCBv
dGhlciBtYWNyb3MgYWNyb3NzIHg4Ni4gV2hlbiB3ZSBoYXZlIGFsbCB0aGlzIHNvcnRlZCBvdXQs
IHRoaXMgd2lsbAo+ID4gPiBoZWxwIHRvIGluamVjdCBEV0FSRiB1bndpbmRpbmcgaW5mbyBieSBv
Ymp0b29sIGxhdGVyLgo+ID4gPiAKPiA+ID4gU28sIGxldCB1cyB1c2UgdGhlIG1hY3JvcyB0aGlz
IHdheToKPiA+ID4gKiBFTlRSWSAtLSBzdGFydCBvZiBhIGdsb2JhbCBmdW5jdGlvbgo+ID4gPiAq
IEVORFBST0MgLS0gZW5kIG9mIGEgbG9jYWwvZ2xvYmFsIGZ1bmN0aW9uCj4gPiA+ICogR0xPQkFM
IC0tIHN0YXJ0IG9mIGEgZ2xvYmFsbHkgdmlzaWJsZSBkYXRhIHN5bWJvbAo+ID4gPiAqIEVORCAt
LSBlbmQgb2YgbG9jYWwvZ2xvYmFsIGRhdGEgc3ltYm9sCj4gPiAKPiA+IFNvIGhvdyBhYm91dCB1
c2luZyBtYWNybyBuYW1lcyB0aGF0IGFjdHVhbGx5IHNob3cgdGhlIHB1cnBvc2UsIGluc3RlYWQg
b2YgCj4gPiBpbXBvcnRpbmcgYWxsIHRoZSBjcmFwcHksIGhpc3RvcmljLCBlc3NlbnRpYWxseSBy
YW5kb21seSBjaG9zZW4gZGVidWcgc3ltYm9sIG1hY3JvIAo+ID4gbmFtZXMgZnJvbSB0aGUgYmlu
dXRpbHMgYW5kIG9sZGVyIGtlcm5lbHM/Cj4gPiAKPiA+IFNvbWV0aGluZyBzYW5lLCBsaWtlOgo+
ID4gCj4gPiAJU1lNX19GVU5DVElPTl9TVEFSVAo+IAo+IFNhbmUgd291bGQgYmU6Cj4gCj4gICAg
ICAJU1lNX0ZVTkNUSU9OX1NUQVJUCj4gCj4gVGhlIGRvdWJsZSB1bmRlcnNjb3JlIGlzIGp1c3Qg
bm90IGdpdmluZyBhbnkgdmFsdWUuCgpTbyB0aGUgZG91YmxlIHVuZGVyc2NvcmUgKGF0IGxlYXN0
IGluIG15IHZpZXcpIGhhcyB0d28gYWR2YW50YWdlczoKCjEpIGl0IGhlbHBzIHNlcGFyYXRlIHRo
ZSBwcmVmaXggZnJvbSB0aGUgcG9zdGZpeC4KCkkuZS4gaXQncyBhICdzeW1ib2xzJyBuYW1lc3Bh
Y2UsIGFuZCBhICdmdW5jdGlvbiBzdGFydCcsIG5vdCB0aGUgJ3N0YXJ0JyBvZiBhIAonc3ltYm9s
IGZ1bmN0aW9uJy4KCjIpIEl0IGFsc28gaGVscHMgZWFzeSBncmVwcGFiaWxpdHkuCgpUcnkgdGhp
cyBpbiBsYXRlc3QgLXRpcDoKCiAgZ2l0IGdyZXAgZTgyMF9fCgpUbyBzZWUgYWxsIHRoZSBFODIw
IEFQSSBjYWxscyAtIHdpdGggbm8gZmFsc2UgcG9zaXRpdmVzIQoKJ2dpdCBncmVwIGU4MjBfJyBv
biB0aGUgb3RoZXIgaGFuZCBpcyBhIGxvdCBsZXNzIHJlbGlhYmxlLi4uCgpCdXQgbm8gc3Ryb25n
IGZlZWxpbmdzIGVpdGhlciB3YXksIEkganVzdCB0cnkgdG8gc25lYWsgaW4gdGhlc2Ugc21hbGwg
bmFtZXNwYWNlIApzdHJ1Y3R1cmUgdHJpY2tzIHdoZW4gbm9ib2R5J3MgbG9va2luZyEgOy0pCgpU
aGFua3MsCgoJSW5nbwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KWGVuLWRldmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVuLm9yZwpodHRw
czovL2xpc3RzLnhlbi5vcmcveGVuLWRldmVsCg==
