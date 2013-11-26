From: Bockholdt Arne <a.bockholdt@precitec-optronik.de>
Subject: [PATCH] intel_idle: Fixed C6 state on Avoton/Rangeley processors
Date: Tue, 26 Nov 2013 07:13:57 +0000
Message-ID: <1385450037.4588.10.camel@po-d-abo-ubu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.precitec.de ([85.115.17.50]:40979 "EHLO mail.precitec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753540Ab3KZHUA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 26 Nov 2013 02:20:00 -0500
Content-Language: en-US
Content-ID: <C5E6A247A888974F95B597DC8CB35BEF@precitecgroup.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Q29ycmVjdGVkIHRoZSBNV0FJVCBmbGFnIGZvciBDLVN0YXRlIEM2IG9uIEludGVsIEF2b3Rvbi9S
YW5nZWxleSBwcm9jZXNzb3JzLg0KDQpTaWduZWQtb2ZmLWJ5OiBBcm5lIEJvY2tob2xkdCA8bGlu
dXgta2VybmVsQGJvY2tob2xkdC5jb20+DQotLS0NCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWRs
ZS9pbnRlbF9pZGxlLmMgYi9kcml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jDQppbmRleCBjYmQ0ZTlh
Li45MmQxMjA2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYw0KKysrIGIv
ZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYw0KQEAgLTMyOSw3ICszMjksNyBAQCBzdGF0aWMgc3Ry
dWN0IGNwdWlkbGVfc3RhdGUgYXRvbV9jc3RhdGVzW10gX19pbml0ZGF0YSA9IHsNCiAJew0KIAkJ
LmVudGVyID0gTlVMTCB9DQogfTsNCi1zdGF0aWMgc3RydWN0IGNwdWlkbGVfc3RhdGUgYXZuX2Nz
dGF0ZXNbQ1BVSURMRV9TVEFURV9NQVhdID0gew0KK3N0YXRpYyBzdHJ1Y3QgY3B1aWRsZV9zdGF0
ZSBhdm5fY3N0YXRlc1tdIF9faW5pdGRhdGEgPSB7DQogCXsNCiAJCS5uYW1lID0gIkMxLUFWTiIs
DQogCQkuZGVzYyA9ICJNV0FJVCAweDAwIiwNCkBAIC0zNDAsNyArMzQwLDcgQEAgc3RhdGljIHN0
cnVjdCBjcHVpZGxlX3N0YXRlIGF2bl9jc3RhdGVzW0NQVUlETEVfU1RBVEVfTUFYXSA9IHsNCiAJ
ew0KIAkJLm5hbWUgPSAiQzYtQVZOIiwNCiAJCS5kZXNjID0gIk1XQUlUIDB4NTEiLA0KLQkJLmZs
YWdzID0gTVdBSVQyZmxnKDB4NTgpIHwgQ1BVSURMRV9GTEFHX1RJTUVfVkFMSUQgfCBDUFVJRExF
X0ZMQUdfVExCX0ZMVVNIRUQsDQorCQkuZmxhZ3MgPSBNV0FJVDJmbGcoMHg1MSkgfCBDUFVJRExF
X0ZMQUdfVElNRV9WQUxJRCB8IENQVUlETEVfRkxBR19UTEJfRkxVU0hFRCwNCiAJCS5leGl0X2xh
dGVuY3kgPSAxNSwNCiAJCS50YXJnZXRfcmVzaWRlbmN5ID0gNDUsDQogCQkuZW50ZXIgPSAmaW50
ZWxfaWRsZSB9LA0KDQo=
