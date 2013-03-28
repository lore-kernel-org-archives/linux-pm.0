From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2 1/4] thermal: Add driver for Armada 370/XP SoC thermal
 management
Date: Thu, 28 Mar 2013 00:43:34 -0300
Message-ID: <20130328034333.GB12212@localhost>
References: <1364292988-8358-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1364292988-8358-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <1364435017.2275.20.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:35422 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754906Ab3C1Dnn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Mar 2013 23:43:43 -0400
Content-Disposition: inline
In-Reply-To: <1364435017.2275.20.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Lior Amsalem <alior@marvell.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>

On Thu, Mar 28, 2013 at 09:43:37AM +0800, Zhang Rui wrote:
> On Tue, 2013-03-26 at 07:16 -0300, Ezequiel Garcia wrote:
> > This driver supports both Armada 370 and Armada XP SoC
> > thermal management controllers.
> >=20
> > Armada 370 has a register to check a valid temperature, whereas
> > Armada XP does not. Each has a different initialization (i.e. calib=
ration)
> > function. The temperature conversion formula is the same for both.
> >=20
> > The controller present in each SoC have a very similar feature set,
> > so it corresponds to have one driver to support both of them.
> >=20
> > Although this driver may present similarities to Dove and Kirkwood
> > thermal driver, the exact differences and coincidences are not full=
y
> > known. For this reason, support is given through a separate driver.
> >=20
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> > Changes from v1:
> >  * Make armada_get_temp() more readable by reading the register
> >    on a separate line, as requested by Durgadoss R.
> >=20
> >  * Reorder Kconfig and Makefile entries, as requested by Andrew Lun=
n.
> >=20
> >  .../devicetree/bindings/thermal/armada-thermal.txt |   22 ++
> >  drivers/thermal/Kconfig                            |    8 +
> >  drivers/thermal/Makefile                           |    1 +
> >  drivers/thermal/armada_thermal.c                   |  236 ++++++++=
++++++++++++
> >  4 files changed, 267 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/armad=
a-thermal.txt
> >  create mode 100644 drivers/thermal/armada_thermal.c
> >=20
> > diff --git a/Documentation/devicetree/bindings/thermal/armada-therm=
al.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > new file mode 100644
> > index 0000000..fff93d5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > @@ -0,0 +1,22 @@
> > +* Marvell Armada 370/XP thermal management
> > +
> > +Required properties:
> > +
> > +- compatible:	Should be set to one of the following:
> > +		marvell,armada370-thermal
> > +		marvell,armadaxp-thermal
> > +
> > +- reg:		Device's register space.
> > +		Two entries are expected, see the examples below.
> > +		The first one is required for the sensor register;
> > +		the second one is required for the control register
> > +		to be used for sensor initialization (a.k.a. calibration).
> > +
> > +Example:
> > +
> > +	thermal@d0018300 {
> > +		compatible =3D "marvell,armada370-thermal";
> > +                reg =3D <0xd0018300 0x4
> > +		       0xd0018304 0x4>;
> > +		status =3D "okay";
> > +	};
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index a764f16..9eddf74 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -144,6 +144,14 @@ config DB8500_THERMAL
> >  	  created. Cooling devices can be bound to the trip points to coo=
l this
> >  	  thermal zone if trip points reached.
> > =20
> > +config ARMADA_THERMAL
> > +	tristate "Armada 370/XP thermal management"
> > +	depends on ARCH_MVEBU
> > +	depends on OF
> > +	help
> > +	  Enable this option if you want to have support for thermal mana=
gement
> > +	  controller present in Armada 370 and Armada XP SoC.
> > +
> >  config DB8500_CPUFREQ_COOLING
> >  	tristate "DB8500 cpufreq cooling"
> >  	depends on ARCH_U8500
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index d3a2b38..7f6509a 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -19,6 +19,7 @@ obj-$(CONFIG_KIRKWOOD_THERMAL)  +=3D kirkwood_the=
rmal.o
> >  obj-$(CONFIG_EXYNOS_THERMAL)	+=3D exynos_thermal.o
> >  obj-$(CONFIG_DOVE_THERMAL)  	+=3D dove_thermal.o
> >  obj-$(CONFIG_DB8500_THERMAL)	+=3D db8500_thermal.o
> > +obj-$(CONFIG_ARMADA_THERMAL)	+=3D armada_thermal.o
> >  obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+=3D db8500_cpufreq_cooling.o
> >  obj-$(CONFIG_INTEL_POWERCLAMP)	+=3D intel_powerclamp.o
> > =20
> > diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/arm=
ada_thermal.c
> > new file mode 100644
> > index 0000000..6743ec2
> > --- /dev/null
> > +++ b/drivers/thermal/armada_thermal.c
> > @@ -0,0 +1,236 @@
> > +/*
> > + * Marvell Armada 370/XP thermal sensor driver
> > + *
> > + * Copyright (C) 2013 Marvell
> > + *
> > + * This software is licensed under the terms of the GNU General Pu=
blic
> > + * License version 2, as published by the Free Software Foundation=
, and
> > + * may be copied, distributed, and modified under those terms.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/of.h>
> > +#include <linux/module.h>
> > +#include <linux/delay.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/of_device.h>
> > +#include <linux/thermal.h>
> > +
> > +#define THERMAL_VALID_OFFSET		9
> > +#define THERMAL_VALID_MASK		0x1
> > +#define THERMAL_TEMP_OFFSET		10
> > +#define THERMAL_TEMP_MASK		0x1ff
> > +
> > +/* Thermal Manager Control and Status Register */
> > +#define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
> > +#define PMU_TM_DISABLE_OFFS		0
> > +#define PMU_TM_DISABLE_MASK		(0x1 << PMU_TM_DISABLE_OFFS)
> > +#define PMU_TDC0_REF_CAL_CNT_OFFS	11
> > +#define PMU_TDC0_REF_CAL_CNT_MASK	(0x1ff << PMU_TDC0_REF_CAL_CNT_O=
=46FS)
> > +#define PMU_TDC0_OTF_CAL_MASK		(0x1 << 30)
> > +#define PMU_TDC0_START_CAL_MASK		(0x1 << 25)
> > +
> > +struct armada_thermal_ops;
> > +
> > +/* Marvell EBU Thermal Sensor Dev Structure */
> > +struct armada_thermal_priv {
> > +	void __iomem *sensor;
> > +	void __iomem *control;
> > +	struct armada_thermal_ops *ops;
> > +};
> > +
> > +struct armada_thermal_ops {
> > +	/* Initialize the sensor */
> > +	void (*init_sensor)(struct armada_thermal_priv *);
> > +
> > +	/* Test for a valid sensor value (optional) */
> > +	bool (*is_valid)(struct armada_thermal_priv *);
> > +};
> > +
> > +static void armadaxp_init_sensor(struct armada_thermal_priv *priv)
> > +{
> > +	unsigned long reg;
> > +
> > +	/* ??? */
>=20
> what does this comment mean?
>=20

It means I'm not sure entirely sure what the below code does.
Maybe I should remove it?

> > +	reg =3D readl_relaxed(priv->control);
> > +	reg |=3D PMU_TDC0_OTF_CAL_MASK;
> > +	writel(reg, priv->control);
> > +

Thanks for the review,
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
