Return-Path: <SRS0=/XJp=SH=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB51C4360F
	for <linux-pm@archiver.kernel.org>; Fri,  5 Apr 2019 15:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C83218AC
	for <linux-pm@archiver.kernel.org>; Fri,  5 Apr 2019 15:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554477115;
	bh=YvGBtCO0klVKGMHmQSoe7cSukMQeNGTnmuOXD21Tqrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aaPiqyq0effGkkydTW1L8If8IrJM9kw8ZnVJ1x761MP7bca0b6N1BWLZWaxY0f/Ts
	 1VgNBlN4vwMNn4nwjPB0nHEAdZThooDdcqlYgknF0JvaQxBKT71J+MVy0kH0onZT/i
	 GYH43BVDJtHoUXQDnqlqMl6l40S1ZTpHUbxKqmP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbfDEPLy (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731677AbfDEPLt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Apr 2019 11:11:49 -0400
Received: from earth.universe (host-091-097-083-087.ewe-ip-backbone.de [91.97.83.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 095EA21872;
        Fri,  5 Apr 2019 15:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554477108;
        bh=YvGBtCO0klVKGMHmQSoe7cSukMQeNGTnmuOXD21Tqrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pyBKh/X4IMgldMs+btO58o0JAv0PzleWrBNFR9UkKrU90lh8B6mGWvkHs1sQ+wbYb
         Q5nbGhTfbIy3FLHKG3UKoTbnmWkfo8Qo9YPxKC4GPtLxr+N9DEVncOyMAcCp5niWvr
         iKUNFuIJ/D5dN+F+fY7JlzDBVKpngGWqhk22RS9o=
Received: by earth.universe (Postfix, from userid 1000)
        id 0E22D3C08D5; Fri,  5 Apr 2019 17:11:46 +0200 (CEST)
Date:   Fri, 5 Apr 2019 17:11:45 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc:     "mike.looijmans@topic.nl" <mike.looijmans@topic.nl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Getz, Robin" <Robin.Getz@analog.com>
Subject: Re: [PATCH] power: supply: ltc3651-charger.c: Fix typo in device name
Message-ID: <20190405151145.3iplzv423u7pkq6j@earth.universe>
References: <1553608635-29376-1-git-send-email-michael.hennerich@analog.com>
 <20190405143747.didydf5neea4iqcq@earth.universe>
 <BY1PR0301MB0901370B40482D4EBD6EE84F8E510@BY1PR0301MB0901.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dblzwh77ugxulmds"
Content-Disposition: inline
In-Reply-To: <BY1PR0301MB0901370B40482D4EBD6EE84F8E510@BY1PR0301MB0901.namprd03.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--dblzwh77ugxulmds
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 05, 2019 at 02:58:24PM +0000, Hennerich, Michael wrote:
> > -----Original Message-----
> > From: Sebastian Reichel [mailto:sre@kernel.org]
> > Sent: Freitag, 5. April 2019 16:38
> > To: Hennerich, Michael <Michael.Hennerich@analog.com>
> > Cc: mike.looijmans@topic.nl; robh+dt@kernel.org; linux-pm@vger.kernel.o=
rg; devicetree@vger.kernel.org; Getz, Robin
> > <Robin.Getz@analog.com>
> > Subject: Re: [PATCH] power: supply: ltc3651-charger.c: Fix typo in devi=
ce name
> >=20
> > Hi,
> >=20
> > On Tue, Mar 26, 2019 at 02:57:15PM +0100, michael.hennerich@analog.com =
wrote:
> > > From: Michael Hennerich <michael.hennerich@analog.com>
> > >
> > > There never was a device called LTC3651, it always was just LT3651.
> > > This circumstance makes it pretty difficult to identify what this
> > > driver is meant to control. This patch is a minimal invasive attempt
> > > to fix this issue without affecting existing systems.
> > >
> > >
> > > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > > ---
> >=20
> > Please change subject to "power: supply: ltc3651-charger: Fix device na=
me"
>=20
> Sure
>=20
> > Also we probably should change the filenames and Kconfig name.
>=20
> If we go that far we can also fix the function prefixes as well.

sounds good to me.

> I'm a bit hesitant about the Kconfig name. It'll break existing kernel co=
nfigs
> for no good reason!? Please let me know what you prefer.

I suppose we can keep to the old Kconfig option, if this is being
used already. Hopefully not many people search for their driver
using raw Kconfig names :)

-- Sebastian

>=20
> Thanks for the review.
>=20
> -- Michael
>=20
> >=20
> > -- Sebastian
> >=20
> > >  .../devicetree/bindings/power/supply/ltc3651-charger.txt         | 8=
 +++++---
> > >  drivers/power/supply/Kconfig                                     | 6=
 +++---
> > >  drivers/power/supply/ltc3651-charger.c                           | 9=
 +++------
> > >  3 files changed, 11 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/power/supply/ltc3651-c=
harger.txt
> > b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
> > > index 71f2840..f012449 100644
> > > --- a/Documentation/devicetree/bindings/power/supply/ltc3651-charger.=
txt
> > > +++ b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.=
txt
> > > @@ -1,7 +1,9 @@
> > > -ltc3651-charger
> > > +Analog Devices LT3651 Charger Power Supply bindings: ltc3651-charger
> > >
> > >  Required properties:
> > > - - compatible: "lltc,ltc3651-charger"
> > > +- compatible: Should contain one of the following:
> > > + * "lltc,ltc3651-charger",
> > > + * "lltc,lt3651-charger"
> > >   - lltc,acpr-gpios: Connect to ACPR output. See remark below.
> > >
> > >  Optional properties:
> > > @@ -20,7 +22,7 @@ attributes to detect changes.
> > >  Example:
> > >
> > >  	charger: battery-charger {
> > > -		compatible =3D "lltc,ltc3651-charger";
> > > +		compatible =3D "lltc,lt3651-charger";
> > >  		lltc,acpr-gpios =3D <&gpio0 68 GPIO_ACTIVE_LOW>;
> > >  		lltc,fault-gpios =3D <&gpio0 64 GPIO_ACTIVE_LOW>;
> > >  		lltc,chrg-gpios =3D <&gpio0 63 GPIO_ACTIVE_LOW>;
> > > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kcon=
fig
> > > index e901b9879..6816a86 100644
> > > --- a/drivers/power/supply/Kconfig
> > > +++ b/drivers/power/supply/Kconfig
> > > @@ -476,11 +476,11 @@ config CHARGER_MANAGER
> > >            with help of suspend_again support.
> > >
> > >  config CHARGER_LTC3651
> > > -	tristate "LTC3651 charger"
> > > +	tristate "Analog Devices LT3651 charger"
> > >  	depends on GPIOLIB
> > >  	help
> > > -	  Say Y to include support for the LTC3651 battery charger which re=
ports
> > > -	  its status via GPIO lines.
> > > +	  Say Y to include support for the Analog Devices (Linear Technolog=
y)
> > > +	  LT3651 battery charger which reports its status via GPIO lines.
> > >
> > >  config CHARGER_MAX14577
> > >  	tristate "Maxim MAX14577/77836 battery charger driver"
> > > diff --git a/drivers/power/supply/ltc3651-charger.c b/drivers/power/s=
upply/ltc3651-charger.c
> > > index eea63ff..07ed537 100644
> > > --- a/drivers/power/supply/ltc3651-charger.c
> > > +++ b/drivers/power/supply/ltc3651-charger.c
> > > @@ -1,11 +1,7 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > >  /*
> > > + *  Driver for Analog Devices (Linear Technology) LT3651 charger IC.
> > >   *  Copyright (C) 2017, Topic Embedded Products
> > > - *  Driver for LTC3651 charger IC.
> > > - *
> > > - *  This program is free software; you can redistribute it and/or mo=
dify it
> > > - *  under  the terms of the GNU General  Public License as published=
 by the
> > > - *  Free Software Foundation;  either version 2 of the License, or (=
at your
> > > - *  option) any later version.
> > >   */
> > >
> > >  #include <linux/device.h>
> > > @@ -190,6 +186,7 @@ static int ltc3651_charger_probe(struct platform_=
device *pdev)
> > >
> > >  static const struct of_device_id ltc3651_charger_match[] =3D {
> > >  	{ .compatible =3D "lltc,ltc3651-charger" },
> > > +	{ .compatible =3D "lltc,lt3651-charger" },
> > >  	{ }
> > >  };
> > >  MODULE_DEVICE_TABLE(of, ltc3651_charger_match);
> > > --
> > > 2.7.4
> > >

--dblzwh77ugxulmds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlyncC4ACgkQ2O7X88g7
+pqxtA//QNvt4WmP277jMga3CFuaWWiJtSrNmmaPoAV0WGbsjnhejX7JHGhCM0W3
fhsE1JQr9H7JEcaX3gF6fiTyvtzyiq9kGkH7KgBaaQMtuz9iU2U9IvR43gXLM7bo
GrrBAHWwDOjeQAxGr925zD320hC3iHnBF27QGu4+KM38KihL8YF41Q/uPBM7I6YI
J91auagt95OLzolBggBQZia8YNmR0Wz79kC9KrjixKCP+x9xit8zT/XjM3TVyR4H
FBbM3QAAH/4cfawu8donAACL7RVApbE6IErqsZSNHrXX4NFj61+iN2fMNz5xna91
9py+NqENRzD3dOARbCpPoKdRifuOzkxl+xrdCjwwbTTEYC9u9UA2owG+L3NMV8pj
QAZREHQQg7btpaN+yDbXvSFgNnRVpWI8jw29VVRhcI/z6OPIMnLHmyeJLiuWe7Lx
8tYXbaHlPFVNKJ76TezEtHE5Us8tRBxis0lNykTuKX9IgiusaNKD+Mu7KqFiRTwF
JzVkJDSlkAJiB9yjCyyeStQTqrAZRzSA33EU5wd+QEWBvMFNXvRpNNssNGFA8Pul
0PhHzAe/lDoosvhr9WflTU4wGMaqIB1ooOy2ewT05y+On8X2Rhf7NNMkREzHf1k5
cJoku4Brag47l6CNrx08fytnzefDNcMCzCXm4tUmJcOKgSiQ6LA=
=342K
-----END PGP SIGNATURE-----

--dblzwh77ugxulmds--
