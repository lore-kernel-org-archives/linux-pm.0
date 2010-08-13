From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Fri, 13 Aug 2010 13:58:12 +0300
Message-ID: <AANLkTin3H0o+WQocUYjUcPGRpkRqK9H2LJ0OwHXFNBdj__44030.7811405093$1281697143$gmane$org@mail.gmail.com>
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
	<20100812174303.GD2524@linux.vnet.ibm.com>
	<AANLkTim1U6QpRyfwYCq2uRA=7-a8ryfDrzv5VCqmHnyB@mail.gmail.com>
	<AANLkTinNxZoMab=tG9KXJ9n_nxB1dXHkfk-7xUMWXACW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinNxZoMab=tG9KXJ9n_nxB1dXHkfk-7xUMWXACW@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: david@lang.hm, Theodore Tso <tytso@mit.edu>, peterz@infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, swmike@swm.pp.se, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

T24gVGh1LCBBdWcgMTIsIDIwMTAgYXQgMTA6NDggUE0sIEJyaWFuIFN3ZXRsYW5kIDxzd2V0bGFu
ZEBnb29nbGUuY29tPiB3cm90ZToKPiBPbiBUaHUsIEF1ZyAxMiwgMjAxMCBhdCAxMjozNCBQTSwg
RmVsaXBlIENvbnRyZXJhcwo+IDxmZWxpcGUuY29udHJlcmFzQGdtYWlsLmNvbT4gd3JvdGU6Cj4+
Cj4+IE5vdCBVYnVudHUsIG5vdCBGZWRvcmEsIG5vdCBNZWVHbywgbm90IGFueW9uZSB3aXRoIGEg
dHlwaWNhbAo+PiB1c2VyLXNwYWNlIHNlZW1zIHRvIGJlIGhhdmluZyB0aGlzIHByb2JsZW0uIEkg
Y2FuIGFyZ3VlIHRvIHlvdSB0aGF0Cj4+IHRoaXMgcHJvYmxlbSBjYW4gYmUgc29sdmVkIGluIGVh
c2llciB3YXlzLCBidXQgaW5zdGVhZCBJIHdpbGwgYXJndWUKPj4gdGhhdCBwZXJoYXBzIHdlIHNo
b3VsZCB3YWl0IGZvciBzb21lYm9keSBiZXNpZGVzIEFuZHJvaWQgdG8gY29tcGxhaW4KPj4gYWJv
dXQgaXQgYmVmb3JlIHByb3ZpZGluZyBhICJzb2x1dGlvbiIuIEJlY2F1c2UgYWZ0ZXIgYWxsLCB3
aGF0IGdvb2QKPj4gaXMgYSAic29sdXRpb24iIHByb3ZpZGVkIGJ5IHRoZSBrZXJuZWwsIGlmIHRo
ZSB1c2VyLXNwYWNlIGlzIG5vdCBnb2luZwo+PiB0byB1c2UgaXQsIGV2ZXIuCj4KPiBJJ20gY3Vy
aW91cywgd2hlbiBkb2VzIEFuZHJvaWQgY291bnQgYXMgYSB1c2VyIG9mIHRoZSBrZXJuZWw/IMKg
SQo+IGdhdGhlciB0aGF0IHZvbHVtZSBvZiBzYWxlcyBvciB1c2VycyBkb2Vzbid0IGNvdW50LiDC
oERvIHdlIGhhdmUgdG8KPiBpbmNsdWRlIHNvbWUgcGVyY2VudGFnZSBvZiAiZGVza3RvcCIgTGlu
dXg/CgpZb3UgYXJlICpvbmUqIHVzZXIgb2YgdGhlIGtlcm5lbC4gTGV0J3Mgc3VwcG9zZSBBbmRy
b2lkIHdhc24ndCB1c2luZwpzdXNwZW5kLWJsb2NrZXJzLCBhbmQgdGhlcmUgd2FzIGFub3RoZXIg
ZXF1YWxseSBzdWNjZXNzZnVsIGxpbnV4Cm1vYmlsZSBwbGF0Zm9ybSwgRm9vYmluZ28sIGFuZCB0
aGV5IHdlcmUgdXNpbmcgdGhlbSwgYW5kIHRoZXkgd2VyZSB0aGUKb25seSBvbmVzIGludGVyZXN0
ZWQgb24gaW1wbGVtZW50aW5nIHRoZW0uCgpXaGF0IGRvZXMgdGhhdCBjaGFuZ2U/IE5vdGhpbmcu
IFRoZXkgc3RpbGwgbmVlZCB0byBjb252aW5jZSB0aGUKY29tbXVuaXR5IHRoYXQgd2hhdCB0aGV5
IGFyZSBwcm9wb3NpbmcgdG8gYmUgbWVyZ2VkIGlzIGFjdHVhbGx5CnVzZWZ1bCwgYW5kIHNvbWVi
b2R5IHdpbGwgdXNlIGl0LiBJZiBub3QsIHRoZXkgY2FuIGp1c3Qga2VlcCB0aGUgcGF0Y2gKZm9y
IHRoZW1zZWx2ZXMgdW50aWwgdGhleSBkby4gSSBkb24ndCBzZWUgdGhlIGJpZyBkZWFsLgoKPiBJ
ZiB3ZSdyZSBhbiB1bmRlc2lyYWJsZSBzZWNvbmQtY2xhc3MgY2l0aXplbiwgd2h5IGRvIHBlb3Bs
ZSBjYXJlIHRoYXQKPiAiYW5kcm9pZCBpcyBmb3JraW5nIHRoZSBrZXJuZWwiPwoKTm9ib2R5IGhh
cyBleHByZXNzZWQgYW55dGhpbmcgcmVtb3RlbHkgbGlrZSB0aGF0ICh0aGF0IHlvdSBhcmUgYQpz
ZWNvbmQtY2xhc3MgY2l0aXplbikuIFdoeSBtYWtlcyB5b3UgdGhpbmsgc28/IExvdHMgb2YgcGVv
cGxlIGdldApwYXRjaGVzIGRlbmllZC4gTGlrZSBOb2tpYSdzIHVfY2hhciBkcml2ZXIsIHdoaWNo
IGlzICp3YXkqIGxlc3MKY29udHJvdmVyc2lhbCB0aGFuIHRoaXMgb25lLgoKLS0gCkZlbGlwZSBD
b250cmVyYXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4LXBtQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1wbQ==
