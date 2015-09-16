From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH v2 2/9] thermal: qcom: tsens-8916: Add support for 8916 family of SoCs
Date: Wed, 16 Sep 2015 14:46:46 +0100
Message-ID: <9hh4miutr21.fsf@e105922-lin.cambridge.arm.com>
References: <1442384603-26053-1-git-send-email-rnayak@codeaurora.org>
	<1442384603-26053-3-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1442384603-26053-3-git-send-email-rnayak@codeaurora.org>
	(Rajendra Nayak's message of "Wed, 16 Sep 2015 11:53:16 +0530")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, sboyd@codeaurora.org, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org
List-Id: linux-pm@vger.kernel.org

Hi Rajendra,

One comment below.

Rajendra Nayak <rnayak@codeaurora.org> writes:

> Add support to calibrate sensors on 8916 family and also add common
> functions to read temperature from sensors (This can be reused on
> other SoCs having similar TSENS device)
> The calibration data is read from eeprom using the generic nvmem
> framework apis.
>
> Based on the original code by Siddartha Mohanadoss and Stephen Boyd.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/thermal/qcom/Makefile       |   2 +-
>  drivers/thermal/qcom/tsens-8916.c   | 107 +++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens-common.c | 130 ++++++++++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.c        |   1 +
>  drivers/thermal/qcom/tsens.h        |  11 +++
>  5 files changed, 250 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/thermal/qcom/tsens-8916.c
>  create mode 100644 drivers/thermal/qcom/tsens-common.c
>

[...]

> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> new file mode 100644
> index 0000000..4acf52c
> --- /dev/null
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -0,0 +1,130 @@
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
> +#include <linux/platform_device.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/regmap.h>
> +#include "tsens.h"
> +
> +#define S0_ST_ADDR		0x1030
> +#define SN_ADDR_OFFSET		0x4
> +#define SN_ST_TEMP_MASK		0x3ff
> +#define CAL_DEGC_PT1		30
> +#define CAL_DEGC_PT2		120
> +#define SLOPE_FACTOR		1000
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
> +	return ret;
> +}
> +
> +void compute_intercept_slope(struct tsens_device *tmdev, u32 *p1,
> +			     u32 *p2, u32 mode)
> +{
> +	int i;
> +	int num, den;
> +
> +	for (i = 0; i < tmdev->num_sensors; i++) {
> +		dev_dbg(tmdev->dev,
> +			"sensor%d - data_point1:%#x data_point2:%#x\n",
> +			i, p1[i], p2[i]);
> +
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

The way this function is coded the temperature will only ever change by
1C (i.e., 1000mC). Is there a chance that you're losing precision in the
code_to_degc conversion that could be preserved perhaps?

This is useful in scenarios where you use the power allocator governor
and the greater precision allows better power budget estimation.

> +
> +static const struct regmap_config tsens_config = {
> +	.reg_bits	= 32,
> +	.val_bits	= 32,
> +	.reg_stride	= 4,
> +};
> +
> +int init_common(struct tsens_device *tmdev)
> +{
> +	void __iomem *base;
> +
> +	base = of_iomap(tmdev->dev->of_node, 0);
> +	if (IS_ERR(base))
> +		return -EINVAL;
> +
> +	tmdev->map = devm_regmap_init_mmio(tmdev->dev, base, &tsens_config);
> +	if (!tmdev->map)
> +		return -ENODEV;
> +
> +	return 0;
> +}

[...]
