From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 01/23] thermal: armada: add a function that sanitizes
 the thermal zone name
Date: Fri, 27 Jul 2018 13:52:30 +0200
Message-ID: <20180727135230.3c7102c7@xps13>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
 <20180716144206.30985-2-miquel.raynal@bootlin.com>
 <84f97022-a470-f314-ee75-e5afb733bea5@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <84f97022-a470-f314-ee75-e5afb733bea5@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Eduardo Valentin <edubezval@gmail.com>, David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

SGkgRGFuaWVsLAoKRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+IHdy
b3RlIG9uIEZyaSwgMjcgSnVsIDIwMTgKMTM6MzQ6MTkgKzAyMDA6Cgo+IE9uIDE2LzA3LzIwMTgg
MTY6NDEsIE1pcXVlbCBSYXluYWwgd3JvdGU6Cj4gPiBUaGVybWFsIHpvbmUgbmFtZXMgbXVzdCBm
b2xsb3cgY2VydGFpbiBydWxlcyBpbXBvc2VkIGJ5IHRoZSBmcmFtZXdvcmsuCj4gPiBUaGV5IGFy
ZSBsaW1pdGVkIGluIGxlbmd0aCBhbmQgc2hhbGwgbm90IGhhdmUgYW55IGh5cGhlbiAnLScuCj4g
PiAKPiA+IFRoaXMgaXMgZG9uZSBpbiBhIHNlcGFyYXRlIGZ1bmN0aW9uIGZvciBmdXR1cmUgdXNl
IGluIGFub3RoZXIgbG9jYXRpb24uCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXlu
YWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+ICAKPiAKPiBXaHkgZG8geW91IGhhdmUgdG8g
cHJvdmlkZSBhIGZ1bmN0aW9uIHRvIHRlc3QgdGhhdD8KPiAKPiBMb2dpY2FsbHksIHRoZSBvbmUg
d2hvIGRpZCB0aGUgY2hhbmdlIHRvIGFkZCBhIHRoZXJtYWwgbmFtZSwgc2hvdWxkCj4gY2hlY2sg
aXRzIGNvZGUgd29ya3MuIFdpdGhvdXQgYSBwcm9wZXIgbmFtZSB0aGF0IHdvbid0IHdvcmsuCgpX
aGF0IGRvIHlvdSBtZWFuICJ0aGUgb25lIHdobyBkaWQgdGhlIGNoYW5nZSI/CkkgdGhpbmsgdGhl
IHRoZXJtYWwgY29yZSBzaG91bGQgbm90IGNhcmUgdGhhdCBtdWNoIHRvIHdoYXQgaXMgZ2l2ZW4g
YXMKbmFtZSBhbmQgc2hvdWxkIHByb2JhYmx5IG5vdCBiZSBzbyBzdHJpY3QuCgpBbHNvLCBJIGRv
bid0IGNob29zZSB3aGF0IGRldl9uYW1lKCkgcmV0dXJucywgaXQncyBpbiB0aGUgZGV2aWNlIHRy
ZWUKYW5kIHRoZSBkZXZpY2UgdHJlZSBkbyBub3QgY2FyZSBhYm91dCB0aGUgaW1wbGVtZW50YXRp
b24sIGl0J3MganVzdCBhCmRlc2NyaXB0aXZlIGZpbGUuCgo+IAo+IFNvIHRoaXMgZnVuY3Rpb24g
aXMgdGVzdGluZyBzb21ldGhpbmcgd2hpY2ggc2hvdWxkIGJlIGFscmVhZHkgdGVzdGVkLCBubz8K
CkkgZG9uJ3QgdGhpbmsgaXQgaXMuIFdpdGhvdXQgdGhpcyBmdW5jdGlvbiB0aGUgcHJvYmUgd2ls
bCBzaW1wbHkgZmFpbC4KClRoZSBleHBsYW5hdGlvbiBvZiB3aGF0IGZhaWxzIGlzIGluIHRoZSBj
b2RlOgoKPiA+ICsJCS8qCj4gPiArCQkgKiBXaGVuIGluc2lkZSBhIHN5c3RlbSBjb250cm9sbGVy
LCB0aGUgZGV2aWNlIG5hbWUgaGFzIHRoZQo+ID4gKwkJICogZm9ybTogZjA2ZjgwMDAuc3lzdGVt
LWNvbnRyb2xsZXI6YXAtdGhlcm1hbCBzbyBzdHJpcHBpbmcKPiA+ICsJCSAqIGFmdGVyIHRoZSAn
Oicgc2hvdWxkIGdpdmUgdXMgYSBzaG9ydGVyIGJ1dCBtZWFuaW5nZnVsIG5hbWUuCj4gPiArCQkg
Ki8KPiA+ICsJCW5hbWUgPSBzdHJyY2hyKG5hbWUsICc6Jyk7Cj4gPiArCQlpZiAoIW5hbWUpCj4g
PiArCQkJbmFtZSA9ICJhcm1hZGFfdGhlcm1hbCI7Cj4gPiArCQllbHNlCj4gPiArCQkJbmFtZSsr
OwoKWy4uLl0KCj4gPiArCj4gPiArCS8qIFRoZW4gY2hlY2sgdGhlcmUgYXJlIG5vICctJyBvciBo
d21vbiBjb3JlIHdpbGwgY29tcGxhaW4gKi8KClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
