From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] power: reset: remove unused imx-snvs-poweroff driver
Date: Tue, 9 Jan 2018 17:20:58 +0100
Message-ID: <20180109162058.et7knegegzgmqcop@earth.universe>
References: <1513938539-20873-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cvxgpdchdo6jujzu"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1513938539-20873-1-git-send-email-aisheng.dong-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dongas86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yibin.gong-3arQi8VN3Tc@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--cvxgpdchdo6jujzu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 22, 2017 at 06:28:59PM +0800, Dong Aisheng wrote:
> There's no user of it in kernel now and it basically functions the same
> as the generic syscon-poweroff.c to which we have already switched.
> So let's remove it.
>=20
> Cc: Robin Gong <yibin.gong-3arQi8VN3Tc@public.gmane.org>
> Cc: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>
> ---

Thanks, queued.

-- Sebastian

>  .../bindings/power/reset/imx-snvs-poweroff.txt     | 23 --------
>  drivers/power/reset/Kconfig                        |  9 ---
>  drivers/power/reset/Makefile                       |  1 -
>  drivers/power/reset/imx-snvs-poweroff.c            | 66 ----------------=
------
>  4 files changed, 99 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/imx-snv=
s-poweroff.txt
>  delete mode 100644 drivers/power/reset/imx-snvs-poweroff.c
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/imx-snvs-power=
off.txt b/Documentation/devicetree/bindings/power/reset/imx-snvs-poweroff.t=
xt
> deleted file mode 100644
> index 1b81fcd..0000000
> --- a/Documentation/devicetree/bindings/power/reset/imx-snvs-poweroff.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -i.mx6 Poweroff Driver
> -
> -SNVS_LPCR in SNVS module can power off the whole system by pull
> -PMIC_ON_REQ low if PMIC_ON_REQ is connected with external PMIC.
> -If you don't want to use PMIC_ON_REQ as power on/off control,
> -please set status=3D'disabled' to disable this driver.
> -
> -Required Properties:
> --compatible: "fsl,sec-v4.0-poweroff"
> --reg: Specifies the physical address of the SNVS_LPCR register
> -
> -Example:
> -	snvs@20cc000 {
> -		compatible =3D "fsl,sec-v4.0-mon", "simple-bus";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <1>;
> -		ranges =3D <0 0x020cc000 0x4000>;
> -		.....
> -		snvs_poweroff: snvs-poweroff@38 {
> -			compatible =3D "fsl,sec-v4.0-poweroff";
> -			reg =3D <0x38 0x4>;
> -		};
> -	}
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index ca0de1a..a102e74 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -98,15 +98,6 @@ config POWER_RESET_HISI
>  	help
>  	  Reboot support for Hisilicon boards.
> =20
> -config POWER_RESET_IMX
> -	bool "IMX6 power-off driver"
> -	depends on POWER_RESET && SOC_IMX6
> -	help
> -	  This driver support power off external PMIC by PMIC_ON_REQ on i.mx6
> -	  boards.If you want to use other pin to control external power,please
> -	  say N here or disable in dts to make sure pm_power_off never be
> -	  overwrote wrongly by this driver.
> -
>  config POWER_RESET_MSM
>  	bool "Qualcomm MSM power-off driver"
>  	depends on ARCH_QCOM
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index aeb65ed..dcc92f5 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -10,7 +10,6 @@ obj-$(CONFIG_POWER_RESET_GEMINI_POWEROFF) +=3D gemini-p=
oweroff.o
>  obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
>  obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restart.o
>  obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
> -obj-$(CONFIG_POWER_RESET_IMX) +=3D imx-snvs-poweroff.o
>  obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
>  obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) +=3D piix4-poweroff.o
>  obj-$(CONFIG_POWER_RESET_LTC2952) +=3D ltc2952-poweroff.o
> diff --git a/drivers/power/reset/imx-snvs-poweroff.c b/drivers/power/rese=
t/imx-snvs-poweroff.c
> deleted file mode 100644
> index ad6ce50..0000000
> --- a/drivers/power/reset/imx-snvs-poweroff.c
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -/* Power off driver for i.mx6
> - * Copyright (c) 2014, FREESCALE CORPORATION.  All rights reserved.
> - *
> - * based on msm-poweroff.c
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 and
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - */
> -
> -#include <linux/err.h>
> -#include <linux/init.h>
> -#include <linux/io.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/platform_device.h>
> -
> -static void __iomem *snvs_base;
> -
> -static void do_imx_poweroff(void)
> -{
> -	u32 value =3D readl(snvs_base);
> -
> -	/* set TOP and DP_EN bit */
> -	writel(value | 0x60, snvs_base);
> -}
> -
> -static int imx_poweroff_probe(struct platform_device *pdev)
> -{
> -	snvs_base =3D of_iomap(pdev->dev.of_node, 0);
> -	if (!snvs_base) {
> -		dev_err(&pdev->dev, "failed to get memory\n");
> -		return -ENODEV;
> -	}
> -
> -	pm_power_off =3D do_imx_poweroff;
> -	return 0;
> -}
> -
> -static const struct of_device_id of_imx_poweroff_match[] =3D {
> -	{ .compatible =3D "fsl,sec-v4.0-poweroff", },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, of_imx_poweroff_match);
> -
> -static struct platform_driver imx_poweroff_driver =3D {
> -	.probe =3D imx_poweroff_probe,
> -	.driver =3D {
> -		.name =3D "imx-snvs-poweroff",
> -		.of_match_table =3D of_match_ptr(of_imx_poweroff_match),
> -	},
> -};
> -
> -static int __init imx_poweroff_init(void)
> -{
> -	return platform_driver_register(&imx_poweroff_driver);
> -}
> -device_initcall(imx_poweroff_init);
> --=20
> 2.7.4
>=20

--cvxgpdchdo6jujzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlpU6+cACgkQ2O7X88g7
+poFxA//ciJVwT6EFNGIZFRDnvHCukHR4Cxoxdx24F/Jfwx8jhm4l+Q0U1xmXJDw
jzsDAu836rufkyn+9yh3ob5MIOfM5aDr8hf5oGh3rzzxOJna2gHh1WG0KvfHoWHJ
7rJvfbpnD3As3n5/YXyrQ1kGpsUVADohrBlb4e1tdqZkyE9f5OSS+rqVXEzj/Ltw
6FPY6NP+E+OtaJmRpmJlnGGBf+5w6guktiHzaoqE3Umj6wC0GXIHsrjHFnFUwxiD
luq9SyoDDTe/7doZ6vyO8ov3bL4VRd0RjNSmtrXJFhDy7Br1q7MlC3VzPTy5Katq
OFD0PcJc4KHeReWJY54poqT7//mzi0fGQ46Wj4krMlsEmH/g3ooq++AHlVM//tk6
wPacyKqw+iXgwLpomqAeyQfl0gfatPdgOQ9y8q1YAoS+4oqvQW6TWC+362oDIkgt
B7LuykKghqKsWaUxFOYuk9MBC0B6jS8J9FRu571vwR1srAjhw112Fjb0Ib3r9X1o
bpvuzmBL0v4EagA/ijoaDxLdmnsxhlCn8Pjd5LUkMBL87YlAO5tGPJryh7xTMt4M
3u80DPZeg02jGL1w4VtnoXWOn0/MOyNnbMCHzXPdyz5zJC3J+cW8/Kot/EqkUldF
OP3ApFctb1UE+6Y3dvk3ZNuQfUoPWnEI55UZkSHzICieVVgz7KM=
=nUdx
-----END PGP SIGNATURE-----

--cvxgpdchdo6jujzu--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
