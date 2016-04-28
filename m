From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v5 01/11] thermal: qcom: tsens: Add a skeletal TSENS
 drivers
Date: Wed, 27 Apr 2016 17:20:41 -0700
Message-ID: <20160428002040.GA18496@localhost.localdomain>
References: <1460626319-14516-1-git-send-email-rnayak@codeaurora.org>
 <1460626319-14516-2-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35183 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbcD1AUr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 20:20:47 -0400
Content-Disposition: inline
In-Reply-To: <1460626319-14516-2-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, sboyd@codeaurora.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com

On Thu, Apr 14, 2016 at 03:01:49PM +0530, Rajendra Nayak wrote:
> TSENS is Qualcomms' thermal temperature sensor device. It
> supports reading temperatures from multiple thermal sensors
> present on various QCOM SoCs.
> Calibration data is generally read from a non-volatile memory
> (eeprom) device.
> 
> Add a skeleton driver with all the necessary abstractions so
> a variety of qcom device families which support TSENS can
> add driver extensions.
> 
> Also add the required device tree bindings which can be used
> to describe the TSENS device in DT.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  .../devicetree/bindings/thermal/qcom-tsens.txt     |  21 +++
>  drivers/thermal/Kconfig                            |   5 +
>  drivers/thermal/Makefile                           |   1 +
>  drivers/thermal/qcom/Kconfig                       |  11 ++
>  drivers/thermal/qcom/Makefile                      |   2 +
>  drivers/thermal/qcom/tsens-common.c                | 135 ++++++++++++++
>  drivers/thermal/qcom/tsens.c                       | 202 +++++++++++++++++++++
>  drivers/thermal/qcom/tsens.h                       |  90 +++++++++
>  8 files changed, 467 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
>  create mode 100644 drivers/thermal/qcom/Kconfig
>  create mode 100644 drivers/thermal/qcom/Makefile
>  create mode 100644 drivers/thermal/qcom/tsens-common.c
>  create mode 100644 drivers/thermal/qcom/tsens.c
>  create mode 100644 drivers/thermal/qcom/tsens.h
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> new file mode 100644
> index 0000000..292ed89
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> @@ -0,0 +1,21 @@
> +* QCOM SoC Temperature Sensor (TSENS)
> +
> +Required properties:
> +- compatible :
> + - "qcom,msm8916-tsens" : For 8916 Family of SoCs
> + - "qcom,msm8974-tsens" : For 8974 Family of SoCs
> + - "qcom,msm8996-tsens" : For 8996 Family of SoCs
> +
> +- reg: Address range of the thermal registers
> +- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
> +- Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
> +nvmem cells
> +
> +Example:
> +tsens: thermal-sensor@900000 {
> +		compatible = "qcom,msm8916-tsens";
> +		reg = <0x4a8000 0x2000>;
> +		nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
> +		nvmem-cell-names = "caldata", "calsel";
> +		#thermal-sensor-cells = <1>;
> +	};
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index c37eedc..463b00c 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -408,4 +408,9 @@ config QCOM_SPMI_TEMP_ALARM
>  	  real time die temperature if an ADC is present or an estimate of the
>  	  temperature based upon the over temperature stage value.
>  
> +menu "Qualcomm thermal drivers"
> +depends on (ARCH_QCOM && OF) || COMPILE_TEST
> +source "drivers/thermal/qcom/Kconfig"
> +endmenu
> +
>  endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 8e9cbc3..3f3e72c 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
>  obj-$(CONFIG_INT340X_THERMAL)  += int340x_thermal/
>  obj-$(CONFIG_INTEL_PCH_THERMAL)	+= intel_pch_thermal.o
>  obj-$(CONFIG_ST_THERMAL)	+= st/
> +obj-$(CONFIG_QCOM_TSENS)	+= qcom/
>  obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra_soctherm.o
>  obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
>  obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> new file mode 100644
> index 0000000..be32e5a
> --- /dev/null
> +++ b/drivers/thermal/qcom/Kconfig
> @@ -0,0 +1,11 @@
> +config QCOM_TSENS
> +	tristate "Qualcomm TSENS Temperature Alarm"
> +	depends on THERMAL
> +	depends on QCOM_QFPROM
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	help
> +	  This enables the thermal sysfs driver for the TSENS device. It shows
> +	  up in Sysfs as a thermal zone with multiple trip points. Disabling the
> +	  thermal zone device via the mode file results in disabling the sensor.
> +	  Also able to set threshold temperature for both hot and cold and update
> +	  when a threshold is reached.
> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
> new file mode 100644
> index 0000000..2e800c5
> --- /dev/null
> +++ b/drivers/thermal/qcom/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
> +qcom_tsens-y			+= tsens.o tsens-common.o
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> new file mode 100644
> index 0000000..4bffbc1
> --- /dev/null
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -0,0 +1,135 @@
> +/*
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
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
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include "tsens.h"
> +
> +#define S0_ST_ADDR		0x1030
> +#define SN_ADDR_OFFSET		0x4
> +#define SN_ST_TEMP_MASK		0x3ff
> +#define CAL_DEGC_PT1		30
> +#define CAL_DEGC_PT2		120
> +#define SLOPE_FACTOR		1000
> +#define SLOPE_DEFAULT		3200
> +
> +char *qfprom_read(struct device *dev, const char *cname)
> +{
> +	struct nvmem_cell *cell;
> +	ssize_t data;
> +	char *ret;
> +
> +	cell = nvmem_cell_get(dev, cname);
> +	if (IS_ERR(cell))
> +		return ERR_CAST(cell);
> +
> +	ret = nvmem_cell_read(cell, &data);
> +	nvmem_cell_put(cell);
> +
> +	return ret;
> +}
> +
> +void compute_intercept_slope(struct tsens_device *tmdev, u32 *p1,
> +			     u32 *p2, u32 mode)
> +{

Could you please add a comment explaining the cases that this function
is used instead of tz->tzp->slope,offset?

> +	int i;
> +	int num, den;
> +
> +	for (i = 0; i < tmdev->num_sensors; i++) {
> +		dev_dbg(tmdev->dev,
> +			"sensor%d - data_point1:%#x data_point2:%#x\n",
> +			i, p1[i], p2[i]);
> +
> +		tmdev->sensor[i].slope = SLOPE_DEFAULT;
> +		if (mode == TWO_PT_CALIB) {
> +			/*
> +			 * slope (m) = adc_code2 - adc_code1 (y2 - y1)/
> +			 *	temp_120_degc - temp_30_degc (x2 - x1)
> +			 */
> +			num = p2[i] - p1[i];
> +			num *= SLOPE_FACTOR;
> +			den = CAL_DEGC_PT2 - CAL_DEGC_PT1;
> +			tmdev->sensor[i].slope = num / den;
> +		}
> +
> +		tmdev->sensor[i].offset = (p1[i] * SLOPE_FACTOR) -
> +				(CAL_DEGC_PT1 *
> +				tmdev->sensor[i].slope);
> +		dev_dbg(tmdev->dev, "offset:%d\n", tmdev->sensor[i].offset);
> +	}
> +}
> +
> +static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
> +{
> +	int degc, num, den;
> +
> +	num = (adc_code * SLOPE_FACTOR) - s->offset;
> +	den = s->slope;
> +
> +	if (num > 0)
> +		degc = num + (den / 2);
> +	else if (num < 0)
> +		degc = num - (den / 2);
> +	else
> +		degc = num;
> +
> +	degc /= den;
> +
> +	return degc;
> +}
> +
> +int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
> +{
> +	struct tsens_sensor *s = &tmdev->sensor[id];
> +	u32 code;
> +	unsigned int sensor_addr;
> +	int last_temp = 0, ret;
> +
> +	sensor_addr = S0_ST_ADDR + s->hw_id * SN_ADDR_OFFSET;
> +	ret = regmap_read(tmdev->map, sensor_addr, &code);
> +	if (ret)
> +		return ret;
> +	last_temp = code & SN_ST_TEMP_MASK;
> +
> +	*temp = code_to_degc(last_temp, s) * 1000;
> +
> +	return 0;
> +}
> +
> +static const struct regmap_config tsens_config = {
> +	.reg_bits	= 32,
> +	.val_bits	= 32,
> +	.reg_stride	= 4,
> +};
> +
> +int __init init_common(struct tsens_device *tmdev)
> +{
> +	void __iomem *base;
> +
> +	base = of_iomap(tmdev->dev->of_node, 0);
> +	if (IS_ERR(base))
> +		return -EINVAL;
> +
> +	tmdev->map = devm_regmap_init_mmio(tmdev->dev, base, &tsens_config);
> +	if (!tmdev->map) {
> +		iounmap(base);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> new file mode 100644
> index 0000000..e799182
> --- /dev/null
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -0,0 +1,202 @@
> +/*
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
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
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +#include "tsens.h"
> +
> +static int tsens_get_temp(void *data, int *temp)
> +{
> +	const struct tsens_sensor *s = data;
> +	struct tsens_device *tmdev = s->tmdev;
> +
> +	return tmdev->ops->get_temp(tmdev, s->id, temp);
> +}
> +
> +static int tsens_get_trend(void *data, long *temp)
> +{
> +	const struct tsens_sensor *s = data;
> +	struct tsens_device *tmdev = s->tmdev;
> +
> +	if (tmdev->ops->get_trend)
> +		return tmdev->ops->get_trend(tmdev, s->id, temp);
> +
> +	return -ENOTSUPP;
> +}
> +
> +static int tsens_suspend(struct device *dev)
> +{
> +	struct tsens_device *tmdev = dev_get_drvdata(dev);
> +
> +	if (tmdev->ops && tmdev->ops->suspend)
> +		return tmdev->ops->suspend(tmdev);
> +
> +	return 0;
> +}
> +
> +static int tsens_resume(struct device *dev)
> +{
> +	struct tsens_device *tmdev = dev_get_drvdata(dev);
> +
> +	if (tmdev->ops && tmdev->ops->resume)
> +		return tmdev->ops->resume(tmdev);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
> +
> +static const struct of_device_id tsens_table[] = {
> +	{
> +		.compatible = "qcom,msm8916-tsens",
> +	}, {
> +		.compatible = "qcom,msm8974-tsens",
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, tsens_table);
> +
> +static const struct thermal_zone_of_device_ops tsens_of_ops = {
> +	.get_temp = tsens_get_temp,
> +	.get_trend = tsens_get_trend,
> +};
> +
> +static int tsens_register(struct tsens_device *tmdev)
> +{
> +	int i;
> +	struct thermal_zone_device *tzd;
> +	u32 *hw_id, n = tmdev->num_sensors;
> +
> +	hw_id = devm_kcalloc(tmdev->dev, n, sizeof(u32), GFP_KERNEL);
> +	if (!hw_id)
> +		return -ENOMEM;
> +
> +	for (i = 0;  i < tmdev->num_sensors; i++) {
> +		tmdev->sensor[i].tmdev = tmdev;
> +		tmdev->sensor[i].id = i;
> +		tzd = thermal_zone_of_sensor_register(tmdev->dev, i,
> +						      &tmdev->sensor[i],
> +						      &tsens_of_ops);

How about using the devm_ version of this API?

> +		if (IS_ERR(tzd))
> +			continue;
> +		tmdev->sensor[i].tzd = tzd;
> +		if (tmdev->ops->enable)
> +			tmdev->ops->enable(tmdev, i);
> +	}
> +	return 0;
> +}
> +
> +static int tsens_probe(struct platform_device *pdev)
> +{
> +	int ret, i;
> +	struct device *dev;
> +	struct device_node *np;
> +	struct tsens_sensor *s;
> +	struct tsens_device *tmdev;
> +	const struct tsens_data *data;
> +	const struct of_device_id *id;
> +
> +	if (pdev->dev.of_node)
> +		dev = &pdev->dev;
> +	else
> +		dev = pdev->dev.parent;
> +
> +	np = dev->of_node;
> +
> +	id = of_match_node(tsens_table, np);
> +	if (!id)
> +		return -EINVAL;
> +
> +	data = id->data;
> +
> +	if (data->num_sensors <= 0) {
> +		dev_err(dev, "invalid number of sensors\n");
> +		return -EINVAL;
> +	}
> +
> +	tmdev = devm_kzalloc(dev, sizeof(*tmdev) +
> +			     data->num_sensors * sizeof(*s), GFP_KERNEL);
> +	if (!tmdev)
> +		return -ENOMEM;
> +
> +	tmdev->dev = dev;
> +	tmdev->num_sensors = data->num_sensors;
> +	tmdev->ops = data->ops;
> +	for (i = 0;  i < tmdev->num_sensors; i++) {
> +		if (data->hw_ids)
> +			tmdev->sensor[i].hw_id = data->hw_ids[i];
> +		else
> +			tmdev->sensor[i].hw_id = i;
> +	}
> +
> +	if (!tmdev->ops || !tmdev->ops->init || !tmdev->ops->get_temp)
> +		return -EINVAL;
> +
> +	ret = tmdev->ops->init(tmdev);
> +	if (ret < 0) {
> +		dev_err(dev, "tsens init failed\n");
> +		return ret;
> +	}
> +
> +	if (tmdev->ops->calibrate) {
> +		ret = tmdev->ops->calibrate(tmdev);
> +		if (ret < 0) {
> +			dev_err(dev, "tsens calibration failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = tsens_register(tmdev);
> +
> +	platform_set_drvdata(pdev, tmdev);
> +
> +	return ret;
> +}
> +
> +static int tsens_remove(struct platform_device *pdev)
> +{
> +	int i;
> +	struct tsens_device *tmdev = platform_get_drvdata(pdev);
> +	struct thermal_zone_device *tzd;
> +
> +	if (tmdev->ops->disable)
> +		tmdev->ops->disable(tmdev);
> +
> +	for (i = 0; i < tmdev->num_sensors; i++) {
> +		tzd = tmdev->sensor[i].tzd;
> +		thermal_zone_of_sensor_unregister(&pdev->dev, tzd);
> +	}


> +
> +	return 0;
> +}
> +
> +static struct platform_driver tsens_driver = {
> +	.probe = tsens_probe,
> +	.remove = tsens_remove,
> +	.driver = {
> +		.name = "qcom-tsens",
> +		.pm	= &tsens_pm_ops,
> +		.of_match_table = tsens_table,
> +	},
> +};
> +module_platform_driver(tsens_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("QCOM Temperature Sensor driver");
> +MODULE_ALIAS("platform:qcom-tsens");
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> new file mode 100644
> index 0000000..6f652ed
> --- /dev/null
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -0,0 +1,90 @@
> +/*
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#ifndef __QCOM_TSENS_H__
> +#define __QCOM_TSENS_H__
> +
> +#define ONE_PT_CALIB		0x1
> +#define ONE_PT_CALIB2		0x2
> +#define TWO_PT_CALIB		0x3
> +
> +struct tsens_device;
> +
> +struct tsens_sensor {
> +	struct tsens_device		*tmdev;
> +	struct thermal_zone_device	*tzd;
> +	int				offset;
> +	int				id;
> +	int				hw_id;
> +	u32				slope;
> +	u32				status;
> +};
> +
> +/**
> + * struct tsens_ops - operations as supported by the tsens device
> + * @init: Function to initialize the tsens device
> + * @calibrate: Function to calibrate the tsens device
> + * @get_temp: Function which returns the temp in millidegC
> + * @enable: Function to enable (clocks/power) tsens device
> + * @disable: Function to disable the tsens device
> + * @suspend: Function to suspend the tsens device
> + * @resume: Function to resume the tsens device
> + * @get_trend: Function to get the thermal/temp trend
> + */
> +struct tsens_ops {
> +	/* mandatory callbacks */
> +	int (*init)(struct tsens_device *);
> +	int (*calibrate)(struct tsens_device *);
> +	int (*get_temp)(struct tsens_device *, int, int *);
> +	/* optional callbacks */
> +	int (*enable)(struct tsens_device *, int);
> +	void (*disable)(struct tsens_device *);
> +	int (*suspend)(struct tsens_device *);
> +	int (*resume)(struct tsens_device *);
> +	int (*get_trend)(struct tsens_device *, int, long *);
> +};
> +
> +/**
> + * struct tsens_data - tsens instance specific data
> + * @num_sensors: Max number of sensors supported by platform
> + * @ops: operations the tsens instance supports
> + * @hw_ids: Subset of sensors ids supported by platform, if not the first n
> + */
> +struct tsens_data {
> +	const u32		num_sensors;
> +	const struct tsens_ops	*ops;
> +	unsigned int		*hw_ids;
> +};
> +
> +/* Registers to be saved/restored across a context loss */
> +struct tsens_context {
> +	int	threshold;
> +	int	control;
> +};
> +
> +struct tsens_device {
> +	struct device			*dev;
> +	u32				num_sensors;
> +	struct regmap			*map;
> +	struct regmap_field		*status_field;
> +	struct tsens_context		ctx;
> +	bool				trdy;
> +	const struct tsens_ops		*ops;
> +	struct tsens_sensor		sensor[0];
> +};
> +
> +char *qfprom_read(struct device *, const char *);
> +void compute_intercept_slope(struct tsens_device *, u32 *, u32 *, u32);
> +int init_common(struct tsens_device *);
> +int get_temp_common(struct tsens_device *, int, int *);
> +
> +#endif /* __QCOM_TSENS_H__ */
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
