From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 18/23] dt-bindings: thermal: armada: add reference to
 new bindings
Date: Fri, 6 Jul 2018 09:49:04 +0200
Message-ID: <20180706094904.22275b10@xps13>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-19-miquel.raynal@bootlin.com>
 <20180703213011.GA13190@rob-hp-laptop>
 <20180705120528.4b923e16@xps13>
 <CAL_JsqL9h4RExZtm5cER-5kNvMpDzH-4MwcmY7VOLXB9-uEYYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqL9h4RExZtm5cER-5kNvMpDzH-4MwcmY7VOLXB9-uEYYA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Eduardo Valentin <edubezval@gmail.com>, David Sniatkiwicz <davidsn@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Zhang Rui <rui.zhang@intel.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

SGkgUm9iLAoKWy4uLl0KCj4gPiA+ID4gZm9yIEFQODA2IGFuZCBDUDExMCBjb21wYXRpYmxlcy4g
QWRkIGEgcmVmZXJlbmNlIHRvIHRoZXNlIGZpbGVzIGZyb20gdGhlCj4gPiA+ID4gb3JpZ2luYWwg
ZG9jdW1lbnRhdGlvbi4KPiA+ID4gPgo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXlu
YWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+Cj4gPiA+ID4gLS0tCj4gPiA+ID4gIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVybWFsL2FybWFkYS10aGVybWFsLnR4dCB8
IDUgKysrKysKPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+ID4gPiA+
Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90
aGVybWFsL2FybWFkYS10aGVybWFsLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy90aGVybWFsL2FybWFkYS10aGVybWFsLnR4dAo+ID4gPiA+IGluZGV4IGUwZDAxM2EyZTY2
ZC4uZjNiNDQxMTAwODkwIDEwMDY0NAo+ID4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy90aGVybWFsL2FybWFkYS10aGVybWFsLnR4dAo+ID4gPiA+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVybWFsL2FybWFkYS10aGVybWFsLnR4
dAo+ID4gPiA+IEBAIC0xMCw2ICsxMCwxMSBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOgo+ID4gPiA+
ICAgICAgKiBtYXJ2ZWxsLGFybWFkYS1hcDgwNi10aGVybWFsCj4gPiA+ID4gICAgICAqIG1hcnZl
bGwsYXJtYWRhLWNwMTEwLXRoZXJtYWwgIAo+ID4gPgo+ID4gPiBSZWFsbHkgeW91IHNob3VsZCBu
b3QgYmUgdXNpbmcgdGhlIHNhbWUgY29tcGF0aWJsZSBmb3IgYm90aC4gTm93IHlvdQo+ID4gPiBo
YXZlIDIgZHJpdmVycyBtYXRjaGluZyB0byBzYW1lIGNvbXBhdGlibGVzLgo+ID4gPgo+ID4gPiBD
YW4ndCB5b3UgbWFrZSB0aGlzIGEgY2hpbGQgb2YgdGhlIHN5c2NvbiB3aXRob3V0IGJyZWFraW5n
IHRoZSBiaW5kaW5nPyAgCj4gPgo+ID4gV2UgYXJlIHRhbGtpbmcgYWJvdXQgb25seSAxIGRyaXZl
ciBoZXJlLCBzbyBJJ20gbm90IHN1cmUgaG93IEkgc2hvdWxkCj4gPiB1bmRlcnN0YW5kIHlvdXIg
bGFzdCBzZW50ZW5jZS4gRG8geW91IHdhbnQgbWUgdG8gYWRkIGEgc2Vjb25kCj4gPiBjb21wYXRp
YmxlIChmb3IgdGhlIHNhbWUgcGllY2Ugb2YgaGFyZHdhcmUpIGZvciB0aGVybWFsIG5vZGUgZGVj
bGFyZWQKPiA+IGFzIGEgY2hpbGQgb2YgdGhlIHN5c2Nvbj8gIAo+IAo+IEkgZG9uJ3Qga25vdyB3
aGF0IEknbSBzdWdnZXN0aW5nLiBZb3VyIGNoYW5nZXMgbG9vayBsaWtlIHRoZXkgYnJlYWsKPiBj
b21wYXRpYmlsaXR5IHRvIG1lLgoKVGhlcmUgaXMgY29kZSBpbiB0aGUgZHJpdmVyIHRvIGhhbmRs
ZSB0aGUgbGVnYWN5IG5vbi1zeXNjb24taXNoIHRoZXJtYWwKbm9kZSAoImFybWFkYV90aGVybWFs
X3Byb2JlX2xlZ2FjeSgpIikuIEFuIG9sZCBEVCB3aXRoIGEgbmV3IGtlcm5lbAp3b3VsZCB3b3Jr
IGZpbmUuCgo+IFdoYXQgaGFwcGVucyBpZiB5b3UgdXNlIHRoaXMgbmV3IGJpbmRpbmcgd2l0aG91
dCBhbnkga2VybmVsIGNoYW5nZT8KCkkgc3VwcG9zZSB5b3UgbWVhbiAiZHVyaW5nIHRoZSBtZXJn
ZSB3aW5kb3ciPyBJbiB0aGlzIGNhc2UgdGhlIGRyaXZlcgpvZiB0aGUgdGhlcm1hbCBJUCB3aWxs
IG5vdCBwcm9iZSAoYW5kIHNwYXduIGFuIGVycm9yIGluIHRoZSBkbWVzZykgd2l0aAphcDgwNi9j
cDExMCBJUHMuIEFzIHRoZSBzdXBwb3J0IGlzIHByZXR0eSBuZXcgZm9yIHRoZW0sIHRoaXMgaXMg
bWF5YmUKbm90IGEgaHVnZSBpc3N1ZS4gQWxzbywgYmVmb3JlIHRoZSBEVCBjaGFuZ2VzIGFkZGlu
ZyB0aGVybWFsIHpvbmVzLApqdXN0IHJldHJpZXZpbmcgdGhlIHRlbXBlcmF0dXJlIG1pZ2h0IGJl
IHByZXR0eSB1c2VsZXNzLiBIb3dldmVyLCBpdAppcyBhbHdheXMgcG9zc2libGUgdG8gbWVyZ2Ug
dGhlIGRyaXZlciBjaGFuZ2VzIGluIDQuMTkgYW5kIHRoZSBEVApjaGFuZ2VzIGluIDQuMjAuCgoK
VGhhbmtzLApNaXF1w6hsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
