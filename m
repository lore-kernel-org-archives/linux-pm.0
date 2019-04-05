Return-Path: <SRS0=/XJp=SH=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C52C4360F
	for <linux-pm@archiver.kernel.org>; Fri,  5 Apr 2019 14:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB4C205F4
	for <linux-pm@archiver.kernel.org>; Fri,  5 Apr 2019 14:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="qALtqIJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfDEO6k (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:58:40 -0400
Received: from mail-eopbgr810049.outbound.protection.outlook.com ([40.107.81.49]:15862
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729269AbfDEO6k (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Apr 2019 10:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wz9aqMOAlU/cIJsva4u5LEvmUWjO0O6ZtZ6CBDlG4kw=;
 b=qALtqIJKXvF/ISaHYAz/SpeIFiBb4J3Uf1whwE90oFQhK31+g7iavcdUVKKo7EaLFD83+xvPGHl+SgS+eXRa23Yvo8raq7pgEymWRJZuYyHGAYXVTD9S+oWk35MlT2L7fKovh7Mnw58ATQ0Ha3JIj7/rehx1rjx3i//KxoAKlDA=
Received: from BY1PR0301MB0901.namprd03.prod.outlook.com (10.160.195.140) by
 BY1PR0301MB0887.namprd03.prod.outlook.com (10.160.194.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Fri, 5 Apr 2019 14:58:24 +0000
Received: from BY1PR0301MB0901.namprd03.prod.outlook.com
 ([fe80::596a:b0b6:d17d:d075]) by BY1PR0301MB0901.namprd03.prod.outlook.com
 ([fe80::596a:b0b6:d17d:d075%8]) with mapi id 15.20.1771.016; Fri, 5 Apr 2019
 14:58:24 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     "mike.looijmans@topic.nl" <mike.looijmans@topic.nl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Getz, Robin" <Robin.Getz@analog.com>
Subject: RE: [PATCH] power: supply: ltc3651-charger.c: Fix typo in device name
Thread-Topic: [PATCH] power: supply: ltc3651-charger.c: Fix typo in device
 name
Thread-Index: AQHU49s3SImT16q/50GfJk0MoCOEJaYtso+AgAAEJCA=
Date:   Fri, 5 Apr 2019 14:58:24 +0000
Message-ID: <BY1PR0301MB0901370B40482D4EBD6EE84F8E510@BY1PR0301MB0901.namprd03.prod.outlook.com>
References: <1553608635-29376-1-git-send-email-michael.hennerich@analog.com>
 <20190405143747.didydf5neea4iqcq@earth.universe>
In-Reply-To: <20190405143747.didydf5neea4iqcq@earth.universe>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.Hennerich@analog.com; 
x-originating-ip: [2001:16b8:2d39:6300:f529:574c:8a6:9dbd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86243a54-7347-4f3a-d101-08d6b9d7272c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BY1PR0301MB0887;
x-ms-traffictypediagnostic: BY1PR0301MB0887:
x-microsoft-antispam-prvs: <BY1PR0301MB0887BAD13A72643B330CC3788E510@BY1PR0301MB0887.namprd03.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(376002)(346002)(39860400002)(13464003)(189003)(199004)(51914003)(305945005)(229853002)(76176011)(105586002)(106356001)(5660300002)(7736002)(68736007)(81156014)(86362001)(6436002)(74316002)(97736004)(7696005)(6246003)(54906003)(6916009)(53546011)(2906002)(102836004)(107886003)(446003)(8936002)(6116002)(14454004)(8676002)(256004)(14444005)(316002)(81166006)(11346002)(9686003)(55016002)(72206003)(53936002)(71190400001)(52536014)(6506007)(33656002)(99286004)(186003)(4326008)(46003)(486006)(71200400001)(476003)(25786009)(478600001)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0301MB0887;H:BY1PR0301MB0901.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mWWsCs+PZ8WGleqk/K1lzww9WcriWcPVv8V3v61akXatwIIrnUzP+2oal3odJVSN1hpX2UUC+WCZhc/TCFuLVUMlSY5zsuH3ZL9txkV8LVcx85OZEk4lD/5nnnMkfNuYJX1R1/MrqkGb6imm2t8+JyF/LIOnEqwrTJPuZLp2lMasqKHibgsKPA/qal2tm9ktIjyVPqDo/q6N/TCXYCEFGbEHdrnfEpvw1ijKchVL9KRUYyyHvh5AvIBp+8VMffn2PiXPvB1gdZtYWRulwNS39585/na/S2/4JN6zccYtxWWwcCfiYz4kn8WdTwVLKoin8HYRBAKoWMoP1ENvxA+y9CIePzZ/HcECC8uqXbK12wOROxneIqNZB3SEhsvGJeVaU4RNGFt/cUAP3lE9slEVQtARC6CV43+finyadfjr4Xw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86243a54-7347-4f3a-d101-08d6b9d7272c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 14:58:24.4588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0301MB0887
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> -----Original Message-----
> From: Sebastian Reichel [mailto:sre@kernel.org]
> Sent: Freitag, 5. April 2019 16:38
> To: Hennerich, Michael <Michael.Hennerich@analog.com>
> Cc: mike.looijmans@topic.nl; robh+dt@kernel.org; linux-pm@vger.kernel.org=
; devicetree@vger.kernel.org; Getz, Robin
> <Robin.Getz@analog.com>
> Subject: Re: [PATCH] power: supply: ltc3651-charger.c: Fix typo in device=
 name
>=20
> Hi,
>=20
> On Tue, Mar 26, 2019 at 02:57:15PM +0100, michael.hennerich@analog.com wr=
ote:
> > From: Michael Hennerich <michael.hennerich@analog.com>
> >
> > There never was a device called LTC3651, it always was just LT3651.
> > This circumstance makes it pretty difficult to identify what this
> > driver is meant to control. This patch is a minimal invasive attempt
> > to fix this issue without affecting existing systems.
> >
> >
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > ---
>=20
> Please change subject to "power: supply: ltc3651-charger: Fix device name=
"

Sure

>=20
> Also we probably should change the filenames and Kconfig name.

If we go that far we can also fix the function prefixes as well.
I'm a bit hesitant about the Kconfig name. It'll break existing kernel conf=
igs for no good reason!?
Please let me know what you prefer.

Thanks for the review.

-- Michael

>=20
> -- Sebastian
>=20
> >  .../devicetree/bindings/power/supply/ltc3651-charger.txt         | 8 +=
++++---
> >  drivers/power/supply/Kconfig                                     | 6 +=
++---
> >  drivers/power/supply/ltc3651-charger.c                           | 9 +=
++------
> >  3 files changed, 11 insertions(+), 12 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/ltc3651-cha=
rger.txt
> b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
> > index 71f2840..f012449 100644
> > --- a/Documentation/devicetree/bindings/power/supply/ltc3651-charger.tx=
t
> > +++ b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.tx=
t
> > @@ -1,7 +1,9 @@
> > -ltc3651-charger
> > +Analog Devices LT3651 Charger Power Supply bindings: ltc3651-charger
> >
> >  Required properties:
> > - - compatible: "lltc,ltc3651-charger"
> > +- compatible: Should contain one of the following:
> > + * "lltc,ltc3651-charger",
> > + * "lltc,lt3651-charger"
> >   - lltc,acpr-gpios: Connect to ACPR output. See remark below.
> >
> >  Optional properties:
> > @@ -20,7 +22,7 @@ attributes to detect changes.
> >  Example:
> >
> >  	charger: battery-charger {
> > -		compatible =3D "lltc,ltc3651-charger";
> > +		compatible =3D "lltc,lt3651-charger";
> >  		lltc,acpr-gpios =3D <&gpio0 68 GPIO_ACTIVE_LOW>;
> >  		lltc,fault-gpios =3D <&gpio0 64 GPIO_ACTIVE_LOW>;
> >  		lltc,chrg-gpios =3D <&gpio0 63 GPIO_ACTIVE_LOW>;
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfi=
g
> > index e901b9879..6816a86 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -476,11 +476,11 @@ config CHARGER_MANAGER
> >            with help of suspend_again support.
> >
> >  config CHARGER_LTC3651
> > -	tristate "LTC3651 charger"
> > +	tristate "Analog Devices LT3651 charger"
> >  	depends on GPIOLIB
> >  	help
> > -	  Say Y to include support for the LTC3651 battery charger which repo=
rts
> > -	  its status via GPIO lines.
> > +	  Say Y to include support for the Analog Devices (Linear Technology)
> > +	  LT3651 battery charger which reports its status via GPIO lines.
> >
> >  config CHARGER_MAX14577
> >  	tristate "Maxim MAX14577/77836 battery charger driver"
> > diff --git a/drivers/power/supply/ltc3651-charger.c b/drivers/power/sup=
ply/ltc3651-charger.c
> > index eea63ff..07ed537 100644
> > --- a/drivers/power/supply/ltc3651-charger.c
> > +++ b/drivers/power/supply/ltc3651-charger.c
> > @@ -1,11 +1,7 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> >  /*
> > + *  Driver for Analog Devices (Linear Technology) LT3651 charger IC.
> >   *  Copyright (C) 2017, Topic Embedded Products
> > - *  Driver for LTC3651 charger IC.
> > - *
> > - *  This program is free software; you can redistribute it and/or modi=
fy it
> > - *  under  the terms of the GNU General  Public License as published b=
y the
> > - *  Free Software Foundation;  either version 2 of the License, or (at=
 your
> > - *  option) any later version.
> >   */
> >
> >  #include <linux/device.h>
> > @@ -190,6 +186,7 @@ static int ltc3651_charger_probe(struct platform_de=
vice *pdev)
> >
> >  static const struct of_device_id ltc3651_charger_match[] =3D {
> >  	{ .compatible =3D "lltc,ltc3651-charger" },
> > +	{ .compatible =3D "lltc,lt3651-charger" },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(of, ltc3651_charger_match);
> > --
> > 2.7.4
> >
