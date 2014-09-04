From: "Liu, Chuansheng" <chuansheng.liu@intel.com>
Subject: RE: [PATCH 1/3] sched: Add new API wake_up_if_idle() to wake up the
 idle cpu
Date: Thu, 4 Sep 2014 12:59:54 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A01E6B3A6@SHSMSX101.ccr.corp.intel.com>
References: <1409815075-4180-1-git-send-email-chuansheng.liu@intel.com>
 <540860AC.3030905@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <540860AC.3030905@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "peterz@infradead.org" <peterz@infradead.org>, "luto@amacapital.net" <luto@amacapital.net>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "mingo@redhat.com" <mingo@redhat.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Liu, Changcheng" <changcheng.liu@intel.com>, "Wang, Xiaoming" <xiaoming.wang@intel.com>, "Chakravarty, Souvik K" <souvik.k.chakravarty@intel.com>
List-Id: linux-pm@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIExlemNhbm8g
W21haWx0bzpkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnXQ0KPiBTZW50OiBUaHVyc2RheSwgU2Vw
dGVtYmVyIDA0LCAyMDE0IDg6NTMgUE0NCj4gVG86IExpdSwgQ2h1YW5zaGVuZzsgcGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc7IGx1dG9AYW1hY2FwaXRhbC5uZXQ7DQo+IHJqd0Byand5c29ja2kubmV0OyBt
aW5nb0ByZWRoYXQuY29tDQo+IENjOiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExpdSwgQ2hhbmdjaGVuZzsNCj4gV2FuZywgWGlhb21pbmc7
IENoYWtyYXZhcnR5LCBTb3V2aWsgSw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvM10gc2NoZWQ6
IEFkZCBuZXcgQVBJIHdha2VfdXBfaWZfaWRsZSgpIHRvIHdha2UgdXAgdGhlDQo+IGlkbGUgY3B1
DQo+IA0KPiBPbiAwOS8wNC8yMDE0IDA5OjE3IEFNLCBDaHVhbnNoZW5nIExpdSB3cm90ZToNCj4g
PiBJbXBsZW1lbnRpbmcgb25lIG5ldyBBUEkgd2FrZV91cF9pZl9pZGxlKCksIHdoaWNoIGlzIHVz
ZWQgdG8NCj4gPiB3YWtlIHVwIHRoZSBpZGxlIENQVS4NCj4gPg0KPiA+IFN1Z2dlc3RlZC1ieTog
QW5keSBMdXRvbWlyc2tpIDxsdXRvQGFtYWNhcGl0YWwubmV0Pg0KPiA+IFNpZ25lZC1vZmYtYnk6
IENodWFuc2hlbmcgTGl1IDxjaHVhbnNoZW5nLmxpdUBpbnRlbC5jb20+DQo+IA0KPiBIaSBDaHVh
bnNlbmcsDQo+IA0KPiBpbiB0aGUgZnV0dXJlLCBwbGVhc2UgcHJlZml4IHRoZSBwYXRjaGVzIHdp
dGggdGhlIHZlcnNpb24gbnVtYmVyIGFuZCBhDQo+IGNoYW5nZWxvZy4NCj4gDQpUaGFua3MgeW91
ciBhZHZpY2UsIERhbmllbCwgd2lsbCBkbyB0aGF0IG5leHQgdGltZTopDQoNCg==
