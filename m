From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 1/4] mfd: rt5033: Add Richtek RT5033 driver core.
Date: Tue, 9 Dec 2014 09:06:26 +0000
Message-ID: <20141209090626.GU3951@x1>
References: <1417527591-20450-1-git-send-email-beomho.seo@samsung.com>
 <1417527591-20450-2-git-send-email-beomho.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33371 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbaLIJGf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Dec 2014 04:06:35 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so109424iec.25
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2014 01:06:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417527591-20450-2-git-send-email-beomho.seo@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sameo@linux.intel.com, lee.jone@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, cw00.choi@samsung.com, geunsik.lim@samsung.com, inki.dae@samsung.com, sw0312.kim@samsung.com

On Tue, 02 Dec 2014, Beomho Seo wrote:

> This patch adds a new driver for Richtek RT5033 driver.
> RT5033 is a Multifunction device which includes battery charger, fuel=
 gauge,
> flash LED current source, LDO and synchronous Buck converter. It is i=
nterfaced
> to host controller using I2C interface.
>=20
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jone@linaro.org>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Changes in v7
> - Use small description.
> - Change some names for a variable.
> - Revise of_device_id struct style.
>=20
> Changes in v6
> - Fix white space issue in mfd cell struct.
>=20
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
>  drivers/mfd/rt5033.c               |  141 +++++++++++++++++++
>  include/linux/mfd/rt5033-private.h |  260 ++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/rt5033.h         |   62 +++++++++
>  5 files changed, 476 insertions(+)
>  create mode 100644 drivers/mfd/rt5033.c
>  create mode 100644 include/linux/mfd/rt5033-private.h
>  create mode 100644 include/linux/mfd/rt5033.h

[...]

> diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
> new file mode 100644
> index 0000000..2d2bfbe
> --- /dev/null
> +++ b/drivers/mfd/rt5033.c
> @@ -0,0 +1,141 @@
> +/*
> + * RT5033 core driver.

I asked you to write a small description of the h/w here.

Instead you've made it _less_ descriptive?

> + * Copyright (C) 2014 Samsung Electronics, Co., Ltd.
> + * Author: Beomho Seo <beomho.seo@samsung.com>
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
> +	{
> +		.name =3D "rt5033-charger",
> +		.of_compatible =3D "richtek,rt5033-charger",
> +	}, {
> +		.name =3D "rt5033-battery",
> +		.of_compatible =3D "richtek,rt5033-battery",
> +	},
> +};
> +
> +static const struct of_device_id rt5033_dt_match[] =3D {
> +	{
> +		.compatible =3D "richtek,rt5033",
> +	},
> +	{ }
> +};

This was better as a single line entry.

I also asked you to move it down to where it's first used, instead of
way up here.  Please convert it back to one line and move the whole
structure down just above the line:

"static struct i2c_driver rt5033_driver =3D {"

[...]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
