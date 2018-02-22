From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: Re: [PATCH] PM / devfreq: exynos-ppmu: Delete an error message
 for a failed memory allocation in exynos_ppmu_probe()
Date: Thu, 22 Feb 2018 14:14:18 +0900
Message-ID: <20180222051418epcms1p515085d1b1fabaf50983ff2ecb3442c02@epcms1p5>
References: <5A8364F8.8050801@samsung.com>
 <e4d3a870-f420-5a06-1665-59152c1924a3@users.sourceforge.net>
 <CGME20180213211754epcas1p12c743dac97dbc187c46206bc2fa16c78@epcms1p5>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5A8364F8.8050801@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chanwoo Choi <cw00.choi@samsung.com>, SF Markus Elfring <elfring@users.sourceforge.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

PiBPbiAyMDE464WEIDAy7JuUIDE07J28IDA2OjE3LCBTRiBNYXJrdXMgRWxmcmluZyB3cm90ZToN
Cj4gPiBGcm9tOiBNYXJrdXMgRWxmcmluZyA8ZWxmcmluZ0B1c2Vycy5zb3VyY2Vmb3JnZS5uZXQ+
DQo+ID4gRGF0ZTogVHVlLCAxMyBGZWIgMjAxOCAyMjoxMDo0MiArMDEwMA0KPiA+IA0KPiA+IE9t
aXQgYW4gZXh0cmEgbWVzc2FnZSBmb3IgYSBtZW1vcnkgYWxsb2NhdGlvbiBmYWlsdXJlIGluIHRo
aXMgZnVuY3Rpb24uDQo+ID4gDQo+ID4gVGhpcyBpc3N1ZSB3YXMgZGV0ZWN0ZWQgYnkgdXNpbmcg
dGhlIENvY2NpbmVsbGUgc29mdHdhcmUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFya3Vz
IEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0Pg0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL2RldmZyZXEvZXZlbnQvZXh5bm9zLXBwbXUuYyB8IDYgKystLS0tDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZGV2ZnJlcS9ldmVudC9leHlub3MtcHBtdS5jIGIvZHJpdmVycy9k
ZXZmcmVxL2V2ZW50L2V4eW5vcy1wcG11LmMNCj4gPiBpbmRleCBkOTZlM2RjNzFjZjguLjcyYWM5
MTEzNTAwZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2RldmZyZXEvZXZlbnQvZXh5bm9zLXBw
bXUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZGV2ZnJlcS9ldmVudC9leHlub3MtcHBtdS5jDQo+ID4g
QEAgLTYyNywxMSArNjI3LDkgQEAgc3RhdGljIGludCBleHlub3NfcHBtdV9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICANCj4gPiAgCXNpemUgPSBzaXplb2Yoc3RydWN0
IGRldmZyZXFfZXZlbnRfZGV2ICopICogaW5mby0+bnVtX2V2ZW50czsNCj4gPiAgCWluZm8tPmVk
ZXYgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ID4gLQlp
ZiAoIWluZm8tPmVkZXYpIHsNCj4gPiAtCQlkZXZfZXJyKCZwZGV2LT5kZXYsDQo+ID4gLQkJCSJm
YWlsZWQgdG8gYWxsb2NhdGUgbWVtb3J5IGRldmZyZXEtZXZlbnQgZGV2aWNlc1xuIik7DQo+ID4g
KwlpZiAoIWluZm8tPmVkZXYpDQo+ID4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4gLQl9DQo+ID4g
Kw0KPiA+ICAJZWRldiA9IGluZm8tPmVkZXY7DQo+ID4gIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShw
ZGV2LCBpbmZvKTsNCj4gPiAgDQo+ID4gDQo+IA0KPiBBY2tlZC1ieTogQ2hhbndvbyBDaG9pIDxj
dzAwLmNob2lAc2Ftc3VuZy5jb20+DQo+IA0KDQpBY2tlZC1ieTogTXl1bmdKb28gSGFtIDxteXVu
Z2pvby5oYW1Ac2Ftc3VuZy5jb20+DQoNCg0KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
