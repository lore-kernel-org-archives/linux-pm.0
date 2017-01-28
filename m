From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH v2 04/25] iio: adc: add support for X-Powers AXP20X and
 AXP22X PMICs ADCs
Date: Sat, 28 Jan 2017 16:12:04 +0100
Message-ID: <0e3ac499-abfc-51e0-20e3-d1231af3adc6@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-5-quentin.schulz@free-electrons.com>
 <f4b3e9dd-926c-c98a-30a2-89907ab2e09e@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <f4b3e9dd-926c-c98a-30a2-89907ab2e09e@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, sre@kernel.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, bonbons@linux-vserver.org, icenowy@aosc.xyz, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Jonathan

On 28/01/2017 15:49, Jonathan Cameron wrote:
> On 27/01/17 08:54, Quentin Schulz wrote:
>> The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose the
>> battery voltage, battery charge and discharge currents, AC-in and VBUS
>> voltages and currents, 2 GPIOs muxable in ADC mode and PMIC temperature.
>>
>> This adds support for most of AXP20X and AXP22X ADCs.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Pretty good, but not everything seems to be cleaned up on error paths
> in probe.
> 
> A few other suggestions / questions inline.
> 
> Jonathan
>> ---
[...]
>> +static int axp20x_adc_raw(struct iio_dev *indio_dev,
>> +			  struct iio_chan_spec const *chan, int *val)
>> +{
>> +	struct axp20x_adc_iio *info = iio_priv(indio_dev);
>> +	int size = 12;
>> +
>> +	switch (chan->type) {
>> +	case IIO_CURRENT:
>> +		/*
>> +		 * Unlike the Chinese datasheets tell, the charging current is
>> +		 * stored on 12 bits, not 13 bits.
>> +		 */
>> +		if (chan->channel == AXP20X_BATT_DISCHRG_I)
>> +			size = 13;
> Given I don't think you can get here without it being current, voltage or temp;
> couldn't this be done more cleanly with
> if ((chan->type == IIO_CURRENT) && (chan->channel == AXP20X_BAT_DISCHRG_I))
>    size = 13;
> 
> and have the rest in the normal code flow?
> 

Indeed.

>> +	case IIO_VOLTAGE:
>> +	case IIO_TEMP:
>> +		*val = axp20x_read_variable_width(info->regmap, chan->address,
>> +						  size);
>> +		if (*val < 0)
>> +			return *val;
>> +
>> +		return IIO_VAL_INT;
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
[...]
>> +static int axp22x_adc_scale(struct iio_chan_spec const *chan, int *val,
>> +			    int *val2)
>> +{
>> +	switch (chan->type) {
>> +	case IIO_VOLTAGE:
>> +		if (chan->channel != AXP22X_BATT_V)
>> +			return -EINVAL;
>> +
>> +		*val = 1;
>> +		*val2 = 100000;
>> +		return IIO_VAL_INT_PLUS_MICRO;
> A fixed scale of 1.1x? (just checking)

Yes, there is only one voltage exposed for AXP22X PMICs: the battery
voltage which has a scale of 1.1 (for mV).

[...]
>> +static int axp20x_probe(struct platform_device *pdev)
>> +{
>> +	struct axp20x_adc_iio *info;
>> +	struct iio_dev *indio_dev;
>> +	struct axp20x_dev *axp20x_dev;
>> +	int ret;
>> +
>> +	axp20x_dev = dev_get_drvdata(pdev->dev.parent);
>> +
>> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	info = iio_priv(indio_dev);
>> +	platform_set_drvdata(pdev, indio_dev);
>> +
>> +	info->regmap = axp20x_dev->regmap;
>> +	indio_dev->name = dev_name(&pdev->dev);
> Not sure on this name - what does end up as?  Expected to be
> a description of the part so in this case something like axp209-adc.
> I've been lax at picking up on this in the past and it's led to some
> crazy naming that is no use at all to userspace.  Basically this
> name just provides a convenient user readable name for userspace apps to
> use.
> 

ACK. Should we have a different name for AXP20X and AXP22X PMICs?

>> +	indio_dev->dev.parent = &pdev->dev;
>> +	indio_dev->dev.of_node = pdev->dev.of_node;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +	info->data = (struct axp_data *)of_device_get_match_data(&pdev->dev);
>> +
>> +	indio_dev->info = info->data->iio_info;
>> +	indio_dev->num_channels = info->data->num_channels;
>> +	indio_dev->channels = info->data->channels;
>> +
>> +	/* Enable the ADCs on IP */
>> +	regmap_write(info->regmap, AXP20X_ADC_EN1, info->data->adc_en1_mask);
>> +
>> +	if (info->data->adc_en2)
>> +		/* Enable GPIO0/1 and internal temperature ADCs */
>> +		regmap_update_bits(info->regmap, AXP20X_ADC_EN2,
>> +				   AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
>> +
>> +	/* Configure ADCs rate */
>> +	regmap_update_bits(info->regmap, AXP20X_ADC_RATE, AXP20X_ADC_RATE_MASK,
>> +			   info->data->adc_rate(100));
>> +
>> +	ret = iio_map_array_register(indio_dev, info->data->maps);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "failed to register IIO maps: %d\n", ret);
> This should be disabling channels.

You mean disabling ADCs as it is done in the remove? If so, indeed.

>> +		return ret;
>> +	}
>> +
>> +	ret = iio_device_register(indio_dev);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "could not register the device\n");
>> +		regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
>> +
>> +		if (info->data->adc_en2)
>> +			regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
> I'd expect to see a complete unwind of what has been done earlier in probe
> including iio_map_array_unregister.
> 
> The traditional goto error* approach is probably worth having here to
> make sure the unwind makes sense.

Indeed.

>> +
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int axp20x_remove(struct platform_device *pdev)
>> +{
>> +	struct axp20x_adc_iio *info;
>> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>> +
>> +	info = iio_priv(indio_dev);
>> +
>> +	iio_device_unregister(indio_dev);
> iio_map_array_unregister?

Yes. I see iio_device_unregister already disable all buffers, why not
unregistering the map array as well in this function?

[...]
Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
