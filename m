From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH 00/21] On-demand device registration
Date: Thu, 11 Jun 2015 15:09:45 +0200
Message-ID: <55798899.10504@collabora.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>	<CACRpkdasLwMfEHGMRd1X3K_DU7NMPreE8TMwqqDTg8k9wj=wJQ@mail.gmail.com>	<CAAObsKCP-C+TY8Wkk6bQzxZeGYL9X01trtjxfaYp--ZnH07C+w@mail.gmail.com>	<CACRpkdZuSj+S2x1yz6n5PgcRK=3ZCcq_To124b2Y+Oj54aydpg@mail.gmail.com>	<5577F533.1060007@ahsoftware.de>
 <CACRpkdYF5K7ckGbgvZc6qRzGFJTQ4WqXdu_7Tcqczn2LkFbn3A@mail.gmail.com>
 <5579602F.1070801@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <5579602F.1070801@ahsoftware.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alexander Holler <holler@ahsoftware.de>, Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, open@wandq.ahsoftware, dmaengine@vger.kernel.org, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "list@wandq.ahsoftware:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Grant Likely <grant.likely@linaro.org>, Dan Williams <dan.j.williams@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-usb@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

T24gMDYvMTEvMjAxNSAxMjoxNyBQTSwgQWxleGFuZGVyIEhvbGxlciB3cm90ZToKPiBBbSAxMS4w
Ni4yMDE1IHVtIDEwOjEyIHNjaHJpZWIgTGludXMgV2FsbGVpajoKPj4gT24gV2VkLCBKdW4gMTAs
IDIwMTUgYXQgMTA6MjggQU0sIEFsZXhhbmRlciBIb2xsZXIgPGhvbGxlckBhaHNvZnR3YXJlLmRl
PiB3cm90ZToKPj4+IEFtIDEwLjA2LjIwMTUgdW0gMDk6MzAgc2NocmllYiBMaW51cyBXYWxsZWlq
Ogo+Pgo+Pj4+IGkyYyBob3N0IGNvbWVzIG91dCwgcHJvYmVzIHRoZSByZWd1bGF0b3IgZHJpdmVy
LCByZWd1bGF0b3IgZHJpdmVyCj4+Pj4gcHJvYmVzIGFuZCB0aGVuIHRoZSByZWd1bGF0b3JfZ2V0
KCkgY2FsbCByZXR1cm5zLgo+Pj4+Cj4+Pj4gVGhpcyByZXF1aXJlcyBpbnN0cnVtZW50YXRpb24g
b24gYW55dGhpbmcgcHJvdmlkaW5nIGEgcmVzb3VyY2UKPj4+PiB0byBhbm90aGVyIGRyaXZlciBs
aWtlIHRob3NlIEkgbWVudGlvbmVkIGFuZCBhIGxvdCBvZiBvdmVyaGVhZAo+Pj4+IGluZnJhc3Ry
dWN0dXJlLCBidXQgSSB0aGluayBpdCdzIHRoZSByaWdodCBhcHByb2FjaC4gSG93ZXZlciBJIGRv
bid0Cj4+Pj4ga25vdyBpZiBJIHdvdWxkIGV2ZXIgYmUgYWJsZSB0byBwdWxsIHRoYXQgb2ZmIG15
c2VsZiwgSSBrbm93IHRhbGsKPj4+PiBpcyBjaGVhcCBhbmQgSSBzaG91bGQgc2hvdyB0aGUgY29k
ZSBpbnN0ZWFkLgo+Pj4KPj4+IFlvdSB3b3VsZCBlbmQgdXAgd2l0aCB0aGUgc2FtZSBwcm9ibGVt
IG9mIGRlYWRsb2NrcyBhcyBjdXJyZW50bHksIGFuZCB5b3UKPj4+IHdvdWxkIHN0aWxsIG5lZWQg
c29tZXRoaW5nIHVnbHkgbGlrZSB0aGUgZGVmZXJlZCBwcm9iZSBicnV0Zm9yY2UgdG8gYXZvaWQK
Pj4+IHRoZW0uCj4+Cj4+IFNvcnJ5IEkgZG9uJ3QgZ2V0IHRoYXQuIENhcmUgdG8gZWxhYm9yYXRl
IG9uIHdoeT8KPiAKPiBCZWNhdXNlIGxvYWRpbmcvaW5pdGlhbGl6aW5nIG9uIGRlbWFuZCBkb2Vz
bid0IGdpdmUgeW91IGFueSBzb2x2ZWQgb3JkZXIgCj4gb2YgZHJpdmVycyB0byBpbml0aWFsaXpl
LiBBbmQgaXQgY2FuJ3QgYmVjYXVzZSBpdCBoYXMgbm8gaWRlYSBhYm91dCB0aGUgCj4gcmVxdWly
ZW1lbnRzIG9mIG90aGVyIGRyaXZlcnMuCgpTbywgdGhpcyBpcyBvbmx5IGFib3V0IG9yZGVyaW5n
IGRldmljZSBwcm9iaW5nLiBBbGwgYnVpbHQtaW4gZHJpdmVycwpoYXZlIGFscmVhZHkgcmVnaXN0
ZXJlZCB0aGVtc2VsdmVzIGJ5IHdoZW4gd2Ugc3RhcnQgcHJvYmluZy4KCj4gVGhlIHJlYXNvbiB3
aHkgaXQgbWlnaHQgd29yayBiZXR0ZXIgaW4gCj4gdGhlIGNhc2Ugb2YgdGhlIHRlZ3JhIGlzIHRo
YXQgaXQgbWlnaHQgZ2l2ZSB5b3UgYW5vdGhlciBpbml0aWFsaXphdGlvbiAKPiBvcmRlciB0aGFu
IHRoZSBvbmUgd2hpY2ggaXMgY3VycmVudGx5IGNob29zZW4sIHdoaWNoLCBieSBsdWNrLCBtaWdo
dCBiZSAKPiBhIGJldHRlciBvbmUuCgpOb3RlIHRoYXQgdGhpcyBzZXJpZXMgd2FzIGFsc28gdGVz
dGVkIG9uIGlNWC42LCBFeHlub3MgYW5kIE9NQVA0LgoKPiBCdXQgbWF5YmUgSSBtaXNzZWQgc29t
ZXRoaW5nLCBJIGhhdmVuJ3QgbG9va2VkIGF0IHRoZSBwYXRjaGVzIGF0IGFsbC4gCgpJdCdzIGEg
cmVhbGx5IHNtYWxsIHBhdGNoc2V0IDopCgogIDE5IGZpbGVzIGNoYW5nZWQsIDEzMCBpbnNlcnRp
b25zKCspLCA0NSBkZWxldGlvbnMoLSkKClRoYW5rcywKClRvbWV1Cgo+IEJ1dCBqdXN0IGxvYWRp
bmcgb24gZGVtYW5kLCBjYW4ndCBtYWdpY2FsbHkgZ2l2ZSB5b3UgYSB3b3JraW5nIG9yZGVyIG9m
IAo+IGRyaXZlcnMgdG8gaW5pdGlhbGl6ZS4gRS5nLiBob3cgZG8geW91IGNob29zZSB0aGUgZmly
c3QgZHJpdmVyIHRvIAo+IGluaXRpYWxpemU/Cj4gCj4gUmVnYXJkcywKPiAKPiBBbGV4YW5kZXIg
SG9sbGVyCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
