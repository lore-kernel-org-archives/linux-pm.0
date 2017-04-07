From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V5 2/2] thermal: broadcom: add Northstar thermal driver
Date: Thu, 6 Apr 2017 21:42:21 -0700
Message-ID: <20170407044218.GA12447@localhost.localdomain>
References: <20170331201124.656-1-zajec5@gmail.com>
 <20170403154829.29780-1-zajec5@gmail.com>
 <20170403154829.29780-2-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170403154829.29780-2-zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>, Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 05:48:29PM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
>=20
> Northstar is a SoC family commonly used in home routers. This commit
> adds a driver for checking CPU temperature. As Northstar Plus seems to
> also have this IP block this new symbol gets ARCH_BCM_IPROC dependency.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
> Signed-off-by: Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

If no objection, I am applying this series.


> ---
> V2: Make it iProc specific as NSP can also use this driver
>     Select proper symbols in config ARCH_BCM_IPROC
>     Define PVTMON register bits
>     Update code selecting temperature monitor mode
>     Thank you Jon!
> V3: More details in help message for BCM_NS_THERMAL
>     Use slope & offset
>     Drop arch code change (I'll be submitted using a proper tree)
>     Thank you Eduardo!
> V4: Comment operations on PVTMON_CONTROL0 register
> ---
>  drivers/thermal/Kconfig               |   5 ++
>  drivers/thermal/Makefile              |   1 +
>  drivers/thermal/broadcom/Kconfig      |   8 +++
>  drivers/thermal/broadcom/Makefile     |   1 +
>  drivers/thermal/broadcom/ns-thermal.c | 105 ++++++++++++++++++++++++++++=
++++++
>  5 files changed, 120 insertions(+)
>  create mode 100644 drivers/thermal/broadcom/Kconfig
>  create mode 100644 drivers/thermal/broadcom/Makefile
>  create mode 100644 drivers/thermal/broadcom/ns-thermal.c
>=20
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 3bd24063375e..ac7301703d03 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -392,6 +392,11 @@ config MTK_THERMAL
>  	  Enable this option if you want to have support for thermal management
>  	  controller present in Mediatek SoCs
> =20
> +menu "Broadcom thermal drivers"
> +depends on ARCH_BCM || COMPILE_TEST
> +source "drivers/thermal/broadcom/Kconfig"
> +endmenu
> +
>  menu "Texas Instruments thermal drivers"
>  depends on ARCH_HAS_BANDGAP || COMPILE_TEST
>  depends on HAS_IOMEM
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index f23cde05dac6..6b7706b9f27c 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -27,6 +27,7 @@ thermal_sys-$(CONFIG_CLOCK_THERMAL)	+=3D clock_cooling.o
>  thermal_sys-$(CONFIG_DEVFREQ_THERMAL) +=3D devfreq_cooling.o
> =20
>  # platform thermal drivers
> +obj-y				+=3D broadcom/
>  obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+=3D qcom-spmi-temp-alarm.o
>  obj-$(CONFIG_SPEAR_THERMAL)	+=3D spear_thermal.o
>  obj-$(CONFIG_ROCKCHIP_THERMAL)	+=3D rockchip_thermal.o
> diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom/=
Kconfig
> new file mode 100644
> index 000000000000..f0dea8a8e002
> --- /dev/null
> +++ b/drivers/thermal/broadcom/Kconfig
> @@ -0,0 +1,8 @@
> +config BCM_NS_THERMAL
> +	tristate "Northstar thermal driver"
> +	depends on ARCH_BCM_IPROC || COMPILE_TEST
> +	help
> +	  Northstar is a family of SoCs that includes e.g. BCM4708, BCM47081,
> +	  BCM4709 and BCM47094. It contains DMU (Device Management Unit) block
> +	  with a thermal sensor that allows checking CPU temperature. This
> +	  driver provides support for it.
> diff --git a/drivers/thermal/broadcom/Makefile b/drivers/thermal/broadcom=
/Makefile
> new file mode 100644
> index 000000000000..059df9a0ed69
> --- /dev/null
> +++ b/drivers/thermal/broadcom/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_BCM_NS_THERMAL)		+=3D ns-thermal.o
> diff --git a/drivers/thermal/broadcom/ns-thermal.c b/drivers/thermal/broa=
dcom/ns-thermal.c
> new file mode 100644
> index 000000000000..eab96b3572b9
> --- /dev/null
> +++ b/drivers/thermal/broadcom/ns-thermal.c
> @@ -0,0 +1,105 @@
> +/*
> + * Copyright (C) 2017 Rafa=C5=82 Mi=C5=82ecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/thermal.h>
> +
> +#define PVTMON_CONTROL0					0x00
> +#define PVTMON_CONTROL0_SEL_MASK			0x0000000e
> +#define PVTMON_CONTROL0_SEL_TEMP_MONITOR		0x00000000
> +#define PVTMON_CONTROL0_SEL_TEST_MODE			0x0000000e
> +#define PVTMON_STATUS					0x08
> +
> +struct ns_thermal {
> +	struct thermal_zone_device *tz;
> +	void __iomem *pvtmon;
> +};
> +
> +static int ns_thermal_get_temp(void *data, int *temp)
> +{
> +	struct ns_thermal *ns_thermal =3D data;
> +	int offset =3D thermal_zone_get_offset(ns_thermal->tz);
> +	int slope =3D thermal_zone_get_slope(ns_thermal->tz);
> +	u32 val;
> +
> +	val =3D readl(ns_thermal->pvtmon + PVTMON_CONTROL0);
> +	if ((val & PVTMON_CONTROL0_SEL_MASK) !=3D PVTMON_CONTROL0_SEL_TEMP_MONI=
TOR) {
> +		/* Clear current mode selection */
> +		val &=3D ~PVTMON_CONTROL0_SEL_MASK;
> +
> +		/* Set temp monitor mode (it's the default actually) */
> +		val |=3D PVTMON_CONTROL0_SEL_TEMP_MONITOR;
> +
> +		writel(val, ns_thermal->pvtmon + PVTMON_CONTROL0);
> +	}
> +
> +	val =3D readl(ns_thermal->pvtmon + PVTMON_STATUS);
> +	*temp =3D slope * val + offset;
> +
> +	return 0;
> +}
> +
> +const struct thermal_zone_of_device_ops ns_thermal_ops =3D {

minor correction here:

-const struct thermal_zone_of_device_ops ns_thermal_ops =3D {
+static const struct thermal_zone_of_device_ops ns_thermal_ops =3D {

but I am applying this already in my tree.

> +	.get_temp =3D ns_thermal_get_temp,
> +};
> +
> +static int ns_thermal_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct ns_thermal *ns_thermal;
> +
> +	ns_thermal =3D devm_kzalloc(dev, sizeof(*ns_thermal), GFP_KERNEL);
> +	if (!ns_thermal)
> +		return -ENOMEM;
> +
> +	ns_thermal->pvtmon =3D of_iomap(dev_of_node(dev), 0);
> +	if (WARN_ON(!ns_thermal->pvtmon))
> +		return -ENOENT;
> +
> +	ns_thermal->tz =3D devm_thermal_zone_of_sensor_register(dev, 0,
> +							      ns_thermal,
> +							      &ns_thermal_ops);
> +	if (IS_ERR(ns_thermal->tz)) {
> +		iounmap(ns_thermal->pvtmon);
> +		return PTR_ERR(ns_thermal->tz);
> +	}
> +
> +	platform_set_drvdata(pdev, ns_thermal);
> +
> +	return 0;
> +}
> +
> +static int ns_thermal_remove(struct platform_device *pdev)
> +{
> +	struct ns_thermal *ns_thermal =3D platform_get_drvdata(pdev);
> +
> +	iounmap(ns_thermal->pvtmon);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ns_thermal_of_match[] =3D {
> +	{ .compatible =3D "brcm,ns-thermal", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ns_thermal_of_match);
> +
> +static struct platform_driver ns_thermal_driver =3D {
> +	.probe		=3D ns_thermal_probe,
> +	.remove		=3D ns_thermal_remove,
> +	.driver =3D {
> +		.name =3D "ns-thermal",
> +		.of_match_table =3D ns_thermal_of_match,
> +	},
> +};
> +module_platform_driver(ns_thermal_driver);
> +
> +MODULE_DESCRIPTION("Northstar thermal driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.11.0
>=20

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY5xifAAoJEA6VkvSQfF5TvQwQAIHgL6xMaBGw3GTJ2N2o7jaN
X0jRIrReIyiHuPeumowTie2coavGOfgjr6RATlEn5GoSFEC6U3lLI9D2pcPiuv9D
+9erYFVC2bo2pUiTYoHexP2f6QTErHBToEKs15nbQEThL4I+vi77fNRBH4wCuYxK
7Y+Q1auLVP9S1GWpo6qQ2Zv0tOYIxn6XVuIFjOF1rt0ndY2hdFsB7dfmN43jtpGl
yct14Fh4i2lk/NzuQQeVoW2qUk8K3+yKjcmgUSiW0lKpqpme1OxpSnXfhAe3SZfo
HV2f1DkvGUf1tNoB2gIWfin84hf5nrfskrwaa5/7ukjJl+RNwOwzyyzpL2AWBaZV
UJKOllNYJ1UDWJoeaknfuVsqflDd+cyU23Xzch43a7JMmRaNJq78/GB2U6tDcrIP
SUVmBSMToPisH3psIyOSq6teiQsNDxQMpOODt07Bkr/4T+PF06J7f45hacb6mtMu
HhFYDQ+cIThTfm/u9tVIEolampQlWYC4RwBCw/vdz7/wfSNcCzwLmg+S/1rGyAPm
kTMmqTkOkmbIcKIUYJVQJ7NWCOuiA8ZlVvZocLdTISE8ouzeyW3WK7dGBpo+EiI7
iW2w0sBx1+UkhzAJqKJy/EaO0TxZumKDC4SwALr6ObNigb+G/nzIpkgcbOXJj3yS
aPg9wU0wcp8gqLRXtjvA
=Er5s
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
