From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v2 1/9] thermal: qcom: tsens: Add a skeletal TSENS drivers
Date: Mon, 21 Sep 2015 09:56:31 +0530
Message-ID: <55FF86F7.5010200@codeaurora.org>
References: <1442384603-26053-1-git-send-email-rnayak@codeaurora.org>	<1442384603-26053-2-git-send-email-rnayak@codeaurora.org> <9hh613atr54.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <9hh613atr54.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, sboyd@codeaurora.org, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org
List-Id: linux-pm@vger.kernel.org

[]..

>> +Example:
>> +tsens: thermal-sensor@900000 {
>> +		compatible = "qcom,msm8916-tsens";
>> +		qcom,tsens-slopes = <1176 1176 1154 1176 1111
>> +				1132 1132 1199 1132 1199
>> +				1132>;
>> +		nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
>> +		nvmem-cell-names = "caldata", "calsel";
>> +		qcom,tsens-slopes = <3200 3200 3200 3200 3200>;
>> +		qcom,sensor-id = <0 1 2 4 5>;
>> +		#thermal-sensor-cells = <1>;
>> +	};
>
> The qcom,tsens-slopes property appears twice in the above example.

sure, will fix.

>
> [...]
>> +#ifdef CONFIG_PM
>> +static int tsens_suspend(struct device *dev)
>> +{
>> +	struct tsens_device *tmdev = dev_get_drvdata(dev);
>> +
>> +	if (tmdev->ops && tmdev->ops->suspend)
>> +		return tmdev->ops->suspend(tmdev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tsens_resume(struct device *dev)
>> +{
>> +	struct tsens_device *tmdev = dev_get_drvdata(dev);
>> +
>> +	if (tmdev->ops && tmdev->ops->resume)
>> +		return tmdev->ops->resume(tmdev);
>> +
>> +	return 0;
>> +}
>> +
>> +static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
>> +#define TSENS_PM_OPS   (&tsens_pm_ops)
>> +
>> +#else /* CONFIG_PM_SLEEP */
>           ^
>
>> +#define TSENS_PM_OPS NULL
>> +#endif /* CONFIG_PM_SLEEP */
>            ^
>
> The comments don't match the #ifdef above. I maybe wrong but looking at
> other drivers it looks like you don't need the #else part. You should be
> able to use the tsens_pm_ops without having to set it to NULL.

yes, I should be able to avoid the #else and thanks for catching the
mismatched comments.

>
>> +
>> +static const struct of_device_id tsens_table[] = {
>> +	{
>> +		.compatible = "qcom,msm8916-tsens",
>> +	}, {
>> +		.compatible = "qcom,msm8974-tsens",
>> +	},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, tsens_table);
>> +
>> +static const struct thermal_zone_of_device_ops tsens_of_ops = {
>> +	.get_temp = tsens_get_temp,
>> +	.get_trend = tsens_get_trend,
>> +};
>> +
>> +static int tsens_register(struct tsens_device *tmdev)
>> +{
>> +	int i, ret;
>> +	struct thermal_zone_device *tzd;
>> +	u32 *hw_id, n = tmdev->num_sensors;
>> +	struct device_node *np = tmdev->dev->of_node;
>> +
>> +	hw_id = devm_kcalloc(tmdev->dev, n, sizeof(u32), GFP_KERNEL);
>> +	if (!hw_id)
>> +		return -ENOMEM;
>> +
>> +	ret = of_property_read_u32_array(np, "qcom,sensor-id", hw_id, n);
>> +	if (ret)
>> +		for (i = 0;  i < tmdev->num_sensors; i++)
>> +			tmdev->sensor[i].hw_id = i;
>> +	else
>> +		for (i = 0;  i < tmdev->num_sensors; i++)
>> +			tmdev->sensor[i].hw_id = hw_id[i];
>> +
>
> You could move the check for vaild for valid sensor ids in the device
> tree (ret) inside a single for loop. In that case the loop above could
> be merged into the iteration over the sensors below.

sure, seems like a reasonable optimization to avoid a few loops.

>
>> +	for (i = 0;  i < tmdev->num_sensors; i++) {
>> +		tmdev->sensor[i].tmdev = tmdev;
>> +		tmdev->sensor[i].id = i;
>> +		tzd = thermal_zone_of_sensor_register(tmdev->dev, i,
>> +						      &tmdev->sensor[i],
>> +						      &tsens_of_ops);
>> +		if (IS_ERR(tzd))
>> +			continue;
>> +		tmdev->sensor[i].tzd = tzd;
>> +		if (tmdev->ops->enable)
>> +			tmdev->ops->enable(tmdev, i);
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int tsens_probe(struct platform_device *pdev)
>> +{
>> +	int ret, i, num;
>> +	struct device *dev;
>> +	struct device_node *np;
>> +	struct tsens_sensor *s;
>> +	struct tsens_device *tmdev;
>> +	const struct of_device_id *id;
>> +
>> +	dev = &pdev->dev;
>> +	np = dev->of_node;
>
> These assignments can be done with the declaration above.

I just have these assignments done conditionally in later patches
(5/9), so left them here.
Thanks for taking time to review.

regards,
Rajendra

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
