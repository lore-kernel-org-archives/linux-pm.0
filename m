From: Icenowy Zheng <icenowy@aosc.xyz>
Subject: Re: [RFC PATCH 3/5] thermal: Add support for the thermal sensor on
 A23/33
Date: Wed, 29 Jun 2016 21:52:39 +0800
Message-ID: <1216731467208359@web29g.yandex.ru>
References: <20160628101325.2522-1-icenowy@aosc.xyz>
 <20160628101325.2522-3-icenowy@aosc.xyz>
 <20160628114640.GE5550@lukather> <60021467122182@web19j.yandex.ru>
 <20160629121021.GD6095@lukather>
 <1112501467207099@web30g.yandex.ru> <20160629134209.GE6095@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160629134209.GE6095@lukather>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "emilio@elopez.com.ar" <emilio@elopez.com.ar>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "wens@csie.org" <wens@csie.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

CgoyOS4wNi4yMDE2LCAyMTo0MiwgIk1heGltZSBSaXBhcmQiIDxtYXhpbWUucmlwYXJkQGZyZWUt
ZWxlY3Ryb25zLmNvbT46Cj4gT24gV2VkLCBKdW4gMjksIDIwMTYgYXQgMDk6MzE6MzlQTSArMDgw
MCwgSWNlbm93eSBaaGVuZyB3cm90ZToKPj4gwqBIb3dldmVyLCBzdW44aXczLzUgdGhzIGlzIG5v
dCBldmVuIGEgR1BBREMuLi4gSXQncyBhIHNwZWNpZmllZCBJUCwKPj4gwqBvbmx5IHVzZWQgYXMg
YW4gQURDIHN1aXRhYmxlIGZvciB0ZW1wZXJhdHVyZSBzZW5zb3IuCj4KPiBJdCBkb2Vzbid0IG1h
dHRlci4gSXQncyB0aGUgc2FtZSBJUCwgbGFiZWxsZWQgZGlmZmVyZW50bHkuCj4KPiBNYXhpbWUK
Pgo+IC0tCj4gTWF4aW1lIFJpcGFyZCwgRnJlZSBFbGVjdHJvbnMKPiBFbWJlZGRlZCBMaW51eCwg
S2VybmVsIGFuZCBBbmRyb2lkIGVuZ2luZWVyaW5nCj4gaHR0cDovL2ZyZWUtZWxlY3Ryb25zLmNv
bQoKT0ssIG5vdyBJIHdpbGwgc2VuZCBvbmx5IFBMTDIgZHJpdmVyLgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
