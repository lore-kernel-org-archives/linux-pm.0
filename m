From: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: RE: [PATCH v3 4/6] drivers: clk-qoriq: Add clockgen support for
 lx2160a
Date: Wed, 3 Oct 2018 14:25:41 +0000
Message-ID: <VI1PR04MB48006A2701212ADAF1977D94F3E90@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
 <1537747741-6245-5-git-send-email-vabhav.sharma@nxp.com>
 <153843146463.119890.6551025813220021124@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <153843146463.119890.6551025813220021124@swboyd.mtv.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-kernel-owner@vger.kernel.org" <linux-kernel-owner@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "mturquette@baylibre.com" <mturquette@bay>
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, Varun Sethi <V.Sethi@nxp.com>, Udit Kumar <udit.kumar@nxp.com>, Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>, Andy Tang <andy.tang@nxp.com>
List-Id: linux-pm@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogZGV2aWNldHJlZS1vd25l
ckB2Z2VyLmtlcm5lbC5vcmcgPGRldmljZXRyZWUtb3duZXJAdmdlci5rZXJuZWwub3JnPg0KPiBP
biBCZWhhbGYgT2YgU3RlcGhlbiBCb3lkDQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMiwgMjAx
OCAzOjM0IEFNDQo+IFRvOiBWYWJoYXYgU2hhcm1hIDx2YWJoYXYuc2hhcm1hQG54cC5jb20+OyBh
cm5kQGFybmRiLmRlOw0KPiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBrc3Rld2FydEBsaW51
eGZvdW5kYXRpb24ub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWwtDQo+IG93bmVyQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHBtQHZn
ZXIua2VybmVsLm9yZzsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IG1hcmsucnV0bGFu
ZEBhcm0uY29tOw0KPiBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgb3NzQGJ1c2Vycm9yLm5ldDsg
cmp3QHJqd3lzb2NraS5uZXQ7DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgc3VkZWVwLmhvbGxhQGFy
bS5jb207IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOw0KPiB3aWxsLmRlYWNvbkBhcm0uY29tOyB5
YW1hZGEubWFzYWhpcm9Ac29jaW9uZXh0LmNvbQ0KPiBDYzogbGludXhAYXJtbGludXgub3JnLnVr
OyBWYXJ1biBTZXRoaSA8Vi5TZXRoaUBueHAuY29tPjsgVWRpdCBLdW1hcg0KPiA8dWRpdC5rdW1h
ckBueHAuY29tPjsgWW9nZXNoIE5hcmF5YW4gR2F1cg0KPiA8eW9nZXNobmFyYXlhbi5nYXVyQG54
cC5jb20+OyBBbmR5IFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPjsgVmFiaGF2DQo+IFNoYXJtYSA8
dmFiaGF2LnNoYXJtYUBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDQvNl0gZHJp
dmVyczogY2xrLXFvcmlxOiBBZGQgY2xvY2tnZW4gc3VwcG9ydCBmb3IgbHgyMTYwYQ0KPiANCj4g
U2FtZSBzdWJqZWN0IGNvbW1lbnQuDQpPaw0KPiANCj4gUXVvdGluZyBWYWJoYXYgU2hhcm1hICgy
MDE4LTA5LTIzIDE3OjA4OjU5KQ0KPiA+IEZyb206IFlvZ2VzaCBHYXVyIDx5b2dlc2huYXJheWFu
LmdhdXJAbnhwLmNvbT4NCj4gPg0KPiA+IEFkZCBjbG9ja2dlbiBzdXBwb3J0IGZvciBseDIxNjBh
Lg0K
