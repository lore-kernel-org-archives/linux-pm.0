From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 3/3] iio: adc: add support for Allwinner SoCs ADC
Date: Mon, 5 Sep 2016 08:29:20 +0200
Message-ID: <f085ee35-889f-58e3-15d6-e6f3c0d15a92@free-electrons.com>
References: <1472738705-20145-1-git-send-email-quentin.schulz@free-electrons.com>
 <1472738705-20145-4-git-send-email-quentin.schulz@free-electrons.com>
 <272fb672-602c-1757-be9f-eadf928b330c@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <272fb672-602c-1757-be9f-eadf928b330c-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, jdelvare-IBi9RG/b67k@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 04/09/2016 16:35, Jonathan Cameron wrote:
> On 01/09/16 15:05, Quentin Schulz wrote:
>> The Allwinner SoCs all have an ADC that can also act as a touchscreen
>> controller and a thermal sensor. This patch adds the ADC driver which is
>> based on the MFD for the same SoCs ADC.
>>
>> This also registers the thermal adc channel in the iio map array so
>> iio_hwmon could use it without modifying the Device Tree. This registers
>> the driver in the thermal framework.
>>
>> This driver probes on three different platform_device_id to take into
>> account slight differences (registers bit and temperature computation)
>> between Allwinner SoCs ADCs.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> One utterly trivial point about unrolling code ordering inline.
> 
> Other than the bit about patch 1 I'm basically happy with this..

ACK. Will revert this patch in v5. Thanks.

> However I would like some input (i.e. an Ack) from thermal given this
> sets up a thermal zone.
> 
> Zhang or Eduardo, could you take a quick look at this and confirm you
> are happy with it?
> 
> Thanks,
> 
> Jonathan
[...]
>> +
>> +err_map:
>> +	iio_map_array_unregister(indio_dev);
>> +
>> +err_fifo_irq:
>> +	/* Disable FIFO_DATA_PENDING interrupt on hardware side. */
>> +	regmap_update_bits(info->regmap, SUN4I_GPADC_INT_FIFOC,
>> +			   SUN4I_GPADC_INT_FIFOC_TP_DATA_IRQ_EN,
>> +			   0);
>> +
>> +err_temp_irq:
>> +	/* Disable TEMP_DATA_PENDING interrupt on hardware side. */
>> +	regmap_update_bits(info->regmap, SUN4I_GPADC_INT_FIFOC,
>> +			   SUN4I_GPADC_INT_FIFOC_TEMP_IRQ_EN,
>> +			   0);
>> +
>> +err:
>> +	pm_runtime_put(&pdev->dev);
>> +	pm_runtime_disable(&pdev->dev);
>> +
>> +	return ret;
>> +}
>> +
>> +static int sun4i_gpadc_remove(struct platform_device *pdev)
>> +{
>> +	struct sun4i_gpadc_dev *info;
>> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>> +
>> +	info = iio_priv(indio_dev);
>> +	iio_device_unregister(indio_dev);
>> +	iio_map_array_unregister(indio_dev);
>> +	pm_runtime_put(&pdev->dev);
>> +	pm_runtime_disable(&pdev->dev);
> Its really minor but in the interests of 'obviously correct' making
> review easy I'd rather everything in the remove was in the reverse order
> of probe (and hence the same as the error path in probe for most of it).
> 
> That would put the pm_runtime stuff last I think..
> 
> If you weren't rerolling anyway over patch 1 I'd probably have just let
> this go, but might as well make this trivial change as well.
> 

I'm going with the following order:
pm_runtime_put
pm_runtime_disable
regmap_update_bits
iio_map_array_unregister
iio_device_unregister

Is that okay? (I don't really know which one of iio_map_array_unregister
or iio_device_unregister to put first, if it matters in any way).

Thanks!
Quentin
> 
>> +	/*
>> +	 * Disable TEMP_DATA_PENDING and FIFO_DATA_PENDING interrupts on
>> +	 * hardware side.
>> +	 */
>> +	regmap_update_bits(info->regmap, SUN4I_GPADC_INT_FIFOC,
>> +			   SUN4I_GPADC_INT_FIFOC_TEMP_IRQ_EN |
>> +				SUN4I_GPADC_INT_FIFOC_TP_DATA_IRQ_EN,
>> +			   0);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct platform_device_id sun4i_gpadc_id[] = {
>> +	{ "sun4i-a10-gpadc-iio", (kernel_ulong_t)&sun4i_gpadc_soc_specific },
>> +	{ "sun5i-a13-gpadc-iio", (kernel_ulong_t)&sun5i_gpadc_soc_specific },
>> +	{ "sun6i-a31-gpadc-iio", (kernel_ulong_t)&sun6i_gpadc_soc_specific },
>> +	{ /* sentinel */ },
>> +};
>> +
>> +static struct platform_driver sun4i_gpadc_driver = {
>> +	.driver = {
>> +		.name = "sun4i-gpadc-iio",
>> +		.pm = &sun4i_gpadc_pm_ops,
>> +	},
>> +	.id_table = sun4i_gpadc_id,
>> +	.probe = sun4i_gpadc_probe,
>> +	.remove = sun4i_gpadc_remove,
>> +};
>> +
>> +module_platform_driver(sun4i_gpadc_driver);
>> +
>> +MODULE_DESCRIPTION("ADC driver for sunxi platforms");
>> +MODULE_AUTHOR("Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>");
>> +MODULE_LICENSE("GPL v2");
>>
> 
