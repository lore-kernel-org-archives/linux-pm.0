From: "Li, Fei" <fei.li@intel.com>
Subject: RE: [PATCH V3] cpuidle: check dev before usage in
 cpuidle_use_deepest_state
Date: Mon, 8 May 2017 00:52:50 +0000
Message-ID: <BEC9F67575FA1E429CA7CF5AE9BE363432A46EAA@SHSMSX104.ccr.corp.intel.com>
References: <BEC9F67575FA1E429CA7CF5AE9BE363432A46913@SHSMSX104.ccr.corp.intel.com>
 <3249200.sUIrOijesG@aspire.rjw.lan>
 <CAHp75VezBgYRZ-axH=GsUw58tHO84ZvFELR1ApmAxn3wfCZiXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30327 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751037AbdEHAw5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 7 May 2017 20:52:57 -0400
In-Reply-To: <CAHp75VezBgYRZ-axH=GsUw58tHO84ZvFELR1ApmAxn3wfCZiXg@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Shi, FengX" <fengx.shi@intel.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Koul, Vinod" <vinod.koul@intel.com>

PiA+PiBSZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51
eC5pbnRlbC5jb20+DQo+ID4+IFJldmlld2VkLWJ5OiBLb3VsLCBWaW5vZCA8dmlub2Qua291bEBp
bnRlbC5jb20+DQo+IA0KPiA+IEEgcHJldmlvdXMgdmVyc2lvbiBvZiB0aGlzIGhhcyBiZWVuIGFw
cGxpZWQgYW5kIEkgZG9uJ3Qgc2VlIGFueSBkaWZmZXJlbmNlcw0KPiA+IGluIHRoZSBjb2RlIGNo
YW5nZXMuDQo+IA0KPiBBRkFJUiBvbmx5IHRhZ3MgKGFib3ZlKSBoYWQgYmVlbiBleHRlbmRlZCBp
biB2My4NCg0KVGhhbmtzLg0KWWVzLCBmb3IgdjMgbm8gY2hhbmdlIGluIGNvZGUsIGFuZCBvbmx5
IHRhZ3MgIlJldmlld2VkLWJ5IiBhZGRlZC4NCg0KPiANCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2Fy
ZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0KDQpCZXN0IFJlZ2FyZHMsDQpGZWkNCg==
