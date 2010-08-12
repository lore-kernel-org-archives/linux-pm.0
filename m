From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Thu, 12 Aug 2010 19:57:39 +0300
Message-ID: <AANLkTik=K2znpgiHVgA1oD5Znrmm0Gx45ajfoQ7AwG3F__9241.0787394785$1281632305$gmane$org@mail.gmail.com>
References: <20100809181638.GI3026@linux.vnet.ibm.com>
	<AANLkTikwHaKpLdRdxmZj6JDJnsZ+o-jzbVcXhRW3Jmd9@mail.gmail.com>
	<20100811222854.GJ2516@linux.vnet.ibm.com>
	<AANLkTimahmGikeai8QnAxCy45deT00-6T7h-eA-NqL4G@mail.gmail.com>
	<20100812010612.GL2516@linux.vnet.ibm.com>
	<AANLkTinVV1NVHFPeO0p_e2pCtNwTNB932q9tbu9MMD3_@mail.gmail.com>
	<20100812034435.GA7403@linux.vnet.ibm.com>
	<AANLkTi=RD=eM_gpc7FfRq0923sUbARmZ2+4-m+fLibYC@mail.gmail.com>
	<E3F3D3E1-4DF7-47E3-895D-95F6BC22CCC4@mit.edu>
	<AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<20100812140903.GB11362@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100812140903.GB11362@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: peterz@infradead.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, galibert@pobox.com, florian@mickler.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, James.Bottomley@suse.de, tglx@linutronix.de, swmike@swm.pp.se, david@lang.hm, Theodore Tso <tytso@mit.edu>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, menage@google.com, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

T24gVGh1LCBBdWcgMTIsIDIwMTAgYXQgNTowOSBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIFRodSwgQXVnIDEyLCAyMDEwIGF0
IDAyOjExOjIyUE0gKzAzMDAsIEZlbGlwZSBDb250cmVyYXMgd3JvdGU6Cj4KPj4gU28gZmFyLCBu
b2JvZHkgaGFzIHJlZnV0ZWQgdGhlc2U6Cj4+IMKgMSkgb3Bwb3J0dW5pc3RpYyBzdXNwZW5kIG5l
ZWRzIGEgZ29vZCBiZWhhdmVkIHVzZXItc3BhY2UgdG8gd29yayBwcm9wZXJseQo+PiDCoDIpIGlm
IHN1c3BlbmQgYmxvY2tlcnMgYXJlIGVuYWJsZWQgaW4gYSBzeXN0ZW0sICphbGwqIHVzZXItc3Bh
Y2UgbXVzdAo+PiBpbXBsZW1lbnQgdGhlbSB0byB3b3JrIGNvcnJlY3RseQo+Cj4gRm9yIHRoaXMg
bm90ZSB0aGF0IHRoZXJlJ3MgYSBmYWlybHkgc3Ryb25nIGV4cGVjdGF0aW9uIHRoYXQgZXZlbiBp
biBhCj4gcGhvbmUgdHlwZSBlbnZpcm9ubWVudCBhIHNhbmUgdXNlcnNwYWNlIGltcGxlbWVudGF0
aW9uIHdpbGwgaW52b2x2ZSBhCj4gdmVyeSBsYXJnZSBwb3J0aW9uIG9mIHVzZXJzcGFjZSBqdXN0
IHRvdGFsbHkgaWdub3Jpbmcgc3VzcGVuZCBibG9ja2Vycy4KPiBUaGlzIG1lYW5zIHRoYXQgd2hp
bGUgaXQgaXMgdHJ1ZSB0aGF0IHVzZXJzcGFjZSBhcyBhIHdob2xlIG11c3QgaGF2ZQo+IHN1cHBv
cnQgZm9yIHN1c3BlbmQgYmxvY2tlcnMgdGhlIGNoYW5nZXMgcmVxdWlyZWQgYXJlIHN1YnN0YW50
aWFsbHkgbGVzcwo+IGludmFzaXZlIHRoYW4geW91IGFwcGVhciB0byBleHBlY3RpbmcuCgpDb3Jy
ZWN0LCBidXQgc3RpbGwgYSBjb25zaWRlcmFibGUgYW1vdW50IG9mIGNoYW5nZXMgd291bGQgbmVl
ZCB0byBiZQpkb25lLCB3aGljaCBfbm9ib2R5XyBoYXMgZXhwcmVzc2VkIGFueSBpbnRlbnRpb24g
dG8gZG8uCgpCZXNpZGVzLCBJTU8gYSBnb29kIG1vYmlsZSBwbGF0Zm9ybSB3b3VsZCBzaGFyZSBh
cyBtdWNoIGFzIHBvc3NpYmxlCndpdGggZGVza3RvcCBzb2Z0d2FyZS4gU2F5LCB0aGUgaW1wcm92
ZW1lbnRzIE5va2lhIGhhcyBlbmRvcnNlZCBvbiB0aGUKVGVsZXBhdGh5IElNIGZyYW1ld29yayBj
YW4gb25seSBoZWxwIHRoZSBwZW9wbGUgYWxyZWFkeSB1c2luZyBpdCBvbgp0aGUgZGVza3RvcC4K
Ckhvd2V2ZXIsIHBlcnNvbmFsbHksIGlmIEkgZXZlciBoYXZlIHRvIGRvICcuL2NvbmZpZ3VyZQot
LWVuYWJsZS1zdXNwZW5kLWJsb2NrZXJzJywgSSB3b3VsZCB0aGluayB0aGF0IHNvbWV0aGluZyB0
aGF0IGp1c3QKZG9lc24ndCBiZWxvbmcgaGFzIGNyZXBlZCBieSB0byB1c2VyLXNwYWNlLiBJIGRv
bid0IHNlZSB3aHkgdGhlcmUKc2hvdWxkIHNvbWV0aGluZyBwYXJ0aWN1bGFybHkgZGlmZmVyZW50
IGJldHdlZW4gbW9iaWxlIHBob25lcyBhbmQKbGFwdG9wcywgYW5kIEkgdGhpbmsgdGhpcyBoYXMg
YmVlbiBhbHJlYWR5IGV4cHJlc3NlZCBvdmVyLCBhbmQgb3Zlci4KCi0tIApGZWxpcGUgQ29udHJl
cmFzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LXBtIG1haWxpbmcgbGlzdApsaW51eC1wbUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcG0=
