From: Shuah Khan <shuah.kh@samsung.com>
Subject: [PATCH] PM: Fix dev_pm_put_subsys_data() to not call kfree() while
 holding device power lock
Date: Fri, 3 May 2013 20:46:50 +0000
Message-ID: <1367614010.8452.2.camel@lorien>
Reply-To: Shuah Khan <shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <059CC7F1C823A24F96532224F6AF8F94@sisa.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "len.brown@intel.com" <len.brown@intel.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>
List-Id: linux-pm@vger.kernel.org

ZGV2X3BtX3B1dF9zdWJzeXNfZGF0YSgpIGNhbGxzIGtmcmVlKCkgd2hpbGUgaG9sZGluZyBkZXZp
Y2UgcG93ZXIgbG9jaywgd2hlbg0KdGhlIHJlZmVyZW5jZSBjb3VudCBpcyAwLiBGaXggaXQgdG8g
Y2FsbCBrZnJlZSgpIGFmdGVyIHJlbGVhc2luZyB0aGUgbG9jay4NCg0KU2lnbmVkLW9mZi1ieTog
U2h1YWggS2hhbiA8c2h1YWgua2hAc2Ftc3VuZy5jb20+DQotLS0NCiBkcml2ZXJzL2Jhc2UvcG93
ZXIvY29tbW9uLmMgfCAgICA2ICsrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9wb3dlci9jb21t
b24uYyBiL2RyaXZlcnMvYmFzZS9wb3dlci9jb21tb24uYw0KaW5kZXggMzljMzI1Mi4uZGEwNWZl
MiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvYmFzZS9wb3dlci9jb21tb24uYw0KKysrIGIvZHJpdmVy
cy9iYXNlL3Bvd2VyL2NvbW1vbi5jDQpAQCAtNzMsMTMgKzczLDE3IEBAIGludCBkZXZfcG1fcHV0
X3N1YnN5c19kYXRhKHN0cnVjdCBkZXZpY2UgKmRldikNCiANCiAJaWYgKC0tcHNkLT5yZWZjb3Vu
dCA9PSAwKSB7DQogCQlkZXYtPnBvd2VyLnN1YnN5c19kYXRhID0gTlVMTDsNCi0JCWtmcmVlKHBz
ZCk7DQogCQlyZXQgPSAxOw0KIAl9DQogDQogIG91dDoNCiAJc3Bpbl91bmxvY2tfaXJxKCZkZXYt
PnBvd2VyLmxvY2spOw0KIA0KKwlpZiAocmV0ID09IDEpIHsNCisJCS8qIGtmcmVlKCkgdmVyaWZp
ZXMgdGhhdCBpdHMgYXJndW1lbnQgaXMgbm9uemVyby4gKi8NCisJCWtmcmVlKHBzZCk7DQorCX0N
CisNCiAJcmV0dXJuIHJldDsNCiB9DQogRVhQT1JUX1NZTUJPTF9HUEwoZGV2X3BtX3B1dF9zdWJz
eXNfZGF0YSk7DQotLSANCjEuNy4xMC40DQoNCg0K
