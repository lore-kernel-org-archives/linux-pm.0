From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Subject: [PATCH 0/5 v2] thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal
 support
Date: Sat, 3 Sep 2016 05:22:57 +0000
Message-ID: <SIXPR06MB0906A90665B5DA288D6E63ECA8E40@SIXPR06MB0906.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:55823 "EHLO
        relmlie4.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750900AbcICF0M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Sep 2016 01:26:12 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <damm+renesas@opensource.se>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Thao Phuong Le. Nguyen" <thao.nguyen.yb@rvc.renesas.com>, Hien Dang <hien.dang.eb@renesas.com>, Toru Oishi <toru.oishi.zj@renesas.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>

VGhpcyBwYXRjaHNldCBhZGRzIG5ldyB0aGVybWFsIHNlbnNvciBkcml2ZXIgdG8gc3VwcG9ydCAz
IHNlbnNvcnMgZm91bmQgaW4gUi1DYXIgR2VuMyBzZXJpZXMuDQoNCkl0IGhhcyBiZWVuIGRlY2lk
ZWQgdG8gY3JlYXRlIG5ldyBkcml2ZXIsIGluc3RlYWQgb2YgdXNpbmcgdGhlIGV4aXN0aW5nIHRo
ZXJtYWwgZHJpdmVyDQpkdWUgdG8gbWFueSBkaWZmZXJlbmNlcyBpbiBIVyBzZXR0aW5nIGZsb3dz
LCB0aGUgbWV0aG9kIHRvIGNhbGN1bGF0ZSB0ZW1wZXJhdHVyZXMgdmFsdWUNCmFuZCBzb21lIG5l
d2x5IHN1cHBvcnRlZCBmZWF0dXJlcy4NCg0KVGhlIG5ldyBkcml2ZXIgY2FuIHN1cHBvcnQgYm90
aCBwb2xsaW5nIG1vZGUgYW5kIGludGVycnVwdCBtb2RlLg0KSXQgaGFzIGJlZW4gdGVzdGVkIHdp
dGggUi1DYXIgSDMuIEkgZXhwZWN0IHNhbWUgcmVzdWx0IG9uIFItQ2FyIE0zLg0KDQpUaGlzIGRy
aXZlciBpcyBkZXZlbG9wZWQgYmFzZWQgb24gZWFybHkgd29yayBvZiBIaWVuIERhbmcgYW5kIFRo
YW8gTmd1eWVuLg0KQWxsIGNvbW1lbnRzIGFyZSB3ZWxjb21lLg0KDQpLaGllbSBOZ3V5ZW4gKDUp
Og0KICB0aGVybWFsOiByY2FyX2dlbjNfdGhlcm1hbDogRG9jdW1lbnQgdGhlIFItQ2FyIEdlbjMg
dGhlcm1hbCBiaW5kaW5ncw0KICB0aGVybWFsOiByY2FyX2dlbjNfdGhlcm1hbDogQWRkIFItQ2Fy
IEdlbjMgdGhlcm1hbCBkcml2ZXIgc3VwcG9ydA0KICBhcm02NDogZHRzOiByOGE3Nzk1OiBBZGQg
Ui1DYXIgR2VuMyB0aGVybWFsIHN1cHBvcnQNCiAgYXJtNjQ6IGR0czogcjhhNzc5NjogQWRkIFIt
Q2FyIEdlbjMgdGhlcm1hbCBzdXBwb3J0DQogIGFybTY0OiBkZWZjb25maWc6IEVuYWJsZSBSLUNh
ciBHZW4zIHRoZXJtYWwgc3VwcG9ydA0KDQogLi4uL2JpbmRpbmdzL3RoZXJtYWwvcmNhci1nZW4z
LXRoZXJtYWwudHh0ICAgICAgICAgfCAgNzkgKysrDQogYXJjaC9hcm02NC9ib290L2R0cy9yZW5l
c2FzL3I4YTc3OTUuZHRzaSAgICAgICAgICAgfCAgODMgKysrKw0KIGFyY2gvYXJtNjQvYm9vdC9k
dHMvcmVuZXNhcy9yOGE3Nzk2LmR0c2kgICAgICAgICAgIHwgIDgzICsrKysNCiBhcmNoL2FybTY0
L2NvbmZpZ3MvZGVmY29uZmlnICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArDQogZHJpdmVy
cy90aGVybWFsL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDkgKw0KIGRy
aXZlcnMvdGhlcm1hbC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsN
CiBkcml2ZXJzL3RoZXJtYWwvcmNhcl9nZW4zX3RoZXJtYWwuYyAgICAgICAgICAgICAgICB8IDUz
OSArKysrKysrKysrKysrKysrKysrKysNCiA3IGZpbGVzIGNoYW5nZWQsIDc5NiBpbnNlcnRpb25z
KCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy90aGVybWFsL3JjYXItZ2VuMy10aGVybWFsLnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL3RoZXJtYWwvcmNhcl9nZW4zX3RoZXJtYWwuYw0KDQotLSANCjEuOS4xDQo=
