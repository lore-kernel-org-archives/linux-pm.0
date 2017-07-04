From: "Wangtao (Kevin, Kirin)" <kevin.wangtao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: RE: [Patch v2 1/3] dt-bindings: Document the hi3660 thermal sensor
 bindings
Date: Tue, 4 Jul 2017 11:03:22 +0000
Message-ID: <68C6844FB78C6946B9DB8EACE2D237B0985B5A3B@dggeml507-mbx.china.huawei.com>
References: <1497930035-60894-3-git-send-email-kevin.wangtao@hisilicon.com>
 <1498102923-68481-1-git-send-email-kevin.wangtao@hisilicon.com>
 <20170701030534.GB11424@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170701030534.GB11424-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Content-Language: zh-CN
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "xuwei (O)" <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "Sunzhaosheng Sun(Zhaosheng)" <sunzhaosheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

DQpPbiAyMDE3LzcvMSAxMTowNiwgIkVkdWFyZG8gVmFsZW50aW4iIDxlZHViZXp2YWxAZ21haWwu
Y29tPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgSnVuIDIyLCAyMDE3IGF0IDExOjQyOjAxQU0gKzA4
MDAsIFRhbyBXYW5nIHdyb3RlOg0KPiA+IFRoaXMgYWRkcyBkb2N1bWVudGF0aW9uIG9mIGRldmlj
ZSB0cmVlIGJpbmRpbmdzIGZvciB0aGUNCj4gPiB0aGVybWFsIHNlbnNvciBjb250cm9sbGVyIG9m
IGhpMzY2MCBTb0MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUYW8gV2FuZyA8a2V2aW4ud2Fu
Z3Rhb0BoaXNpbGljb24uY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gLSBy
ZW1vdmUgcmVkdW5kYW50IHByb3BlcnR5DQo+ID4NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGlu
Z3MvdGhlcm1hbC9oaTM2NjAtdGhlcm1hbC50eHQgfCAgIDE2DQo+ICsrKysrKysrKysrKysrKysN
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVybWFsL2hpMzY2MC0N
Cj4gdGhlcm1hbC50eHQNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvdGhlcm1hbC9oaTM2NjAtDQo+IHRoZXJtYWwudHh0IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvaGkzNjYwLQ0KPiB0aGVybWFsLnR4dA0K
PiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMC4uZjNkZGRjZg0KPiA+
IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvdGhlcm1hbC9oaTM2NjAtdGhlcm1hbC50eHQNCj4gPiBAQCAtMCwwICsxLDE2IEBADQo+ID4g
KyogVGVtcGVyYXR1cmUgU2Vuc29yIG9uIGhpc2lsaWNvbiBoaTM2NjAgU29DDQo+ID4gKw0KPiAN
Cj4gV291bGQgeW91IG1pbmQgYWRkIHNvbWUgbW9yZSBkZXNjcmlwdGlvbiBvZiB0aGUgc2Vuc29y
cy93aGVyZSB0byBmaW5kDQo+IGZ1cnRoZXIgaGFyZHdhcmUgZG9jdW1lbnRhdGlvbj8NClN1cmUs
ICBkb2N1bWVudGF0aW9uIGlzIG9uDQpodHRwczovL2dpdGh1Yi5jb20vOTZib2FyZHMvZG9jdW1l
bnRhdGlvbi9ibG9iL21hc3Rlci9Db25zdW1lckVkaXRpb24vSGlLZXk5NjAvSGFyZHdhcmVEb2Nz
L0hpS2V5OTYwX1NvQ19SZWZlcmVuY2VfTWFudWFsLnBkZg0KDQo+IA0KPiA+ICsqKiBSZXF1aXJl
ZCBwcm9wZXJ0aWVzIDoNCj4gPiArDQo+ID4gKy0gY29tcGF0aWJsZTogImhpc2lsaWNvbix0aGVy
bWFsLWhpMzY2MCIuDQo+ID4gKy0gcmVnOiBwaHlzaWNhbCBiYXNlIGFkZHJlc3Mgb2YgdGhlcm1h
bCBzZW5zb3IgYW5kIGxlbmd0aCBvZiBtZW1vcnkNCj4gbWFwcGVkDQo+ID4gKyAgcmVnaW9uLg0K
PiA+ICstICN0aGVybWFsLXNlbnNvci1jZWxsczogU2hvdWxkIGJlIDEuIFNlZSAuL3RoZXJtYWwu
dHh0IGZvciBhIGRlc2NyaXB0aW9uLg0KPiA+ICsNCj4gPiArRXhhbXBsZSA6DQo+ID4gKw0KPiA+
ICsJdHNlbnNvcjogdHNlbnNvciB7DQo+ID4gKwkJY29tcGF0aWJsZSA9ICJoaXNpbGljb24sdGhl
cm1hbC1oaTM2NjAiOw0KPiA+ICsJCXJlZyA9IDwweDAgMHhmZmYzMDAwMCAweDAgMHgxMDAwPjsN
Cj4gPiArCQkjdGhlcm1hbC1zZW5zb3ItY2VsbHMgPSA8MT47DQo+ID4gKwkgfTsNCj4gPiAtLQ0K
PiA+IDEuNy45LjUNCj4gPg0K
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
