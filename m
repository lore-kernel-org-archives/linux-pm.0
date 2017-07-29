From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH] thermal: fix INTEL_SOC_DTS_IOSF_CORE dependencies
Date: Sat, 29 Jul 2017 19:22:11 +0000
Message-ID: <1501356129.3479.1.camel@intel.com>
References: <20170721161704.3335851-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6110 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbdG2TWb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 29 Jul 2017 15:22:31 -0400
In-Reply-To: <20170721161704.3335851-1-arnd@arndb.de>
Content-Language: en-US
Content-ID: <A70780268AD08D47BB0460003562EEF2@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

T24gRnJpLCAyMDE3LTA3LTIxIGF0IDE4OjE2ICswMjAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0K
PiBXZSBnZXQgYSBLY29uZmlnIHdhcm5pbmcgd2hlbiBzZWxlY3RpbmcgdGhpcyB3aXRob3V0IGFs
c28gZW5hYmxpbmcNCj4gQ09ORklHX1BDSToNCj4gDQo+IHdhcm5pbmc6IChYODZfSU5URUxfTFBT
UyAmJiBJTlRFTF9TT0NfRFRTX0lPU0ZfQ09SRSAmJg0KPiBTTkRfU1NUX0lQQ19BQ1BJICYmIE1N
Q19TREhDSV9BQ1BJICYmIFBVTklUX0FUT01fREVCVUcpIHNlbGVjdHMNCj4gSU9TRl9NQkkgd2hp
Y2ggaGFzIHVubWV0IGRpcmVjdCBkZXBlbmRlbmNpZXMgKFBDSSkNCj4gDQo+IFRoaXMgYWRkcyBh
IG5ldyBkZXBlZGVuY3kuDQo+IA0KPiBGaXhlczogM2EyNDE5Zjg2NWE2ICgiVGhlcm1hbDogSW50
ZWwgU29DOiBEVFMgdGhlcm1hbCB1c2UgY29tbW9uDQo+IEFQSXMiKQ0KPiBTaWduZWQtb2ZmLWJ5
OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KUmV2aWV3ZWQtYnk6IFNyaW5pdmFzIFBh
bmRydXZhZGEgPHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29tPg0KDQo+IC0tLQ0K
PiDCoGRyaXZlcnMvdGhlcm1hbC9LY29uZmlnIHwgNCArKy0tDQo+IMKgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3RoZXJtYWwvS2NvbmZpZyBiL2RyaXZlcnMvdGhlcm1hbC9LY29uZmlnDQo+IGluZGV4IGI1
YjVmYWNiODc0Ny4uYWMyYTUzODIzNTc2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwv
S2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZw0KPiBAQCAtMzQyLDcgKzM0
Miw3IEBAIGNvbmZpZyBYODZfUEtHX1RFTVBfVEhFUk1BTA0KPiDCoA0KPiDCoGNvbmZpZyBJTlRF
TF9TT0NfRFRTX0lPU0ZfQ09SRQ0KPiDCoAl0cmlzdGF0ZQ0KPiAtCWRlcGVuZHMgb24gWDg2DQo+
ICsJZGVwZW5kcyBvbiBYODYgJiYgUENJDQo+IMKgCXNlbGVjdCBJT1NGX01CSQ0KPiDCoAloZWxw
DQo+IMKgCcKgwqBUaGlzIGlzIGJlY29taW5nIGEgY29tbW9uIGZlYXR1cmUgZm9yIEludGVsIFNv
Q3MgdG8gZXhwb3NlDQo+IHRoZSBhZGRpdGlvbmFsDQo+IEBAIC0zNTIsNyArMzUyLDcgQEAgY29u
ZmlnIElOVEVMX1NPQ19EVFNfSU9TRl9DT1JFDQo+IMKgDQo+IMKgY29uZmlnIElOVEVMX1NPQ19E
VFNfVEhFUk1BTA0KPiDCoAl0cmlzdGF0ZSAiSW50ZWwgU29DcyBEVFMgdGhlcm1hbCBkcml2ZXIi
DQo+IC0JZGVwZW5kcyBvbiBYODYNCj4gKwlkZXBlbmRzIG9uIFg4NiAmJiBQQ0kNCj4gwqAJc2Vs
ZWN0IElOVEVMX1NPQ19EVFNfSU9TRl9DT1JFDQo+IMKgCXNlbGVjdCBUSEVSTUFMX1dSSVRBQkxF
X1RSSVBTDQo+IMKgCWhlbHA=
