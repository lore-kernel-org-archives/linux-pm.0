From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH 3/3] cpufreq: imx-sc: add i.mx system controller cpufreq
 support
Date: Wed, 13 Feb 2019 10:35:32 +0000
Message-ID: <DB3PR0402MB39161A96602CBF6D38514164F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550027011-7884-1-git-send-email-Anson.Huang@nxp.com>
 <1550027011-7884-3-git-send-email-Anson.Huang@nxp.com>
 <20190213070904.3oswrjafy6cqedsr@vireshk-i7>
 <DB3PR0402MB3916203C35D82A7667DA3A16F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB391662EC01B6160C1AA9A540F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190213101502.v75d3nfwctcks2gx@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213101502.v75d3nfwctcks2gx@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Aisheng Dong <aisheng.dong@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Andy Gross <andy.gross@linaro.org>, "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, "heiko@sntech.de" <heiko@sntech.de>, "arnd@arndb.de" <arnd@arndb.de>, "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>, "jagan@amarulasolutions.com" <jagan@amarulasolution>
List-Id: linux-pm@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogVmlyZXNoIEt1bWFyIFttYWlsdG86dmlyZXNoLmt1bWFyQGxpbmFyby5v
cmddDQo+IFNlbnQ6IDIwMTnE6jLUwjEzyNUgMTg6MTUNCj4gVG86IEFuc29uIEh1YW5nIDxhbnNv
bi5odWFuZ0BueHAuY29tPg0KPiBDYzogcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRA
YXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsg
a2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGNhdGFsaW4ubWFy
aW5hc0Bhcm0uY29tOyB3aWxsLmRlYWNvbkBhcm0uY29tOyByandAcmp3eXNvY2tpLm5ldDsNCj4g
QWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IERhbmllbCBCYWx1dGENCj4gPGRh
bmllbC5iYWx1dGFAbnhwLmNvbT47IEFuZHkgR3Jvc3MgPGFuZHkuZ3Jvc3NAbGluYXJvLm9yZz47
DQo+IGhvcm1zK3JlbmVzYXNAdmVyZ2UubmV0LmF1OyBoZWlrb0BzbnRlY2guZGU7IGFybmRAYXJu
ZGIuZGU7DQo+IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBqYWdhbkBhbWFydWxhc29sdXRp
b25zLmNvbTsNCj4gZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsgbWFyYy53LmdvbnphbGV6
QGZyZWUuZnI7IG9sb2ZAbGl4b20ubmV0Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxp
bnV4LQ0KPiBpbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIGNwdWZyZXE6
IGlteC1zYzogYWRkIGkubXggc3lzdGVtIGNvbnRyb2xsZXIgY3B1ZnJlcQ0KPiBzdXBwb3J0DQo+
IA0KPiBPbiAxMy0wMi0xOSwgMDg6NTMsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+IEZvcmdvdCB0
byBtZW50aW9uLCBpLk1YIHN5c3RlbSBjb250cm9sbGVyIGNwdWZyZXEgYWN0dWFsbHkgY2FuIE5P
VCBkbw0KPiA+IGFueSBDUFUgY2xvY2svdm9sdGFnZSBzY2FsaW5nIGZyb20gTGludXgga2VybmVs
LCB0aGV5IGFyZSBjb250cm9sbGVkDQo+ID4gYnkgc3lzdGVtIGNvbnRyb2xsZXIgZmlybXdhcmUg
YW5kIE9OTFkgY2FuIGJlIHJlcXVlc3RlZCB2aWEgUlBDIHdpdGgNCj4gPiBzZWN1cmUgbW9kZSwg
c28gTGludXgga2VybmVsIGhhcyB0byBjYWxsIFNNQyBhbmQgdHJhcCB0bw0KPiA+IEFSTS1UcnVz
dGVkLUZpcm13YXJlIHRvIGRvIGl0LCBpbiB0aGlzIGNhc2UsIGlzIGNwdWZyZXEtZHQgc3RpbGwN
Cj4gPiBzdWl0YWJsZSB0byBzdXBwb3J0IGl0PyBJIHNhdyBjcHVmcmVxLWR0IGRyaXZlciB3aWxs
IGRvIENQVSBjbG9jay92b2x0YWdlDQo+IHNjYWxpbmcgZGlyZWN0bHkuDQo+IA0KPiBXaGF0IGFi
b3V0IG1vdmluZyB0aG9zZSBTTUMgY2FsbHMgdG8gdGhlIGNsay1kcml2ZXIsIHRoZW4gaXQgd291
bGRuJ3QgbWF0dGVyDQo+IHRvIHRoZSBjcHVmcmVxIGRyaXZlciBvbiBob3cgdGhlIGNsb2NrIGlz
IGdldHRpbmcgY2hhbmdlZC4NCg0KT0ssIHRoYW5rcywgSSB3aWxsIGhhdmUgYSB0cnkgYW5kIHJl
c2VuZCB0aGUgcGF0Y2guDQoNCkFuc29uLg0KDQo+IA0KPiAtLQ0KPiB2aXJlc2gNCg==
