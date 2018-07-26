From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 00/23] Add multi-channel support to Armada thermal
 driver
Date: Thu, 26 Jul 2018 14:14:43 -0700
Message-ID: <20180726211442.GB3487@localhost.localdomain>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
 <20180718172849.30b7cec0@xps13> <20180725095222.054f1e80@xps13>
 <1532570441.2358.27.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1532570441.2358.27.camel@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

SGVsbG8sCgpPbiBUaHUsIEp1bCAyNiwgMjAxOCBhdCAxMDowMDo0MUFNICswODAwLCBaaGFuZyBS
dWkgd3JvdGU6Cj4gT24g5LiJLCAyMDE4LTA3LTI1IGF0IDA5OjUyICswMjAwLCBNaXF1ZWwgUmF5
bmFsIHdyb3RlOgo+ID4gSGkgRWR1YXJkbywgWmhhbmcsCj4gPiAKPiA+IE1pcXVlbCBSYXluYWwg
PG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+IHdyb3RlIG9uIFdlZCwgMTggSnVsIDIwMTgKPiA+
IDE3OjI4OjQ5ICswMjAwOgo+ID4gCj4gPiA+IAo+ID4gPiBIaSBFZHVhcmRvLAo+ID4gPiAKPiA+
ID4gTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4gd3JvdGUgb24gTW9u
LCAxNiBKdWwgMjAxOAo+ID4gPiAxNjo0MTo0MyArMDIwMDoKPiA+ID4gCj4gPiA+ID4gCj4gPiA+
ID4gVGhlIG9ubHkgY2FwYWJpbGl0eSBvZiB0aGUgQXJtYWRhIHRoZXJtYWwgZHJpdmVyIGlzIGN1
cnJlbnRseQo+ID4gPiA+IGp1c3QgdG8KPiA+ID4gPiByZWFkIG9uZSBzZW5zb3IgKHRoZSBkZWZh
dWx0IG9uZSkgcGVyIEFQIGFuZCBvbmUgcGVyIENQLgo+ID4gPiA+IEFjdHVhbGx5LAo+ID4gPiA+
IHRoZXJlIGlzIG9uZSBzZW5zb3IgcGVyIGNvcmUgaW4gdGhlIEFQODA2IHBsdXMgb25lIHNlbnNv
ciBpbiB0aGUKPiA+ID4gPiB0aGVybWFsIElQIGl0c2VsZi4gVGhlIENQMTEwIGp1c3QgZmVhdHVy
ZXMgb25lIHRoZXJtYWwgc2Vuc29yIGluCj4gPiA+ID4gaXRzCj4gPiA+ID4gb3duIHRoZXJtYWwg
SVAuCj4gPiA+ID4gCj4gPiA+ID4gVGhpcyBzZXJpZXMgZmlyc3QgaW1wcm92ZXMgdGhlIHJlYWRh
YmlsaXR5IG9mIHRoaXMgZHJpdmVyLCB0aGVuCj4gPiA+ID4gYWRkcwo+ID4gPiA+IHN1cHBvcnQg
Zm9yIG11bHRpLWNoYW5uZWwgdGhlcm1hbCBJUHMuIFRoZSBiaW5kaW5ncyBhbmQgdGhlCj4gPiA+
ID4gZGV2aWNlLXRyZWVzIGFyZSB1cGRhdGVkIGFjY29yZGluZ2x5Lgo+ID4gPiA+IAo+ID4gPiA+
IFRoYW5rIHlvdSwKPiA+ID4gPiBNaXF1w6hswqDCoAo+ID4gPiBJIGtub3cgSSBzZW50IHRoaXMg
c2VyaWVzIG9uIG1vbmRheSBidXQgdGhlcmUgd2FzIGFsbW9zdCBubyBjaGFuZ2UKPiA+ID4gb24K
PiA+ID4gaXQgKHNlZSBiZWxvdyksIGRvIHlvdSB0aGluayB5b3Ugd2lsbCBoYXZlIHRoZSB0aW1l
IHRvIGxvb2sgYXQgaXQKPiA+ID4gYmVmb3JlIGl0J3MgdG9vIGxhdGUgZm9yIHRoZSBtZXJnZSB3
aW5kb3c/Cj4gPiBJIGtub3cgYSBsaXR0bGUgYml0IHdoYXQgaXQgaXMgdG8gYmUgb24gdGhlIG1h
aW50YWluZXIgc2lkZSBvZiBhCj4gPiBzdWJzeXN0ZW0gYnV0IHRoZXNlIGNoYW5nZXMgYXJlIGxh
eWluZyBzaW5jZSBBcHJpbCwgMjFzdCBhbmQgSSByZWFsbHkKPiA+IGV4cGVjdCB0byBnZXQgdGhl
bSBtZXJnZWQuIFpoYW5nLCBhcyBFZHVhcmRvIHNlZW1zIHRvIGJlIG92ZXJsb2FkZWQKPiA+IHRo
aXMgcmVsZWFzZSwgY291bGQgeW91IHBsZWFzZSB0YWtlIHRoZSBzZXJpZXM/Cj4gPiAKPiA+IE9m
IGNvdXJzZSBpZiB0aGVyZSBhcmUgdGhpbmdzIHRvIGFkZHJlc3MgSSdsbCBiZSBoYXBweSB0byBk
byBzby4KPiA+IAo+IEkgaGFkIGEgc3luYyB3aXRoIEVkdWFyZG8gZHVyaW5nIGxhc3QgbWVyZ2Ug
d2luZG93LCBhbmQgd2UgYWdyZWVkIHRvCj4gc2VuZCBzZXBhcmF0ZSBnaXQgcHVsbCByZXF1ZXN0
cyB0byBMaW51cyBzaW5jZSB0aGlzIHJlbGVhc2UgYW5kIHNlZSBob3cKPiBpdCB3b3Jrcy4KPiBU
aGlzIG1lYW5zIHRoYXQgYWxsIHRoZSBzb2MgdGhlcm1hbCBkcml2ZXIgcGF0Y2hlcyBzaG91bGQg
Z28gdG8KPiBFZHVhcmRvJyB0cmVlIGFuZCB0aGVuIExpbnVzJyB0cmVlIGRpcmVjdGx5Lgo+IAo+
IEFueXdheSwgbGV0J3MgcGluZyBFZHVhcmRvIGFuZCBzZWUgaWYgaGUgY2FuIHJldmlldy90YWtl
IHRoZSBwYXRjaGVzLgoKU29ycnkgZmVsbG93cywgYnV0IEkgd2FzIG9mZiBjYW1waW5nIGluIGEg
cGxhY2Ugd2l0aCBubyBlbGVjdHJpY2l0eS9ubwppbnRlcm5ldC4gSSBsb29rZWQgYXQgdGhpcyBz
ZXJpZXMgYmVmb3JlLCBhbmQgSSBkbyBub3QgcmVtZW1iZXIgYW55dGhpbmcKdGhhdCBjb3VsZCBi
bG9jayBpdCB0byBnby4gTGV0IG1lIHJlc3RhcnQgb24gd29ya2luZyBvbiBpdC4KCj4gCj4gdGhh
bmtzLAo+IHJ1aQo+ID4gVGhhbmtzLAo+ID4gTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
