Return-Path: <SRS0=x0P7=S4=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80382C43219
	for <linux-pm@archiver.kernel.org>; Fri, 26 Apr 2019 21:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F4C206DD
	for <linux-pm@archiver.kernel.org>; Fri, 26 Apr 2019 21:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EqMp+I+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfDZViY (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:38:24 -0400
Received: from mail-eopbgr10061.outbound.protection.outlook.com ([40.107.1.61]:34670
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726830AbfDZViY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Apr 2019 17:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAWyXl0veyS18rARt83A2yN1QRo4F+SPYtb6JDHN6q0=;
 b=EqMp+I+azoNwOetjPiG8AZBDHRMai/Iu/rXAofAmeaHDNtOYcwv/eRN56HA3KQn+fo4MNJkamIeZfx9gvap3fCg1eEjgqk7Blso1kdaCE/DaDSpX5M9k2PgDaoG1VZJ4hEkaXNQTsLm4zhN4VH188KUaVuVJxeQI3ITcMmjzjVk=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB4451.eurprd04.prod.outlook.com (52.135.149.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 21:38:16 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::f56b:2fea:d9c0:7c2b]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::f56b:2fea:d9c0:7c2b%6]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 21:38:16 +0000
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
Subject: [PATCH v4 2/2] soc: imx: gpc: Use GENPD_FLAG_NO_RUNTIME_OFF for
 ERR009619
Thread-Topic: [PATCH v4 2/2] soc: imx: gpc: Use GENPD_FLAG_NO_RUNTIME_OFF for
 ERR009619
Thread-Index: AQHU/Hhb/Zjo/l8+IUm+AW7uK7YJmA==
Date:   Fri, 26 Apr 2019 21:38:16 +0000
Message-ID:
 <f0bf98cc6ef4cc42101092965b1e4f34375915d3.1556313614.git.leonard.crestez@nxp.com>
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
x-ms-office365-filtering-correlation-id: 2335fb81-fe97-46ef-f3c4-08d6ca8f7da5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4451;
x-ms-traffictypediagnostic: AM0PR04MB4451:
x-microsoft-antispam-prvs: <AM0PR04MB445142F739F41F4717BE8701EE3E0@AM0PR04MB4451.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(396003)(346002)(189003)(199004)(8676002)(73956011)(76176011)(52116002)(81166006)(2906002)(66946007)(486006)(66446008)(66556008)(81156014)(44832011)(64756008)(66476007)(478600001)(36756003)(4326008)(446003)(2616005)(50226002)(118296001)(86362001)(476003)(11346002)(5660300002)(53936002)(66066001)(102836004)(6436002)(6486002)(186003)(256004)(14444005)(26005)(97736004)(68736007)(305945005)(316002)(386003)(6506007)(7736002)(99286004)(8936002)(25786009)(54906003)(3846002)(6116002)(14454004)(6512007)(71190400001)(71200400001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4451;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j96TLI6xKaoXHkm5QSptX8qvFuRX6Ql3pSUZs4LslL3Xrdd9cTP3sTtvhQrhXYmITpfehBZ5jX9efkiXcOwDjPt8I+xTNZNyoWdyRPQ/8w6mQbsyRGkUFtq44uydrDb/5D8U1ifUzc22fHtESaBnbHfGpjrWEIbkUqyuy1gZ79UxgOdrf3DgyvKZIY5HqQemzk861hxuvNwP3+4hWoqFOko6ESAVC006kmwWnpfoHcNQJihg8BJp7TTty+gCbOO4dQITuaFx+F40grRNHwMPVVZ0keYtmyySNHmEtOUJMfMD3e//XLIonIvY3pIl73ZX0IyhmStCC3Qt0RdW8j8u0gRGAvLQ9kQ//7XoIYpCmtdlHX9LJRs/uLgZtTDwmxrTNn9lWYi6YiHhLgVVdepZEzh3TOaW9NeOzVbk1P30cH0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2335fb81-fe97-46ef-f3c4-08d6ca8f7da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 21:38:16.3190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4451
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190426213816.mbzYy-NK9TVD_zV_iJB9pAS73Aolx3bbioq-OiHPnx4@z>

VGhpcyBhbGxvd3MgUFUgdG8gYmUgdHVybmVkIG9mZiBpbiBzdXNwZW5kIGFuZCBzYXZlIHBvd2Vy
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAu
Y29tPg0KLS0tDQogZHJpdmVycy9zb2MvaW14L2dwYy5jIHwgMTMgKysrKysrKysrKystLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9zb2MvaW14L2dwYy5jIGIvZHJpdmVycy9zb2MvaW14L2dwYy5jDQppbmRl
eCBhOGYxZTQ3Y2U2OTguLjRkZDQ5M2VjY2M5OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc29jL2lt
eC9ncGMuYw0KKysrIGIvZHJpdmVycy9zb2MvaW14L2dwYy5jDQpAQCAtNDI3LDE0ICs0MjcsMjMg
QEAgc3RhdGljIGludCBpbXhfZ3BjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQogCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gaW5pdCByZWdtYXA6ICVkXG4iLA0K
IAkJCXJldCk7DQogCQlyZXR1cm4gcmV0Ow0KIAl9DQogDQotCS8qIERpc2FibGUgUFUgcG93ZXIg
ZG93biBpbiBub3JtYWwgb3BlcmF0aW9uIGlmIEVSUjAwOTYxOSBpcyBwcmVzZW50ICovDQorCS8q
DQorCSAqIERpc2FibGUgUFUgcG93ZXIgZG93biBieSBydW50aW1lIFBNIGlmIEVSUjAwOTYxOSBp
cyBwcmVzZW50Lg0KKwkgKg0KKwkgKiBUaGUgUFJFIGNsb2NrIHdpbGwgYmUgcGF1c2VkIGZvciBz
ZXZlcmFsIGN5Y2xlcyB3aGVuIHR1cm5pbmcgb24gdGhlDQorCSAqIFBVIGRvbWFpbiBMRE8gZnJv
bSBwb3dlciBkb3duIHN0YXRlLiBJZiBQUkUgaXMgaW4gdXNlIGF0IHRoYXQgdGltZSwNCisJICog
dGhlIElQVS9QUkcgY2Fubm90IGdldCB0aGUgY29ycmVjdCBkaXNwbGF5IGRhdGEgZnJvbSB0aGUg
UFJFLg0KKwkgKg0KKwkgKiBUaGlzIGlzIG5vdCBhIGNvbmNlcm4gd2hlbiB0aGUgd2hvbGUgc3lz
dGVtIGVudGVycyBzdXNwZW5kIHN0YXRlLCBzbw0KKwkgKiBpdCdzIHNhZmUgdG8gcG93ZXIgZG93
biBQVSBpbiB0aGlzIGNhc2UuDQorCSAqLw0KIAlpZiAob2ZfaWRfZGF0YS0+ZXJyMDA5NjE5X3By
ZXNlbnQpDQogCQlpbXhfZ3BjX2RvbWFpbnNbR1BDX1BHQ19ET01BSU5fUFVdLmJhc2UuZmxhZ3Mg
fD0NCi0JCQkJR0VOUERfRkxBR19BTFdBWVNfT047DQorCQkJCUdFTlBEX0ZMQUdfTk9fUlVOVElN
RV9PRkY7DQogDQogCS8qIEtlZXAgRElTUCBhbHdheXMgb24gaWYgRVJSMDA2Mjg3IGlzIHByZXNl
bnQgKi8NCiAJaWYgKG9mX2lkX2RhdGEtPmVycjAwNjI4N19wcmVzZW50KQ0KIAkJaW14X2dwY19k
b21haW5zW0dQQ19QR0NfRE9NQUlOX0RJU1BMQVldLmJhc2UuZmxhZ3MgfD0NCiAJCQkJR0VOUERf
RkxBR19BTFdBWVNfT047DQotLSANCjIuMTcuMQ0KDQo=
