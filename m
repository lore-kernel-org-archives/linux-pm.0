From: "Anson.Huang@freescale.com" <Anson.Huang@freescale.com>
Subject: RE: [PATCH 2/3] thermal: imx: add necessary clk operation
Date: Thu, 19 Dec 2013 06:52:29 +0000
Message-ID: <56958e0099194dc69d3d91a2ac8a97b2@DM2PR03MB317.namprd03.prod.outlook.com>
References: <1387477045-19037-1-git-send-email-b20788@freescale.com>
 <1387477045-19037-2-git-send-email-b20788@freescale.com>
 <20131219062450.GC4148@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131219062450.GC4148@tarshish>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcy4NCkFuc29uIGh1YW5nIOm7hOWLh+aJjQ0KwqANCkZyZWVzY2FsZSBT
ZW1pY29uZHVjdG9yIFNoYW5naGFpDQrkuIrmtbfmtabkuJzmlrDljLrkuq7mma/ot68xOTLlj7dB
5bqnMualvA0KMjAxMjAzDQpUZWw6MDIxLTI4OTM3MDU4DQoNCg0KPi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+RnJvbTogQmFydWNoIFNpYWNoIFttYWlsdG86YmFydWNoQHRrb3MuY28uaWxd
DQo+U2VudDogVGh1cnNkYXksIERlY2VtYmVyIDE5LCAyMDEzIDI6MjUgUE0NCj5UbzogSHVhbmcg
WW9uZ2NhaS1CMjA3ODgNCj5DYzogc2hhd24uZ3VvQGxpbmFyby5vcmc7IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgcnVpLnpoYW5nQGludGVsLmNvbTsNCj5lZHVhcmRvLnZhbGVudGluQHRpLmNvbTsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsNCj5s
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWRvY0B2Z2VyLmtlcm5l
bC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIIDIvM10gdGhlcm1hbDogaW14OiBhZGQgbmVjZXNz
YXJ5IGNsayBvcGVyYXRpb24NCj4NCj5IaSBBbnNvbiwNCj4NCj5PbiBUaHUsIERlYyAxOSwgMjAx
MyBhdCAwMToxNzoyNFBNIC0wNTAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4+ICsJaWYgKElTX0VS
UihkYXRhLT50aGVybWFsX2NsaykpIHsNCj4+ICsJCXJldCA9IElTX0VSUihkYXRhLT50aGVybWFs
X2Nsayk7DQo+DQo+WW91IHByb2JhYmx5IHdoYXQgdG8gcmV0dXJuIFBUUl9FUlIgaGVyZS4NCj4N
Cg0KWWVzLCB0aGFua3MsIHdpbGwgZml4IGl0IGluIFYyLg0KW0Fuc29uXSANCg0KDQo+YmFydWNo
DQo+DQo+PiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gZ2V0IHRoZXJtYWwgY2xr
IVxuIik7DQo+PiArCQlyZXR1cm4gcmV0Ow0KPj4gKwl9DQo+DQo+LS0NCj4gICAgIGh0dHA6Ly9i
YXJ1Y2guc2lhY2gubmFtZS9ibG9nLyAgICAgICAgICAgICAgICAgIH4uIC5+ICAgVGsgT3BlbiBT
eXN0ZW1zDQo+PX0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS1vb08tLVUtLU9vby0tLS0tLS0tLS0tLXs9DQo+ICAgLSBiYXJ1Y2hAdGtvcy5jby5pbCAtIHRl
bDogKzk3Mi4yLjY3OS41MzY0LCBodHRwOi8vd3d3LnRrb3MuY28uaWwgLQ0KPg0KDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
