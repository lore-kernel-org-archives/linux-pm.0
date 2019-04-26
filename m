Return-Path: <SRS0=x0P7=S4=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF44BC43219
	for <linux-pm@archiver.kernel.org>; Fri, 26 Apr 2019 21:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A7A20869
	for <linux-pm@archiver.kernel.org>; Fri, 26 Apr 2019 21:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SpTHT7yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDZViT (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:38:19 -0400
Received: from mail-eopbgr10061.outbound.protection.outlook.com ([40.107.1.61]:34670
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726246AbfDZViS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Apr 2019 17:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnZSlAJQF70+Z3BIqbMRMwWqK0AoRgtCnJK8ba44IMA=;
 b=SpTHT7ycutLYHqRUpce9l7rHg5FUFz1waOl1FoSvGNyqrNTj1nFZO34uX3z5TZU0LnUA/80vy3Ua3XJRY19U+iIDgImPMIRSHHitPGr2x9D4lCwuS/65AKvErKpeH4a0L6DTmvkqLFjhK2mOo5oM4OU+mKBInoZsos6zAA0+074=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB4451.eurprd04.prod.outlook.com (52.135.149.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 21:38:13 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::f56b:2fea:d9c0:7c2b]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::f56b:2fea:d9c0:7c2b%6]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 21:38:13 +0000
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
Subject: [PATCH v4 0/2] Allow imx6qp PU domain off in suspend
Thread-Topic: [PATCH v4 0/2] Allow imx6qp PU domain off in suspend
Thread-Index: AQHU/HhaZ2nxYQKJjkCUkrpqVUx0Fw==
Date:   Fri, 26 Apr 2019 21:38:13 +0000
Message-ID: <cover.1556313614.git.leonard.crestez@nxp.com>
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
x-ms-office365-filtering-correlation-id: 7f4f4c7f-0903-4ffb-d283-08d6ca8f7c5b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4451;
x-ms-traffictypediagnostic: AM0PR04MB4451:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM0PR04MB445136E680FBDCBC13579371EE3E0@AM0PR04MB4451.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(396003)(346002)(189003)(199004)(8676002)(73956011)(52116002)(81166006)(4744005)(2906002)(66946007)(486006)(66446008)(66556008)(81156014)(44832011)(64756008)(66476007)(478600001)(36756003)(4326008)(966005)(2616005)(50226002)(86362001)(476003)(5660300002)(53936002)(66066001)(102836004)(6436002)(6486002)(6306002)(186003)(256004)(14444005)(26005)(97736004)(68736007)(305945005)(316002)(15650500001)(386003)(6506007)(7736002)(99286004)(8936002)(25786009)(54906003)(3846002)(6116002)(14454004)(6512007)(71190400001)(71200400001)(110136005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4451;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S6N+jlSpdL9St95DNpzDkx1VtR7qL0g3nh4iTGUGxAzxCNdNqTw1Ss+mMp+kMZ1073+F2nwky94upKB/Wgxhrk5zAOP/JJKrc9K2LHEZGApnzc/sxje+p9iwkjhU39rK5+adIbB+FEs3Em5aC3NLJH0bera8fCUl0gOx8g/pmjehv54CyAjniiR9EoTQnnlrW78UO4vRQ0oqMQUASlECVa/drAzdAtYKib2nijRf9u6piKg/FRGe+99Te7ZQsldJGzuYyNAFEL+l00Dcs9pytoSRpRaoCe6Bni2s3lljEYpAsXbOUWia4j+bYVieJaBK+FTfneXyrCITF4Lf9Uqs8auf3yzxaV9hCxI4b2xBsPfTZXjUkDHBut5hq7GlQVORqFZYcsPjhUmvl8Cw0oXyQ2XkxNB/cv6qCXXJWU1PUSc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4f4c7f-0903-4ffb-d283-08d6ca8f7c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 21:38:13.7962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4451
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190426213813.AfDTtCIIlSkt0jqOqBRlkjfM-SdENZa9sQWpF6qupZ8@z>

T24gaW14NnFwIHBvd2VyIGdhdGluZyBvbiB0aGUgUFUgZG9tYWluIGlzIGRpc2FibGVkIGJlY2F1
c2Ugb2YgZXJyYXRhDQpFUlIwMDk2MTkuIEhvd2V2ZXIgcG93ZXIgZ2F0aW5nIGR1cmluZyBzdXNw
ZW5kL3Jlc3VtZSBjYW4gc3RpbGwgYmUNCnBlcmZvcm1lZC4NCg0KSW1wbGVtZW50ZWQgd2l0aCBh
IG5ldyBjb3JlIGZsYWcgYmVjYXVzZSBvdGhlcndpc2UgZGlzdGluZ3Vpc2hpbmcNCmJldHdlZW4g
InJ1bnRpbWUgb2ZmIiBhbmQgInN1c3BlbmQgb2ZmIiBpcyB2ZXJ5IGNvbXBsaWNhdGVkLg0KDQpM
aW5rIHRvIHYzIGZvciBwcmV2aW91cyBhdHRlbXB0OiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAx
OC83LzYvNjk4DQoNClRoZSBpbXggdmVuZG9yIHRyZWUgaGFzIGJlZW4gZG9pbmcgdGhpcyBmb3Ig
YSBtYW55IHllYXJzIGJ1dCBpdCB1c2VzDQpkaXJlY3QgY2FsbHMgZnJvbSBwbGF0Zm9ybSBzdXNw
ZW5kIHRvIEdQQyBkcml2ZXIuDQoNCkxpbmsgdG8gdjEgZm9yIHNpbWlsYXIgYXR0ZW1wdDogaHR0
cHM6Ly9sa21sLm9yZy9sa21sLzIwMTgvNy8yLzM1Nw0KDQpMZW9uYXJkIENyZXN0ZXogKDIpOg0K
ICBQTSAvIERvbWFpbnM6IEFkZCBHRU5QRF9GTEFHX05PX1JVTlRJTUVfT0ZGIGZsYWcNCiAgc29j
OiBpbXg6IGdwYzogVXNlIEdFTlBEX0ZMQUdfTk9fUlVOVElNRV9PRkYgZm9yIEVSUjAwOTYxOQ0K
DQogZHJpdmVycy9iYXNlL3Bvd2VyL2RvbWFpbi5jIHwgIDggKysrKysrLS0NCiBkcml2ZXJzL3Nv
Yy9pbXgvZ3BjLmMgICAgICAgfCAxMyArKysrKysrKysrKy0tDQogaW5jbHVkZS9saW51eC9wbV9k
b21haW4uaCAgIHwgIDQgKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjE3LjENCg0K
