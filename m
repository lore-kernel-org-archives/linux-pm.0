From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v3 2/3] power: reset: imx-snvs-poweroff: add power off
 driver for i.mx6
Date: Wed, 17 Sep 2014 13:10:05 +0200
Message-ID: <20140917131005.7d8ab95c@ipc1.ka-ro>
References: <1410947881-7345-1-git-send-email-b38343@freescale.com>
	<1410947881-7345-3-git-send-email-b38343@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:62745 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048AbaIQLM3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Sep 2014 07:12:29 -0400
In-Reply-To: <1410947881-7345-3-git-send-email-b38343@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Robin Gong <b38343@freescale.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawn.guo@freescale.com, kernel@pengutronix.de, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, grant.likely@linaro.org, linux@arm.linux.org.uk, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

Hi,

Robin Gong wrote:
> This driver register pm_power_off with snvs power off function. If
> your boards NOT use PMIC_ON_REQ to turn on/off external pmic, or use
> other pin to do, please disable the driver in dts, otherwise, your
> pm_power_off maybe overwrote by this driver.
>=20
> Signed-off-by: Robin Gong <b38343@freescale.com>
> ---
>  .../bindings/power_supply/imx-snvs-poweroff.txt    |   23 +++++++
>  drivers/power/reset/Kconfig                        |    9 +++
>  drivers/power/reset/Makefile                       |    1 +
>  drivers/power/reset/imx-snvs-poweroff.c            |   66 ++++++++++=
++++++++++
>  4 files changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power_supply/im=
x-snvs-poweroff.txt
>  create mode 100644 drivers/power/reset/imx-snvs-poweroff.c
>=20
[...]
> diff --git a/drivers/power/reset/imx-snvs-poweroff.c b/drivers/power/=
reset/imx-snvs-poweroff.c
> new file mode 100644
> index 0000000..d726ac4
> --- /dev/null
> +++ b/drivers/power/reset/imx-snvs-poweroff.c
> @@ -0,0 +1,66 @@
> +/* Power off driver for i.mx6
> + * Copyright (c) 2014, FREESCALE CORPORATION.  All rights reserved.
> + *
> + * based on msm-poweroff.c
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 an=
d
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +
> +static void __iomem *snvs_base;
> +
> +static void do_imx_poweroff(void)
> +{
> +	u32 value =3D readl(snvs_base);
> +
> +	/* set TOP and DP_EN bit */
> +	writel(value | 0x60, snvs_base);
> +}
> +
> +static int imx_poweroff_probe(struct platform_device *pdev)
> +{
> +	snvs_base =3D of_iomap(pdev->dev.of_node, 0);
> +	if (!snvs_base) {
> +		dev_err(&pdev->dev, "failed to get memory\n");
> +		return -EIO;
>
I don't think EIO is an appropriate return code here. There was no I/O
in progress that had an error. IMO ENODEV would be more appropriate
here.

> +static const struct of_device_id of_imx_poweroff_match[] =3D {
> +	{ .compatible =3D "fsl,sec-v4.0-poweroff", },
> +	{},
>
useless comma after terminating NULL element of array.
You never want any patch to add an entry after this one.
Without the comma doing so (e.g. because of a badly resolved merge
conflict) would lead to a compile error.


> +};
> +MODULE_DEVICE_TABLE(of, of_imx_poweroff_match);
> +
> +static struct platform_driver imx_poweroff_driver =3D {
> +	.probe =3D imx_poweroff_probe,
> +	.driver =3D {
> +		.name =3D "imx-snvs-poweroff",
> +		.of_match_table =3D of_match_ptr(of_imx_poweroff_match),
>
useless use of of_match_ptr()


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
