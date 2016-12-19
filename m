From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] power: reset: add linkstation-reset driver
Date: Mon, 19 Dec 2016 16:38:02 +0100
Message-ID: <20161219153802.vhcish35qyjbpevj@earth>
References: <20161207172415.9776-1-rogershimizu@gmail.com>
 <20161216100501.18173-1-rogershimizu@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wjd43eukro6n5yhg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755534AbcLSPiR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Dec 2016 10:38:17 -0500
Content-Disposition: inline
In-Reply-To: <20161216100501.18173-1-rogershimizu@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Roger Shimizu <rogershimizu@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Ryan Tandy <ryan@nardis.ca>, Martin Michlmayr <tbm@cyrius.com>, Sylver Bruneau <sylver.bruneau@googlemail.com>, Herbert Valerio Riedel <hvr@gnu.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org


--wjd43eukro6n5yhg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Roger,

On Fri, Dec 16, 2016 at 07:05:01PM +0900, Roger Shimizu wrote:
> Buffalo Linkstation / KuroBox and their variants need magic command
> sending to UART1 to power-off.
>=20
> Power driver linkstation-reset implements the magic command and I/O
> routine, which come from files listed below:
>   - arch/arm/mach-orion5x/kurobox_pro-setup.c
>   - arch/arm/mach-orion5x/terastation_pro2-setup.c

Ok.

> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Martin Michlmayr <tbm@cyrius.com>
> Cc: Sylver Bruneau <sylver.bruneau@googlemail.com>
> Cc: Herbert Valerio Riedel <hvr@gnu.org>
> Reported-by: Ryan Tandy <ryan@nardis.ca>
> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
> ---
> Dear Sebastian,
>=20
> Kurobox-Pro (and variants) need more commands sending to UART1 to shutdow=
n.
> So here I make this patch series to let current qnap-poweroff implementat=
ion
> be able to handle such case.
>=20
> I already tested this change on Kurobox-Pro and Linkstation LS-GL devices,
> with a modified device-tree file. (Previous device-tree of kurobox-pro in=
vokes
> restart-poweroff, so it simply restarts.)
>=20
> Thank you and look forward to your feedback!
>
> Dear Andrew,
>=20
> Thanks for your 2nd review!
>=20
> So I accept your suggestion and make the new driver for linkstation serie=
s.
>
> Changes:
>   v0 =3D> v1:
>   - Update 0003 to split kuroboxpro related code into kuroboxpro-common.c
>   v1 =3D> v2:
>   - Slipt off linkstation/kuroboxpro related code to linkstation-reset.c
>     Because linkstation before kuroboxpro also need this driver to power
>     off properly. It's more proper to call it linkstation driver.
>=20
> Cheers,
> --
> Roger Shimizu, GMT +9 Tokyo
> PGP/GPG: 4096R/6C6ACD6417B3ACB1
>=20
>  .../bindings/power/reset/linkstation-reset.txt     |  26 ++++
>  drivers/power/reset/Kconfig                        |  10 ++
>  drivers/power/reset/Makefile                       |   1 +
>  drivers/power/reset/linkstation-common.c           | 124 +++++++++++++++
>  drivers/power/reset/linkstation-common.h           |   8 +
>  drivers/power/reset/linkstation-reset.c            | 172 +++++++++++++++=
++++++
>  6 files changed, 341 insertions(+)

With this being its own driver please merge linkstation-common and
linkstation-reset. The common part is only used by linkstation-reset
anyways.

>  create mode 100644 Documentation/devicetree/bindings/power/reset/linksta=
tion-reset.txt

This patch is missing Cc for DT binding people (check "OPEN FIRMWARE
AND FLATTENED DEVICE TREE BINDINGS" in MAINTAINERS file).

>  create mode 100644 drivers/power/reset/linkstation-common.c
>  create mode 100644 drivers/power/reset/linkstation-common.h
>  create mode 100644 drivers/power/reset/linkstation-reset.c
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/linkstation-re=
set.txt b/Documentation/devicetree/bindings/power/reset/linkstation-reset.t=
xt
> new file mode 100644
> index 0000000..815e340
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/linkstation-reset.txt
> @@ -0,0 +1,26 @@
> +* Buffalo Linkstation Reset Driver
> +
> +Power of some Buffalo Linkstation or KuroBox Pro is managed by
> +micro-controller, which connects to UART1. After being fed from UART1
> +by a few magic numbers, the so-called power-off command,
> +the micro-controller will turn power off the device.
> +
> +This is very similar to QNAP or Synology NAS devices, which is
> +described in qnap-poweroff.txt, however the command is much simpler,
> +only 1-byte long and without checksums.
> +
> +This driver adds a handler to pm_power_off which is called to turn the
> +power off.
> +
> +Required Properties:
> +- compatible: Should be "linkstation,power-off"
> +- reg: Address and length of the register set for UART1
> +- clocks: tclk clock
> +
> +Example:
> +
> +	reset {
> +		compatible =3D "linkstation,power-off";
> +		reg =3D <0x12100 0x100>;
> +		clocks =3D <&core_clk 0>;
> +	};

This might be another user for UART slave device [0].
[0] https://lkml.org/lkml/2016/8/24/769

Is the UART port used for anything else besides the reset
controller?

> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index c74c3f6..77c44ca 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -98,6 +98,16 @@ config POWER_RESET_IMX
>  	  say N here or disable in dts to make sure pm_power_off never be
>  	  overwrote wrongly by this driver.
> =20
> +config POWER_RESET_LINKSTATION
> +	bool "Buffalo Linkstation and its variants reset driver"
> +	depends on OF_GPIO && PLAT_ORION
> +	help
> +	  This driver supports power off Buffalo Linkstation / KuroBox Pro
> +	  NAS and their variants by sending commands to the micro-controller
> +	  which controls the main power.
> +
> +	  Say Y if you have a Buffalo Linkstation / KuroBox Pro NAS.
> +
>  config POWER_RESET_MSM
>  	bool "Qualcomm MSM power-off driver"
>  	depends on ARCH_QCOM
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 1be307c..520afbe 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
>  obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restart.o
>  obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
>  obj-$(CONFIG_POWER_RESET_IMX) +=3D imx-snvs-poweroff.o
> +obj-$(CONFIG_POWER_RESET_LINKSTATION) +=3D linkstation-reset.o linkstati=
on-common.o
>  obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
>  obj-$(CONFIG_POWER_RESET_LTC2952) +=3D ltc2952-poweroff.o
>  obj-$(CONFIG_POWER_RESET_QNAP) +=3D qnap-poweroff.o
> diff --git a/drivers/power/reset/linkstation-common.c b/drivers/power/res=
et/linkstation-common.c
> new file mode 100644
> index 0000000..a6d0930
> --- /dev/null
> +++ b/drivers/power/reset/linkstation-common.c
> @@ -0,0 +1,124 @@
> +/*
> + * Common I/O routine for micro-controller of Buffalo Linkstation
> + * and its variants.
> + *
> + * Copyright (C) 2016 Roger Shimizu <rogershimizu@gmail.com>
> + *
> + * Based on the code from:
> + *
> + * Copyright (C) 2008  Sylver Bruneau <sylver.bruneau@googlemail.com>
> + * Copyright (C) 2007  Herbert Valerio Riedel <hvr@gnu.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/serial_reg.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include "linkstation-common.h"
> +
> +static int uart1_micon_read(void *base, unsigned char *buf, int count)
> +{
> +	int i;
> +	int timeout;
> +
> +	for (i =3D 0; i < count; i++) {
> +		timeout =3D 10;
> +
> +		while (!(readl(UART1_REG(LSR)) & UART_LSR_DR)) {
> +			if (--timeout =3D=3D 0)
> +				break;
> +			udelay(1000);
> +		}
> +
> +		if (timeout =3D=3D 0)
> +			break;
> +		buf[i] =3D readl(UART1_REG(RX));
> +	}
> +
> +	/* return read bytes */
> +	return i;
> +}
> +
> +static int uart1_micon_write(void *base, const unsigned char *buf, int c=
ount)
> +{
> +	int i =3D 0;
> +
> +	while (count--) {
> +		while (!(readl(UART1_REG(LSR)) & UART_LSR_THRE))
> +			barrier();
> +		writel(buf[i++], UART1_REG(TX));
> +	}
> +
> +	return 0;
> +}
> +
> +int uart1_micon_send(void *base, const unsigned char *data, int count)
> +{
> +	int i;
> +	unsigned char checksum =3D 0;
> +	unsigned char recv_buf[40];
> +	unsigned char send_buf[40];
> +	unsigned char correct_ack[3];
> +	int retry =3D 2;
> +
> +	/* Generate checksum */
> +	for (i =3D 0; i < count; i++)
> +		checksum -=3D  data[i];
> +
> +	do {
> +		/* Send data */
> +		uart1_micon_write(base, data, count);
> +
> +		/* send checksum */
> +		uart1_micon_write(base, &checksum, 1);
> +
> +		if (uart1_micon_read(base, recv_buf, sizeof(recv_buf)) <=3D 3) {
> +			printk(KERN_ERR ">%s: receive failed.\n", __func__);
> +
> +			/* send preamble to clear the receive buffer */
> +			memset(&send_buf, 0xff, sizeof(send_buf));
> +			uart1_micon_write(base, send_buf, sizeof(send_buf));
> +
> +			/* make dummy reads */
> +			mdelay(100);
> +			uart1_micon_read(base, recv_buf, sizeof(recv_buf));
> +		} else {
> +			/* Generate expected ack */
> +			correct_ack[0] =3D 0x01;
> +			correct_ack[1] =3D data[1];
> +			correct_ack[2] =3D 0x00;
> +
> +			/* checksum Check */
> +			if ((recv_buf[0] + recv_buf[1] + recv_buf[2] +
> +			     recv_buf[3]) & 0xFF) {
> +				printk(KERN_ERR ">%s: Checksum Error : "
> +					"Received data[%02x, %02x, %02x, %02x]"
> +					"\n", __func__, recv_buf[0],
> +					recv_buf[1], recv_buf[2], recv_buf[3]);
> +			} else {
> +				/* Check Received Data */
> +				if (correct_ack[0] =3D=3D recv_buf[0] &&
> +				    correct_ack[1] =3D=3D recv_buf[1] &&
> +				    correct_ack[2] =3D=3D recv_buf[2]) {
> +					/* Interval for next command */
> +					mdelay(10);
> +
> +					/* Receive ACK */
> +					return 0;
> +				}
> +			}
> +			/* Received NAK or illegal Data */
> +			printk(KERN_ERR ">%s: Error : NAK or Illegal Data "
> +					"Received\n", __func__);
> +		}
> +	} while (retry--);
> +
> +	/* Interval for next command */
> +	mdelay(10);
> +
> +	return -1;
> +}
> diff --git a/drivers/power/reset/linkstation-common.h b/drivers/power/res=
et/linkstation-common.h
> new file mode 100644
> index 0000000..89c64a9
> --- /dev/null
> +++ b/drivers/power/reset/linkstation-common.h
> @@ -0,0 +1,8 @@
> +#ifndef __LINKSTATION_COMMON_H__
> +#define __LINKSTATION_COMMON_H__
> +
> +#define UART1_REG(x)	(base + ((UART_##x) << 2))
> +
> +int uart1_micon_send(void *base, const unsigned char *data, int count);
> +
> +#endif
> diff --git a/drivers/power/reset/linkstation-reset.c b/drivers/power/rese=
t/linkstation-reset.c
> new file mode 100644
> index 0000000..78a0137
> --- /dev/null
> +++ b/drivers/power/reset/linkstation-reset.c
> @@ -0,0 +1,172 @@
> +/*
> + * Buffalo Linkstation power reset driver.
> + * It may also be used on following devices:
> + *  - Buffalo Linkstation HG
> + *  - KuroBox HG
> + *  - Buffalo KURO-NAS/T4
> + *  - KuroBox Pro
> + *  - Buffalo Linkstation Pro (LS-GL)
> + *  - Buffalo Terastation Pro II/Live
> + *  - Buffalo Linkstation Duo (LS-WTGL)
> + *  - Buffalo Linkstation Mini (LS-WSGL)
> + *
> + * Copyright (C) 2016  Roger Shimizu <rogershimizu@gmail.com>
> + *
> + * Based on the code from:
> + *
> + * Copyright (C) 2012  Andrew Lunn <andrew@lunn.ch>
> + * Copyright (C) 2009  Martin Michlmayr <tbm@cyrius.com>
> + * Copyright (C) 2008  Byron Bradley <byron.bbradley@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/serial_reg.h>
> +#include <linux/kallsyms.h>
> +#include <linux/of.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include "linkstation-common.h"
> +
> +#define MICON_CMD_SIZE	4
> +
> +/* 4-byte magic hello command to UART1-attached microcontroller */
> +static const unsigned char linkstation_micon_magic[] =3D {
> +	0x1b,
> +	0x00,
> +	0x07,
> +	0x00
> +};

4-byte magic hello command? Those are used as uart configuration as
far as I can see. Just move this directly into reset_cfg:

struct reset_cfg {
    u32 baud;
    u8 lcr;
    u8 ier;
    u8 fcr;
    u8 mcr;
    const unsigned char (*cmd)[MICON_CMD_SIZE];
};

> +// for each row, first byte is the size of command
> +static const unsigned char linkstation_power_off_cmd[][MICON_CMD_SIZE] =
=3D {
> +	{ 3,	0x01, 0x35, 0x00},
> +	{ 2,	0x00, 0x0c},
> +	{ 2,	0x00, 0x06},
> +	{}
> +};
> +
> +struct reset_cfg {
> +	u32 baud;
> +	const unsigned char *magic;
> +	const unsigned char (*cmd)[MICON_CMD_SIZE];
> +};
> +
> +static const struct reset_cfg linkstation_power_off_cfg =3D {
> +	.baud =3D 38400,
> +	.magic =3D linkstation_micon_magic,
> +	.cmd =3D linkstation_power_off_cmd,
> +};
> +
> +static const struct of_device_id linkstation_reset_of_match_table[] =3D {
> +	{ .compatible =3D "linkstation,power-off",
> +	  .data =3D &linkstation_power_off_cfg,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, linkstation_reset_of_match_table);
> +
> +static void __iomem *base;
> +static unsigned long tclk;
> +static const struct reset_cfg *cfg;
> +
> +static void linkstation_reset(void)
> +{
> +	const unsigned divisor =3D ((tclk + (8 * cfg->baud)) / (16 * cfg->baud)=
);
> +
> +	pr_err("%s: triggering power-off...\n", __func__);
> +
> +	/* hijack UART1 and reset into sane state */
> +	writel(0x83, UART1_REG(LCR));
> +	writel(divisor & 0xff, UART1_REG(DLL));
> +	writel((divisor >> 8) & 0xff, UART1_REG(DLM));
> +	writel(cfg->magic[0], UART1_REG(LCR));
> +	writel(cfg->magic[1], UART1_REG(IER));
> +	writel(cfg->magic[2], UART1_REG(FCR));
> +	writel(cfg->magic[3], UART1_REG(MCR));
> +
> +	/* send the power-off command to PIC */
> +	if(cfg->cmd[0][0] =3D=3D 1 && cfg->cmd[1][0] =3D=3D 0) {
> +		/* if it's simply one-byte command, send it directly */
> +		writel(cfg->cmd[0][1], UART1_REG(TX));
> +	}

I guess this optimization can be dropped and you can directly
call the for loop with uart1_micon_send().

> +	else {
> +		int i;
> +		for(i =3D 0; cfg->cmd[i][0] > 0; i ++) {
> +			/* [0] is size of the command; command starts from [1] */
> +			uart1_micon_send(base, &(cfg->cmd[i][1]), cfg->cmd[i][0]);
> +		}
> +	}
> +}
> +
> +static int linkstation_reset_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np =3D pdev->dev.of_node;
> +	struct resource *res;
> +	struct clk *clk;
> +	char symname[KSYM_NAME_LEN];
> +
> +	const struct of_device_id *match =3D
> +		of_match_node(linkstation_reset_of_match_table, np);
> +	cfg =3D match->data;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Missing resource");
> +		return -EINVAL;
> +	}
> +
> +	base =3D devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (!base) {
> +		dev_err(&pdev->dev, "Unable to map resource");
> +		return -EINVAL;
> +	}
> +
> +	/* We need to know tclk in order to calculate the UART divisor */
> +	clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk)) {
> +		dev_err(&pdev->dev, "Clk missing");
> +		return PTR_ERR(clk);
> +	}
> +
> +	tclk =3D clk_get_rate(clk);
> +
> +	/* Check that nothing else has already setup a handler */
> +	if (pm_power_off) {
> +		lookup_symbol_name((ulong)pm_power_off, symname);
> +		dev_err(&pdev->dev,
> +			"pm_power_off already claimed %p %s",
> +			pm_power_off, symname);
> +		return -EBUSY;
> +	}
> +	pm_power_off =3D linkstation_reset;
> +
> +	return 0;
> +}
> +
> +static int linkstation_reset_remove(struct platform_device *pdev)
> +{
> +	pm_power_off =3D NULL;
> +	return 0;
> +}
> +
> +static struct platform_driver linkstation_reset_driver =3D {
> +	.probe	=3D linkstation_reset_probe,
> +	.remove	=3D linkstation_reset_remove,
> +	.driver	=3D {
> +		.name	=3D "linkstation_reset",
> +		.of_match_table =3D of_match_ptr(linkstation_reset_of_match_table),
> +	},
> +};
> +
> +module_platform_driver(linkstation_reset_driver);
> +
> +MODULE_AUTHOR("Roger Shimizu <rogershimizu@gmail.com>");
> +MODULE_DESCRIPTION("KuroBox Pro Reset driver");
> +MODULE_LICENSE("GPL v2");

-- Sebastian

--wjd43eukro6n5yhg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhX/tcACgkQ2O7X88g7
+poUKQ//cIcAMojZjfzcHQlpzPyxxpNG0MNM+qCqavmfjbk3VvkqaEfX9OwuzTAi
F75TvgUq449IBJhf8Pcf2WvB2tyXyMzZt+ksrGJoNNLg8G0GjJzhWaWuXQIYIXq/
r2WlWcsnVTJMvZSi1ckO0euPy90Ly2QVLEa2jT0qTqj+mrcjxyim3y4hrJyX3DMd
I72G+2x+yuOkJiJvfHcGlayWKIiuYSgBYLOfFoYDswqdmzQYD8AzA3y0TmQH1QLX
vF8T/eThJjOKTcvL/wJBlwL3xC9ea6Q+az1irufYugXHcIxJQ/eGS//AnNFBcX6i
TOaNo86mOUogQ3enZC9iG84JQ8f0dzgLFVzK12ZdDTRGWHgFC9bK+MoACOHg7ypS
75ngvP9VVwXnC+/E6fHThfiay40R/lDy50ajNFQJ4r8vTTlJR5kfcHkN0kwfZPlp
ISMZER+w8PQXmhdKZ8yfjlgparxOqjOSihrCj3j0f4pkPHecw133oCMYcMly1Fe6
AavQz0/ilXBQUASKI7VJ2JXoCoanCrMBnxPT5tR3kcnm5jiNBKRL/WBbGxr5EJER
ja5swj2Fqn/WKq60A0rG4yL0X0puChcxZoXW8X8wcBJJdXCzwOG3DPWXA29S+/Rj
QhRQcHQAUf+fDQ66qfa5VEO7XNw8HFlRhoV3s5p9kv6o9bt0Ns4=
=jimt
-----END PGP SIGNATURE-----

--wjd43eukro6n5yhg--
