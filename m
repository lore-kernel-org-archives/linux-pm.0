From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v5 01/11] thermal: qcom: tsens: Add a skeletal TSENS drivers
Date: Thu, 05 May 2016 10:20:41 +0530
Message-ID: <572AD121.8040503@codeaurora.org>
References: <1460626319-14516-1-git-send-email-rnayak@codeaurora.org> <1460626319-14516-2-git-send-email-rnayak@codeaurora.org> <20160428002040.GA18496@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160428002040.GA18496@localhost.localdomain>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, sboyd@codeaurora.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com
List-Id: linux-pm@vger.kernel.org



On 04/28/2016 05:50 AM, Eduardo Valentin wrote:
> On Thu, Apr 14, 2016 at 03:01:49PM +0530, Rajendra Nayak wrote:
>> TSENS is Qualcomms' thermal temperature sensor device. It
>> supports reading temperatures from multiple thermal sensors
>> present on various QCOM SoCs.
>> Calibration data is generally read from a non-volatile memory
>> (eeprom) device.
>>
>> Add a skeleton driver with all the necessary abstractions so
>> a variety of qcom device families which support TSENS can
>> add driver extensions.
>>
>> Also add the required device tree bindings which can be used
>> to describe the TSENS device in DT.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Reviewed-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
[]..

>> @@ -0,0 +1,135 @@
>> +/*
>> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/nvmem-consumer.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include "tsens.h"
>> +
>> +#define S0_ST_ADDR		0x1030
>> +#define SN_ADDR_OFFSET		0x4
>> +#define SN_ST_TEMP_MASK		0x3ff
>> +#define CAL_DEGC_PT1		30
>> +#define CAL_DEGC_PT2		120
>> +#define SLOPE_FACTOR		1000
>> +#define SLOPE_DEFAULT		3200
>> +
>> +char *qfprom_read(struct device *dev, const char *cname)
>> +{
>> +	struct nvmem_cell *cell;
>> +	ssize_t data;
>> +	char *ret;
>> +
>> +	cell = nvmem_cell_get(dev, cname);
>> +	if (IS_ERR(cell))
>> +		return ERR_CAST(cell);
>> +
>> +	ret = nvmem_cell_read(cell, &data);
>> +	nvmem_cell_put(cell);
>> +
>> +	return ret;
>> +}
>> +
>> +void compute_intercept_slope(struct tsens_device *tmdev, u32 *p1,
>> +			     u32 *p2, u32 mode)
>> +{
> 
> Could you please add a comment explaining the cases that this function
> is used instead of tz->tzp->slope,offset?

sure, will do.

> 
>> +	int i;
>> +	int num, den;
>> +
>> +	for (i = 0; i < tmdev->num_sensors; i++) {
>> +		dev_dbg(tmdev->dev,
>> +			"sensor%d - data_point1:%#x data_point2:%#x\n",
>> +			i, p1[i], p2[i]);
>> +
>> +		tmdev->sensor[i].slope = SLOPE_DEFAULT;
>> +		if (mode == TWO_PT_CALIB) {
>> +			/*
>> +			 * slope (m) = adc_code2 - adc_code1 (y2 - y1)/
>> +			 *	temp_120_degc - temp_30_degc (x2 - x1)
>> +			 */
>> +			num = p2[i] - p1[i];
>> +			num *= SLOPE_FACTOR;
>> +			den = CAL_DEGC_PT2 - CAL_DEGC_PT1;
>> +			tmdev->sensor[i].slope = num / den;
>> +		}
>> +
>> +		tmdev->sensor[i].offset = (p1[i] * SLOPE_FACTOR) -
>> +				(CAL_DEGC_PT1 *
>> +				tmdev->sensor[i].slope);
>> +		dev_dbg(tmdev->dev, "offset:%d\n", tmdev->sensor[i].offset);
>> +	}
>> +}
[]..
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
