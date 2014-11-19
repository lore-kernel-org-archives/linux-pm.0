From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 1/4] mfd: rt5033: Add Richtek RT5033 driver core.
Date: Wed, 19 Nov 2014 16:37:02 +0000
Message-ID: <20141119163702.GF1875@x1>
References: <1416372760-2090-1-git-send-email-beomho.seo@samsung.com>
 <1416372760-2090-2-git-send-email-beomho.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416372760-2090-2-git-send-email-beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, geunsik.lim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, 19 Nov 2014, Beomho Seo wrote:

> This patch adds a new driver for Richtek RT5033 driver.
> RT5033 is a Multifunction device which includes battery charger, fuel=
 gauge,
> flash LED current source, LDO and synchronous Buck converter. It is i=
nterfaced
> to host controller using I2C interface.
>=20
> Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Lee Jones <lee.jone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> Changes in v5
> - Change possible built as a module.
> - Revise rt5033_dev mfd cell entry.
> - Fix incorrect typo.
> - Add module alias.
>=20
> Changes in v4
> - none.
>=20
> Changes in v3
> - Correct sentence errors.
> - Add author information the top of each drivers.
> - Remove unnecessary pre-initialise, struct member(rt5033->i2c) and b=
link.
> - Change some return check.
> - Use bool and of_match_ptr().
>=20
> Changes in v2
> - Remove volatile_reg callback. Because this driver not in use regmap=
 cache.
> - Revmoe unnecessary subnode of_compatible.
> - Add define for set_high impedance mode of charger.
> ---
>  drivers/mfd/Kconfig                |   12 ++
>  drivers/mfd/Makefile               |    1 +
>  drivers/mfd/rt5033.c               |  136 +++++++++++++++++++
>  include/linux/mfd/rt5033-private.h |  260 ++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/rt5033.h         |   62 +++++++++
>  5 files changed, 471 insertions(+)
>  create mode 100644 drivers/mfd/rt5033.c
>  create mode 100644 include/linux/mfd/rt5033-private.h
>  create mode 100644 include/linux/mfd/rt5033.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 72d3808..9c13170 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -618,6 +618,18 @@ config MFD_RTSX_PCI
>  	  types of memory cards, such as Memory Stick, Memory Stick Pro,
>  	  Secure Digital and MultiMediaCard.
> =20
> +config MFD_RT5033
> +	tristate "Richtek RT5033 Power Management IC"
> +	depends on I2C=3Dy
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  This driver provides for the Richtek RT5033 Power Management IC,
> +	  which includes the I2C driver and the Core APIs. This driver prov=
ides
> +	  common support for accessing the device. The device supports mult=
iple
> +	  sub-devices like charger, fuel gauge, flash LED, current source,
> +	  LDO and Buck.
> +
>  config MFD_RTSX_USB
>  	tristate "Realtek USB card reader"
>  	depends on USB
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 53467e2..4059c24 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -176,6 +176,7 @@ obj-$(CONFIG_MFD_IPAQ_MICRO)	+=3D ipaq-micro.o
>  obj-$(CONFIG_MFD_MENF21BMC)	+=3D menf21bmc.o
>  obj-$(CONFIG_MFD_HI6421_PMIC)	+=3D hi6421-pmic-core.o
>  obj-$(CONFIG_MFD_DLN2)		+=3D dln2.o
> +obj-$(CONFIG_MFD_RT5033)	+=3D rt5033.o
> =20
>  intel-soc-pmic-objs		:=3D intel_soc_pmic_core.o intel_soc_pmic_crc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC)	+=3D intel-soc-pmic.o
> diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
> new file mode 100644
> index 0000000..4d289b9
> --- /dev/null
> +++ b/drivers/mfd/rt5033.c
> @@ -0,0 +1,136 @@
> +/*
> + * MFD core driver for the Richtek RT5033.
> + *
> + * Copyright (C) 2014 Samsung Electronics, Co., Ltd.
> + * Author: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published bythe Free Software Foundation.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/rt5033.h>
> +#include <linux/mfd/rt5033-private.h>
> +
> +static const struct regmap_irq rt5033_irqs[] =3D {
> +	{ .mask =3D RT5033_PMIC_IRQ_BUCKOCP, },
> +	{ .mask =3D RT5033_PMIC_IRQ_BUCKLV, },
> +	{ .mask =3D RT5033_PMIC_IRQ_SAFELDOLV, },
> +	{ .mask =3D RT5033_PMIC_IRQ_LDOLV, },
> +	{ .mask =3D RT5033_PMIC_IRQ_OT, },
> +	{ .mask =3D RT5033_PMIC_IRQ_VDDA_UV, },
> +};
> +
> +static const struct regmap_irq_chip rt5033_irq_chip =3D {
> +	.name		=3D "rt5033",
> +	.status_base	=3D RT5033_REG_PMIC_IRQ_STAT,
> +	.mask_base	=3D RT5033_REG_PMIC_IRQ_CTRL,
> +	.mask_invert	=3D true,
> +	.num_regs	=3D 1,
> +	.irqs		=3D rt5033_irqs,
> +	.num_irqs	=3D ARRAY_SIZE(rt5033_irqs),
> +};
> +
> +static const struct mfd_cell rt5033_devs[] =3D {
> +	{ .name =3D "rt5033-regulator", },
> +	{ .name =3D "rt5033-charger", .of_compatible =3D "richtek,rt5033-ch=
arger",},
> +	{ .name =3D "rt5033-battery", .of_compatible =3D "richtek,rt5033-ba=
ttery",},
> +};

Perhaps I wasn't clear enough in my previous review -- sorry for
that.  I only want to see the single entry on one line i.e. one with
=2Ename, but no .of_compatible.  I probably wouldn't have requested a
re-spin, but you have white space issues at the end of those two lines
too.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
