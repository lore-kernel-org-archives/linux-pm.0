From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 07/16] iio: adc: axp20x_adc: add support for AXP813
 ADC
Date: Sun, 28 Jan 2018 08:12:52 +0000
Message-ID: <20180128081252.476264ca@archlinux>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
        <e9e6b1e841f6b2ce66076d3a4031e3579ead8486.1516012352.git-series.quentin.schulz@free-electrons.com>
        <20180121122655.0efd9480@archlinux>
        <20180122082225.ovh4l4mu7uwnph3d@qschulz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180122082225.ovh4l4mu7uwnph3d@qschulz>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, 22 Jan 2018 09:22:25 +0100
Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Hi Jonathan,
> 
> On Sun, Jan 21, 2018 at 12:26:55PM +0000, Jonathan Cameron wrote:
> > On Mon, 15 Jan 2018 11:33:41 +0100
> > Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> >   
> > > The X-Powers AXP813 PMIC is really close to what is already done for
> > > AXP20X/AXP22X.
> > > 
> > > There are two pairs of bits to set the rate (one for Voltage and Current
> > > measurements and one for TS/GPIO0 voltage measurements) instead of one.
> > > 
> > > The register to set the ADC rates is different from the one for
> > > AXP20X/AXP22X.
> > > 
> > > GPIO0 can be used as an ADC (measuring Volts) unlike for AXP22X.
> > > 
> > > The scales to apply to the different inputs are unlike the ones from
> > > AXP20X and AXP22X.
> > > 
> > > Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > > Acked-by: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>  
> > Applied to the togreg branch of iio.git and pushed out as testing
> > for the autobuilders to play with it.
> > 
> > One thing that might be nice to tidy up in this driver though.
> > 
> > CHECK   drivers/iio/adc/axp20x_adc.c
> > drivers/iio/adc/axp20x_adc.c:548:26: warning: dubious: !x & y
> > drivers/iio/adc/axp20x_adc.c:553:26: warning: dubious: !x & y
> > 
> > Those are 'interesting' code constructions.  It may be worth being
> > a little more verbose to keep sparse happy and suppress the
> > warning.
> >   
> 
> Would adding a val = !!val; before the call to the macro be "verbose"
> enough for you?
> 
> Sparse does not complain anymore after that.
I'd just use a good old fashioned if statement.  Few more lines of
code but clearer and will keep sparse happy.

Jonathan

> 
> Thanks,
> Quentin
> 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/iio/adc/axp20x_adc.c | 123 ++++++++++++++++++++++++++++++++++++-
> > >  include/linux/mfd/axp20x.h   |   2 +-
> > >  2 files changed, 125 insertions(+)
> > > 
> > > diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> > > index 3968053..7cdb8bc 100644
> > > --- a/drivers/iio/adc/axp20x_adc.c
> > > +++ b/drivers/iio/adc/axp20x_adc.c
> > > @@ -35,8 +35,13 @@
> > >  #define AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(x)	(((x) & BIT(0)) << 1)
> > >  
> > >  #define AXP20X_ADC_RATE_MASK			GENMASK(7, 6)
> > > +#define AXP813_V_I_ADC_RATE_MASK		GENMASK(5, 4)
> > > +#define AXP813_ADC_RATE_MASK			(AXP20X_ADC_RATE_MASK | AXP813_V_I_ADC_RATE_MASK)
> > >  #define AXP20X_ADC_RATE_HZ(x)			((ilog2((x) / 25) << 6) & AXP20X_ADC_RATE_MASK)
> > >  #define AXP22X_ADC_RATE_HZ(x)			((ilog2((x) / 100) << 6) & AXP20X_ADC_RATE_MASK)
> > > +#define AXP813_TS_GPIO0_ADC_RATE_HZ(x)		AXP20X_ADC_RATE_HZ(x)
> > > +#define AXP813_V_I_ADC_RATE_HZ(x)		((ilog2((x) / 100) << 4) & AXP813_V_I_ADC_RATE_MASK)
> > > +#define AXP813_ADC_RATE_HZ(x)			(AXP20X_ADC_RATE_HZ(x) | AXP813_V_I_ADC_RATE_HZ(x))
> > >  
> > >  #define AXP20X_ADC_CHANNEL(_channel, _name, _type, _reg)	\
> > >  	{							\
> > > @@ -95,6 +100,12 @@ enum axp22x_adc_channel_i {
> > >  	AXP22X_BATT_DISCHRG_I,
> > >  };
> > >  
> > > +enum axp813_adc_channel_v {
> > > +	AXP813_TS_IN = 0,
> > > +	AXP813_GPIO0_V,
> > > +	AXP813_BATT_V,
> > > +};
> > > +
> > >  static struct iio_map axp20x_maps[] = {
> > >  	{
> > >  		.consumer_dev_name = "axp20x-usb-power-supply",
> > > @@ -197,6 +208,25 @@ static const struct iio_chan_spec axp22x_adc_channels[] = {
> > >  			   AXP20X_BATT_DISCHRG_I_H),
> > >  };
> > >  
> > > +static const struct iio_chan_spec axp813_adc_channels[] = {
> > > +	{
> > > +		.type = IIO_TEMP,
> > > +		.address = AXP22X_PMIC_TEMP_H,
> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > > +				      BIT(IIO_CHAN_INFO_SCALE) |
> > > +				      BIT(IIO_CHAN_INFO_OFFSET),
> > > +		.datasheet_name = "pmic_temp",
> > > +	},
> > > +	AXP20X_ADC_CHANNEL(AXP813_GPIO0_V, "gpio0_v", IIO_VOLTAGE,
> > > +			   AXP288_GP_ADC_H),
> > > +	AXP20X_ADC_CHANNEL(AXP813_BATT_V, "batt_v", IIO_VOLTAGE,
> > > +			   AXP20X_BATT_V_H),
> > > +	AXP20X_ADC_CHANNEL(AXP22X_BATT_CHRG_I, "batt_chrg_i", IIO_CURRENT,
> > > +			   AXP20X_BATT_CHRG_I_H),
> > > +	AXP20X_ADC_CHANNEL(AXP22X_BATT_DISCHRG_I, "batt_dischrg_i", IIO_CURRENT,
> > > +			   AXP20X_BATT_DISCHRG_I_H),
> > > +};
> > > +
> > >  static int axp20x_adc_raw(struct iio_dev *indio_dev,
> > >  			  struct iio_chan_spec const *chan, int *val)
> > >  {
> > > @@ -243,6 +273,18 @@ static int axp22x_adc_raw(struct iio_dev *indio_dev,
> > >  	return IIO_VAL_INT;
> > >  }
> > >  
> > > +static int axp813_adc_raw(struct iio_dev *indio_dev,
> > > +			  struct iio_chan_spec const *chan, int *val)
> > > +{
> > > +	struct axp20x_adc_iio *info = iio_priv(indio_dev);
> > > +
> > > +	*val = axp20x_read_variable_width(info->regmap, chan->address, 12);
> > > +	if (*val < 0)
> > > +		return *val;
> > > +
> > > +	return IIO_VAL_INT;
> > > +}
> > > +
> > >  static int axp20x_adc_scale_voltage(int channel, int *val, int *val2)
> > >  {
> > >  	switch (channel) {
> > > @@ -273,6 +315,24 @@ static int axp20x_adc_scale_voltage(int channel, int *val, int *val2)
> > >  	}
> > >  }
> > >  
> > > +static int axp813_adc_scale_voltage(int channel, int *val, int *val2)
> > > +{
> > > +	switch (channel) {
> > > +	case AXP813_GPIO0_V:
> > > +		*val = 0;
> > > +		*val2 = 800000;
> > > +		return IIO_VAL_INT_PLUS_MICRO;
> > > +
> > > +	case AXP813_BATT_V:
> > > +		*val = 1;
> > > +		*val2 = 100000;
> > > +		return IIO_VAL_INT_PLUS_MICRO;
> > > +
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > >  static int axp20x_adc_scale_current(int channel, int *val, int *val2)
> > >  {
> > >  	switch (channel) {
> > > @@ -342,6 +402,26 @@ static int axp22x_adc_scale(struct iio_chan_spec const *chan, int *val,
> > >  	}
> > >  }
> > >  
> > > +static int axp813_adc_scale(struct iio_chan_spec const *chan, int *val,
> > > +			    int *val2)
> > > +{
> > > +	switch (chan->type) {
> > > +	case IIO_VOLTAGE:
> > > +		return axp813_adc_scale_voltage(chan->channel, val, val2);
> > > +
> > > +	case IIO_CURRENT:
> > > +		*val = 1;
> > > +		return IIO_VAL_INT;
> > > +
> > > +	case IIO_TEMP:
> > > +		*val = 100;
> > > +		return IIO_VAL_INT;
> > > +
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > >  static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
> > >  				     int *val)
> > >  {
> > > @@ -425,6 +505,26 @@ static int axp22x_read_raw(struct iio_dev *indio_dev,
> > >  	}
> > >  }
> > >  
> > > +static int axp813_read_raw(struct iio_dev *indio_dev,
> > > +			   struct iio_chan_spec const *chan, int *val,
> > > +			   int *val2, long mask)
> > > +{
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_OFFSET:
> > > +		*val = -2667;
> > > +		return IIO_VAL_INT;
> > > +
> > > +	case IIO_CHAN_INFO_SCALE:
> > > +		return axp813_adc_scale(chan, val, val2);
> > > +
> > > +	case IIO_CHAN_INFO_RAW:
> > > +		return axp813_adc_raw(indio_dev, chan, val);
> > > +
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > >  static int axp20x_write_raw(struct iio_dev *indio_dev,
> > >  			    struct iio_chan_spec const *chan, int val, int val2,
> > >  			    long mask)
> > > @@ -470,6 +570,10 @@ static const struct iio_info axp22x_adc_iio_info = {
> > >  	.read_raw = axp22x_read_raw,
> > >  };
> > >  
> > > +static const struct iio_info axp813_adc_iio_info = {
> > > +	.read_raw = axp813_read_raw,
> > > +};
> > > +
> > >  static int axp20x_adc_rate(struct axp20x_adc_iio *info, int rate)
> > >  {
> > >  	return regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
> > > @@ -484,6 +588,13 @@ static int axp22x_adc_rate(struct axp20x_adc_iio *info, int rate)
> > >  				  AXP22X_ADC_RATE_HZ(rate));
> > >  }
> > >  
> > > +static int axp813_adc_rate(struct axp20x_adc_iio *info, int rate)
> > > +{
> > > +	return regmap_update_bits(info->regmap, AXP813_ADC_RATE,
> > > +				 AXP813_ADC_RATE_MASK,
> > > +				 AXP813_ADC_RATE_HZ(rate));
> > > +}
> > > +
> > >  struct axp_data {
> > >  	const struct iio_info		*iio_info;
> > >  	int				num_channels;
> > > @@ -515,9 +626,20 @@ static const struct axp_data axp22x_data = {
> > >  	.maps = axp22x_maps,
> > >  };
> > >  
> > > +static const struct axp_data axp813_data = {
> > > +	.iio_info = &axp813_adc_iio_info,
> > > +	.num_channels = ARRAY_SIZE(axp813_adc_channels),
> > > +	.channels = axp813_adc_channels,
> > > +	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
> > > +	.adc_rate = axp813_adc_rate,
> > > +	.adc_en2 = false,
> > > +	.maps = axp22x_maps,
> > > +};
> > > +
> > >  static const struct of_device_id axp20x_adc_of_match[] = {
> > >  	{ .compatible = "x-powers,axp209-adc", .data = (void *)&axp20x_data, },
> > >  	{ .compatible = "x-powers,axp221-adc", .data = (void *)&axp22x_data, },
> > > +	{ .compatible = "x-powers,axp813-adc", .data = (void *)&axp813_data, },
> > >  	{ /* sentinel */ }
> > >  };
> > >  MODULE_DEVICE_TABLE(of, axp20x_adc_of_match);
> > > @@ -525,6 +647,7 @@ MODULE_DEVICE_TABLE(of, axp20x_adc_of_match);
> > >  static const struct platform_device_id axp20x_adc_id_match[] = {
> > >  	{ .name = "axp20x-adc", .driver_data = (kernel_ulong_t)&axp20x_data, },
> > >  	{ .name = "axp22x-adc", .driver_data = (kernel_ulong_t)&axp22x_data, },
> > > +	{ .name = "axp813-adc", .driver_data = (kernel_ulong_t)&axp813_data, },
> > >  	{ /* sentinel */ },
> > >  };
> > >  MODULE_DEVICE_TABLE(platform, axp20x_adc_id_match);
> > > diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> > > index 080798f..82bf774 100644
> > > --- a/include/linux/mfd/axp20x.h
> > > +++ b/include/linux/mfd/axp20x.h
> > > @@ -266,6 +266,8 @@ enum axp20x_variants {
> > >  #define AXP288_RT_BATT_V_H		0xa0
> > >  #define AXP288_RT_BATT_V_L		0xa1
> > >  
> > > +#define AXP813_ADC_RATE			0x85
> > > +
> > >  /* Fuel Gauge */
> > >  #define AXP288_FG_RDC1_REG          0xba
> > >  #define AXP288_FG_RDC0_REG          0xbb  
> >   
