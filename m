From: Troy Jia <hongtao.jia@nxp.com>
Subject: RE: [PATCH 1/3] dt-bindings: Update QorIQ TMU thermal bindings
Date: Thu, 5 Jan 2017 02:28:50 +0000
Message-ID: <AM4PR0401MB184304CF8DAB4FE6B6ECC13DEB600@AM4PR0401MB1843.eurprd04.prod.outlook.com>
References: <1483520271-3838-1-git-send-email-hongtao.jia@nxp.com>
         <1483520271-3838-2-git-send-email-hongtao.jia@nxp.com>
 <1483526274.17813.1.camel@buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-db5eur01on0078.outbound.protection.outlook.com ([104.47.2.78]:44384
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751122AbdAEC2y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Jan 2017 21:28:54 -0500
In-Reply-To: <1483526274.17813.1.camel@buserror.net>
Content-Language: zh-CN
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Scott Wood <oss@buserror.net>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "Y.T. Tang" <yuantian.tang@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2NvdHQgV29vZCBbbWFp
bHRvOm9zc0BidXNlcnJvci5uZXRdDQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAwNCwgMjAx
NyA2OjM4IFBNDQo+IFRvOiBUcm95IEppYSA8aG9uZ3Rhby5qaWFAbnhwLmNvbT47IHJ1aS56aGFu
Z0BpbnRlbC5jb207IGVkdWJlenZhbEBnbWFpbC5jb207DQo+IFkuVC4gVGFuZyA8eXVhbnRpYW4u
dGFuZ0BueHAuY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1wbUB2Z2VyLmtl
cm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvM10gZHQtYmluZGluZ3M6IFVw
ZGF0ZSBRb3JJUSBUTVUgdGhlcm1hbCBiaW5kaW5ncw0KPiANCj4gT24gV2VkLCAyMDE3LTAxLTA0
IGF0IDE2OjU3ICswODAwLCBKaWEgSG9uZ3RhbyB3cm90ZToNCj4gPiBGb3IgZGlmZmVyZW50IHR5
cGVzIG9mIFNvQyB0aGUgc2Vuc29yIGlkIGFuZCBlbmRpYW5uZXNzIG1heSB2YXJ5Lg0KPiA+ICIj
dGhlcm1hbC1zZW5zb3ItY2VsbHMiIGlzIHVzZWQgdG8gcHJvdmlkZSBzZW5zb3IgaWQgaW5mb3Jt
YXRpb24uDQo+ID4gImxpdHRsZS1lbmRpYW4iIHByb3BlcnR5IGlzIHRvIHRlbGwgdGhlIGVuZGlh
bm5lc3Mgb2YgVE1VLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhIEhvbmd0YW8gPGhvbmd0
YW8uamlhQG54cC5jb20+DQo+ID4gQWNrZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+DQo+ID4gLS0tDQo+ID4gwqBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGhl
cm1hbC9xb3JpcS10aGVybWFsLnR4dCB8IDcNCj4gPiArKysrKysrDQo+ID4gwqAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGhlcm1hbC9xb3JpcS10aGVybWFsLnR4dA0KPiA+
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvcW9yaXEtdGhlcm1h
bC50eHQNCj4gPiBpbmRleCA2NjIyM2Q1Li4yMGNhNGVmIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVybWFsL3FvcmlxLXRoZXJtYWwudHh0DQo+
ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvcW9yaXEt
dGhlcm1hbC50eHQNCj4gPiBAQCAtMTcsNiArMTcsMTIgQEAgUmVxdWlyZWQgcHJvcGVydGllczoN
Cj4gPiDCoAljYWxpYnJhdGlvbiBkYXRhLCBhcyBzcGVjaWZpZWQgYnkgdGhlIFNvQyByZWZlcmVu
Y2UgbWFudWFsLg0KPiA+IMKgCVRoZSBmaXJzdCBjZWxsIG9mIGVhY2ggcGFpciBpcyB0aGUgdmFs
dWUgdG8gYmUgd3JpdHRlbiB0byBUVENGR1IsDQo+ID4gwqAJYW5kIHRoZSBzZWNvbmQgaXMgdGhl
IHZhbHVlIHRvIGJlIHdyaXR0ZW4gdG8gVFNDRkdSLg0KPiA+ICstICN0aGVybWFsLXNlbnNvci1j
ZWxscyA6IE11c3QgYmUgMS4gVGhlIHNlbnNvciBzcGVjaWZpZXIgaXMgdGhlIG1vbml0b3JpbmcN
Cj4gPiArCXNpdGUgSUQsIGFuZCByZXByZXNlbnRzIHRoZSAibiIgaW4gVFJJVFNSbiBhbmQgVFJB
VFNSbi4NCj4gDQo+IEkgYXNzdW1lIHRoZSBkcml2ZXIgd2lsbCBjb250aW51ZSB0byB3b3JrIHdp
dGggZXhpc3RpbmcgZGV2aWNlIHRyZWVzIHdoZXJlIHRoaXMNCj4gaW5mb3JtYXRpb24gaXMgYWJz
ZW50PyDCoElmIHNvLCBBQ0sgZm9yIHRoZSB3aG9sZSBzZXJpZXMuDQoNClllcy4gVGhlIGRyaXZl
ciB3b3JrcyBmb3IgYWxsIGV4aXN0aW5nIGRldmljZSB0cmVlcy4NCg0KVGhhbmtzIGZvciB0aGUg
QUNLLg0KDQo+IA0KPiAtU2NvdHQNCg0K
