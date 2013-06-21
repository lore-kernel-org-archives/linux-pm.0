From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH v3] thermal: add imx thermal driver support
Date: Fri, 21 Jun 2013 12:45:54 -0400
Message-ID: <51C48342.2060303@ti.com>
References: <1371816567-22821-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2VDDRODMLLSBSJAGDEHSJ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51567 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161513Ab3FUQq0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 21 Jun 2013 12:46:26 -0400
In-Reply-To: <1371816567-22821-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-arm-kernel@lists.infradead.org

------enig2VDDRODMLLSBSJAGDEHSJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 21-06-2013 08:09, Shawn Guo wrote:
> This is based on the initial imx thermal work done by
> Rob Lee <rob.lee@linaro.org> (Not sure if the email address is still
> valid).  Since he is no longer interested in the work and I have
> rewritten a significant amount of the code, I just took the authorship
> over from him.
>=20
> It adds the imx thermal support using Temperature Monitor (TEMPMON)
> block found on some Freescale i.MX SoCs.  The driver uses syscon regmap=

> interface to access TEMPMON control registers and calibration data, and=

> supports cpufreq as the cooling device.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Changes since v2:
>  * Improve binding doc and Kconfig help text
>  * Use a safer polling interval
>  * Change 1ms sleep to 50 us in imx_get_temp() call
>  * Give it a wait instead of shutting the ongoing measurement in suspen=
d
>  * Use module_platform_driver()

Thanks!

It follows very minor change requests (most typos).


>=20
>  .../devicetree/bindings/thermal/imx-thermal.txt    |   17 +
>  drivers/thermal/Kconfig                            |   11 +
>  drivers/thermal/Makefile                           |    1 +
>  drivers/thermal/imx_thermal.c                      |  397 ++++++++++++=
++++++++
>  4 files changed, 426 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/imx-therm=
al.txt
>  create mode 100644 drivers/thermal/imx_thermal.c
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt =
b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> new file mode 100644
> index 0000000..541c25e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> @@ -0,0 +1,17 @@
> +* Temperature Monitor (TEMPMON) on Freescale i.MX SoCs
> +
> +Required properties:
> +- compatible : "fsl,imx6q-thermal"
> +- fsl,tempmon : phandle pointer to system controller that contains TEM=
PMON
> +  control registers, e.g. ANATOP on imx6q.
> +- fsl,tempmon-data : phandle pointer to fuse controller that contains =
TEMPMON
> +  calibration data, e.g. OCOTP on imx6q.  The details about calibratio=
n data
> +  can be found in SoC Reference Manual.
> +
> +Example:
> +
> +tempmon {
> +	compatible =3D "fsl,imx6q-tempmon";
> +	fsl,tempmon =3D <&anatop>;
> +	fsl,tempmon-data =3D <&ocotp>;
> +};
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index b13c2bc..22a702e 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -91,6 +91,17 @@ config THERMAL_EMULATION
>  	  because userland can easily disable the thermal policy by simply
>  	  flooding this sysfs node with low temperature values.
> =20
> +config IMX_THERMAL
> +	tristate "Temperature sensor driver for Freescale i.MX SoCs"
> +	depends on CPU_THERMAL
> +	depends on MFD_SYSCON
> +	depends on OF
> +	help
> +	  Support for Temperature Monitor (TEMPMON) found on Freescale i.MX S=
oCs.
> +	  It supports one critical trip point and one passive trip point.  Th=
e
> +	  cpufreq is used as the cooling device to throttle CPUs when the
> +	  passive trip is crossed.
> +
>  config SPEAR_THERMAL
>  	bool "SPEAr thermal sensor driver"
>  	depends on PLAT_SPEAR
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 67184a2..dff19c6 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_EXYNOS_THERMAL)	+=3D exynos_thermal.o
>  obj-$(CONFIG_DOVE_THERMAL)  	+=3D dove_thermal.o
>  obj-$(CONFIG_DB8500_THERMAL)	+=3D db8500_thermal.o
>  obj-$(CONFIG_ARMADA_THERMAL)	+=3D armada_thermal.o
> +obj-$(CONFIG_IMX_THERMAL)	+=3D imx_thermal.o
>  obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+=3D db8500_cpufreq_cooling.o
>  obj-$(CONFIG_INTEL_POWERCLAMP)	+=3D intel_powerclamp.o
>  obj-$(CONFIG_X86_PKG_TEMP_THERMAL)	+=3D x86_pkg_temp_thermal.o
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_therma=
l.c
> new file mode 100644
> index 0000000..4045850
> --- /dev/null
> +++ b/drivers/thermal/imx_thermal.c
> @@ -0,0 +1,397 @@
> +/*
> + * Copyright 2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/cpu_cooling.h>
> +#include <linux/cpufreq.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +#include <linux/types.h>
> +
> +#define REG_SET		0x4
> +#define REG_CLR		0x8
> +#define REG_TOG		0xc
> +
> +#define MISC0				0x0150
> +#define MISC0_REFTOP_SELBIASOFF		(1 << 3)
> +
> +#define TEMPSENSE0			0x0180
> +#define TEMPSENSE0_TEMP_CNT_SHIFT	8
> +#define TEMPSENSE0_TEMP_CNT_MASK	(0xfff << TEMPSENSE0_TEMP_CNT_SHIFT)
> +#define TEMPSENSE0_FINISHED		(1 << 2)
> +#define TEMPSENSE0_MEASURE_TEMP		(1 << 1)
> +#define TEMPSENSE0_POWER_DOWN		(1 << 0)
> +
> +#define TEMPSENSE1			0x0190
> +#define TEMPSENSE1_MEASURE_FREQ		0xffff
> +
> +#define OCOTP_ANA1			0x04e0
> +
> +/* The driver supports 1 passive trip point and 1 critical trip point =
*/
> +enum imx_thermal_trip {
> +	IMX_TRIP_PASSIVE,
> +	IMX_TRIP_CRITICAL,
> +	IMX_TRIP_NUM,
> +};
> +
> +/*
> + * It defines the temperature in millicelsius for passive trip point
> + * that will trigger cooling action when crossed.
> + */
> +#define IMX_TEMP_PASSIVE		85000
> +
> +/*
> + * The maximum die temperature on imx parts is 105C, let's give some c=
ushion
> + * for noise and possible temperature rise between measurements.
> + */
> +#define IMX_TEMP_CRITICAL		100000
> +
> +#define IMX_POLLING_DELAY		2000 /* millisecond */
> +#define IMX_PASSIVE_DELAY		1000
> +
> +struct imx_thermal_data {
> +	struct thermal_zone_device *tz;
> +	struct thermal_cooling_device *cdev;
> +	enum thermal_device_mode mode;
> +	struct regmap *tempmon;
> +	int c1, c2; /* See forumla in imx_get_sensor_data() */

s/forumla/formula/g (there are more occurrences of same typo)

> +};
> +
> +static int imx_get_temp(struct thermal_zone_device *tz, unsigned long =
*temp)
> +{
> +	struct imx_thermal_data *data =3D tz->devdata;
> +	struct regmap *map =3D data->tempmon;
> +	static unsigned long last_temp;
> +	unsigned int n_meas;
> +	u32 val;
> +
> +	/*
> +	 * Every time we measure the temperature, we will power on the
> +	 * temperature sensor, enable measurements, take a reading,
> +	 * disable measurements, power off the temperature sensor.
> +	 */
> +	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
> +	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
> +
> +	/*
> +	 * According to the temp sensor designers, it may require up to ~17us=

> +	 * to complete a measurement.
> +	 */
> +	usleep_range(20, 50);
> +
> +	regmap_read(map, TEMPSENSE0, &val);
> +	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
> +	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
> +
> +	if ((val & TEMPSENSE0_FINISHED) =3D=3D 0) {
> +		dev_dbg(&tz->device, "temp measurement never finished\n");
> +		return -EAGAIN;
> +	}
> +
> +	n_meas =3D (val & TEMPSENSE0_TEMP_CNT_MASK) >> TEMPSENSE0_TEMP_CNT_SH=
IFT;
> +
> +	/* See imx_get_sensor_data() for forumla derivation */
> +	*temp =3D data->c2 + data->c1 * n_meas;
> +
> +	if (*temp !=3D last_temp) {
> +		dev_dbg(&tz->device, "millicelsius: %ld\n", *temp);
> +		last_temp =3D *temp;
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx_get_mode(struct thermal_zone_device *tz,
> +			enum thermal_device_mode *mode)
> +{
> +	struct imx_thermal_data *data =3D tz->devdata;
> +
> +	*mode =3D data->mode;
> +
> +	return 0;
> +}
> +
> +static int imx_set_mode(struct thermal_zone_device *tz,
> +			enum thermal_device_mode mode)
> +{
> +	struct imx_thermal_data *data =3D tz->devdata;
> +
> +	if (mode =3D=3D THERMAL_DEVICE_ENABLED) {
> +		tz->polling_delay =3D IMX_POLLING_DELAY;
> +		tz->passive_delay =3D IMX_PASSIVE_DELAY;
> +	} else {
> +		tz->polling_delay =3D 0;
> +		tz->passive_delay =3D 0;
> +	}
> +
> +	data->mode =3D mode;
> +	thermal_zone_device_update(tz);
> +
> +	return 0;
> +}
> +
> +static int imx_get_trip_type(struct thermal_zone_device *tz, int trip,=

> +			     enum thermal_trip_type *type)
> +{
> +	*type =3D (trip =3D=3D IMX_TRIP_PASSIVE) ? THERMAL_TRIP_PASSIVE :
> +					     THERMAL_TRIP_CRITICAL;
> +	return 0;
> +}
> +
> +static int imx_get_crit_temp(struct thermal_zone_device *tz,
> +			     unsigned long *temp)
> +{
> +	*temp =3D IMX_TEMP_CRITICAL;
> +	return 0;
> +}
> +
> +static int imx_get_trip_temp(struct thermal_zone_device *tz, int trip,=

> +			     unsigned long *temp)
> +{
> +	*temp =3D (trip =3D=3D IMX_TRIP_PASSIVE) ? IMX_TEMP_PASSIVE :
> +					     IMX_TEMP_CRITICAL;
> +	return 0;
> +}
> +
> +static int imx_bind(struct thermal_zone_device *tz,
> +		    struct thermal_cooling_device *cdev)
> +{
> +	int ret;
> +
> +	ret =3D thermal_zone_bind_cooling_device(tz, IMX_TRIP_PASSIVE, cdev,
> +					       THERMAL_NO_LIMIT,
> +					       THERMAL_NO_LIMIT);

Remember that if you ever add another cdev in your system, you will be
blindly bind it to your tz.

> +	if (ret) {
> +		dev_err(&tz->device,
> +			"binding zone %s with cdev %s failed:%d\n",
> +			tz->type, cdev->type, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx_unbind(struct thermal_zone_device *tz,
> +		      struct thermal_cooling_device *cdev)
> +{
> +	int ret;
> +
> +	ret =3D thermal_zone_unbind_cooling_device(tz, IMX_TRIP_PASSIVE, cdev=
);
> +	if (ret) {
> +		dev_err(&tz->device,
> +			"unbinding zone %s with cdev %s failed:%d\n",
> +			tz->type, cdev->type, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_device_ops imx_tz_ops =3D {
> +	.bind =3D imx_bind,
> +	.unbind =3D imx_unbind,
> +	.get_temp =3D imx_get_temp,
> +	.get_mode =3D imx_get_mode,
> +	.set_mode =3D imx_set_mode,
> +	.get_trip_type =3D imx_get_trip_type,
> +	.get_trip_temp =3D imx_get_trip_temp,
> +	.get_crit_temp =3D imx_get_crit_temp,
> +};
> +
> +static int imx_get_sensor_data(struct platform_device *pdev)
> +{
> +	struct imx_thermal_data *data =3D platform_get_drvdata(pdev);
> +	struct regmap *map;
> +	int t1, t2, n1, n2;
> +	int ret;
> +	u32 val;
> +
> +	map =3D syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +					      "fsl,tempmon-data");
> +	if (IS_ERR(map)) {
> +		ret =3D PTR_ERR(map);
> +		dev_err(&pdev->dev, "failed to get sensor regmap: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D regmap_read(map, OCOTP_ANA1, &val);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to read sensor data: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (val =3D=3D 0 || val =3D=3D ~0) {
> +		dev_err(&pdev->dev, "invalid sensor calibration data\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Sensor data layout:
> +	 *   [31:20] - sensor value @ 25C
> +	 *    [19:8] - sensor value of hot
> +	 *     [7:0] - hot temperature value
> +	 */
> +	n1 =3D val >> 20;
> +	n2 =3D (val & 0xfff00) >> 8;
> +	t2 =3D val & 0xff;
> +	t1 =3D 25; /* t1 always 25C */

don't the above constants deserve #define macros?

> +
> +	/*
> +	 * Derived from linear interpolation,
> +	 * Tmeas =3D T2 + (Nmeas - N2) * (T1 - T2) / (N1 - N2)
> +	 * We want to reduce this down to the minimum computation necessary
> +	 * for each temperature read.  Also, we want Tmeas in millicelsius
> +	 * and we don't want to lose precision from integer division. So...
> +	 * milli_Tmeas =3D 1000 * T2 + 1000 * (Nmeas - N2) * (T1 - T2) / (N1 =
- N2)
> +	 * Let constant c1 =3D 1000 * (T1 - T2) / (N1 - N2)
> +	 * milli_Tmeas =3D (1000 * T2) + c1 * (Nmeas - N2)
> +	 * milli_Tmeas =3D (1000 * T2) + (c1 * Nmeas) - (c1 * N2)
> +	 * Let constant c2 =3D (1000 * T2) - (c1 * N2)
> +	 * milli_Tmeas =3D c2 + (c1 * Nmeas)
> +	 */
> +	data->c1 =3D 1000 * (t1 - t2) / (n1 - n2);
> +	data->c2 =3D 1000 * t2 - data->c1 * n2;
> +
> +	return 0;
> +}
> +
> +static int imx_thermal_probe(struct platform_device *pdev)
> +{
> +	struct imx_thermal_data *data;
> +	struct cpumask clip_cpus;
> +	struct regmap *map;
> +	int ret;
> +
> +	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	map =3D syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "fsl,tempm=
on");
> +	if (IS_ERR(map)) {
> +		ret =3D PTR_ERR(map);
> +		dev_err(&pdev->dev, "failed to get tempmon regmap: %d\n", ret);
> +		return ret;
> +	}
> +	data->tempmon =3D map;
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	ret =3D imx_get_sensor_data(pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to get sensor data\n");
> +		return ret;
> +	}
> +
> +	/* Make sure sensor is in known good state for measurements */
> +	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
> +	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
> +	regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
> +	regmap_write(map, MISC0 + REG_SET, MISC0_REFTOP_SELBIASOFF);
> +	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
> +
> +	cpumask_set_cpu(0, &clip_cpus);
> +	data->cdev =3D cpufreq_cooling_register(&clip_cpus);
> +	if (IS_ERR(data->cdev)) {
> +		ret =3D PTR_ERR(data->cdev);
> +		dev_err(&pdev->dev,
> +			"failed to register cpufreq cooling device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	data->tz =3D thermal_zone_device_register("imx_thermal_zone",
> +						IMX_TRIP_NUM, 0, data,
> +						&imx_tz_ops, NULL,
> +						IMX_PASSIVE_DELAY,
> +						IMX_POLLING_DELAY);
> +	if (IS_ERR(data->tz)) {
> +		ret =3D PTR_ERR(data->tz);
> +		dev_err(&pdev->dev,
> +			"failed to register thermal zone device %d\n", ret);
> +		cpufreq_cooling_unregister(data->cdev);
> +		return ret;
> +	}
> +
> +	data->mode =3D THERMAL_DEVICE_ENABLED;
> +
> +	return 0;
> +}
> +
> +static int imx_thermal_remove(struct platform_device *pdev)
> +{
> +	struct imx_thermal_data *data =3D platform_get_drvdata(pdev);
> +
> +	thermal_zone_device_unregister(data->tz);
> +	cpufreq_cooling_unregister(data->cdev);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int imx_thermal_suspend(struct device *dev)
> +{
> +	struct imx_thermal_data *data =3D dev_get_drvdata(dev);
> +	struct regmap *map =3D data->tempmon;
> +	u32 val;
> +
> +	regmap_read(map, TEMPSENSE0, &val);
> +	if ((val & TEMPSENSE0_POWER_DOWN) =3D=3D 0) {
> +		/*
> +		 * If a measurement is taking place, wait for a long enough
> +		 * time for it to finish, and then check again.  If it still
> +		 * does not finish, something must go wrong.
> +		 */
> +		udelay(50);
> +		regmap_read(map, TEMPSENSE0, &val);
> +		if ((val & TEMPSENSE0_POWER_DOWN) =3D=3D 0)
> +			return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx_thermal_resume(struct device *dev)
> +{
> +	/* Nothing to do for now */
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(imx_thermal_pm_ops,
> +			 imx_thermal_suspend, imx_thermal_resume);
> +
> +static const struct of_device_id of_imx_thermal_match[] =3D {
> +	{ .compatible =3D "fsl,imx6q-tempmon", },
> +	{ /* end */ }
> +};
> +
> +static struct platform_driver imx_thermal =3D {
> +	.driver =3D {
> +		.name	=3D "imx_thermal",
> +		.owner  =3D THIS_MODULE,
> +		.pm	=3D &imx_thermal_pm_ops,
> +		.of_match_table =3D of_imx_thermal_match,
> +	},
> +	.probe		=3D imx_thermal_probe,
> +	.remove		=3D imx_thermal_remove,
> +};
> +module_platform_driver(imx_thermal);
> +
> +MODULE_AUTHOR("Freescale Semiconductor, Inc.");
> +MODULE_DESCRIPTION("Thermal driver for Freescale i.MX SoCs");
> +MODULE_LICENSE("GPL");

GPLv2, accordingly to your header.

> +MODULE_ALIAS("platform:imx-thermal");
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2VDDRODMLLSBSJAGDEHSJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlHEg0IACgkQCXcVR3XQvP33HgEAxvJlu7HWPsOi6Gp6zVvQZbaM
Jx64Ij3BRayD25fdPxsA/04gUt03wsvaydgPIXuHKBksA0MboobUpANXkMKtLZ00
=U4fD
-----END PGP SIGNATURE-----

------enig2VDDRODMLLSBSJAGDEHSJ--
