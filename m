From: Icenowy Zheng <icenowy@aosc.xyz>
Subject: Re: [RFC PATCH 3/5] thermal: Add support for the thermal sensor on
 A23/33
Date: Wed, 29 Jun 2016 21:42:41 +0800
Message-ID: <1264761467207761@web22j.yandex.ru>
References: <20160628101325.2522-1-icenowy@aosc.xyz>
 <20160628101325.2522-3-icenowy@aosc.xyz>
 <20160628114640.GE5550@lukather>
 <60021467122182@web19j.yandex.ru> <20160629121021.GD6095@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160629121021.GD6095@lukather>
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

CgoyOS4wNi4yMDE2LCAyMDoxMCwgIk1heGltZSBSaXBhcmQiIDxtYXhpbWUucmlwYXJkQGZyZWUt
ZWxlY3Ryb25zLmNvbT46Cj4gSGksCj4KPiBPbiBUdWUsIEp1biAyOCwgMjAxNiBhdCAwOTo1Njoy
MlBNICswODAwLCBJY2Vub3d5IFpoZW5nIHdyb3RlOgo+PiDCoFRoZSByZWFzb24gZm9yIGEgZGVk
aWNhdGUgZHJpdmVyIGlzOgo+PiDCoDEuIFRoaXMgSVAgaGF2ZSBvbmx5IHRoZXJtYWwgZnVuY3Rp
b24sIHNvIGl0J3Mgbm90IHN1aXRhYmxlIHRvIHVzZSBhCj4+IMKgZHJpdmVyIGF0IGRyaXZlcnMv
aW5wdXQvdG91Y2hzY3JlZW4vLgo+Cj4gVGhhdCdzIG5vdCBhIHByb2JsZW0sIGFuZCBpdCdzIGJl
aW5nIHdvcmtlZCBvbiBbMV0uCj4KPj4gwqAyLiBDb250cm9sIFJlZ2lzdGVyIGFyZSBxdWl0ZSBk
aWZmZXJlbnQuCj4KPiBUaGF0J3Mgbm90IGEgcHJvYmxlbSBlaXRoZXIsIHRoZXJlJ3MganVzdCBh
IGJpdCB0aGF0IHlvdSBkb24ndCBuZWVkIHRvCj4gc2V0IGluIHRoZSBjb250cm9sIDEgcmVnaXN0
ZXIsIGFuZCB0aGF0J3MgcHJldHR5IG11Y2ggaXQuIEl0IGRvZXNuJ3QKPiBqdXN0aWZ5IGEgd2hv
bGUgbmV3IGRyaXZlci4KPgo+PiDCoDMuIFRoaXMgSVAgdXNlcyBBVURJTyBQTEwgKFBMTDIpIGFz
IGl0cyBjbG9jayEKPgo+IEl0J3MgbGlzdGVkIGFzIHRoZSBpbnB1dCwgYnV0IGFsbCB0aGUgcmVz
dCBvZiB0aGUgZG9jdW1lbnRhdGlvbiByZWZlcnMKPiBvbmx5IHRvIDI0TUh6LCB3aGljaCBzZWVt
cyB0byBpbmRpY2F0ZSB0aGF0IGl0J3Mgb25seSBydW5uaW5nIG9uIHRoZQo+IG9zY2lsbGF0b3Is
IHdoaWNoIHdvdWxkIG1ha2UgbXVjaCBtb3JlIHNlbnNlLgo+Cj4gVGhhbmtzLAo+IE1heGltZQo+
Cj4gMTogaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LWFybS1rZXJu
ZWwvMjAxNi1KdW5lLzQzOTQ4Ny5odG1sCj4KPiAtLQo+IE1heGltZSBSaXBhcmQsIEZyZWUgRWxl
Y3Ryb25zCj4gRW1iZWRkZWQgTGludXgsIEtlcm5lbCBhbmQgQW5kcm9pZCBlbmdpbmVlcmluZwo+
IGh0dHA6Ly9mcmVlLWVsZWN0cm9ucy5jb20KCk9oIGl0IHdvcmtzIHByb3Blcmx5IHdpdGggUExM
MiBzZXQgYXMgYSBkdW1teSBwbGwuCgpNYXliZSBvbmx5IG9zYzI0TSBpcyByZXF1aXJlZC4uLgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
