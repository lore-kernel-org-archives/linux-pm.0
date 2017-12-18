From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v4 11/12] thermal: armada: Give meaningful names to the
 thermal zones
Date: Mon, 18 Dec 2017 17:12:46 +0100
Message-ID: <87d13chv5t.fsf@free-electrons.com>
References: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
 <20171218143643.7714-12-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171218143643.7714-12-miquel.raynal@free-electrons.com> (Miquel
 Raynal's message of "Mon, 18 Dec 2017 15:36:42 +0100")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Miquel Raynal <miquel.raynal@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Baruch Siach <baruch@tkos.co.il>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Will Deacon <will.deacon@arm.com>, David Sniatkiwicz <davidsn@marvell.com>, Eduardo Valentin <edubezval@gmail.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

SGkgTWlxdWVsLAogCiBPbiBsdW4uLCBkw6ljLiAxOCAyMDE3LCBNaXF1ZWwgUmF5bmFsIDxtaXF1
ZWwucmF5bmFsQGZyZWUtZWxlY3Ryb25zLmNvbT4gd3JvdGU6Cgo+IEFmdGVyIHJlZ2lzdHJhdGlv
biB0byB0aGUgdGhlcm1hbCBjb3JlLCBzeXNmcyB3aWxsIG1ha2Ugb25lIGVudHJ5Cj4gcGVyIGlu
c3RhbmNlIG9mIHRoZSBkcml2ZXIgaW4gL3N5cy9jbGFzcy90aGVybWFsX3pvbmVYIGFuZAo+IC9z
eXMvY2xhc3MvaHdtb24vaHdtb25YLCBYIGJlaW5nIHRoZSBpbmRleCBvZiB0aGUgaW5zdGFuY2Us
IGFsbCBvZiB0aGVtCj4gaGF2aW5nIHRoZSB0eXBlL25hbWUgImFybWFkYV90aGVybWFsIi4KPgo+
IFVudGlsIG5vdyB0aGVyZSB3YXMgb25seSBvbmUgdGhlcm1hbCB6b25lIHBlciBTb0MgYnV0IFNv
Q3MgbGlrZSBBcm1hZGEKPiBBN0sgYW5kIEFybWFkYSBBOEsgaGF2ZSByZXNwZWN0aXZlbHkgdHdv
IGFuZCB0aHJlZSB0aGVybWFsIHpvbmVzIChvbmUKPiBwZXIgQVAgYW5kIG9uZSBwZXIgQ1ApIGFu
ZCB0aGlzIG51bWJlciBpcyBzdWJqZWN0IHRvIGdyb3cgaW4gdGhlIGZ1dHVyZS4KPgo+IFVzZSBk
ZXZfbmFtZSgpIGluc3RlYWQgb2YgdGhlICJhcm1hZGFfdGhlcm1hbCIgc3RyaW5nIHRvIGdldCBh
Cj4gbWVhbmluZ2Z1bCBuYW1lIGFuZCBiZSBhYmxlIHRvIGlkZW50aWZ5IHRoZSB0aGVybWFsIHpv
bmVzIGZyb20KPiB1c2Vyc3BhY2UuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNaXF1ZWwgUmF5bmFsIDxt
aXF1ZWwucmF5bmFsQGZyZWUtZWxlY3Ryb25zLmNvbT4KClJldmlld2VkLWJ5OiBHcmVnb3J5IENM
RU1FTlQgPGdyZWdvcnkuY2xlbWVudEBmcmVlLWVsZWN0cm9ucy5jb20+CgpHcmVnb3J5CgoKPiAt
LS0KPiAgZHJpdmVycy90aGVybWFsL2FybWFkYV90aGVybWFsLmMgfCA0ICsrLS0KPiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3RoZXJtYWwvYXJtYWRhX3RoZXJtYWwuYyBiL2RyaXZlcnMvdGhlcm1hbC9hcm1h
ZGFfdGhlcm1hbC5jCj4gaW5kZXggNGE1MTY0ZGRmZmU3Li40MmVmODBiM2I1ZjggMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy90aGVybWFsL2FybWFkYV90aGVybWFsLmMKPiArKysgYi9kcml2ZXJzL3Ro
ZXJtYWwvYXJtYWRhX3RoZXJtYWwuYwo+IEBAIC00MDMsOCArNDAzLDggQEAgc3RhdGljIGludCBh
cm1hZGFfdGhlcm1hbF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ICAKPiAg
CXByaXYtPmRhdGEtPmluaXRfc2Vuc29yKHBkZXYsIHByaXYpOwo+ICAKPiAtCXRoZXJtYWwgPSB0
aGVybWFsX3pvbmVfZGV2aWNlX3JlZ2lzdGVyKCJhcm1hZGFfdGhlcm1hbCIsIDAsIDAsCj4gLQkJ
CQkJICAgICAgIHByaXYsICZvcHMsIE5VTEwsIDAsIDApOwo+ICsJdGhlcm1hbCA9IHRoZXJtYWxf
em9uZV9kZXZpY2VfcmVnaXN0ZXIoZGV2X25hbWUoJnBkZXYtPmRldiksIDAsIDAsIHByaXYsCj4g
KwkJCQkJICAgICAgICZvcHMsIE5VTEwsIDAsIDApOwo+ICAJaWYgKElTX0VSUih0aGVybWFsKSkg
ewo+ICAJCWRldl9lcnIoJnBkZXYtPmRldiwKPiAgCQkJIkZhaWxlZCB0byByZWdpc3RlciB0aGVy
bWFsIHpvbmUgZGV2aWNlXG4iKTsKPiAtLSAKPiAyLjExLjAKPgoKLS0gCkdyZWdvcnkgQ2xlbWVu
dCwgRnJlZSBFbGVjdHJvbnMKS2VybmVsLCBkcml2ZXJzLCByZWFsLXRpbWUgYW5kIGVtYmVkZGVk
IExpbnV4CmRldmVsb3BtZW50LCBjb25zdWx0aW5nLCB0cmFpbmluZyBhbmQgc3VwcG9ydC4KaHR0
cDovL2ZyZWUtZWxlY3Ryb25zLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
