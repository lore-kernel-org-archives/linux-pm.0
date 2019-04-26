Return-Path: <SRS0=x0P7=S4=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC09C43219
	for <linux-pm@archiver.kernel.org>; Fri, 26 Apr 2019 21:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10642206DD
	for <linux-pm@archiver.kernel.org>; Fri, 26 Apr 2019 21:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RoIaOX7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfDZViW (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:38:22 -0400
Received: from mail-eopbgr10061.outbound.protection.outlook.com ([40.107.1.61]:34670
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726246AbfDZViW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Apr 2019 17:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMqpDbh78nMRg0X/dXqQ8/znlSVMVMGE16CYCnjHBeI=;
 b=RoIaOX7vy774QRMcZxbs5QsLe1+3sCQrXNfqjN9cfF2hJMqa8O1Pmmr3obYMXjCdRmukjLMfpN+ERYX4QXadKt5B8WvT2YiM3xNHaNoqD8FEfS2rxfSeC6anjgmpJDqRFcqIi5LMZ1d8SQdTUVvO7Gj/UNSBnw4+tpVAjZc+Coc=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB4451.eurprd04.prod.outlook.com (52.135.149.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 21:38:14 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::f56b:2fea:d9c0:7c2b]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::f56b:2fea:d9c0:7c2b%6]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 21:38:14 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Arulpandiyan Vadivel <Arulpandiyan_Vadivel@mentor.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 1/2] PM / Domains: Add GENPD_FLAG_NO_RUNTIME_OFF flag
Thread-Topic: [PATCH v4 1/2] PM / Domains: Add GENPD_FLAG_NO_RUNTIME_OFF flag
Thread-Index: AQHU/Hhau/GWEJEX5Ui7EZG6LbfZoA==
Date:   Fri, 26 Apr 2019 21:38:14 +0000
Message-ID:
 <68ccb5a90d1d2a596e7ed94ba3245171f013c781.1556313614.git.leonard.crestez@nxp.com>
References: <cover.1556313614.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1556313614.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: VI1PR06CA0164.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::21) To AM0PR04MB6434.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bcb7fc3-7f8c-472d-3f20-08d6ca8f7d04
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4451;
x-ms-traffictypediagnostic: AM0PR04MB4451:
x-microsoft-antispam-prvs: <AM0PR04MB44510B4168758B584923E1CDEE3E0@AM0PR04MB4451.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(396003)(346002)(189003)(199004)(8676002)(73956011)(76176011)(52116002)(81166006)(2906002)(66946007)(486006)(66446008)(66556008)(81156014)(44832011)(64756008)(66476007)(478600001)(36756003)(4326008)(446003)(2616005)(50226002)(118296001)(86362001)(476003)(11346002)(5660300002)(53936002)(66066001)(102836004)(6436002)(6486002)(186003)(256004)(14444005)(26005)(97736004)(68736007)(305945005)(316002)(386003)(6506007)(7736002)(99286004)(8936002)(25786009)(54906003)(3846002)(6116002)(14454004)(6512007)(71190400001)(71200400001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4451;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N7aPId5JqjvzUakVHiKnvFO301V8v6j3LlJHYiQrjAo6zu2hQkoC6slw+dfyroKelZ6n08vL5cdBDD/v+avqeApNafluzIs5wY6jOPpg8Mp8yXFCF337xxfWgcn9l1Pz9DmcvGbiihR0qV77yzMjkYrhUsAYTxY/n68g7R0uVr3St/3v5M1MngMNWfM6i5FYjVYS6Kefxyxos+6o4BeXA77dLLeIxgxFsrWDI35NyKm2/rnQzY8pQg/4DUpjFST9yhqQIA9/jLisNiRzyjpThP3SMXrPxOl/qOARxrPj01/Hsni9giOW9PaaXtaZ6wUwKka2T02UPvw79iERj6RBir8chHY4beP9RSGLknICSD1BMjAdwhHYV/Wivk1PB5yEx2DwPJ4cSn3VZvu/TIH+CbPUqvAOrKoktSxo8wZmEhY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcb7fc3-7f8c-472d-3f20-08d6ca8f7d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 21:38:14.8600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4451
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190426213814.REknDzwRO23MSl0DYD_8KoA4djzOQteIGmuCB6EEO7s@z>

VGhpcyBpcyBmb3IgcG93ZXIgZG9tYWlucyB3aGljaCBjYW4gb25seSBiZSBwb3dlcmVkIG9mZiBm
b3Igc3VzcGVuZCBidXQNCm5vdCBhcyBwYXJ0IG9mIHJ1bnRpbWUgUE0uDQoNClN1Z2dlc3RlZC1i
eTogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBM
ZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg0KLS0tDQogZHJpdmVycy9i
YXNlL3Bvd2VyL2RvbWFpbi5jIHwgOCArKysrKystLQ0KIGluY2x1ZGUvbGludXgvcG1fZG9tYWlu
LmggICB8IDQgKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9wb3dlci9kb21haW4uYyBiL2Ry
aXZlcnMvYmFzZS9wb3dlci9kb21haW4uYw0KaW5kZXggMTg5ZDdlMTRjNjExLi5mNTAyMjE4YTBk
ZGIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Jhc2UvcG93ZXIvZG9tYWluLmMNCisrKyBiL2RyaXZl
cnMvYmFzZS9wb3dlci9kb21haW4uYw0KQEAgLTEyNiwxMCArMTI2LDExIEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgZ2VucGRfbG9ja19vcHMgZ2VucGRfc3Bpbl9vcHMgPSB7DQogI2RlZmluZSBnZW5w
ZF9zdGF0dXNfb24oZ2VucGQpCQkoZ2VucGQtPnN0YXR1cyA9PSBHUERfU1RBVEVfQUNUSVZFKQ0K
ICNkZWZpbmUgZ2VucGRfaXNfaXJxX3NhZmUoZ2VucGQpCShnZW5wZC0+ZmxhZ3MgJiBHRU5QRF9G
TEFHX0lSUV9TQUZFKQ0KICNkZWZpbmUgZ2VucGRfaXNfYWx3YXlzX29uKGdlbnBkKQkoZ2VucGQt
PmZsYWdzICYgR0VOUERfRkxBR19BTFdBWVNfT04pDQogI2RlZmluZSBnZW5wZF9pc19hY3RpdmVf
d2FrZXVwKGdlbnBkKQkoZ2VucGQtPmZsYWdzICYgR0VOUERfRkxBR19BQ1RJVkVfV0FLRVVQKQ0K
ICNkZWZpbmUgZ2VucGRfaXNfY3B1X2RvbWFpbihnZW5wZCkJKGdlbnBkLT5mbGFncyAmIEdFTlBE
X0ZMQUdfQ1BVX0RPTUFJTikNCisjZGVmaW5lIGdlbnBkX2lzX25vX3J1bnRpbWVfb2ZmKGdlbnBk
KQkoZ2VucGQtPmZsYWdzICYgR0VOUERfRkxBR19OT19SVU5USU1FX09GRikNCiANCiBzdGF0aWMg
aW5saW5lIGJvb2wgaXJxX3NhZmVfZGV2X2luX25vX3NsZWVwX2RvbWFpbihzdHJ1Y3QgZGV2aWNl
ICpkZXYsDQogCQljb25zdCBzdHJ1Y3QgZ2VuZXJpY19wbV9kb21haW4gKmdlbnBkKQ0KIHsNCiAJ
Ym9vbCByZXQ7DQpAQCAtNTEzLDExICs1MTQsMTMgQEAgc3RhdGljIGludCBnZW5wZF9wb3dlcl9v
ZmYoc3RydWN0IGdlbmVyaWNfcG1fZG9tYWluICpnZW5wZCwgYm9vbCBvbmVfZGV2X29uLA0KIAkv
Kg0KIAkgKiBBYm9ydCBwb3dlciBvZmYgZm9yIHRoZSBQTSBkb21haW4gaW4gdGhlIGZvbGxvd2lu
ZyBzaXR1YXRpb25zOg0KIAkgKiAoMSkgVGhlIGRvbWFpbiBpcyBjb25maWd1cmVkIGFzIGFsd2F5
cyBvbi4NCiAJICogKDIpIFdoZW4gdGhlIGRvbWFpbiBoYXMgYSBzdWJkb21haW4gYmVpbmcgcG93
ZXJlZCBvbi4NCiAJICovDQotCWlmIChnZW5wZF9pc19hbHdheXNfb24oZ2VucGQpIHx8IGF0b21p
Y19yZWFkKCZnZW5wZC0+c2RfY291bnQpID4gMCkNCisJaWYgKGdlbnBkX2lzX2Fsd2F5c19vbihn
ZW5wZCkgfHwNCisJCQlnZW5wZF9pc19ub19ydW50aW1lX29mZihnZW5wZCkgfHwNCisJCQlhdG9t
aWNfcmVhZCgmZ2VucGQtPnNkX2NvdW50KSA+IDApDQogCQlyZXR1cm4gLUVCVVNZOw0KIA0KIAls
aXN0X2Zvcl9lYWNoX2VudHJ5KHBkZCwgJmdlbnBkLT5kZXZfbGlzdCwgbGlzdF9ub2RlKSB7DQog
CQllbnVtIHBtX3Fvc19mbGFnc19zdGF0dXMgc3RhdDsNCiANCkBAIC0xODEzLDExICsxODE2LDEy
IEBAIGludCBwbV9nZW5wZF9pbml0KHN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQsDQog
CQlnZW5wZC0+ZGV2X29wcy5zdG9wID0gcG1fY2xrX3N1c3BlbmQ7DQogCQlnZW5wZC0+ZGV2X29w
cy5zdGFydCA9IHBtX2Nsa19yZXN1bWU7DQogCX0NCiANCiAJLyogQWx3YXlzLW9uIGRvbWFpbnMg
bXVzdCBiZSBwb3dlcmVkIG9uIGF0IGluaXRpYWxpemF0aW9uLiAqLw0KLQlpZiAoZ2VucGRfaXNf
YWx3YXlzX29uKGdlbnBkKSAmJiAhZ2VucGRfc3RhdHVzX29uKGdlbnBkKSkNCisJaWYgKChnZW5w
ZF9pc19hbHdheXNfb24oZ2VucGQpIHx8IGdlbnBkX2lzX25vX3J1bnRpbWVfb2ZmKGdlbnBkKSkg
JiYNCisJCQkhZ2VucGRfc3RhdHVzX29uKGdlbnBkKSkNCiAJCXJldHVybiAtRUlOVkFMOw0KIA0K
IAlpZiAoZ2VucGRfaXNfY3B1X2RvbWFpbihnZW5wZCkgJiYNCiAJICAgICF6YWxsb2NfY3B1bWFz
a192YXIoJmdlbnBkLT5jcHVzLCBHRlBfS0VSTkVMKSkNCiAJCXJldHVybiAtRU5PTUVNOw0KZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcG1fZG9tYWluLmggYi9pbmNsdWRlL2xpbnV4L3BtX2Rv
bWFpbi5oDQppbmRleCBiYzgyZTc0NTYwZWUuLmM5ZjMxMzdlMmMwMCAxMDA2NDQNCi0tLSBhL2lu
Y2x1ZGUvbGludXgvcG1fZG9tYWluLmgNCisrKyBiL2luY2x1ZGUvbGludXgvcG1fZG9tYWluLmgN
CkBAIC01MSwxNiArNTEsMjAgQEANCiAgKgkJCQlkZXBsb3kgaWRsZSBwb3dlciBtYW5hZ2VtZW50
IHN1cHBvcnQgZm9yIENQVXMNCiAgKgkJCQlhbmQgZ3JvdXBzIG9mIENQVXMuIE5vdGUgdGhhdCwg
dGhlIGJhY2tlbmQNCiAgKgkJCQlkcml2ZXIgbXVzdCB0aGVuIGNvbXBseSB3aXRoIHRoZSBzbyBj
YWxsZWQsDQogICoJCQkJbGFzdC1tYW4tc3RhbmRpbmcgYWxnb3JpdGhtLCBmb3IgdGhlIENQVXMg
aW4gdGhlDQogICoJCQkJUE0gZG9tYWluLg0KKyAqDQorICogR0VOUERfRkxBR19OT19SVU5USU1F
X09GRjoJSW5zdHJ1Y3RzIGdlbnBkIHRvIGFsd2F5cyBrZWVwIHRoZSBQTSBkb21haW4NCisgKgkJ
CQlwb3dlcmVkIG9uIGV4Y2VwdCBmb3Igc3lzdGVtIHN1c3BlbmQuDQogICovDQogI2RlZmluZSBH
RU5QRF9GTEFHX1BNX0NMSwkgKDFVIDw8IDApDQogI2RlZmluZSBHRU5QRF9GTEFHX0lSUV9TQUZF
CSAoMVUgPDwgMSkNCiAjZGVmaW5lIEdFTlBEX0ZMQUdfQUxXQVlTX09OCSAoMVUgPDwgMikNCiAj
ZGVmaW5lIEdFTlBEX0ZMQUdfQUNUSVZFX1dBS0VVUCAoMVUgPDwgMykNCiAjZGVmaW5lIEdFTlBE
X0ZMQUdfQ1BVX0RPTUFJTgkgKDFVIDw8IDQpDQorI2RlZmluZSBHRU5QRF9GTEFHX05PX1JVTlRJ
TUVfT0ZGICgxVSA8PCA1KSAvKiBOZXZlciBwb3dlcmVkIG9mZiBieSBSUE0gKi8NCiANCiBlbnVt
IGdwZF9zdGF0dXMgew0KIAlHUERfU1RBVEVfQUNUSVZFID0gMCwJLyogUE0gZG9tYWluIGlzIGFj
dGl2ZSAqLw0KIAlHUERfU1RBVEVfUE9XRVJfT0ZGLAkvKiBQTSBkb21haW4gaXMgb2ZmICovDQog
fTsNCi0tIA0KMi4xNy4xDQoNCg==
