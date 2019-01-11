From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 0/7] Bring suspend to RAM support to MVEBU SATA
Date: Fri, 11 Jan 2019 14:34:04 +0100
Message-ID: <20190111143404.518723a3@xps13>
References: <20181204192831.12440-1-miquel.raynal@bootlin.com>
 <35c5cdcf-0d89-9236-7937-0c750a781d13@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <35c5cdcf-0d89-9236-7937-0c750a781d13@kernel.dk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

SGkgSmVucywKCkplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4gd3JvdGUgb24gVHVlLCA0IERl
YyAyMDE4IDE3OjExOjE4IC0wNzAwOgoKPiBPbiAxMi80LzE4IDEyOjI4IFBNLCBNaXF1ZWwgUmF5
bmFsIHdyb3RlOgo+ID4gSGVsbG8sCj4gPiAKPiA+IEFzIHBhcnQgb2YgYW4gZWZmb3J0IHRvIGJy
aW5nIHN1c3BlbmQgdG8gUkFNIHN1cHBvcnQgdG8gQXJtYWRhIDM3MDAKPiA+IFNvQ3MgKG1haW4g
dGFyZ2V0OiBFU1BSRVNTT2JpbiksIHRoaXMgc2VyaWVzIGhhbmRsZXMgdGhlIHdvcmsgYXJvdW5k
Cj4gPiB0aGUgU0FUQSBJUC4KPiA+IAo+ID4gRmlyc3QsIGEgY2hhbmdlIGluIHRoZSBsaWJhaGNp
IHBsYXRmb3JtIGFkZHMgc3VwcG9ydCBmb3IgdGhlIG5ldyBQSFkKPiA+IGZyYW1ld29yayBieSBm
b2xsb3dpbmcgdGhlIHBoeV9zZXRfbW9kZSgpL3BoeV9wb3dlcl9vbigpCj4gPiBzZXF1ZW5jZS4g
VGhlbiwgdGhlIEFIQ0kgTVZFQlUgZHJpdmVyIGlzIGEgYml0IHVwZGF0ZWQgKHBhdGNoIDIgJiAz
KQo+ID4gYW5kIGEgbWlzc2luZyBpbml0aWFsaXphdGlvbiBpcyBhZGRlZCBmb3IgdGhlIEEzNzAw
IGluIHBhdGNoIDQgKG9ubHkKPiA+IGRvbmUgYnkgdGhlIEJvb3Rsb2FkZXIgYmVmb3JlKS4gTWlz
c2luZyBjbG9jayBzdXBwb3J0IGlzIGltcGxlbWVudGVkCj4gPiBpbiBwYXRjaCA1IHRvIGJlIHN1
cmUgdGhlIGNsb2NrIHdpbGwgYmUgcmVzdW1lZCBiZWZvcmUgdGhpcyBkcml2ZXIKPiA+IChzZWUg
WzFdIGZvciB0aGUgc2VyaWVzIGFkZGluZyBkZXZpY2UgbGlua3MgdG8gdGhlIGNsb2NrIGNvcmUp
Lgo+ID4gCj4gPiBGaW5hbGx5LCBkZXZpY2UgdHJlZXMgYXJlIHVwZGF0ZWQgdG8gcmVmbGVjdCB0
aGUgaGFyZHdhcmU6IHRoZSBtaXNzaW5nCj4gPiBQSFkgaXMgYWRkZWQgdG8gdGhlIEVTUFJFU1NP
YmluIERULCBhbmQgdGhlIGNsb2NrIGlzIGFkZGVkIHRvIHRoZSBTb0MKPiA+IERUIChwYXRjaCA2
ICYgNykuIEJpbmRpbmdzIGFscmVhZHkgZG9jdW1lbnQgdGhlIGNsb2NrIGFuZCB0aGUgUEhZIHNv
Cj4gPiBubyB1cGRhdGUgaXMgbmVlZGVkIG9uIHRoaXMgcmVnYXJkLiAgCj4gCj4gUHJvYmFibHkg
dGhlIGJlc3QvZWFzaWVzdCB0byBxdWV1ZSB0aGlzIHRocm91Z2ggdGhlIGxpYmF0YSB0cmVlIGZv
cgo+IDQuMjEuIEFncmVlPwo+IAoKSXQgbG9va3MgbGlrZSB0aGlzIHBhdGNoc2V0IGdvdCBsZWZ0
IGFzaWRlIGZvciA1LjAsIHNoYWxsIEkgcmUtc2VuZD8gKEkKcmViYXNlZCBvbiB0b3Agb2YgNS4w
IGFuZCB0aGUgc2VyaWVzIGFwcGxpZWQgZmluZSkuCgoKVGhhbmtzLApNaXF1w6hsCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
