From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / AVS: SmartReflex: remove unused function
Date: Thu, 15 Nov 2018 03:28:50 +0100
Message-ID: <CAJZ5v0g8Y+KTHmMfbzfhhRqs6MM9kq3p3J7R2tNvPZZs2iKhpQ@mail.gmail.com>
References: <20181006164059.16106-1-u.kleine-koenig@pengutronix.de>
 <10339961.29dihbgRqp@aspire.rjw.lan>
 <20181114094253.v45kxd2efgwhuh42@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181114094253.v45kxd2efgwhuh42@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Nishanth Menon <nm@ti.com>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, linadmin@quickline.ch, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCBOb3YgMTQsIDIwMTggYXQgMTA6NDIgQU0gVXdlIEtsZWluZS1Lw7ZuaWcKPHUua2xl
aW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4gd3JvdGU6Cj4KPiBIZWxsbywKPgo+IE9uIFR1ZSwg
T2N0IDE2LCAyMDE4IGF0IDExOjA5OjExQU0gKzAyMDAsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3Rl
Ogo+ID4gT24gU2F0dXJkYXksIE9jdG9iZXIgNiwgMjAxOCA2OjQwOjU5IFBNIENFU1QgVXdlIEts
ZWluZS1Lw7ZuaWcgd3JvdGU6Cj4gPiA+IEZyb206IFV3ZSBLbGVpbmUtS8O2bmlnIDx1d2VAa2xl
aW5lLWtvZW5pZy5vcmc+Cj4gPiA+Cj4gPiA+IG9tYXBfc3JfcmVnaXN0ZXJfcG1pYygpIHdhcyBp
bnRyb2R1Y2VkIGluIDIwMTAgaW4gY29tbWl0Cj4gPiA+Cj4gPiA+ICAgICA5ODRhYTZkYmY0Y2Eg
KCJPTUFQMzogUE06IEFkZGluZyBzbWFydHJlZmxleCBkcml2ZXIgc3VwcG9ydC4iKQo+ID4gPgo+
ID4gPiAuIFRoZXJlIHdhcyBuZXZlciBhbnkgY2FsbGVyIG9mIHRoaXMgZnVuY3Rpb24gaW4gbWFp
bmxpbmUgcmVzdWx0aW5nIGluIGEKPiA+ID4gd2FybmluZwo+ID4gPgo+ID4gPiAgICAgc3JfaW5p
dDogTm8gUE1JQyBob29rIHRvIGluaXQgc21hcnRyZWZsZXgKPiA+ID4KPiA+ID4gZm9yIGVhY2gg
bWFjaGluZSB3aGVyZSB0aGlzIGRyaXZlciBpcyBlbmFibGVkLiBTbyByZW1vdmUgdGhlIHVudXNl
ZAo+ID4gPiBmdW5jdGlvbiBhbmQgdGhlIHByX3dhcm4uCj4gPgo+ID4gQXBwbGllZCwgdGhhbmtz
IQo+Cj4gVGhpcyBwYXRjaCBkaWRuJ3QgbWFrZSBpdCBpbnRvIG5leHQgeWV0LCBpcyB0aGlzIGV4
cGVjdGVkPwoKSXQgZGlkIHNvbWUgdGltZSBhZ28sIGJ1dCB0aGVuIHRoZSBicmFuY2ggaXQncyBv
biB3YXMgbmVnbGVjdGVkIGJ5Cm1pc3Rha2UuICBTb3JyeSBhYm91dCB0aGF0LgoKSSB3aWxsIG1l
cmdlIGl0IGludG8gbXkgbGludXgtbmV4dCBicmFuY2ggbmV4dCB3ZWVrLgoKVGhhbmtzLApSYWZh
ZWwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
