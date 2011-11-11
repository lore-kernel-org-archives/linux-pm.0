From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] s3c-adc-battery: Add naive
	POWER_SUPPLY_PROP_PRESENT implementation
Date: Fri, 11 Nov 2011 16:18:56 +0100
Message-ID: <201111111619.00388.heiko__29794.3968711936$1321026260$gmane$org@sntech.de>
References: <201111100956.43979.heiko@sntech.de>
	<1320923106.2594.0.camel@anarsoul-laptop.Home>
	<20111110133052.GA31381@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20111110133052.GA31381@oksana.dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

QW0gRG9ubmVyc3RhZywgMTAuIE5vdmVtYmVyIDIwMTEsIDE0OjMwOjUyIHNjaHJpZWIgQW50b24g
Vm9yb250c292Ogo+IE9uIFRodSwgTm92IDEwLCAyMDExIGF0IDAyOjA1OjA2UE0gKzAzMDAsIFZh
c2lseSBLaG9ydXpoaWNrIHdyb3RlOgo+ID4gT24gVGh1LCAyMDExLTExLTEwIGF0IDA5OjU2ICsw
MTAwLCBIZWlrbyBTdMO8Ym5lciB3cm90ZToKPiA+ID4gVXNlcnNwYWNlIHByb2dyYW1zIGxpa2Ug
dXBvd2VyIHNlZW0gdG8gZGVwZW5kIG9uIHRoZSBwcmVzZW5jZSBvZiB0aGUKPiA+ID4gUE9XRVJf
U1VQUExZX1BST1BfUFJFU0VOVCBwcm9wZXJ0eS4KPiA+ID4gCj4gPiA+IFRoZSByZWFsIHByZXNl
bmNlIG9mIHRoZSBiYXR0ZXJ5IGNhbm5vdCBiZSBzZW5zZWQgYW5kIGFsbCBvdGhlcgo+ID4gPiBy
b3V0aW5lcyBvZiBzM2MtYWRjLWJhdHRlcnkgc2ltcGx5IGV4cGVjdCBpdCB0byBiZSBwcmVzZW50
Lgo+ID4gPiAKPiA+ID4gVGhlcmVmb3JlIHdlIHNpbXBseSByZXR1cm4gMSwgdW5sZXNzIHRoZSBi
YXR0ZXJ5IHN0cnVjdCBpcyBub3QgcHJlc2VudAo+ID4gPiBhdCBhbGwuCj4gPiAKPiA+IExvb2tz
IE9LIGZvciBtZSwKPiA+IAo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIZWlrbyBTdHVlYm5lciA8aGVp
a29Ac250ZWNoLmRlPgo+ID4gCj4gPiBBY2tlZC1ieTogVmFzaWx5IEtob3J1emhpY2sgPGFuYXJz
b3VsQGdtYWlsLmNvbT4KPiAKPiBJIGRpc2FncmVlLiBJZiB0aGUgZHJpdmVyIGJlaGF2ZXMgbGlr
ZSB0aGUgaGFyZHdhcmUgZG9lcyBub3Qgc3VwcG9ydAo+IGhvdC1wbHVnZ2FibGUgY2VsbHMsIHRo
ZW4gcHJlc2VudCBwcm9wZXJ0eSBpcyBub3QgbmVjZXNzYXJ5Lgo+IAo+IFVwb3dlcmQgc2hvdWxk
IGxvb2sgYXQgdGhlICdwcmVzZW50JyBvbmx5IGlmIGl0IGlzIHRoZXJlOyBhbmQgaWYgaXQKPiBp
cyBub3QsIGNlbGxzIGFzc3VtZWQgdG8gYmUgYWx3YXlzIHByZXNlbnQuCgpbLi5dCiAKPiBTbywg
dGhlIHByb2JsZW0gaXMgaW4gdXBvd2VyZCwgbm90IHRoaXMgZHJpdmVyLgoKVGhhbmtzIGZvciB5
b3VyIGNvbW1lbnQuIEkgd2lsbCB0aGVyZWZvcmUgdGFrZSB0aGlzIG1hdHRlciB1cCB3aXRoIHRo
ZSB1cG93ZXItCmd1eXMuCgpUaGFua3MKSGVpa28KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4LXBtQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LXBt
