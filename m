From: Bockholdt Arne <a.bockholdt@precitec-optronik.de>
Subject: [PATCH v2] intel_idle: Fixed C6 state on Avoton/Rangeley processors
Date: Tue, 26 Nov 2013 13:38:25 +0000
Message-ID: <1385473105.4588.14.camel@po-d-abo-ubu>
References: <1385450037.4588.10.camel@po-d-abo-ubu>
	 <1574800.Vl6NB1rGSk@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.precitec.de ([85.115.17.50]:41639 "EHLO mail.precitec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115Ab3KZNib (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 26 Nov 2013 08:38:31 -0500
In-Reply-To: <1574800.Vl6NB1rGSk@amdc1032>
Content-Language: en-US
Content-ID: <FF23D130EEE8E54A80D1868AC0E15327@precitecgroup.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Q29ycmVjdGVkIHRoZSBNV0FJVCBmbGFnIGZvciBDLVN0YXRlIEM2IG9uIEludGVsIEF2b3Rvbi9S
YW5nZWxleSBwcm9jZXNzb3JzLg0KDQp2MS4udjI6IERyb3BwZWQgYWRkaXRpb25hbCBmaXh1cCBh
bHJlYWR5IGhhbmRsZWQgYnkgcHJldmlvdXMgcGF0Y2gNCg0KU2lnbmVkLW9mZi1ieTogQXJuZSBC
b2NraG9sZHQgPGxpbnV4LWtlcm5lbEBib2NraG9sZHQuY29tPg0KLS0tDQoNCmRpZmYgLXVwIGxp
bnV4L2RyaXZlcnMvaWRsZS9pbnRlbF9pZGxlLmMub3JpZyBsaW51eC9kcml2ZXJzL2lkbGUvaW50
ZWxfaWRsZS5jDQotLS0gbGludXgvZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYy5vcmlnCTIwMTMt
MTEtMjYgMTQ6MjM6MzkuMzcxNzA2MjI4ICswMTAwDQorKysgbGludXgvZHJpdmVycy9pZGxlL2lu
dGVsX2lkbGUuYwkyMDEzLTExLTI2IDE0OjI0OjA1LjM5OTY3NDkyOSArMDEwMA0KQEAgLTM0MCw3
ICszNDAsNyBAQCBzdGF0aWMgc3RydWN0IGNwdWlkbGVfc3RhdGUgYXZuX2NzdGF0ZXNbDQogCXsN
CiAJCS5uYW1lID0gIkM2LUFWTiIsDQogCQkuZGVzYyA9ICJNV0FJVCAweDUxIiwNCi0JCS5mbGFn
cyA9IE1XQUlUMmZsZygweDU4KSB8IENQVUlETEVfRkxBR19USU1FX1ZBTElEIHwgQ1BVSURMRV9G
TEFHX1RMQl9GTFVTSEVELA0KKwkJLmZsYWdzID0gTVdBSVQyZmxnKDB4NTEpIHwgQ1BVSURMRV9G
TEFHX1RJTUVfVkFMSUQgfCBDUFVJRExFX0ZMQUdfVExCX0ZMVVNIRUQsDQogCQkuZXhpdF9sYXRl
bmN5ID0gMTUsDQogCQkudGFyZ2V0X3Jlc2lkZW5jeSA9IDQ1LA0KIAkJLmVudGVyID0gJmludGVs
X2lkbGUgfSwNCg0K
