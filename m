From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 04/18] iio: adc: add support for X-Powers AXP20X and
 AXP22X PMICs ADCs
Date: Sat, 25 Feb 2017 16:53:40 +0000
Message-ID: <b46192ef-c516-c842-57ca-ff15016b1b75@kernel.org>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
 <20170214094112.27426-5-quentin.schulz@free-electrons.com>
 <b76264cc-9c6c-169c-d490-91852c052890@kernel.org>
 <cd4eac68-0155-d032-6d49-91e3ebdee72e@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cd4eac68-0155-d032-6d49-91e3ebdee72e@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, sre@kernel.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, bonbons@linux-vserver.org, icenowy@aosc.xyz, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 21/02/17 18:03, Quentin Schulz wrote:
> Hi Jonathan,
> 
> On 19/02/2017 13:40, Jonathan Cameron wrote:
>> On 14/02/17 09:40, Quentin Schulz wrote:
>>> The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose the
>>> battery voltage, battery charge and discharge currents, AC-in and VBUS
>>> voltages and currents, 2 GPIOs muxable in ADC mode and PMIC temperature.
>>>
>>> This adds support for most of AXP20X and AXP22X ADCs.
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Hi Quentin,
>>
>> A few bits and bobs inline.  The bigest one is that I don't think
>> you need to carry your struct axp_data pointer around in the iio_priv
>> structure as it only seems to be used in probe.
>>
>> Anyhow, tidy these little bits up (quite a few are optional in the
>> sense that they are a matter or personal taste and I don't feel
>> strongly about them) and you can add
>>
>> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
>>
>> A nice driver.
>>
>> Jonathan
> [...]
>>> +static int axp20x_probe(struct platform_device *pdev)
>>> +{
>>> +	struct axp20x_adc_iio *info;
>>> +	struct iio_dev *indio_dev;
>>> +	struct axp20x_dev *axp20x_dev;
>>> +	int ret;
>>> +
>>> +	axp20x_dev = dev_get_drvdata(pdev->dev.parent);
>>> +
>>> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
>>> +	if (!indio_dev)
>>> +		return -ENOMEM;
>>> +
>>> +	info = iio_priv(indio_dev);
>>> +	platform_set_drvdata(pdev, indio_dev);
>>> +
>>> +	info->regmap = axp20x_dev->regmap;
>>> +	indio_dev->dev.parent = &pdev->dev;
>>> +	indio_dev->dev.of_node = pdev->dev.of_node;
>>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>>> +
>>> +	info->data = (struct axp_data *)platform_get_device_id(pdev)->driver_data;
>> I think this is only actually used in probe, so could be handled more
>> neatly with a local variable rather than sticking it in info.
>>
> [...]
>>> +static int axp20x_remove(struct platform_device *pdev)
>>> +{
>>> +	struct axp20x_adc_iio *info;
>>> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>>> +
>>> +	info = iio_priv(indio_dev);
>> Reorder the two lines above this one and then you could just do this
>> inline. (really trivial so feel free to not bother ;)
>>> +
>>> +	iio_device_unregister(indio_dev);
>>> +	iio_map_array_unregister(indio_dev);
>>> +
>>> +	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
>>> +
>>> +	if (info->data->adc_en2)
> 
> data is used here to know if I should disable misc ADCs (if supported by
> the PMIC). So kinda need it only for that purpose, maybe I can use a
> slightly simpler structure to only store regmap and this adc_en2 boolean.
> 
> Ack for everything else.
cool. Not sure how my searching missed that!

Up to you on whether you simplify that structure or not, I'm happy either way.
> 
> Thanks,
> Quentin
> 
