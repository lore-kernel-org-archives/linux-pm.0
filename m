From: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: RE: [PATCH v3 3/6] drivers: clk-qoriq: increase array size of
 cmux_to_group
Date: Wed, 3 Oct 2018 14:25:11 +0000
Message-ID: <VI1PR04MB48001B1FBCF455D690ACF58DF3E90@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
 <1537747741-6245-4-git-send-email-vabhav.sharma@nxp.com>
 <153843144041.119890.5558230475983572666@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <153843144041.119890.5558230475983572666@swboyd.mtv.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-kernel-owner@vger.kernel.org" <linux-kernel-owner@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "mturquette@baylibre.com" <mturquette@bay>
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, Varun Sethi <V.Sethi@nxp.com>, Udit Kumar <udit.kumar@nxp.com>, Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
List-Id: linux-pm@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBCb3lkIDxz
Ym95ZEBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDIsIDIwMTggMzozNCBB
TQ0KPiBUbzogVmFiaGF2IFNoYXJtYSA8dmFiaGF2LnNoYXJtYUBueHAuY29tPjsgYXJuZEBhcm5k
Yi5kZTsNCj4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOw0KPiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsga3N0ZXdhcnRAbGludXhmb3VuZGF0
aW9uLm9yZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgt
Y2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBwbUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNv
bTsNCj4gbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207IG9zc0BidXNlcnJvci5uZXQ7IHJqd0Byand5
c29ja2kubmV0Ow0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IHN1ZGVlcC5ob2xsYUBhcm0uY29tOyB2
aXJlc2gua3VtYXJAbGluYXJvLm9yZzsNCj4gd2lsbC5kZWFjb25AYXJtLmNvbTsgeWFtYWRhLm1h
c2FoaXJvQHNvY2lvbmV4dC5jb20NCj4gQ2M6IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgVmFydW4g
U2V0aGkgPFYuU2V0aGlAbnhwLmNvbT47IFVkaXQgS3VtYXINCj4gPHVkaXQua3VtYXJAbnhwLmNv
bT47IFlvZ2VzaCBOYXJheWFuIEdhdXINCj4gPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPjsg
VmFiaGF2IFNoYXJtYSA8dmFiaGF2LnNoYXJtYUBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYzIDMvNl0gZHJpdmVyczogY2xrLXFvcmlxOiBpbmNyZWFzZSBhcnJheSBzaXplIG9mDQo+
IGNtdXhfdG9fZ3JvdXANCj4gDQo+IFN1YmplY3Qgc2hvdWxkIGJlICJjbGs6IHFvcmlxOiBpbmNy
ZWFzZSBhcnJheSBzaXplIC4uLiINCk9rDQoNCg==
