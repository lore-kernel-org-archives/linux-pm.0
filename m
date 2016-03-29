From: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH v8 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Tue, 29 Mar 2016 00:32:12 +0000
Message-ID: <HE1PR04MB145070EE7CAC373C00C539478B870@HE1PR04MB1450.eurprd04.prod.outlook.com>
References: <cover.1458822334.git.baolin.wang@linaro.org>
	<20160325070937.GA22398@peterchendt>
	<CAMz4kuJYBg4eortA35Dhr4-jPVhLzu9XhjpOcu0hDWq6FV09mw@mail.gmail.com>
	<20160328071351.GC3302@peterchendt>
 <CAMz4kuK33mfiO9OttbRF9yVbQE1DFeuOtwyUWkCa5iPYbE-H8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMz4kuK33mfiO9OttbRF9yVbQE1DFeuOtwyUWkCa5iPYbE-H8g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org" <device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

IA0KPiANCj4gT24gMjggTWFyY2ggMjAxNiBhdCAxNToxMywgUGV0ZXIgQ2hlbiA8aHpwZXRlcmNo
ZW5AZ21haWwuY29tPiB3cm90ZToNCj4gPiBPbiBNb24sIE1hciAyOCwgMjAxNiBhdCAwMjo1MTo0
MFBNICswODAwLCBCYW9saW4gV2FuZyB3cm90ZToNCj4gPj4gT24gMjUgTWFyY2ggMjAxNiBhdCAx
NTowOSwgUGV0ZXIgQ2hlbiA8aHpwZXRlcmNoZW5AZ21haWwuY29tPiB3cm90ZToNCj4gPj4gPiBP
biBUaHUsIE1hciAyNCwgMjAxNiBhdCAwODozNTo1M1BNICswODAwLCBCYW9saW4gV2FuZyB3cm90
ZToNCj4gPj4gPj4gQ3VycmVudGx5IHRoZSBMaW51eCBrZXJuZWwgZG9lcyBub3QgcHJvdmlkZSBh
bnkgc3RhbmRhcmQNCj4gPj4gPj4gaW50ZWdyYXRpb24gb2YgdGhpcyBmZWF0dXJlIHRoYXQgaW50
ZWdyYXRlcyB0aGUgVVNCIHN1YnN5c3RlbSB3aXRoDQo+ID4+ID4+IHRoZSBzeXN0ZW0gcG93ZXIg
cmVndWxhdGlvbiBwcm92aWRlZCBieSBQTUlDcyBtZWFuaW5nIHRoYXQgZWl0aGVyDQo+ID4+ID4+
IHZlbmRvcnMgbXVzdCBhZGQgdGhpcyBpbiB0aGVpciBrZXJuZWxzIG9yIFVTQiBnYWRnZXQgZGV2
aWNlcyBiYXNlZA0KPiA+PiA+PiBvbiBMaW51eCAoc3VjaCBhcyBtb2JpbGUgcGhvbmVzKSBtYXkg
bm90IGJlaGF2ZSBhcyB0aGV5IHNob3VsZC4gVGh1cw0KPiBwcm92aWRlIGEgc3RhbmRhcmQgZnJh
bWV3b3JrIGZvciBkb2luZyB0aGlzIGluIGtlcm5lbC4NCj4gPj4gPj4NCj4gPj4gPj4gTm93IGlu
dHJvZHVjZSBvbmUgdXNlciB3aXRoIHdtODMxeF9wb3dlciB0byBzdXBwb3J0IGFuZCB0ZXN0IHRo
ZQ0KPiA+PiA+PiB1c2IgY2hhcmdlciwgd2hpY2ggaXMgcGVuZGluZyB0ZXN0aW5nLiBNb3Jlb3Zl
ciB0aGVyZSBtYXkgYmUgb3RoZXINCj4gPj4gPj4gcG90ZW50aWFsIHVzZXJzIHdpbGwgdXNlIGl0
IGluIGZ1dHVyZS4NCj4gPj4gPj4NCj4gPj4gPg0KPiA+PiA+IEkgYW0gYWZyYWlkIEkgc3RpbGwg
bm90IGZpbmQgdGhlIHVzZXIgKHVkYyBkcml2ZXIpIGZvciB0aGlzDQo+ID4+ID4gZnJhbWV3b3Jr
LCBJIHdvdWxkIGxpa2UgdG8gc2VlIGhvdyB1ZGMgZHJpdmVyIGJsb2NrIHRoZSBlbnVtZXJhdGlv
bg0KPiA+PiA+IHVudGlsIHRoZSBjaGFyZ2VyIGRldGVjdGlvbiBoYXMgZmluaXNoZWQsIG9yIGFt
IEkgbWlzc2luZyBzb21ldGhpbmc/DQo+ID4+DQo+ID4+IEl0IGlzIG5vdCBmb3IgdWRjIGRyaXZl
ciBidXQgZm9yIHBvd2VyIHVzZXJzIHdobyB3YW50IHRvIG5lZ290aWF0ZQ0KPiA+PiB3aXRoIFVT
QiBzdWJzeXN0ZW0uDQo+ID4+DQo+ID4NCj4gPiBUaGVuLCB3aGVyZSBpcyB0aGUgY29kZSB0aGUg
dGVzdCB1c2VyIHRvIGRlY2lkZSB3aGF0IGtpbmRzIG9mIFVTQg0KPiA+IGNoYXJnZXIgKFNEUCwg
Q0RQLCBEQ1ApIGlzIGNvbm5lY3Rpbmcgbm93Pw0KPiANCj4gVXNlcnMgY2FuIGNob29zZSB0byBp
bXBsZW1lbnQgbXVsdGlwbGUgd2F5cyB0byBnZXQgdGhlIGNoYXJnZXIgdHlwZSBJbg0KPiAndXNi
X2NoYXJnZXJfZGV0ZWN0X3R5cGUoKScgZnVuY3Rpb24uDQo+IA0KPiA+DQogDQpUaGVuLCBob3cg
eW91IHRlc3QgeW91ciBjb2RlPyBXaGVuIHdlIGludHJvZHVjZSBhbiBBUEksIGF0IGxlYXN0LCB0
aGVyZSBpcyBvbmUNCnVzZXIgZm9yIGl0Lg0KDQpQZXRlcg0K
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
