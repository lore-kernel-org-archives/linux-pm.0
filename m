From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3 00/23] Add multi-channel support to Armada thermal
 driver
Date: Thu, 26 Jul 2018 10:00:41 +0800
Message-ID: <1532570441.2358.27.camel@intel.com>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
 <20180718172849.30b7cec0@xps13> <20180725095222.054f1e80@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180725095222.054f1e80@xps13>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

T24g5LiJLCAyMDE4LTA3LTI1IGF0IDA5OjUyICswMjAwLCBNaXF1ZWwgUmF5bmFsIHdyb3RlOgo+
IEhpIEVkdWFyZG8sIFpoYW5nLAo+IAo+IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9v
dGxpbi5jb20+IHdyb3RlIG9uIFdlZCwgMTggSnVsIDIwMTgKPiAxNzoyODo0OSArMDIwMDoKPiAK
PiA+IAo+ID4gSGkgRWR1YXJkbywKPiA+IAo+ID4gTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5h
bEBib290bGluLmNvbT4gd3JvdGUgb24gTW9uLCAxNiBKdWwgMjAxOAo+ID4gMTY6NDE6NDMgKzAy
MDA6Cj4gPiAKPiA+ID4gCj4gPiA+IFRoZSBvbmx5IGNhcGFiaWxpdHkgb2YgdGhlIEFybWFkYSB0
aGVybWFsIGRyaXZlciBpcyBjdXJyZW50bHkKPiA+ID4ganVzdCB0bwo+ID4gPiByZWFkIG9uZSBz
ZW5zb3IgKHRoZSBkZWZhdWx0IG9uZSkgcGVyIEFQIGFuZCBvbmUgcGVyIENQLgo+ID4gPiBBY3R1
YWxseSwKPiA+ID4gdGhlcmUgaXMgb25lIHNlbnNvciBwZXIgY29yZSBpbiB0aGUgQVA4MDYgcGx1
cyBvbmUgc2Vuc29yIGluIHRoZQo+ID4gPiB0aGVybWFsIElQIGl0c2VsZi4gVGhlIENQMTEwIGp1
c3QgZmVhdHVyZXMgb25lIHRoZXJtYWwgc2Vuc29yIGluCj4gPiA+IGl0cwo+ID4gPiBvd24gdGhl
cm1hbCBJUC4KPiA+ID4gCj4gPiA+IFRoaXMgc2VyaWVzIGZpcnN0IGltcHJvdmVzIHRoZSByZWFk
YWJpbGl0eSBvZiB0aGlzIGRyaXZlciwgdGhlbgo+ID4gPiBhZGRzCj4gPiA+IHN1cHBvcnQgZm9y
IG11bHRpLWNoYW5uZWwgdGhlcm1hbCBJUHMuIFRoZSBiaW5kaW5ncyBhbmQgdGhlCj4gPiA+IGRl
dmljZS10cmVlcyBhcmUgdXBkYXRlZCBhY2NvcmRpbmdseS4KPiA+ID4gCj4gPiA+IFRoYW5rIHlv
dSwKPiA+ID4gTWlxdcOobMKgwqAKPiA+IEkga25vdyBJIHNlbnQgdGhpcyBzZXJpZXMgb24gbW9u
ZGF5IGJ1dCB0aGVyZSB3YXMgYWxtb3N0IG5vIGNoYW5nZQo+ID4gb24KPiA+IGl0IChzZWUgYmVs
b3cpLCBkbyB5b3UgdGhpbmsgeW91IHdpbGwgaGF2ZSB0aGUgdGltZSB0byBsb29rIGF0IGl0Cj4g
PiBiZWZvcmUgaXQncyB0b28gbGF0ZSBmb3IgdGhlIG1lcmdlIHdpbmRvdz8KPiBJIGtub3cgYSBs
aXR0bGUgYml0IHdoYXQgaXQgaXMgdG8gYmUgb24gdGhlIG1haW50YWluZXIgc2lkZSBvZiBhCj4g
c3Vic3lzdGVtIGJ1dCB0aGVzZSBjaGFuZ2VzIGFyZSBsYXlpbmcgc2luY2UgQXByaWwsIDIxc3Qg
YW5kIEkgcmVhbGx5Cj4gZXhwZWN0IHRvIGdldCB0aGVtIG1lcmdlZC4gWmhhbmcsIGFzIEVkdWFy
ZG8gc2VlbXMgdG8gYmUgb3ZlcmxvYWRlZAo+IHRoaXMgcmVsZWFzZSwgY291bGQgeW91IHBsZWFz
ZSB0YWtlIHRoZSBzZXJpZXM/Cj4gCj4gT2YgY291cnNlIGlmIHRoZXJlIGFyZSB0aGluZ3MgdG8g
YWRkcmVzcyBJJ2xsIGJlIGhhcHB5IHRvIGRvIHNvLgo+IApJIGhhZCBhIHN5bmMgd2l0aCBFZHVh
cmRvIGR1cmluZyBsYXN0IG1lcmdlIHdpbmRvdywgYW5kIHdlIGFncmVlZCB0bwpzZW5kIHNlcGFy
YXRlIGdpdCBwdWxsIHJlcXVlc3RzIHRvIExpbnVzIHNpbmNlIHRoaXMgcmVsZWFzZSBhbmQgc2Vl
IGhvdwppdCB3b3Jrcy4KVGhpcyBtZWFucyB0aGF0IGFsbCB0aGUgc29jIHRoZXJtYWwgZHJpdmVy
IHBhdGNoZXMgc2hvdWxkIGdvIHRvCkVkdWFyZG8nIHRyZWUgYW5kIHRoZW4gTGludXMnIHRyZWUg
ZGlyZWN0bHkuCgpBbnl3YXksIGxldCdzIHBpbmcgRWR1YXJkbyBhbmQgc2VlIGlmIGhlIGNhbiBy
ZXZpZXcvdGFrZSB0aGUgcGF0Y2hlcy4KCnRoYW5rcywKcnVpCj4gVGhhbmtzLAo+IE1pcXXDqGwK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
