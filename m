From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/21] On-demand device registration
Date: Tue, 2 Jun 2015 10:48:50 +0200
Message-ID: <CACRpkdasLwMfEHGMRd1X3K_DU7NMPreE8TMwqqDTg8k9wj=wJQ@mail.gmail.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Grant Likely <grant.likely@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, dmaengine@vger.kernel.org, Alexander Holler <holler@ahsoftware.de>, Dan Williams <dan.j.williams@intel.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.or
List-Id: linux-pm@vger.kernel.org

T24gTW9uLCBNYXkgMjUsIDIwMTUgYXQgNDo1MyBQTSwgVG9tZXUgVml6b3NvCjx0b21ldS52aXpv
c29AY29sbGFib3JhLmNvbT4gd3JvdGU6Cgo+IGhhdmUgbG9va2VkIGludG8gb3JkZXJlZCBwcm9i
aW5nIGFzIGEKPiBiZXR0ZXIgd2F5IG9mIHNvbHZpbmcgdGhpcyB0aGFuIG1vdmluZyBub2RlcyBh
cm91bmQgaW4gdGhlIERUIG9yIHBsYXlpbmcgd2l0aAo+IGluaXRjYWxsIGxldmVscy4KPgo+IFdo
aWxlIHJlYWRpbmcgdGhlIHRocmVhZCBbMV0gdGhhdCBBbGV4YW5kZXIgSG9sbGVyIHN0YXJ0ZWQg
d2l0aCBoaXMgc2VyaWVzIHRvCj4gbWFrZSBwcm9iaW5nIG9yZGVyIGRldGVybWluaXN0aWMsIGl0
IG9jY3VycmVkIHRvIG1lIHRoYXQgaXQgc2hvdWxkIGJlIHBvc3NpYmxlCj4gdG8gYWNoaWV2ZSB0
aGUgc2FtZSBieSByZWdpc3RlcmluZyBkZXZpY2VzIGFzIHRoZXkgYXJlIHJlZmVyZW5jZWQgYnkg
b3RoZXIKPiBkZXZpY2VzLgoKVGhpcyBpcyBwcmV0dHkgY29vbCwgYnV0IGEgdG9vIGxvY2FsIHNv
bHV0aW9uIHRvIGEgZ2xvYmFsIHByb2JsZW0uCgpEZWZlcnJlZCBwcm9iZSBhbmQgaW5pdGNhbGwg
cmVvcmRlcmluZywgc2lsbHkgYXMgdGhleSBtYXkgc2VlbSwKZG9lcyBub3QgcmVxdWlyZSB5b3Ug
dG8gdXNlIGRldmljZSB0cmVlLgoKVGhlIHJlYWwgc29sdXRpb24sIHdoaWNoIEkgdGhpbmsgSSBw
b2ludGVkIG91dCBhbHJlYWR5IHdoZW4gd2UKYWRkZWQgZGVmZXJyZWQgcHJvYmUsIGlzIHRvIHB1
dCBkZXBlbmRlbmN5IGdyYXBocyBpbiB0aGUgZHJpdmVycwphbmQgaGF2ZSB0aGUga2VybmVsIGRl
dmljZSBkcml2ZXIgY29yZSBwZXJjb2xhdGUgZGVwZW5kZWNpZXMgYnkKd2Fsa2luZyB0aGUgZ3Jh
cGggb24gcHJvYmluZyBkcml2ZXIsIHJlbW92aW5nIGRyaXZlciAodXN1YWxseSB0aGUKaW52ZXJz
ZSB1c2UgY2FzZSksIFtydW50aW1lXSBzdXNwZW5kIGFuZCBbcnVudGltZV0gcmVzdW1laW5nCmEg
ZHJpdmVyLiBQb3NzaWJseSB0aGUgZGVwZW5kZW5jaWVzIHdpbGwgZXZlbiBiZSBkaWZmZXJlbnQK
ZGVwZW5kaW5nIG9uIHVzZSBjYXNlLgoKVGhpcyBpcyB3aGF0IHN5c3RlbWQgaXMgZG9pbmcgaW4g
dXNlcnNwYWNlIGZvciBzdGFydGluZyBzZXJ2aWNlczoKYXNrIGZvciB5b3VyIGRlcGVuZGVuY2ll
cyBhbmQgd2FpdCBmb3IgdGhlbSBpZiB0aGV5IGFyZSBub3QKdGhlcmUuIFNvIGRyaXZlcnMgYXNr
IGZvciByZXNvdXJjZXMgYW5kIHdhaXQgZm9yIHRoZW0uIEl0IGFsc28KbmVlZHMgdG8gYmUgYWJz
dHJhY3QsIHNvIGZvciBleGFtcGxlIHdlIG5lZWQgdG8gYmUgYWJsZSB0bwpoYW5nIG9uIHJlZ3Vs
YXRvcl9nZXQoKSB1bnRpbCB0aGUgZHJpdmVyIGlzIHVwIGFuZCBwcm92aWRpbmcgdGhhdApyZWd1
bGF0b3IsIGFuZCBhcyBsb25nIGFzIGV2ZXJ5dGhpbmcgaXMgaW4gc2xvd3BhdGggaXQgc2hvdWxk
CmJlIE9LLiAoQW5kIHZpY2UgdmVyc2EgbXV0YXRpcyBtdXRhbmRpcyBmb3IgY2xrLCBncGlvLCBw
aW4KY29udHJvbCwgaW50ZXJydXB0cyAoISkgYW5kIERNQSBjaGFubmVscyBmb3IgZXhhbXBsZS4p
CgoKU28gaWYgdGhpcyBzaG91bGQgYmUgc29sdmVkIGl0IHNob3VsZCBiZSBzb2x2ZWQgaW4gYW4g
YWJzdHJhY3Qgd2F5CmluIHRoZSBkZXZpY2UgZHJpdmVyIGNvcmUgYXZhaWxhYmxlIGZvciBhbGws
IHRoZW4gaGF2ZSBjYWxscyBjYWxsaW5nCm91dCB0byBEVCwgQUNQSSwgcG9zc2libHkgZXZlbiBQ
Q0kgb3IgVVNCIChhcyB0aGVzZQplbnVtZXJhdGUgZGV2aWNlcyB0aGVtc2VsdmVzKSB0byBvYnRh
aW4gYSBjZXJ0YWluCmRlcGVuZGVuY3kuCgpZb3VycywKTGludXMgV2FsbGVpagpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
