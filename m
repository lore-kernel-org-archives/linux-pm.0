From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH RESEND v2 02/10] power: charger-manager: Use
 power_supply_changed() not private uevent.
Date: Fri, 19 Dec 2014 07:41:15 +0000 (GMT)
Message-ID: <1443120167.38671418974875751.JavaMail.weblogic@epmlwas08d>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
MIME-version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?=EC=9D=B4=EC=A2=85=ED=99=94?= <jonghwa3.lee@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "anton@enomsg.org" <anton@enomsg.org>, "pavel@ucw.cz" <pavel@ucw.cz>, =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

PiAgIA0KPiAgV2hlbmV2ZXIgYmF0dGVyeSBzdGF0dXMgaXMgY2hhbmdlZCwgY2hhcmdlciBtYW5h
Z2VyIHRyaWVzIHRvIHRyaWdnZXIgdWV2ZW50DQo+IHRocm91Z2ggcHJpdmF0ZSBpbnRlcmZhY2Uu
IFRoaXMgcGF0Y2ggbW9kaWZpZXMgaXQgdG8gdXNlIHBvd2VyX3N1cHBseV9jaGFuZ2VkKCkNCj4g
c2luY2UgaXQgYmVsb25ncyB0byBwb3dlciBzdXBwbHkgc3Vic3lzdGVtLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogSm9uZ2h3YSBMZWUgPGpvbmdod2EzLmxlZUBzYW1zdW5nLmNvbT4NCg0KVGhlIG9y
aWdpbmFsIHVldmVudF9ub3RpZnkoKSBoYXMgdHdvIGFkZGl0aW9uYWwgbWVjaGFuaXNtczoNCkMx
LiBTYXZlIGV2ZW50cyBpbiBzdXNwZW5kLWFnYWluIGNvbnRleHQgYW5kIHNob3cgdGhlbSB1cCBh
dCB3YWtldXAuDQpDMi4gSWYgdGhlIG5ldyBldmVudCBpcyBhIGR1cGxpY2F0ZWQgZXZlbnQsIGln
bm9yZSBpdC4NCg0KUXVlc3Rpb25zOg0KUTEuIEhhdmUgeW91IGNoZWNrZWQgaWYgQzEgaXMgbWV0
IHdpdGggdGhlIG1vZGlmaWNhdGlvbj8gQmVzaWRlcywgaGF2ZQ0KeW91IG1hZGUgaXQgc3VyZSB0
aGF0IHRoZSBtb2RpZmljYXRpb24gd29uJ3QgY2hhbmdlIHRoZSBiZWhhdmlvciBvZg0Kc3VzcGVu
ZC1hZ2FpbiBjb250ZXh0PyAod2hldGhlciAidGhlb3JldGljYWwiIG9yICJleHBlcmltZW50YWwi
KQ0KUTIuIERvIHlvdSBzdGlsbCBzdXBwb3J0IEMyPw0KICBGb3IgZXhhbXBsZSwgaWYgd2UgaGF2
ZSBub3RpZml0ZWQgdGhlIHVzZXIgdGhhdCB3ZSBhcmUgY2hhcmdpbmcNCiAgMzAgc2Vjb25kcyBh
Z28sIHdlIHNob3VsZCBuZXZlciBib3RoZXIgdGhlIHVzZXIgd2l0aCBhbm90aGVyIG1lc3NhZ2UN
CiAgdGhhdCBkZWNsYXJlcyB0aGF0IGl0IGlzIGNoYXJnaW5nIHVubGVzcyB3ZSBoYXZlIG5vdGlm
aWVkIHRoYXQNCiAgd2UgYXJlIG5vdCBjaGFyZ2luZyBzaW5jZSB0aGVuLg0KDQpDaGVlcnMsDQpN
eXVuZ0pvby4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvcG93ZXIvY2hhcmdlci1tYW5hZ2VyLmMgfCAg
IDkxICsrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDExIGluc2VydGlvbnMoKyksIDgwIGRlbGV0aW9ucygtKQ0KPiANCg==
