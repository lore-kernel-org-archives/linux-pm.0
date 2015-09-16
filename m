From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH v2 1/9] thermal: qcom: tsens: Add a skeletal TSENS drivers
Date: Wed, 16 Sep 2015 14:44:55 +0100
Message-ID: <9hh613atr54.fsf@e105922-lin.cambridge.arm.com>
References: <1442384603-26053-1-git-send-email-rnayak@codeaurora.org>
	<1442384603-26053-2-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:54559 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752614AbbIPNpb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2015 09:45:31 -0400
In-Reply-To: <1442384603-26053-2-git-send-email-rnayak@codeaurora.org>
	(Rajendra Nayak's message of "Wed, 16 Sep 2015 11:53:15 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, sboyd@codeaurora.org, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org

Hi Rajendra,

I have some comments on the code below (purely based on code review).

Rajendra Nayak <rnayak@codeaurora.org> writes:

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
>  .../devicetree/bindings/thermal/qcom-tsens.txt     |  36 ++++
>  drivers/thermal/Kconfig                            |   5 +
>  drivers/thermal/Makefile                           |   1 +
>  drivers/thermal/qcom/Kconfig                       |  10 +
>  drivers/thermal/qcom/Makefile                      |   2 +
>  drivers/thermal/qcom/tsens.c                       | 208 +++++++++++++++++++++
>  drivers/thermal/qcom/tsens.h                       |  58 ++++++
>  7 files changed, 320 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
>  create mode 100644 drivers/thermal/qcom/Kconfig
>  create mode 100644 drivers/thermal/qcom/Makefile
>  create mode 100644 drivers/thermal/qcom/tsens.c
>  create mode 100644 drivers/thermal/qcom/tsens.h
>
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> new file mode 100644
> index 0000000..3d54d37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> @@ -0,0 +1,36 @@
> +* QCOM SoC Temperature Sensor (TSENS)
> +
> +Required properties:
> +- compatible :
> + - "qcom,msm8916-tsens" : For 8916 Family of SoCs
> + - "qcom,msm8974-tsens" : For 8974 Family of SoCs
> +
> +- reg: Address range of the thermal registers
> +- qcom,tsens-slopes : Must contain slope value for each of the sensors controlled
> +			by this device
> +- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
> +- Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
> +nvmem cells
> +
> +Optional properties:
> +- qcom,sensor-id: List of sensor instances used in a given SoC. A TSENS IP can
> +		  have a fixed number of sensors (like 11) but a given SoC can
> +		  use only 5 of these and they might not always the first 5. They
> +		  could be sensors 0, 1, 4, 8 and 9. This property is used to
> +		  describe the subset of the sensors used. If this property is
> +		  missing they are assumed to be the first 'n' sensors numbered
> +		  sequentially in which case the number of sensors defaults to
> +		  the number of slope values.
> +
> +Example:
> +tsens: thermal-sensor@900000 {
> +		compatible = "qcom,msm8916-tsens";
> +		qcom,tsens-slopes = <1176 1176 1154 1176 1111
> +				1132 1132 1199 1132 1199
> +				1132>;
> +		nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
> +		nvmem-cell-names = "caldata", "calsel";
> +		qcom,tsens-slopes = <3200 3200 3200 3200 3200>;
> +		qcom,sensor-id = <0 1 2 4 5>;
> +		#thermal-sensor-cells = <1>;
> +	};

The qcom,tsens-slopes property appears twice in the above example.

[...]

> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> new file mode 100644
> index 0000000..9615845
> --- /dev/null
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -0,0 +1,208 @@
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
> +	return -ENOSYS;
> +}
> +
> +#ifdef CONFIG_PM
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
> +#define TSENS_PM_OPS   (&tsens_pm_ops)
> +
> +#else /* CONFIG_PM_SLEEP */
         ^
         
> +#define TSENS_PM_OPS NULL
> +#endif /* CONFIG_PM_SLEEP */
          ^
          
The comments don't match the #ifdef above. I maybe wrong but looking at
other drivers it looks like you don't need the #else part. You should be
able to use the tsens_pm_ops without having to set it to NULL.

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
> +	int i, ret;
> +	struct thermal_zone_device *tzd;
> +	u32 *hw_id, n = tmdev->num_sensors;
> +	struct device_node *np = tmdev->dev->of_node;
> +
> +	hw_id = devm_kcalloc(tmdev->dev, n, sizeof(u32), GFP_KERNEL);
> +	if (!hw_id)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_u32_array(np, "qcom,sensor-id", hw_id, n);
> +	if (ret)
> +		for (i = 0;  i < tmdev->num_sensors; i++)
> +			tmdev->sensor[i].hw_id = i;
> +	else
> +		for (i = 0;  i < tmdev->num_sensors; i++)
> +			tmdev->sensor[i].hw_id = hw_id[i];
> +

You could move the check for vaild for valid sensor ids in the device
tree (ret) inside a single for loop. In that case the loop above could
be merged into the iteration over the sensors below.

> +	for (i = 0;  i < tmdev->num_sensors; i++) {
> +		tmdev->sensor[i].tmdev = tmdev;
> +		tmdev->sensor[i].id = i;
> +		tzd = thermal_zone_of_sensor_register(tmdev->dev, i,
> +						      &tmdev->sensor[i],
> +						      &tsens_of_ops);
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
> +	int ret, i, num;
> +	struct device *dev;
> +	struct device_node *np;
> +	struct tsens_sensor *s;
> +	struct tsens_device *tmdev;
> +	const struct of_device_id *id;
> +
> +	dev = &pdev->dev;
> +	np = dev->of_node;

These assignments can be done with the declaration above.

Thanks,
Punit
> +
> +	num = of_property_count_u32_elems(np, "qcom,tsens-slopes");
> +	if (num <= 0) {
> +		dev_err(dev, "invalid tsens slopes\n");
> +		return -EINVAL;
> +	}
> +
> +	tmdev = devm_kzalloc(dev, sizeof(*tmdev) +
> +			     num * sizeof(*s), GFP_KERNEL);
> +	if (!tmdev)
> +		return -ENOMEM;
> +
> +	tmdev->dev = dev;
> +	tmdev->num_sensors = num;
> +
> +	for (i = 0, s = tmdev->sensor; i < tmdev->num_sensors; i++, s++)
> +		of_property_read_u32_index(np, "qcom,tsens-slopes", i,
> +					   &s->slope);
> +
> +	id = of_match_node(tsens_table, np);
> +	if (!id)
> +		return -ENODEV;
> +
> +	tmdev->ops = id->data;
> +	if (!tmdev->ops || !tmdev->ops->init || !tmdev->ops->calibrate ||
> +	    !tmdev->ops->get_temp)
> +		return -EINVAL;
> +
> +	ret = tmdev->ops->init(tmdev);
> +	if (ret < 0) {
> +		dev_err(dev, "tsens init failed\n");
> +		return ret;
> +	}
> +
> +	ret = tmdev->ops->calibrate(tmdev);
> +	if (ret < 0) {
> +		dev_err(dev, "tsens calibration failed\n");
> +		return ret;
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
> +		.pm	= TSENS_PM_OPS,
> +		.of_match_table = tsens_table,
> +	},
> +};
> +module_platform_driver(tsens_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("QCOM Temperature Sensor driver");
> +MODULE_ALIAS("platform:qcom-tsens");

[...]

