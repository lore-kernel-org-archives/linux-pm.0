From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2 11/14] thermal: mvebu: Add support for Marvell Dove
 SoC family
Date: Sat, 23 Mar 2013 21:16:26 -0300
Message-ID: <20130324001625.GA3269@localhost>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363991114-4225-12-git-send-email-ezequiel.garcia@free-electrons.com>
 <514D914D.3010105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:42462 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab3CXAQe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 23 Mar 2013 20:16:34 -0400
Content-Disposition: inline
In-Reply-To: <514D914D.3010105@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>

On Sat, Mar 23, 2013 at 12:26:05PM +0100, Sebastian Hesselbarth wrote:
> On 03/22/2013 11:25 PM, Ezequiel Garcia wrote:
> > With the infrastructure added in mvebu-thermal to support multiple =
SoC
> > families, it is now possible to add support for Dove SoC.
> > This patch adds such support taking the implementation from the
> > dove-thermal driver, and then removing it.
> >
> > Signed-off-by: Ezequiel Garcia<ezequiel.garcia@free-electrons.com>
> > ---
> >   .../devicetree/bindings/thermal/dove-thermal.txt   |   18 --
> >   .../devicetree/bindings/thermal/mvebu-thermal.txt  |    8 +
> >   drivers/thermal/Kconfig                            |    8 -
> >   drivers/thermal/Makefile                           |    1 -
> >   drivers/thermal/dove_thermal.c                     |  210 -------=
-------------
> >   drivers/thermal/mvebu_thermal.c                    |   74 +++++++
> >   6 files changed, 82 insertions(+), 237 deletions(-)
> >   delete mode 100644 Documentation/devicetree/bindings/thermal/dove=
-thermal.txt
> >   delete mode 100644 drivers/thermal/dove_thermal.c
> >
>=20
> [...]
>=20
> > diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_=
thermal.c
> > deleted file mode 100644
> > index ddd73a5..0000000
> > --- a/drivers/thermal/dove_thermal.c
> > +++ /dev/null
> > @@ -1,210 +0,0 @@
> > -/*
> > - * Dove thermal sensor driver
> > - *
> > - * Copyright (C) 2013 Andrew Lunn<andrew@lunn.ch>
> > - *
> > - * This software is licensed under the terms of the GNU General Pu=
blic
> > - * License version 2, as published by the Free Software Foundation=
, and
> > - * may be copied, distributed, and modified under those terms.
> > - *
> > - * This program is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > - * GNU General Public License for more details.
> > - *
> > - */
> > -#include<linux/device.h>
> > -#include<linux/err.h>
> > -#include<linux/io.h>
> > -#include<linux/kernel.h>
> > -#include<linux/of.h>
> > -#include<linux/module.h>
> > -#include<linux/platform_device.h>
> > -#include<linux/thermal.h>
> > -
> > -#define DOVE_THERMAL_TEMP_OFFSET	1
> > -#define DOVE_THERMAL_TEMP_MASK		0x1FF
>=20
> [...]
>=20
> > diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mveb=
u_thermal.c
> > index 56c58b1..2f37b3e 100644
> > --- a/drivers/thermal/mvebu_thermal.c
> > +++ b/drivers/thermal/mvebu_thermal.c
> > @@ -2,6 +2,7 @@
> >    * Marvell EBU thermal sensor driver
> >    *
> >    * Copyright (C) 2013 Marvell
> > + * Copyright (C) 2013 Andrew Lunn<andrew@lunn.ch>
> >    * Copyright (C) 2012 Nobuhiro Iwamatsu<iwamatsu@nigauri.org>
> >    *
> >    * This software is licensed under the terms of the GNU General P=
ublic
> > @@ -38,6 +39,14 @@
> >   #define PMU_TDC0_REF_CAL_CNT_MASK	(0x1ff<<  PMU_TDC0_REF_CAL_CNT_=
OFFS)
> >   #define PMU_TDC0_OTF_CAL_MASK		(0x1<<  30)
> >   #define PMU_TDC0_START_CAL_MASK		(0x1<<  25)
> > +#define PMU_TDC0_AVG_NUM_OFFS		25
> > +#define PMU_TDC0_AVG_NUM_MASK		(0x7<<  PMU_TDC0_AVG_NUM_OFFS)
> > +#define PMU_TDC0_SEL_VCAL_OFFS		5
> > +#define PMU_TDC0_SEL_VCAL_MASK		(0x3<<  PMU_TDC0_SEL_VCAL_OFFS)
> > +
> > +/* Dove Thermal Diode Control 1 Register */
> > +#define PMU_TEMP_DIOD_CTRL1_REG		0x04
> > +#define PMU_TDC1_TEMP_VALID_MASK	(0x1<<  10)
>=20
> Ezequiel,
>=20
> maybe Dove thermal isn't that compatible with the others as you thoug=
ht.
>=20
> Have a look at DOVE_THERMAL_TEMP_OFFSET above, it is 1 while MVEBU_TH=
ERMAL_TEMP_OFFSET
> is 10. I've tested your patches on Dove and they break thermal. You e=
ither need
> a dove_get_temp() that uses correct DOVE_THERMAL_TEMP_OFFSET or have =
it stored
> within mvebu_thermal_ops and use it in mvebu_get_temp().
>=20

Ouch, you're totally right. I was too fast on this and I forgot that
Dove has a specific way of reading the sensor, only the formula is
shared with Kirkwood.

I'll send a fix for this in v3, probably monday.

Thanks for testing, and sorry for being so careless.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
