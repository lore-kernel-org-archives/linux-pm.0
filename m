Return-Path: <SRS0=5pBW=S3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44955C10F03
	for <linux-pm@archiver.kernel.org>; Thu, 25 Apr 2019 11:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BD520811
	for <linux-pm@archiver.kernel.org>; Thu, 25 Apr 2019 11:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GwfE2Vzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbfDYLip (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:38:45 -0400
Received: from mail-eopbgr60084.outbound.protection.outlook.com ([40.107.6.84]:19844
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726223AbfDYLip (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Apr 2019 07:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCzaOWZUuEfGHzVD0baNs0c+Nb231KggJsqsdEhMaZU=;
 b=GwfE2Vzx+49+NX9/a1EDvikCQvGGWvX+WdGoyflM8YcJfosdA8UMAvcDST5to+5qoVN4bjVFhqfbksBG1sLp8Azf6JLpiM16PzYLRyajxgN8XIZ8w3rnE68KRSqHN11xqxxERjHwqV6ju5PxuwzLABDRgky5e/YX8wqGpbmJLaw=
Received: from AM6PR0402MB3350.eurprd04.prod.outlook.com (52.133.21.17) by
 AM6PR0402MB3528.eurprd04.prod.outlook.com (52.133.19.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.19; Thu, 25 Apr 2019 11:38:40 +0000
Received: from AM6PR0402MB3350.eurprd04.prod.outlook.com
 ([fe80::f504:a635:91b3:1e7a]) by AM6PR0402MB3350.eurprd04.prod.outlook.com
 ([fe80::f504:a635:91b3:1e7a%3]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 11:38:40 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        Abel Vesa <abel.vesa@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [RFC] cpufreq: Add imx-cpufreq-dt driver
Thread-Topic: [RFC] cpufreq: Add imx-cpufreq-dt driver
Thread-Index: AQHU+1G5n8xA1o8EXEODrFl/NmnNOaZMwDaA
Date:   Thu, 25 Apr 2019 11:38:40 +0000
Message-ID: <0e33e8f8e7f5aae410750a815dffc0cd8d2b1d2e.camel@nxp.com>
References: <83a3ade389239bd492ee646aa4868c5e37e65434.1556187603.git.leonard.crestez@nxp.com>
In-Reply-To: <83a3ade389239bd492ee646aa4868c5e37e65434.1556187603.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee743f11-389d-42a1-ac4f-08d6c9729071
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR0402MB3528;
x-ms-traffictypediagnostic: AM6PR0402MB3528:
x-microsoft-antispam-prvs: <AM6PR0402MB3528F3BA99A6EEB920DF0B07F93D0@AM6PR0402MB3528.eurprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(39860400002)(346002)(366004)(199004)(189003)(76176011)(5660300002)(6486002)(14454004)(71190400001)(6436002)(71200400001)(316002)(73956011)(118296001)(99286004)(229853002)(7736002)(305945005)(66066001)(66946007)(66476007)(54906003)(6636002)(66446008)(76116006)(64756008)(66556008)(91956017)(110136005)(2501003)(478600001)(97736004)(8936002)(486006)(68736007)(2616005)(11346002)(53936002)(476003)(6246003)(3846002)(102836004)(81166006)(558084003)(6116002)(2906002)(6506007)(26005)(81156014)(8676002)(4326008)(256004)(25786009)(36756003)(44832011)(6512007)(186003)(446003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3528;H:AM6PR0402MB3350.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9RmibougQzaxOoHzuZWg5XhOthxL3SrUpJeZ/fLwZoo5s6gj8pHLUV8MlxAGG6EBLKUBQlp/DUsal+Igqb6XC+gVqI+4o1rDrjbKbxFCzECv1iqtekiZ+BU5pVrpv1Yy12Rvn7tx861ubPdN5ETPHmlHdcvUBA7cCdzjltKRt0ZaKHpP0Uby+NZtJcegrZdlOGwT5ak48NnsGODKlG+cLAyepHt4hZrPAyQtvQ2MfzuhFHy1bZFy5EmZkIC1MVAaR08PcVHf74LLWOqsmUZbjs3RNgleEIjdstHiQpMkmn4Z0g+0+F0/9Vs4T3hgRg3PkWpTC4fQ1hq+MgHXTFsfu0b0DDjYBk+bnMtDIfJUpUZrv5v1YWAamiWH+UKyMqtbis5/pYiVyb9/pITlt+P9+E5HofTeH6SBTbGU90gHJV0=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <57215398384D874883E3369C039A37DC@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee743f11-389d-42a1-ac4f-08d6c9729071
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 11:38:40.4566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3528
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190425113840.Gj2sIep330gwMXp3NnUfaWa80VFqpmadQCaALECCqxg@z>

TWlub3IgY29tbWVudCwNCg0KPHNuaXA+DQo+ICsJdTMyICgqY2hlY2tfc3BlZWRfZ3JhZGluZyko
c3RydWN0IGRldmljZSAqKTsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsgICAgICAgCW5wID0gb2Zf
ZmluZF9ub2RlX2J5X3BhdGgoIi8iKTsNCg0KSW5kZW50YXRpb24gbG9va3Mgc3RyYW5nZSBoZXJl
IF4NCg0KPiArCWlkID0gb2ZfbWF0Y2hfbm9kZShpbXhfY3B1ZnJlcV9kdF9tYXRjaF9saXN0LCBu
cCk7DQo+ICsJb2Zfbm9kZV9wdXQobnApOw0KPiArCWlmICghaWQpDQo+ICsJCXJldHVybiAtRU5P
REVWOw0KPiANCg0KDQo=
