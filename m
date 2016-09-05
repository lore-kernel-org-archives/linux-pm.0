From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4 3/3] iio: adc: add support for Allwinner SoCs ADC
Date: Mon, 5 Sep 2016 20:51:17 +0100
Message-ID: <f7d115a6-29e3-6157-60a1-0dd47cef79e3@kernel.org>
References: <1472738705-20145-1-git-send-email-quentin.schulz@free-electrons.com>
 <1472738705-20145-4-git-send-email-quentin.schulz@free-electrons.com>
 <272fb672-602c-1757-be9f-eadf928b330c@kernel.org>
 <f085ee35-889f-58e3-15d6-e6f3c0d15a92@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57926 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933623AbcIETvX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Sep 2016 15:51:23 -0400
In-Reply-To: <f085ee35-889f-58e3-15d6-e6f3c0d15a92@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>, jdelvare@suse.com, Guenter Roeck <linux@roeck-us.net>, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org, lee.jones@linaro.org
Cc: thomas.petazzoni@free-electrons.com, antoine.tenart@free-electrons.com, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm <linux-pm@vger.kernel.org>

On 05/09/16 07:29, Quentin Schulz wrote:
> On 04/09/2016 16:35, Jonathan Cameron wrote:
>> On 01/09/16 15:05, Quentin Schulz wrote:
>>> The Allwinner SoCs all have an ADC that can also act as a touchscreen
>>> controller and a thermal sensor. This patch adds the ADC driver which is
>>> based on the MFD for the same SoCs ADC.
>>>
>>> This also registers the thermal adc channel in the iio map array so
>>> iio_hwmon could use it without modifying the Device Tree. This registers
>>> the driver in the thermal framework.
>>>
>>> This driver probes on three different platform_device_id to take into
>>> account slight differences (registers bit and temperature computation)
>>> between Allwinner SoCs ADCs.
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> One utterly trivial point about unrolling code ordering inline.
>>
>> Other than the bit about patch 1 I'm basically happy with this..
> 
> ACK. Will revert this patch in v5. Thanks.
> 
>> However I would like some input (i.e. an Ack) from thermal given this
>> sets up a thermal zone.
>>
>> Zhang or Eduardo, could you take a quick look at this and confirm you
>> are happy with it?
>>
>> Thanks,
>>
>> Jonathan
> [...]
>>> +
>>> +err_map:
>>> +	iio_map_array_unregister(indio_dev);
>>> +
>>> +err_fifo_irq:
>>> +	/* Disable FIFO_DATA_PENDING interrupt on hardware side. */
>>> +	regmap_update_bits(info->regmap, SUN4I_GPADC_INT_FIFOC,
>>> +			   SUN4I_GPADC_INT_FIFOC_TP_DATA_IRQ_EN,
>>> +			   0);
>>> +
>>> +err_temp_irq:
>>> +	/* Disable TEMP_DATA_PENDING interrupt on hardware side. */
>>> +	regmap_update_bits(info->regmap, SUN4I_GPADC_INT_FIFOC,
>>> +			   SUN4I_GPADC_INT_FIFOC_TEMP_IRQ_EN,
>>> +			   0);
>>> +
>>> +err:
>>> +	pm_runtime_put(&pdev->dev);
>>> +	pm_runtime_disable(&pdev->dev);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int sun4i_gpadc_remove(struct platform_device *pdev)
>>> +{
>>> +	struct sun4i_gpadc_dev *info;
>>> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>>> +
>>> +	info = iio_priv(indio_dev);
>>> +	iio_device_unregister(indio_dev);
>>> +	iio_map_array_unregister(indio_dev);
>>> +	pm_runtime_put(&pdev->dev);
>>> +	pm_runtime_disable(&pdev->dev);
>> Its really minor but in the interests of 'obviously correct' making
>> review easy I'd rather everything in the remove was in the reverse order
>> of probe (and hence the same as the error path in probe for most of it).
>>
>> That would put the pm_runtime stuff last I think..
>>
>> If you weren't rerolling anyway over patch 1 I'd probably have just let
>> this go, but might as well make this trivial change as well.
>>
> 
> I'm going with the following order:
> pm_runtime_put
> pm_runtime_disable
> regmap_update_bits
> iio_map_array_unregister
> iio_device_unregister
> 
> Is that okay? (I don't really know which one of iio_map_array_unregister
> or iio_device_unregister to put first, if it matters in any way).
Unless we have a really complex race condition involving a client driver
coming up just as the provider is unregistered I doubt it matters.

At some point we should probably chase down any paths through that
with some carefully crafted tests but it's in the seriously unlikely
category!

Jonathan
> 
> Thanks!
> Quentin
>>
>>> +	/*
>>> +	 * Disable TEMP_DATA_PENDING and FIFO_DATA_PENDING interrupts on
>>> +	 * hardware side.
>>> +	 */
>>> +	regmap_update_bits(info->regmap, SUN4I_GPADC_INT_FIFOC,
>>> +			   SUN4I_GPADC_INT_FIFOC_TEMP_IRQ_EN |
>>> +				SUN4I_GPADC_INT_FIFOC_TP_DATA_IRQ_EN,
>>> +			   0);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct platform_device_id sun4i_gpadc_id[] = {
>>> +	{ "sun4i-a10-gpadc-iio", (kernel_ulong_t)&sun4i_gpadc_soc_specific },
>>> +	{ "sun5i-a13-gpadc-iio", (kernel_ulong_t)&sun5i_gpadc_soc_specific },
>>> +	{ "sun6i-a31-gpadc-iio", (kernel_ulong_t)&sun6i_gpadc_soc_specific },
>>> +	{ /* sentinel */ },
>>> +};
>>> +
>>> +static struct platform_driver sun4i_gpadc_driver = {
>>> +	.driver = {
>>> +		.name = "sun4i-gpadc-iio",
>>> +		.pm = &sun4i_gpadc_pm_ops,
>>> +	},
>>> +	.id_table = sun4i_gpadc_id,
>>> +	.probe = sun4i_gpadc_probe,
>>> +	.remove = sun4i_gpadc_remove,
>>> +};
>>> +
>>> +module_platform_driver(sun4i_gpadc_driver);
>>> +
>>> +MODULE_DESCRIPTION("ADC driver for sunxi platforms");
>>> +MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
>>> +MODULE_LICENSE("GPL v2");
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

