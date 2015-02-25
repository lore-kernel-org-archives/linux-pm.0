From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [v3 1/2] thermal: Add qcom tsens thermal sensor driver
Date: Wed, 25 Feb 2015 15:44:05 -0400
Message-ID: <20150225194403.GC2983@developer.amazonguestwifi.org>
References: <1424760442-12564-1-git-send-email-nrajan@codeaurora.org>
 <1424760442-12564-2-git-send-email-nrajan@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:39709 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbbBYToL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Feb 2015 14:44:11 -0500
Content-Disposition: inline
In-Reply-To: <1424760442-12564-2-git-send-email-nrajan@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Narendran Rajan <nrajan@codeaurora.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux ARM MSM <linux-arm-msm@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Siddartha Mohanadoss <smohanad@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2015 at 10:47:21PM -0800, Narendran Rajan wrote:
> TSENS supports reading temperature from multiple thermal
> sensors present in QCOM SOCs.
> TSENS HW is enabled only when the main sensor is requested.
> TSENS block is disabled if the main senors is disabled
> irrespective of any other sensors that are being enabled
>=20
> The driver needs calibration data which is read from qfprom.
> Calibration data location is configured through dt files.
>=20
> Based on code by Siddartha Mohanadoss and Stephen Boyd.
>=20
> Cc: Siddartha Mohanadoss <smohanad@codeaurora.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Narendran Rajan <nrajan@codeaurora.org>
> ---
>  .../devicetree/bindings/thermal/qcom-thermal.txt   |  59 +++
>  drivers/thermal/Kconfig                            |  14 +
>  drivers/thermal/Makefile                           |   1 +
>  drivers/thermal/qcom-tsens.c                       | 493 +++++++++++++++=
++++++
>  4 files changed, 567 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-therma=
l.txt
>  create mode 100644 drivers/thermal/qcom-tsens.c
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-thermal.txt b=
/Documentation/devicetree/bindings/thermal/qcom-thermal.txt
> new file mode 100644
> index 0000000..d513043
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qcom-thermal.txt
> @@ -0,0 +1,59 @@
> +* QCOM SoC Temperature Sensor (TSENS)

Can you please add a brief description of this device and maybe a
pointer/reference to its documentation?


What are the current QCOM SoC supported? Or in which SoCs should we
expect to see TSENS in?

> +
> +Required properties:
> +- compatible : "qcom,qcom-tsens"
> +- qcom,tsens-slopes : Must contain slope value for each of the sensors c=
ontrolled
> +			by this device
> +- qcom,qfprom : An array of triplets containing tsens calibration data.
> +		The first element in the triplet is a phandle
> +                to qfprom compatible node, second element is an offset t=
o calibration
> +                data within this node, third element indicates size of c=
alibration
> +                data. In general, there would be two elements in this ar=
ray - the
> +                first containing information on primary calibration data
> +                and second containing information on backup calibration =
data
> +- qcom,qfprom-names : Names for each calibration data
> +- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a descripti=
on.
> +
> +Example:
> +
> +tsens: tsens-msm8960 {
> +		compatible =3D "qcom,qcom-tsens";
> +		qcom,tsens-slopes =3D <1176 1176 1154 1176 1111
> +				1132 1132 1199 1132 1199
> +				1132>;

Please use the thermal zone coefficients property here. Describing
slopes is possible with current thermal.txt descriptors.



> +		qcom,qfprom =3D <&imem 0x400 11>, <&imem 0x410 11>;
> +		qcom,qfprom-names =3D "calib", "backup_calib";
> +		#thermal-sensor-cells =3D <1>;
> +	};
> +
> +Example: referring to thermal sensors:
> +thermal-zones {
> +	cpu_thermal: cpu_thermal {
> +		polling-delay-passive =3D <1000>; /* milliseconds */
> +		polling-delay =3D <5000>; /* milliseconds */
> +
> +		/* sensor ID */
> +		thermal-sensors =3D <&tsens 1>;
> +
> +		trips {
> +			cpu_alert0: cpu_alert {
> +				temperature =3D <80000>; /* millicelsius */
> +				hysteresis =3D <2000>; /* millicelsius */
> +				type =3D "passive";
> +			};
> +			cpu_crit: cpu_crit {
> +				temperature =3D <120000>; /* millicelsius */
> +				hysteresis =3D <2000>; /* millicelsius */
> +				type =3D "critical";
> +			};
> +		};
> +
> +		cooling-maps {
> +			map0 {
> +				trip =3D <&cpu_alert0>;
> +				cooling-device =3D
> +					<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +			};
> +		};
> +	};
> +};
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index af40db0..a57f1164 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -285,6 +285,20 @@ config ACPI_THERMAL_REL
>  	tristate
>  	depends on ACPI
> =20
> +config THERMAL_QCOM_TSENS
> +	tristate "Qualcomm Tsens Temperature driver"
> +	depends on THERMAL
> +	depends on ARCH_QCOM
> +	help
> +	  QCOM tsens thermal driver provides support for Temperature sensor
> +	  (TSENS) found on QCOM SoCs. It supports four configurable trip points
> +	  and controls multiple sensors on the SOC. The four trip points are
> +	  common across all sensors present in the SoC. The number of sensors
> +	  present varies from chip to chip and are set through device tree entr=
y.
> +	  The driver presents as a standard thermal zone device with configurab=
le
> +	  trip points and cooling device mapping through standard thermal zone
> +	  device tree.

Should we assume this driver supports all QCOM SoCs?

> +
>  menu "Texas Instruments thermal drivers"
>  source "drivers/thermal/ti-soc-thermal/Kconfig"
>  endmenu
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index fa0dc48..3fdf6b9 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -39,3 +39,4 @@ obj-$(CONFIG_TI_SOC_THERMAL)	+=3D ti-soc-thermal/
>  obj-$(CONFIG_INT340X_THERMAL)  +=3D int340x_thermal/
>  obj-$(CONFIG_ST_THERMAL)	+=3D st/
>  obj-$(CONFIG_TEGRA_SOCTHERM)	+=3D tegra_soctherm.o
> +obj-$(CONFIG_THERMAL_QCOMTSENS)	+=3D qcom-tsens.o
> diff --git a/drivers/thermal/qcom-tsens.c b/drivers/thermal/qcom-tsens.c
> new file mode 100644
> index 0000000..accc6a74
> --- /dev/null
> +++ b/drivers/thermal/qcom-tsens.c
> @@ -0,0 +1,493 @@
> +/* Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/thermal.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/pm.h>
> +#include <linux/bitops.h>
> +#include <linux/regmap.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <soc/qcom/qfprom.h>
> +
> +#define TSENS_CAL_MDEGC                         30000
> +
> +#define TSENS_8960_CONFIG_ADDR                  0x3640
> +#define TSENS_8960_CONFIG                       0x9b
> +#define TSENS_8960_CONFIG_MASK                  0xff
> +
> +#define TSENS_CNTL_ADDR                         0x3620
> +#define TSENS_EN                                BIT(0)
> +#define TSENS_SW_RST                            BIT(1)
> +#define SENSOR0_EN                              BIT(3)
> +#define TSENS_MIN_STATUS_MASK                   BIT(0)
> +#define TSENS_LOWER_STATUS_CLR                  BIT(1)
> +#define TSENS_UPPER_STATUS_CLR                  BIT(2)
> +#define TSENS_MAX_STATUS_MASK                   BIT(3)
> +#define TSENS_8960_MEASURE_PERIOD               BIT(18)
> +#define TSENS_8660_MEASURE_PERIOD               BIT(16)
> +#define TSENS_8960_SLP_CLK_ENA                  BIT(26)
> +#define TSENS_8660_SLP_CLK_ENA                  BIT(24)
> +#define TSENS_8064_STATUS_CNTL                  0x3660
> +
> +#define TSENS_THRESHOLD_ADDR                    0x3624
> +#define TSENS_THRESHOLD_MAX_CODE                0xff
> +#define TSENS_THRESHOLD_MIN_CODE                0
> +#define TSENS_THRESHOLD_MAX_LIMIT_SHIFT         24
> +#define TSENS_THRESHOLD_MIN_LIMIT_SHIFT         16
> +#define TSENS_THRESHOLD_UPPER_LIMIT_SHIFT       8
> +#define TSENS_THRESHOLD_LOWER_LIMIT_SHIFT       0
> +
> +/* Initial temperature threshold values */
> +#define TSENS_LOWER_LIMIT_TH                    0x50
> +#define TSENS_UPPER_LIMIT_TH                    0xdf
> +#define TSENS_MIN_LIMIT_TH                      0x0
> +#define TSENS_MAX_LIMIT_TH                      0xff
> +
> +#define TSENS_S0_STATUS_ADDR                    0x3628
> +
> +#define TSENS_INT_STATUS_ADDR                   0x363c
> +#define TSENS_TRDY_MASK                         BIT(7)
> +
> +#define TSENS_SENSOR0_SHIFT                     3
> +
> +#define TSENS_8660_CONFIG                       1
> +#define TSENS_8660_CONFIG_SHIFT                 28
> +#define TSENS_8660_CONFIG_MASK                  (3 << TSENS_8660_CONFIG_=
SHIFT)
> +#define TSENS_SENSORABOVEFIVE_OFFSET            40
> +
> +struct tsens_device;
> +
> +struct tsens_sensor {
> +	struct thermal_zone_device	*tz_dev;
> +	enum thermal_device_mode	mode;
> +	unsigned int			sensor_num;
> +	int				offset;
> +	int				slope;
> +	struct tsens_device		*tmdev;
> +	u32                             status;
> +};
> +
> +struct tsens_device {
> +	struct device		*dev;
> +	bool			prev_reading_avail;
> +	unsigned int		num_sensors;
> +	int			pm_tsens_thr_data;
> +	int			pm_tsens_cntl;
> +	u32			slp_clk_enable;
> +	struct regmap		*map;
> +	struct regmap_field	*status_field;
> +	struct tsens_sensor	sensor[0];
> +};
> +
> +/* Temperature on y axis and ADC-code on x-axis */
> +static int
> +tsens_tz_code_to_mdegC(u32 adc_code, const struct tsens_sensor *s)
> +{
> +	return s->slope * adc_code + s->offset;
> +}
> +
> +static int tsens_tz_get_temp(void *_sensor,
> +			     long *temp)
> +{
> +	const struct tsens_sensor *tm_sensor =3D _sensor;
> +	struct tsens_device *tmdev =3D tm_sensor->tmdev;
> +	u32 code, trdy;
> +
> +	if (tm_sensor->mode !=3D THERMAL_DEVICE_ENABLED)
> +		return -EINVAL;
> +
> +	if (!tmdev->prev_reading_avail) {
> +		while (!regmap_read(tmdev->map, TSENS_INT_STATUS_ADDR, &trdy) &&
> +		       !(trdy & TSENS_TRDY_MASK))
> +			usleep_range(1000, 1100);
> +		tmdev->prev_reading_avail =3D true;
> +	}
> +
> +	regmap_read(tmdev->map, tm_sensor->status, &code);
> +	*temp =3D tsens_tz_code_to_mdegC(code, tm_sensor);
> +
> +	tmdev->prev_reading_avail =3D false;
> +
> +	dev_dbg(tmdev->dev, "Sensor %d temp is: %ld",
> +		tm_sensor->sensor_num, *temp);
> +	return 0;
> +}
> +
> +/*
> + * If the main sensor is disabled, rest of the sensors are disabled
> + * along with the clock.
> + * If the main sensor is disabled and a sub-sensor is enabled
> + * return with an error.
> + */
> +static int tsens_tz_set_mode(struct tsens_sensor *tm_sensor,
> +			      enum thermal_device_mode mode)
> +{
> +	struct tsens_device *tmdev =3D tm_sensor->tmdev;
> +	unsigned int i, n =3D tmdev->num_sensors;
> +	u32 reg, mask;
> +
> +	if (mode =3D=3D tm_sensor->mode)
> +		return 0;
> +
> +	regmap_read(tmdev->map, TSENS_CNTL_ADDR, &reg);
> +
> +	mask =3D BIT(tm_sensor->sensor_num + TSENS_SENSOR0_SHIFT);
> +	if (mode =3D=3D THERMAL_DEVICE_ENABLED) {
> +		if (!(reg & SENSOR0_EN) && mask !=3D SENSOR0_EN) {
> +			dev_warn(tmdev->dev, "Main sensor not enabled\n");
> +			return -EINVAL;
> +		}
> +
> +		regmap_write(tmdev->map, TSENS_CNTL_ADDR, reg | TSENS_SW_RST);
> +		reg |=3D mask | tmdev->slp_clk_enable | TSENS_EN;
> +
> +		tmdev->prev_reading_avail =3D false;
> +	} else {
> +		reg &=3D ~mask;
> +		if (!(reg & SENSOR0_EN)) {
> +			dev_warn(tmdev->dev, "Main sensor not enabled. Disabling subsensors\n=
");
> +
> +			reg &=3D ~GENMASK(n + TSENS_SENSOR0_SHIFT - 1,
> +					TSENS_SENSOR0_SHIFT);
> +			reg &=3D ~TSENS_EN;
> +
> +			reg &=3D ~tmdev->slp_clk_enable;
> +
> +			/* Disable all sub-sensors */
> +			for (i =3D 1; i < n; i++)
> +				tmdev->sensor[i].mode =3D mode;
> +		}
> +	}
> +
> +	regmap_write(tmdev->map, TSENS_CNTL_ADDR, reg);
> +	tm_sensor->mode =3D mode;
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int tsens_suspend(struct device *dev)
> +{
> +	int i;
> +	unsigned int mask;
> +	struct tsens_device *tmdev =3D dev_get_drvdata(dev);
> +	struct regmap *map =3D tmdev->map;
> +
> +	regmap_read(map, TSENS_THRESHOLD_ADDR, &tmdev->pm_tsens_thr_data);
> +	regmap_read(map, TSENS_CNTL_ADDR, &tmdev->pm_tsens_cntl);
> +
> +	mask =3D tmdev->slp_clk_enable | TSENS_EN;
> +	regmap_update_bits(map, TSENS_CNTL_ADDR, mask, 0);
> +
> +	tmdev->prev_reading_avail =3D false;
> +	for (i =3D 0; i < tmdev->num_sensors; i++)
> +		tmdev->sensor[i].mode =3D THERMAL_DEVICE_DISABLED;
> +
> +	return 0;
> +}
> +
> +static int tsens_resume(struct device *dev)
> +{
> +	int i;
> +	unsigned long reg_cntl;
> +	struct tsens_device *tmdev =3D dev_get_drvdata(dev);
> +	struct regmap *map =3D tmdev->map;
> +
> +	regmap_update_bits(map, TSENS_CNTL_ADDR, TSENS_SW_RST, TSENS_SW_RST);
> +	regmap_field_update_bits(tmdev->status_field,
> +			TSENS_MIN_STATUS_MASK | TSENS_MAX_STATUS_MASK,
> +			TSENS_MIN_STATUS_MASK | TSENS_MAX_STATUS_MASK);
> +
> +	/*
> +	* Separate CONFIG restore is needed only for 8960. For 8660
> +	* config is part of CTRL Addr and its restored as such
> +	*/
> +	if (tmdev->num_sensors > 1)
> +		regmap_update_bits(map, TSENS_8960_CONFIG_ADDR,
> +				TSENS_8960_CONFIG_MASK,
> +				TSENS_8960_CONFIG);
> +
> +	regmap_write(map, TSENS_THRESHOLD_ADDR, tmdev->pm_tsens_thr_data);
> +	regmap_write(map, TSENS_CNTL_ADDR, tmdev->pm_tsens_cntl);
> +
> +	reg_cntl =3D tmdev->pm_tsens_cntl;
> +	reg_cntl >>=3D TSENS_SENSOR0_SHIFT;
> +	for_each_set_bit(i, &reg_cntl, tmdev->num_sensors)
> +		tmdev->sensor[i].mode =3D THERMAL_DEVICE_ENABLED;
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
> +#define TSENS_PM_OPS	(&tsens_pm_ops)
> +
> +#else /* CONFIG_PM_SLEEP */
> +
> +#define TSENS_PM_OPS	NULL
> +
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static void tsens_disable_mode(const struct tsens_device *tmdev)
> +{
> +	u32 reg_cntl;
> +	u32 mask;
> +
> +	mask =3D GENMASK(tmdev->num_sensors - 1, 0);
> +	mask <<=3D TSENS_SENSOR0_SHIFT;
> +	mask |=3D TSENS_EN;
> +
> +	regmap_read(tmdev->map, TSENS_CNTL_ADDR, &reg_cntl);
> +	reg_cntl &=3D ~mask;
> +
> +	reg_cntl &=3D ~tmdev->slp_clk_enable;
> +	regmap_write(tmdev->map, TSENS_CNTL_ADDR, reg_cntl);
> +}
> +
> +static void tsens_hw_init(struct tsens_device *tmdev)
> +{
> +	u32 reg_cntl, reg_thr;
> +
> +	reg_cntl =3D TSENS_SW_RST;
> +	regmap_update_bits(tmdev->map, TSENS_CNTL_ADDR, TSENS_SW_RST, reg_cntl);
> +
> +	if (tmdev->num_sensors > 1) {
> +		reg_cntl |=3D TSENS_8960_SLP_CLK_ENA | TSENS_8960_MEASURE_PERIOD;
> +		reg_cntl &=3D ~TSENS_SW_RST;
> +		regmap_update_bits(tmdev->map, TSENS_8960_CONFIG_ADDR,
> +				   TSENS_8960_CONFIG_MASK, TSENS_8960_CONFIG);
> +		tmdev->slp_clk_enable =3D TSENS_8960_SLP_CLK_ENA;
> +
> +	} else {
> +		reg_cntl |=3D TSENS_8660_SLP_CLK_ENA | TSENS_8660_MEASURE_PERIOD;
> +		reg_cntl &=3D ~TSENS_8660_CONFIG_MASK;
> +		reg_cntl |=3D TSENS_8660_CONFIG << TSENS_8660_CONFIG_SHIFT;
> +		tmdev->slp_clk_enable =3D TSENS_8660_SLP_CLK_ENA;
> +	}
> +
> +	reg_cntl |=3D GENMASK(tmdev->num_sensors - 1, 0) << TSENS_SENSOR0_SHIFT;
> +	regmap_write(tmdev->map, TSENS_CNTL_ADDR, reg_cntl);
> +
> +	regmap_field_update_bits(tmdev->status_field,
> +			TSENS_LOWER_STATUS_CLR | TSENS_UPPER_STATUS_CLR |
> +			TSENS_MIN_STATUS_MASK | TSENS_MAX_STATUS_MASK,
> +			TSENS_LOWER_STATUS_CLR | TSENS_UPPER_STATUS_CLR |
> +			TSENS_MIN_STATUS_MASK | TSENS_MAX_STATUS_MASK);
> +
> +	reg_cntl |=3D TSENS_EN;
> +	regmap_write(tmdev->map, TSENS_CNTL_ADDR, reg_cntl);
> +
> +	reg_thr =3D (TSENS_LOWER_LIMIT_TH << TSENS_THRESHOLD_LOWER_LIMIT_SHIFT)=
 |
> +		(TSENS_UPPER_LIMIT_TH << TSENS_THRESHOLD_UPPER_LIMIT_SHIFT) |
> +		(TSENS_MIN_LIMIT_TH << TSENS_THRESHOLD_MIN_LIMIT_SHIFT) |
> +		(TSENS_MAX_LIMIT_TH << TSENS_THRESHOLD_MAX_LIMIT_SHIFT);
> +	regmap_write(tmdev->map, TSENS_THRESHOLD_ADDR, reg_thr);
> +}
> +
> +static int
> +tsens_calib_sensors(struct tsens_device *tmdev)
> +{
> +	int i;
> +	u8 *byte_data;
> +	u32 num_read;
> +	struct tsens_sensor *s =3D tmdev->sensor;
> +
> +	byte_data =3D devm_qfprom_get_data_byname(tmdev->dev, "calib", &num_rea=
d);
> +
> +	if (IS_ERR(byte_data) || !byte_data[0]
> +		|| num_read !=3D tmdev->num_sensors)
> +		byte_data =3D devm_qfprom_get_data_byname(tmdev->dev,
> +			"backup_calib", &num_read);
> +
> +	if (IS_ERR(byte_data) || !byte_data[0]
> +		|| num_read !=3D tmdev->num_sensors)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < num_read; i++, s++)
> +		s->offset =3D TSENS_CAL_MDEGC - s->slope * byte_data[i];
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops tsens_thermal_of_ops =3D {
> +	.get_temp =3D tsens_tz_get_temp,
> +};
> +
> +static int tsens_register(struct tsens_device *tmdev, int i)
> +{
> +	u32 addr =3D TSENS_S0_STATUS_ADDR;
> +	struct tsens_sensor *s =3D &tmdev->sensor[i];
> +
> +	/*
> +	* The status registers for each sensor are discontiguous
> +	* because some SoCs have 5 sensors while others have more
> +	* but the control registers stay in the same place, i.e.
> +	* directly after the first 5 status registers.
> +	*/
> +	if (i >=3D 5)
> +		addr +=3D TSENS_SENSORABOVEFIVE_OFFSET;
> +
> +	addr +=3D i * 4;
> +
> +	s->mode =3D THERMAL_DEVICE_ENABLED;
> +	s->sensor_num =3D i;
> +	s->status =3D addr;
> +	s->tmdev =3D tmdev;
> +	s->tz_dev =3D thermal_zone_of_sensor_register(tmdev->dev, i, s,
> +					&tsens_thermal_of_ops);
> +
> +	if (IS_ERR(s->tz_dev))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static int tsens_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np =3D pdev->dev.of_node;
> +	int ret, i, num;
> +	struct tsens_sensor *s;
> +	struct tsens_device *tmdev;
> +	struct regmap *map;
> +	struct reg_field *field;
> +	static struct reg_field status_0 =3D {
> +		.reg =3D TSENS_8064_STATUS_CNTL,
> +		.lsb =3D 0,
> +		.msb =3D 3,
> +	};
> +	static struct reg_field status_8 =3D {
> +		.reg =3D TSENS_CNTL_ADDR,
> +		.lsb =3D 8,
> +		.msb =3D 11,
> +	};
> +
> +	num =3D of_property_count_u32_elems(np, "qcom,tsens-slopes");
> +	if (num <=3D 0) {
> +		dev_err(&pdev->dev, "invalid tsens slopes\n");
> +		return -EINVAL;
> +	}
> +
> +	tmdev =3D devm_kzalloc(&pdev->dev, sizeof(*tmdev) +
> +			     num * sizeof(struct tsens_sensor), GFP_KERNEL);
> +	if (tmdev =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	tmdev->dev =3D &pdev->dev;
> +	tmdev->num_sensors =3D num;
> +
> +	for (i =3D 0, s =3D tmdev->sensor; i < num; i++, s++)
> +		of_property_read_u32_index(np, "qcom,tsens-slopes", i,
> +					   &s->slope);
> +
> +	ret =3D tsens_calib_sensors(tmdev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "tsense calibration failed\n");
> +		return ret;
> +	}
> +
> +	tmdev->map =3D map =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!map)
> +		return -ENODEV;
> +
> +	/* Status bits move when the sensor bits next to them overlap */
> +	if (num > 5)
> +		field =3D &status_0;
> +	else
> +		field =3D &status_8;
> +
> +	tmdev->status_field =3D devm_regmap_field_alloc(&pdev->dev, map, *field=
);
> +	if (IS_ERR(tmdev->status_field)) {
> +		dev_err(&pdev->dev, "regmap alloc failed\n");
> +		return PTR_ERR(tmdev->status_field);
> +	}
> +
> +	tsens_hw_init(tmdev);
> +
> +	/*
> +	* Register sensor 0 separately. This sensor is always
> +	* expected to be present and if this fails, thermal
> +	* sensor probe would fail.
> +	* Other sensors are optional and if registration fails
> +	* disable the sensor and continue
> +	*/
> +	ret =3D tsens_register(tmdev, 0);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Registering failed for primary sensor");
> +		ret =3D -ENODEV;
> +		goto fail;
> +	} else {
> +		tsens_tz_set_mode(&tmdev->sensor[0], THERMAL_DEVICE_ENABLED);
> +	}
> +
> +	for (i =3D 1;  i < tmdev->num_sensors; i++) {
> +		ret =3D tsens_register(tmdev, i);
> +
> +		if (ret < 0) {
> +			dev_err(&pdev->dev,
> +				"Registering sensor(%i) failed - disabled", i);
> +			tsens_tz_set_mode(&tmdev->sensor[i],
> +				THERMAL_DEVICE_DISABLED);
> +		} else {
> +			tsens_tz_set_mode(&tmdev->sensor[i],
> +				THERMAL_DEVICE_ENABLED);
> +		}
> +	}
> +
> +	platform_set_drvdata(pdev, tmdev);
> +
> +	return 0;
> +fail:
> +	dev_err(&pdev->dev, "Tsens driver init failed\n");
> +	tsens_disable_mode(tmdev);
> +	return ret;
> +}
> +
> +static int tsens_remove(struct platform_device *pdev)
> +{
> +	int i;
> +	struct tsens_sensor *s;
> +	struct tsens_device *tmdev =3D platform_get_drvdata(pdev);
> +
> +	tsens_disable_mode(tmdev);
> +	for (i =3D 0, s =3D tmdev->sensor; i < tmdev->num_sensors; i++, s++)
> +		thermal_zone_device_unregister(s->tz_dev);
> +
> +	return 0;
> +}
> +
> +static struct of_device_id tsens_match_table[] =3D {
> +	{.compatible =3D "qcom,qcom-tsens"},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, tsens_match_table);
> +
> +static struct platform_driver tsens_driver =3D {
> +	.probe =3D tsens_probe,
> +	.remove =3D tsens_remove,
> +	.driver =3D {
> +		.of_match_table =3D tsens_match_table,
> +		.name =3D "qcom-tsens",
> +		.pm	=3D TSENS_PM_OPS,
> +	},
> +};
> +module_platform_driver(tsens_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("QCOM Temperature Sensor driver");
> +MODULE_ALIAS("platform:qcom-tsens");
> --=20
> Qualcomm Innovation Center, Inc. The Qualcomm Innovation Center, Inc. is =
a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
>=20

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7iX7AAoJEMLUO4d9pOJWgXYIAJKMMFI+j/JVnSQi3vHfB/IO
UdGja+moqSEkiaFjlA8msppxwNwn0SndIjQrRK7zDkKhtEp4uv6OAslRH9HziYJk
AqVJ89N0ksXGWLaUIWxJ+lFAwWJaKYhTKWLCZlbLi2vqS17OFtKkFj3jfxIg+OnW
WFJ2fO2xp8nalmEqHYch8GTnCHOUMb3CgMuHsB4ERvfVd125oDQ5iHr/9+7J44C8
+7A2ZpTjpXztZYLlOs4sevCmPxLWfPOYxtO7g24FT6QQbdiZJAwEeuHmRny5Nprz
2vARIvXfXhaOXOJihkpapSmlBDFwG7K9oUs8FRCcJ6cdKEVT731/ipo7HQBAxys=
=ffB3
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
