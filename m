From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 5/7] ata: ahci: mvebu: add clock support
Date: Thu, 29 Nov 2018 15:02:41 +0100
Message-ID: <20181129150241.52e7ae2f@xps13>
References: <20181123101556.29888-1-miquel.raynal@bootlin.com>
 <20181123101556.29888-6-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181123101556.29888-6-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

SGVsbG8sCgpNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPiB3cm90ZSBv
biBGcmksIDIzIE5vdiAyMDE4CjExOjE1OjU0ICswMTAwOgoKPiBBZGQgY2xvY2sgc3VwcG9ydCB0
byB0aGUgYWhjaV9tdmVidS5jIGRyaXZlci4gVGhpcyBpcyBuZWVkZWQgaW4gb3JkZXIKPiB0byBn
ZXQgc3VzcGVuZCB0byBSQU0gd29ya2luZy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBNaXF1ZWwgUmF5
bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPgo+IC0tLQo+ICBkcml2ZXJzL2F0YS9haGNp
X212ZWJ1LmMgfCAxMCArKysrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL2FoY2lfbXZlYnUuYyBiL2RyaXZlcnMv
YXRhL2FoY2lfbXZlYnUuYwo+IGluZGV4IDkwMjk3MWJmZTMwMS4uY2FkMzU4MDZjM2MyIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvYXRhL2FoY2lfbXZlYnUuYwo+ICsrKyBiL2RyaXZlcnMvYXRhL2Fo
Y2lfbXZlYnUuYwo+IEBAIC0xOTUsNiArMTk1LDE2IEBAIHN0YXRpYyBpbnQgYWhjaV9tdmVidV9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ICAJaWYgKCFocHJpdi0+cGxhdF9k
YXRhKQo+ICAJCXJldHVybiAtRUlOVkFMOwo+ICAKPiArCS8qIFRoZSBjbG9jayBwcm9wZXJ0eSBp
cyBhYnNlbnQgaW4gb2xkIGJpbmRpbmdzICovCj4gKwlocHJpdi0+Y2xrc1swXSA9IGRldm1fY2xr
X2dldCgmcGRldi0+ZGV2LCBOVUxMKTsKPiArCWlmIChJU19FUlIoaHByaXYtPmNsa3NbMF0pKSB7
Cj4gKwkJaWYgKFBUUl9FUlIoaHByaXYtPmNsa3NbMF0pID09IC1FUFJPQkVfREVGRVIpCj4gKwkJ
CXJldHVybiBQVFJfRVJSKGhwcml2LT5jbGtzWzBdKTsKPiArCj4gKwkJZGV2X3dhcm4oJnBkZXYt
PmRldiwgIm5vIGNsb2NrIGF2YWlsYWJsZVxuIik7Cj4gKwkJaHByaXYtPmNsa3NbMF0gPSBOVUxM
Owo+ICsJfQo+ICsKCkR1cmluZyBhIGRlYnVnIHNlc3Npb24gYWJvdXQgY2xvY2sgZGV2aWNlIGxp
bmtzIEkgcmVhbGl6ZWQgdGhpcyBwYXRjaAp3YXMgbm90IG5lZWRlZC4gVGhlIGNsa19nZXQoKSBv
biBocHJpdi0+Y2xrc1sqXSBpcyBkb25lIGluCmxpYmFoY2lfcGxhdGZvcm0uYyBpbiBhaGNpX3Bs
YXRmb3JtX2dldF9yZXNvdXJjZXMoKSBzbyB0aGlzIGlzCnJlZHVuZGFudC4KCkknbGwgZml4IGl0
IGluIHRoZSB2Mi4KCj4gIAlyYyA9IGFoY2lfcGxhdGZvcm1fZW5hYmxlX3Jlc291cmNlcyhocHJp
dik7Cj4gIAlpZiAocmMpCj4gIAkJcmV0dXJuIHJjOwoKClRoYW5rcywKTWlxdcOobAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
