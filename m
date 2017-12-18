From: Miquel RAYNAL <miquel.raynal@free-electrons.com>
Subject: Re: [PATCH v3 05/11] thermal: armada: Add support for Armada AP806
Date: Mon, 18 Dec 2017 13:25:00 +0100
Message-ID: <20171218132500.7f7225e9@xps13>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
 <20171214103011.24713-6-miquel.raynal@free-electrons.com>
 <87y3m5o9h4.fsf@free-electrons.com> <20171218104127.65017555@xps13>
 <20171218111156.76a66q5kwh3advs7@sapphire.tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171218111156.76a66q5kwh3advs7@sapphire.tkos.co.il>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Eduardo Valentin <edubezval@gmail.com>, David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

SGkgQmFydWNoLAoKT24gTW9uLCAxOCBEZWMgMjAxNyAxMzoxMTo1NiArMDIwMApCYXJ1Y2ggU2lh
Y2ggPGJhcnVjaEB0a29zLmNvLmlsPiB3cm90ZToKCj4gSGkgTWlxdcOobCwKPiAKPiBPbiBNb24s
IERlYyAxOCwgMjAxNyBhdCAxMDo0MToyN0FNICswMTAwLCBNaXF1ZWwgUkFZTkFMIHdyb3RlOgo+
ID4gSGVsbG8gR3JlZ29yeSAmIEJhcnVjaCwKPiA+IAo+ID4gT24gVGh1LCAxNCBEZWMgMjAxNyAx
MjowNTo0MyArMDEwMAo+ID4gR3JlZ29yeSBDTEVNRU5UIDxncmVnb3J5LmNsZW1lbnRAZnJlZS1l
bGVjdHJvbnMuY29tPiB3cm90ZToKPiA+ICAgCj4gPiA+ID4gQEAgLTE4NCw5ICsyMTQsOSBAQCBz
dGF0aWMgaW50IGFybWFkYV9nZXRfdGVtcChzdHJ1Y3QKPiA+ID4gPiB0aGVybWFsX3pvbmVfZGV2
aWNlICp0aGVybWFsLCBkaXYgPSBwcml2LT5kYXRhLT5jb2VmX2RpdjsKPiA+ID4gPiAgCj4gPiA+
ID4gIAlpZiAocHJpdi0+ZGF0YS0+aW52ZXJ0ZWQpCj4gPiA+ID4gLQkJKnRlbXAgPSAoKG0gKiBy
ZWcpIC0gYikgLyBkaXY7Cj4gPiA+ID4gKwkJKnRlbXAgPSAoKG0gKiBzYW1wbGUpIC0gYikgLyBk
aXY7Cj4gPiA+ID4gIAllbHNlCj4gPiA+ID4gLQkJKnRlbXAgPSAoYiAtIChtICogcmVnKSkgLyBk
aXY7Cj4gPiA+ID4gKwkJKnRlbXAgPSAoYiAtIChtICogc2FtcGxlKSkgLyBkaXY7Cj4gPiA+ID4g
IAlyZXR1cm4gMDsKPiA+ID4gPiAgfQo+ID4gPiA+ICAKPiA+ID4gPiBAQCAtMjM3LDYgKzI2Nywx
OSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFybWFkYV90aGVybWFsX2RhdGEKPiA+ID4gPiBhcm1h
ZGEzODBfZGF0YSA9IHsgLmludmVydGVkID0gdHJ1ZSwKPiA+ID4gPiAgfTsKPiA+ID4gPiAgCj4g
PiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYXJtYWRhX3RoZXJtYWxfZGF0YSBhcm1hZGFfYXA4
MDZfZGF0YSA9IHsKPiA+ID4gPiArCS5pc192YWxpZCA9IGFybWFkYV9pc192YWxpZCwKPiA+ID4g
PiArCS5pbml0X3NlbnNvciA9IGFybWFkYV9hcDgwNl9pbml0X3NlbnNvciwKPiA+ID4gPiArCS5p
c192YWxpZF9iaXQgPSBCSVQoMTYpLAo+ID4gPiA+ICsJLnRlbXBfc2hpZnQgPSAwLAo+ID4gPiA+
ICsJLnRlbXBfbWFzayA9IDB4M2ZmLAo+ID4gPiA+ICsJLmNvZWZfYiA9IC0xNTAwMDAsICAgIAo+
ID4gPiAKPiA+ID4gRG9uJ3QgeW91IGV4cGVjdCBhbnkgc2lkZSBlZmZlY3QgYnkgc3RvcmluZyBh
IG5lZ2F0aXZlIHZhbHVlIGluIGEKPiA+ID4gdW5zaWduZWQgdmFyaWFibGU/ICAKPiA+IAo+ID4g
VGhhdCBpcyBhIGZhaXIgcXVlc3Rpb24sIEkgZGlkIG5vdCBzcG90IHRoYXQuCj4gPiAKPiA+IEFz
IG90aGVyIHZhbHVlcyBhcmUgcmVhbGx5IGNsb3NlIHRvIDJeMzIgSSBkb24ndCBrbm93IHdoYXQg
aXMgdGhlCj4gPiBiZXN0IG9wdGlvbiBmb3IgdXMgaW4gdGhpcyBjYXNlLiBTaG91bGQgSToKPiA+
IC0gZG9uJ3QgY2FyZT8KPiA+IC0gdXNlIHNpZ25lZCB2YWx1ZXM/IChkYW5nZXJvdXMgSU1ITykK
PiA+IC0gdXNlIGEgdW5pb24gd2l0aCBhIHNpZ25lZCBhbmQgYW4gdW5zaWduZWQgdmFsdWU/IChw
cm9ibGVtIG1vdmVkCj4gPiB0byAtPmdldF90ZW1wKCkpICAKPiAKPiBBbm90aGVyIG9wdGlvbiBp
cyB0byB1c2UgczY0IHR5cGUuCgpJIHByZWZlciB0aGlzIG9uZSEKClRoYW5rIHlvdSwKTWlxdcOo
bAoKPiAKPiBiYXJ1Y2gKPiAKCgoKLS0gCk1pcXVlbCBSYXluYWwsIEZyZWUgRWxlY3Ryb25zCkVt
YmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcKaHR0cDovL2ZyZWUtZWxlY3Ryb25z
LmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
