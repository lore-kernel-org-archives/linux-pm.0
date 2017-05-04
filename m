From: "Li, Fei" <fei.li@intel.com>
Subject: [PATCH V3] cpuidle: check dev before usage in
 cpuidle_use_deepest_state
Date: Thu, 4 May 2017 09:00:52 +0000
Message-ID: <BEC9F67575FA1E429CA7CF5AE9BE363432A46913@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:52972 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750786AbdEDJA4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 May 2017 05:00:56 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Shi, FengX" <fengx.shi@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Koul, Vinod" <vinod.koul@intel.com>

SW4gY2FzZSBvZiB0aGVyZSBpcyBubyBjcHVpZGxlIGRldmljZXMgcmVnaXN0ZXJlZCwgZGV2IHdp
bGwgYmUgbnVsbCwgYW5kIA0KcGFuaWMgd2lsbCBiZSB0cmlnZ2VyZWQgbGlrZSBiZWxvdzsNCklu
IHRoaXMgcGF0Y2gsIGFkZCBjaGVja2luZyBvZiBkZXYgYmVmb3JlIHVzYWdlLCBsaWtlIHRoYXQg
ZG9uZSBpbg0KY3B1aWRsZV9pZGxlX2NhbGwuDQoNClBhbmljIHdpdGhvdXQgZml4Og0KWyAgMTg0
Ljk2MTMyOF0gQlVHOiB1bmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZl
cmVuY2UgYXQNCiAgKG51bGwpDQpbICAxODQuOTYxMzI4XSBJUDogY3B1aWRsZV91c2VfZGVlcGVz
dF9zdGF0ZSsweDMwLzB4NjANCi4uLg0KWyAgMTg0Ljk2MTMyOF0gIHBsYXlfaWRsZSsweDhkLzB4
MjEwDQpbICAxODQuOTYxMzI4XSAgPyBfX3NjaGVkdWxlKzB4MzU5LzB4OGUwDQpbICAxODQuOTYx
MzI4XSAgPyBfcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUrMHgyOC8weDUwDQpbICAxODQuOTYx
MzI4XSAgPyBrdGhyZWFkX3F1ZXVlX2RlbGF5ZWRfd29yaysweDQxLzB4ODANClsgIDE4NC45NjEz
MjhdICBjbGFtcF9pZGxlX2luamVjdGlvbl9mdW5jKzB4NjQvMHgxZTANCg0KRml4ZXM6IGJiODMx
M2I2MDNlYjggKCJjcHVpZGxlOiBBbGxvdyBlbmZvcmNpbmcgZGVlcGVzdCBpZGxlIHN0YXRlIHNl
bGVjdGlvbiIpDQpTaWduZWQtb2ZmLWJ5OiBMaSwgRmVpIDxmZWkubGlAaW50ZWwuY29tPg0KVGVz
dGVkLWJ5OiBTaGksIEZlbmcgPGZlbmd4LnNoaUBpbnRlbC5jb20+DQpSZXZpZXdlZC1ieTogQW5k
eSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQpSZXZpZXdl
ZC1ieTogS291bCwgVmlub2QgPHZpbm9kLmtvdWxAaW50ZWwuY29tPg0KLS0tDQogZHJpdmVycy9j
cHVpZGxlL2NwdWlkbGUuYyB8IDMgKystIA0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1aWRsZS9jcHVpZGxl
LmMgYi9kcml2ZXJzL2NwdWlkbGUvY3B1aWRsZS5jDQppbmRleCA1NDhiOTBiLi4yNzA2YmU3IDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9jcHVpZGxlL2NwdWlkbGUuYw0KKysrIGIvZHJpdmVycy9jcHVp
ZGxlL2NwdWlkbGUuYw0KQEAgLTExMSw3ICsxMTEsOCBAQCB2b2lkIGNwdWlkbGVfdXNlX2RlZXBl
c3Rfc3RhdGUoYm9vbCBlbmFibGUpDQogDQogICAgcHJlZW1wdF9kaXNhYmxlKCk7DQogICAgZGV2
ID0gY3B1aWRsZV9nZXRfZGV2aWNlKCk7DQotICAgZGV2LT51c2VfZGVlcGVzdF9zdGF0ZSA9IGVu
YWJsZTsNCisgICBpZiAoZGV2KQ0KKyAgICAgICBkZXYtPnVzZV9kZWVwZXN0X3N0YXRlID0gZW5h
YmxlOw0KICAgIHByZWVtcHRfZW5hYmxlKCk7DQogfQ0KIA0KLS0gDQoxLjkuMQ0KDQpCZXN0IFJl
Z2FyZHMsDQpGZWkNCg==
