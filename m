From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V4 2/2] thermal: broadcom: add Northstar thermal driver
Date: Sat, 1 Apr 2017 23:41:08 +0200
Message-ID: <426f06c2-e972-a9b0-e72c-88e7dde991ed@milecki.pl>
References: <20170331073132.21457-2-zajec5@gmail.com>
 <20170331201124.656-1-zajec5@gmail.com>
 <20170331201124.656-2-zajec5@gmail.com>
 <20170401195443.GE28514@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170401195443.GE28514@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <edubezval@gmail.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Ray Jui <rjui@broadcom.com>, linux-pm@vger.kernel.org, Lee Jones <lee@kernel.org>, Jon Mason <jon.mason@broadcom.com>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

T24gMDQvMDEvMjAxNyAwOTo1NCBQTSwgRWR1YXJkbyBWYWxlbnRpbiB3cm90ZToKPiBPbiBGcmks
IE1hciAzMSwgMjAxNyBhdCAxMDoxMToyNFBNICswMjAwLCBSYWZhxYIgTWnFgmVja2kgd3JvdGU6
Cj4+IEZyb206IFJhZmHFgiBNacWCZWNraSA8cmFmYWxAbWlsZWNraS5wbD4KPj4KPj4gTm9ydGhz
dGFyIGlzIGEgU29DIGZhbWlseSBjb21tb25seSB1c2VkIGluIGhvbWUgcm91dGVycy4gVGhpcyBj
b21taXQKPj4gYWRkcyBhIGRyaXZlciBmb3IgY2hlY2tpbmcgQ1BVIHRlbXBlcmF0dXJlLiBBcyBO
b3J0aHN0YXIgUGx1cyBzZWVtcyB0bwo+PiBhbHNvIGhhdmUgdGhpcyBJUCBibG9jayB0aGlzIG5l
dyBzeW1ib2wgZ2V0cyBBUkNIX0JDTV9JUFJPQyBkZXBlbmRlbmN5Lgo+Pgo+PiBTaWduZWQtb2Zm
LWJ5OiBSYWZhxYIgTWnFgmVja2kgPHJhZmFsQG1pbGVja2kucGw+Cj4+IFNpZ25lZC1vZmYtYnk6
IEpvbiBNYXNvbiA8am9uLm1hc29uQGJyb2FkY29tLmNvbT4KPj4gLS0tCj4KPiBUaGlzIGRyaXZl
ciBsb29rcyBmaW5lIGZyb20gd2hhdCBjb25jZXJucyB0aGUgb2YgdGhlcm1hbCB1c2FnZS4KPiBJ
IGhhZCBvbmx5IG9uZSByZXF1ZXN0IG9uIHRoZSBEVCBiaW5kaW5ncyBleGFtcGxlLiBJIGJlbGll
dmUgYmV0dGVyIHRvCj4gZ2V0IHRoZSBleGFtcGxlIGZpeGVkIHNvIGJhZCBEVHMgZG9lcyBub3Qg
Z2V0IGNvcGllZC4KClRoYW5rcyEgSSdsbCBjb21tZW50IG9uIHRoaXMgaW4gYSByZXBseSB0byBw
YXRjaCAxLzIuCgoKPj4gVjI6IE1ha2UgaXQgaVByb2Mgc3BlY2lmaWMgYXMgTlNQIGNhbiBhbHNv
IHVzZSB0aGlzIGRyaXZlcgo+PiAgICAgU2VsZWN0IHByb3BlciBzeW1ib2xzIGluIGNvbmZpZyBB
UkNIX0JDTV9JUFJPQwo+PiAgICAgRGVmaW5lIFBWVE1PTiByZWdpc3RlciBiaXRzCj4+ICAgICBV
cGRhdGUgY29kZSBzZWxlY3RpbmcgdGVtcGVyYXR1cmUgbW9uaXRvciBtb2RlCj4+ICAgICBUaGFu
ayB5b3UgSm9uIQo+PiBWMzogTW9yZSBkZXRhaWxzIGluIGhlbHAgbWVzc2FnZSBmb3IgQkNNX05T
X1RIRVJNQUwKPj4gICAgIFVzZSBzbG9wZSAmIG9mZnNldAo+PiAgICAgRHJvcCBhcmNoIGNvZGUg
Y2hhbmdlIChJJ2xsIGJlIHN1Ym1pdHRlZCB1c2luZyBhIHByb3BlciB0cmVlKQo+PiAgICAgVGhh
bmsgeW91IEVkdWFyZG8hCj4+IFY0OiBDb21tZW50IG9wZXJhdGlvbnMgb24gUFZUTU9OX0NPTlRS
T0wwIHJlZ2lzdGVyCj4+IC0tLQo+PiAgZHJpdmVycy90aGVybWFsL0tjb25maWcgICAgICAgICAg
ICAgICB8ICAgNSArKwo+PiAgZHJpdmVycy90aGVybWFsL01ha2VmaWxlICAgICAgICAgICAgICB8
ICAgMSArCj4+ICBkcml2ZXJzL3RoZXJtYWwvYnJvYWRjb20vS2NvbmZpZyAgICAgIHwgICA4ICsr
Kwo+PiAgZHJpdmVycy90aGVybWFsL2Jyb2FkY29tL01ha2VmaWxlICAgICB8ICAgMSArCj4+ICBk
cml2ZXJzL3RoZXJtYWwvYnJvYWRjb20vbnMtdGhlcm1hbC5jIHwgMTA1ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysKPgo+IEFsc28sIEkgaGF2ZSBqdXN0IG1lcmdlZCBhIEJSQ00g
ZHJpdmVyLiBEb2VzIGl0IG1ha2Ugc2Vuc2UgdG8gbW92ZSBpdAo+IGhlcmUgdG9vPwo+Cj4gSXQg
ZG9lcyBub3QgbmVlZCB0byBiZSBhIGJsb2NraW5nIHJlcXVlc3QgZm9yIHRoaXMgZHJpdmVyIHRo
b3VnaC4KClllcywgSSBwbGFuIHRvIHNlbmQgYSBwYXRjaCBmb3IgdGhhdCBhZnRlciBnZXR0aW5n
IHRoaXMgb25lIGFjY2VwdGVkLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
