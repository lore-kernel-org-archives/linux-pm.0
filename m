From: "Ong, Boon Leong" <boon.leong.ong@intel.com>
Subject: RE: [PATCH v2 1/1] thermal: intel Quark SoC X1000 DTS thermal driver
Date: Thu, 5 Mar 2015 16:19:13 +0000
Message-ID: <AF233D1473C1364ABD51D28909A1B1B732767601@PGSMSX105.gar.corp.intel.com>
References: <1424880737-12119-1-git-send-email-boon.leong.ong@intel.com>
	<1424880737-12119-2-git-send-email-boon.leong.ong@intel.com>
	<54F48BCB.7070505@nexus-software.ie>
	<AF233D1473C1364ABD51D28909A1B1B73276139A@PGSMSX105.gar.corp.intel.com>
 <CAHp75VfLj5moAXsbXz4bFh8Ukgv9+4DWYc63E_SOKckR+gqNeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:31006 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757312AbbCEQUE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 5 Mar 2015 11:20:04 -0500
In-Reply-To: <CAHp75VfLj5moAXsbXz4bFh8Ukgv9+4DWYc63E_SOKckR+gqNeQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bryan O'Donoghue <pure.logic@nexus-software.ie>, "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "Kweh, Hock Leong" <hock.leong.kweh@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQW5keSBTaGV2Y2hlbmtvIFttYWls
dG86YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbV0NCj5TZW50OiBGcmlkYXksIE1hcmNoIDYsIDIw
MTUgMTI6MTEgQU0NCj5UbzogT25nLCBCb29uIExlb25nDQo+Q2M6IEJyeWFuIE8nRG9ub2dodWU7
IFpoYW5nLCBSdWk7IGVkdWJlenZhbEBnbWFpbC5jb207IEt3ZWgsIEhvY2sgTGVvbmc7DQo+bGlu
dXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+U3Vi
amVjdDogUmU6IFtQQVRDSCB2MiAxLzFdIHRoZXJtYWw6IGludGVsIFF1YXJrIFNvQyBYMTAwMCBE
VFMgdGhlcm1hbCBkcml2ZXINCj4NCj5PbiBUdWUsIE1hciAzLCAyMDE1IGF0IDM6MTMgQU0sIE9u
ZywgQm9vbiBMZW9uZw0KPjxib29uLmxlb25nLm9uZ0BpbnRlbC5jb20+IHdyb3RlOg0KPj4+PiAr
Y29uZmlnIElOVEVMX1FVQVJLX0RUU19USEVSTUFMDQo+Pj4+ICsgICAgdHJpc3RhdGUgIkludGVs
IFF1YXJrIERUUyB0aGVybWFsIGRyaXZlciINCj4+Pj4gKyAgICBkZXBlbmRzIG9uIFg4NiAmJiBJ
T1NGX01CSQ0KPj4+DQo+Pj5TaW5jZSB0aGUgY2hhbmdlIGlzIGluIFJDLTEgc3VnZ2VzdA0KPj4+
ZGVwZW5kcyBvbiBYODZfSU5URUxfUVVBUksNCj4+PnlvdSBjYW4gc2tpcCB0aGlzIHRob3VnaCBp
dCdzIG5vdCBpbXBvcnRhbnQuDQo+PiBZYS4gVGhhdCBpcyB0cnVlIG5vdyBzaW5jZSB0aGUgYmVs
b3cgY29tbWl0IGhhcyBiZWVuIG1lcmdlZDoNCj4+IDhiYmMyYTEzNWI2M2JlZTZiNDFmYTkwZjQx
NTUyMWE5Nzk5NWE0OWYgdG8gbWFpbmxpbmUgaW4gNC4wLXJjMQ0KPj4NCj4+IE9uIGFub3RoZXIg
dGhvdWdodCwgaG93IGFib3V0IGFkZGluZyBJTlRFTF9RVUFSS19EVFNfVEhFUk1BTCB0bw0KPj4g
YmUgc2VsZWN0ZWQgYnkgWDg2X0lOVEVMX1FVQVJLICBpbiBhcmNoL3g4Ni9LY29uZmlnIC4uLiBh
bmQgd2UgY2FuDQo+PiBkcm9wIHRoZSBhYm92ZSBkZXBlbmRlbmNpZXMgZnJvbSBoZXJlLg0KPg0K
PlRoaXMgZHJpdmVyIGFzIGZhciBhcyBJIHVuZGVyc3RhbmQgaXMgbm90IGNyaXRpY2FsIHRvIHJ1
biBJbnRlbCBRdWFyay4NCj5TbywgdGhlcmUgaXMgc2hvdWxkIG5vdCBiZSBhIGRlcGVuZGVuY3kg
aW4gdGhlIHBsYXRmb3JtIGRlZmluaXRpb24uDQpZdXAsIFF1YXJrIHBsYXRmb3JtIGNhbiBib290
IHVwIHdpdGhvdXQgdGhpcyBkcml2ZXIgc2VsZWN0ZWQgYnkgZGVmYXVsdC4NCg0KPg0KPk9uIHRo
ZSBvdGhlciBoYW5kIGlzIHRoZSBkcml2ZXIgd2lsbCB3b3JrIGV4Y2x1c2l2ZWx5IG9uIFF1YXJr
PyBJZiBzbywNCj5iZXR0ZXIgdG8gbGVhdmUgdGhlIG1lbnRpb25lZCBkZXBlbmRlbmN5LCAuaS5l
Lg0KPmRlcGVuZHMgb24gWDg2X0lOVEVMX1FVQVJLDQpZdXAuIEN1cnJlbnRseSwgaXQgaXMgZXhj
bHVzaXZlIHRvIFF1YXJrLiANCkluIHYzLCBJIG1ha2UgaXQgZGVwZW5kcyBvbiBYODZfSU5URUxf
UVVBUksgb25seS4gDQoNCg==
