From: Shuah Khan <shuah.kh@samsung.com>
Subject: [PATCH v2] PM: Fix dev_pm_put_subsys_data() to not call kfree()
 while holding device power lock
Date: Mon, 6 May 2013 19:04:53 +0000
Message-ID: <1367867093.2953.49.camel@lorien>
References: <1367614010.8452.2.camel@lorien>
	 <20130504125116.GA13770@amd.pavel.ucw.cz>
	 <1882177.s6zpHZ6crc@vostro.rjw.lan>
	 <20130506120925.GA25542@amd.pavel.ucw.cz>
Reply-To: Shuah Khan <shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130506120925.GA25542@amd.pavel.ucw.cz>
Content-Language: en-US
Content-ID: <7579030CCEDC2A4EAE54A207B29DC6E0@sisa.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "len.brown@intel.com" <len.brown@intel.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>, Shuah Khan <shuah.kh@samsung.com>
List-Id: linux-pm@vger.kernel.org

ZGV2X3BtX3B1dF9zdWJzeXNfZGF0YSgpIGNhbGxzIGtmcmVlKCkgd2hpbGUgaG9sZGluZyBkZXZp
Y2UgcG93ZXIgbG9jaywgd2hlbg0KdGhlIHJlZmVyZW5jZSBjb3VudCBpcyAwLiBGaXggaXQgdG8g
Y2FsbCBrZnJlZSgpIGFmdGVyIHJlbGVhc2luZyB0aGUgbG9jay4NCg0KU2lnbmVkLW9mZi1ieTog
U2h1YWggS2hhbiA8c2h1YWgua2hAc2Ftc3VuZy5jb20+DQpSZXZpZXdlZC1ieTogUGF2ZWwgTWFj
aGVrIDxwYXZlbEB1Y3cuY3o+DQpSZXZpZXdlZC1ieTogUmFmYWVsIFd5c29ja2kgPHJhZmFlbC5q
Lnd5c29ja2lAaW50ZWwuY29tPg0KLS0tDQogZHJpdmVycy9iYXNlL3Bvd2VyL2NvbW1vbi5jIHwg
ICAgOCArKysrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvcG93ZXIvY29tbW9uLmMgYi9kcml2
ZXJzL2Jhc2UvcG93ZXIvY29tbW9uLmMNCmluZGV4IDM5YzMyNTIuLmU1Yjk5ZjcgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2Jhc2UvcG93ZXIvY29tbW9uLmMNCisrKyBiL2RyaXZlcnMvYmFzZS9wb3dl
ci9jb21tb24uYw0KQEAgLTYxLDI0ICs2MSwyNiBAQCBFWFBPUlRfU1lNQk9MX0dQTChkZXZfcG1f
Z2V0X3N1YnN5c19kYXRhKTsNCiBpbnQgZGV2X3BtX3B1dF9zdWJzeXNfZGF0YShzdHJ1Y3QgZGV2
aWNlICpkZXYpDQogew0KIAlzdHJ1Y3QgcG1fc3Vic3lzX2RhdGEgKnBzZDsNCi0JaW50IHJldCA9
IDA7DQorCWludCByZXQgPSAxOw0KIA0KIAlzcGluX2xvY2tfaXJxKCZkZXYtPnBvd2VyLmxvY2sp
Ow0KIA0KIAlwc2QgPSBkZXZfdG9fcHNkKGRldik7DQogCWlmICghcHNkKSB7DQotCQlyZXQgPSAt
RUlOVkFMOw0KIAkJZ290byBvdXQ7DQogCX0NCiANCiAJaWYgKC0tcHNkLT5yZWZjb3VudCA9PSAw
KSB7DQogCQlkZXYtPnBvd2VyLnN1YnN5c19kYXRhID0gTlVMTDsNCi0JCWtmcmVlKHBzZCk7DQog
CQlyZXQgPSAxOw0KKwl9IGVsc2Ugew0KKwkJcHNkID0gTlVMTDsNCisJCXJldCA9IDA7DQogCX0N
CiANCiAgb3V0Og0KIAlzcGluX3VubG9ja19pcnEoJmRldi0+cG93ZXIubG9jayk7DQorCWtmcmVl
KHBzZCk7DQogDQogCXJldHVybiByZXQ7DQogfQ0KLS0gDQoxLjcuMTAuNA0K
