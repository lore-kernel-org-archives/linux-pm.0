From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Thu, 12 Aug 2010 03:28:00 +0300
Message-ID: <AANLkTimahmGikeai8QnAxCy45deT00-6T7h-eA-NqL4G__22686.2057847486$1281573066$gmane$org@mail.gmail.com>
References: <AANLkTikyRhtfX4R3x_NDgHnXssmfVuhjC5PbhRZ0a7su@mail.gmail.com>
	<alpine.DEB.2.00.1008062010510.30564@asgard.lang.hm>
	<20100807061558.GA28087@thunk.org>
	<AANLkTi=sMVjya9CH6UoZwJCXJTDRgBhnPXmApU_RHVTi@mail.gmail.com>
	<20100808155719.GB3635@thunk.org>
	<AANLkTinM5e2HGOFavODPZNzZx4KshDSjsvKN4pLpGGgr@mail.gmail.com>
	<20100808213821.GD3635@thunk.org>
	<20100809112453.77210acc@lxorguk.ukuu.org.uk>
	<20100809181638.GI3026@linux.vnet.ibm.com>
	<AANLkTikwHaKpLdRdxmZj6JDJnsZ+o-jzbVcXhRW3Jmd9@mail.gmail.com>
	<20100811222854.GJ2516@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100811222854.GJ2516@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: paulmck@linux.vnet.ibm.com
Cc: david@lang.hm, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, linux-pm@lists.linux-foundation.org, swmike@swm.pp.se, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

T24gVGh1LCBBdWcgMTIsIDIwMTAgYXQgMToyOCBBTSwgUGF1bCBFLiBNY0tlbm5leQo8cGF1bG1j
a0BsaW51eC52bmV0LmlibS5jb20+IHdyb3RlOgo+IE9uIFdlZCwgQXVnIDExLCAyMDEwIGF0IDEw
OjE4OjUxUE0gKzAzMDAsIEZlbGlwZSBDb250cmVyYXMgd3JvdGU6Cj4+IE9uIE1vbiwgQXVnIDks
IDIwMTAgYXQgOToxNiBQTSwgUGF1bCBFLiBNY0tlbm5leQo+PiA8cGF1bG1ja0BsaW51eC52bmV0
LmlibS5jb20+IHdyb3RlOgo+PiA+IEJ1dCB3b3VsZG4ndCBhbiBvZmZpY2Ugc3VpdGUgcnVuIGFz
IGEgcG93ZXItb2JsaXZpb3VzIGFwcGxpY2F0aW9uIG9uIGFuCj4+ID4gQW5kcm9pZCBkZXZpY2U/
IMKgQWZ0ZXIgYWxsLCBvZmZpY2UgYXBwbGljYXRpb25zIGRvIG5vdCBuZWVkIHRvIHJ1biB3aGVu
Cj4+ID4gdGhlIHNjcmVlbiBpcyB0dXJuZWQgb2ZmLCBzbyB0aGVzZSB0aGUgYXBwbGljYXRpb25z
IGRvIG5vdCBuZWVkIHRvIHVzZQo+PiA+IHN1c3BlbmQgYmxvY2tlcnMuCj4+Cj4+IElkZWFsbHkg
dGhlIHN5c3RlbSB3b3VsZCBiZSBzdXNwZW5kZWQgZXZlbiB3aGVuIHRoZSBzY3JlZW4gaXMgb24u
IElmCj4+IHRoZXJlIGFyZSBubyAidHJ1c3RlZCIgYXBwbGljYXRpb25zIHJ1bm5pbmcgYXQgdGhl
IHNhbWUgdGltZSwgdGhlbgo+PiBvcGVub2ZmaWNlIHdvdWxkbid0IGxvYWQgYXQgYWxsLiBSaWdo
dD8KPgo+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBBbmRyb2lkIHN5c3RlbXMgaW4gZmFjdCBk
byBub3Qgc3VzcGVuZCB3aGVuCj4gdGhlIHNjcmVlbiBpcyBvbiwgYW5kIHRoYXQgbW9zdCAocGVy
aGFwcyBhbGwpIG90aGVyIHN5c3RlbXMgZG8gbm90Cj4gb3Bwb3J0dW5pc3RpY2FsbHkgc3VzcGVu
ZCBhdCBhbGwuIMKgVGhlcmUgaGFzIGJlZW4gc29tZSBzcGVjdWxhdGlvbiBhYm91dAo+IHdoYXQg
YSBoeXBvdGhldGljYWwgQW5kcm9pZCBoYXZpbmcgYSBub24tdm9sYXRpbGUgZGlzcGxheSBtaWdo
dCBkbywKPiBidXQgYXMgZmFyIGFzIEkga25vdywgdGhpcyBpcyBqdXN0IHNwZWN1bGF0aW9uLgoK
SSBoYXZlIGEgZGVza3RvcCBzeXN0ZW0gaW4gbWluZC4gSWYgb3Bwb3J0dW5pc3RpYyBzdXNwZW5k
IGlzIG9ubHkKdHJpZ2dlcmVkIHdoZW4gdGhlIGRpc3BsYXkgaXMgb2ZmLCB0aGVuIGl0J3Mgbm8g
Z29vZCBmb3Igbm9ybWFsIHVzYWdlLAphbmQgdGhlcmVmb3JlIGR5bmFtaWMgUEMgbmVlZHMgdG8g
Z2V0IGl0cyBhY3QgdG9nZXRoZXIuLi4gc3BlY2lhbGx5CmZvciBsYXB0b3BzLgoKLS0gCkZlbGlw
ZSBDb250cmVyYXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4LXBtQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1wbQ==
