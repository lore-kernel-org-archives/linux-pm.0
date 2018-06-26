From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 14/23] dt-bindings: cp110: prepare the syscon file to
 list other syscons nodes
Date: Tue, 26 Jun 2018 09:34:10 +0200
Message-ID: <20180626093410.2d9f815c@xps13>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-15-miquel.raynal@bootlin.com>
 <20180626033556.bsub25ykdseflsta@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180626033556.bsub25ykdseflsta@tarshish>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Eduardo Valentin <edubezval@gmail.com>, David Sniatkiwicz <davidsn@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

SGkgQmFydWNoLAoKT24gVHVlLCAyNiBKdW4gMjAxOCAwNjozNTo1NiArMDMwMCwgQmFydWNoIFNp
YWNoIDxiYXJ1Y2hAdGtvcy5jby5pbD4Kd3JvdGU6Cgo+IEhpIE1pcXVlbCwKPiAKPiBPbiBNb24s
IEp1biAyNSwgMjAxOCBhdCAwNToxMjozMFBNICswMjAwLCBNaXF1ZWwgUmF5bmFsIHdyb3RlOgo+
ID4gVGhlcmUgYXJlIG11bHRpcGxlIHN5c3RlbSBjb250cm9sbGVycyBpbiBDUDExMC4gQmVjYXVz
ZSBhbGwgc3lzY29uIG5vZGVzCj4gPiB1c2UgdGhlIHNhbWUgY29tcGF0aWJsZSwgaXQgaXMgcGVy
dGluZW50IHRvIHVzZSB0aGlzIHNhbWUgZmlsZSB0byBsaXN0Cj4gPiBJUHMgaW5zaWRlIGl0LiBU
aHVzLCBjaGFuZ2UgdGhlIGhlYWRlciB0byBiZSBtb3JlIGdlbmVyaWMsIGFuZCBhbGlnbgo+ID4g
d2l0aCBBUDgwNiBmaWxlLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaXF1ZWwgUmF5bmFsIDxt
aXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPiAgCj4gCj4gVGhpcyBwYXRjaCBhbmQgdGhlIGZpbGUg
cmVuYW1lIGluIHBhdGNoICMxMiBzaG91bGQgYmUgc3F1YXNoZWQgdG9nZXRoZXIsIEkgCj4gdGhp
bmsuCgpJIHdhcyBhc2tlZCBtdWx0aXBsZSB0aW1lcyB0byBjbGVhcmx5IHNlcGFyYXRlIGFueSBr
aW5kIG9mIGZpbGUKcmVuYW1pbmcgd2l0aCBpbnRlcm5hbCBjaGFuZ2VzIGJlY2F1c2Ugb3RoZXJ3
aXNlIHRoZSByZXZpZXdpbmcgcHJvY2VzcwppcyB3YXkgbW9yZSBjb21wbGljYXRlZC4gSSBkbyBh
Z3JlZSB0aGUgY2hhbmdlcyBjb3VsZCBiZSBzcXVhc2hlZCBidXQKbm93IEkgcHJlZmVyIHRvIGxl
dCB0aGVtIGFzIGlzIHVubGVzcyBJJ20gZXhwbGljaXRseSB0b2xkIHRvIGRvIHNvCmFmdGVyIHRo
ZSByZXZpZXdpbmcgcHJvY2Vzcy4KClJlZ2FyZHMsCk1pcXXDqGwKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
