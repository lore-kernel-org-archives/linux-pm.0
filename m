From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/7] mfd/iio: move the AB8500 GPADC to IIO
Date: Fri, 13 Jan 2017 14:56:52 +0000
Message-ID: <20170113145652.GG6864@dell>
References: <20170110234745.29691-1-linus.walleij@linaro.org>
 <20170110234745.29691-7-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170110234745.29691-7-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Mboumba Cedric Madianga <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, 11 Jan 2017, Linus Walleij wrote:

> The AB8500 GPADC driver is indeed a "general purpose ADC" driver,
> and while the IIO subsystem did not exist when the driver was
> first merged, it is never too late to clean things up and move it
> to the right place.
> 
> We have to cut a bunch of debugfs luggage to make this transition
> swift, but all these files to is read out the raw values of the
> ADC and the IIO subsystem already has a standard sysfs ABI for
> doing exactly this: no debugfs is needed.
> 
> We convert the present driver to IIO in the move.
> 
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/iio/adc/Kconfig                 |    7 +
>  drivers/iio/adc/Makefile                |    1 +
>  drivers/{mfd => iio/adc}/ab8500-gpadc.c |  469 ++++++----
>  drivers/mfd/Kconfig                     |    7 -
>  drivers/mfd/Makefile                    |    1 -
>  drivers/mfd/ab8500-debugfs.c            | 1448 +++++--------------------------
>  include/linux/mfd/abx500/ab8500-gpadc.h |   75 --
>  7 files changed, 511 insertions(+), 1497 deletions(-)
>  rename drivers/{mfd => iio/adc}/ab8500-gpadc.c (76%)
>  delete mode 100644 include/linux/mfd/abx500/ab8500-gpadc.h

Ack for it being moved out of MFD.

Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 38bc319904c4..e524bdeb3e27 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -5,6 +5,13 @@
>  
>  menu "Analog to digital converters"
>  
> +config AB8500_GPADC
> +	bool "ST-Ericsson AB8500 GPADC driver"
> +	depends on AB8500_CORE && REGULATOR_AB8500
> +	default y
> +	help
> +	  AB8500 GPADC driver used to convert Acc and battery/ac/usb voltage
> +
>  config AD_SIGMA_DELTA
>  	tristate
>  	select IIO_BUFFER
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d36c4be8d1fc..025ec9a547a8 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -3,6 +3,7 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
>  obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
>  obj-$(CONFIG_AD7266) += ad7266.o
>  obj-$(CONFIG_AD7291) += ad7291.o
> diff --git a/drivers/mfd/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
> similarity index 76%
> rename from drivers/mfd/ab8500-gpadc.c
> rename to drivers/iio/adc/ab8500-gpadc.c
> index f4e94869d612..ba4e6f5a6cb9 100644
> --- a/drivers/mfd/ab8500-gpadc.c
> +++ b/drivers/iio/adc/ab8500-gpadc.c
> @@ -6,8 +6,11 @@
>   * Author: Daniel Willerud <daniel.willerud-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
>   * Author: Johan Palsson <johan.palsson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
>   * Author: M'boumba Cedric Madianga
> + * Author: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>   */
>  #include <linux/init.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
>  #include <linux/spinlock.h>
> @@ -18,10 +21,48 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> -#include <linux/list.h>
>  #include <linux/mfd/abx500.h>
>  #include <linux/mfd/abx500/ab8500.h>
> -#include <linux/mfd/abx500/ab8500-gpadc.h>
> +
> +/* GPADC source: From datasheet(ADCSwSel[4:0] in GPADCCtrl2
> + * and ADCHwSel[4:0] in GPADCCtrl3 ) */
> +#define BAT_CTRL		0x01
> +#define BTEMP_BALL		0x02
> +#define MAIN_CHARGER_V		0x03
> +#define ACC_DETECT1		0x04
> +#define ACC_DETECT2		0x05
> +#define ADC_AUX1		0x06
> +#define ADC_AUX2		0x07
> +#define MAIN_BAT_V		0x08
> +#define VBUS_V			0x09
> +#define MAIN_CHARGER_C		0x0A
> +#define USB_CHARGER_C		0x0B
> +#define BK_BAT_V		0x0C
> +#define DIE_TEMP		0x0D
> +#define USB_ID			0x0E
> +#define XTAL_TEMP		0x12
> +#define VBAT_TRUE_MEAS		0x13
> +#define BAT_CTRL_AND_IBAT	0x1C
> +#define VBAT_MEAS_AND_IBAT	0x1D
> +#define VBAT_TRUE_MEAS_AND_IBAT	0x1E
> +#define BAT_TEMP_AND_IBAT	0x1F
> +
> +/* Virtual channel used only for ibat convertion to ampere
> + * Battery current conversion (ibat) cannot be requested as a single conversion
> + *  but it is always in combination with other input requests
> + */
> +#define IBAT_VIRTUAL_CHANNEL		0xFF
> +
> +#define SAMPLE_1        1
> +#define SAMPLE_4        4
> +#define SAMPLE_8        8
> +#define SAMPLE_16       16
> +#define RISING_EDGE     0
> +#define FALLING_EDGE    1
> +
> +/* Arbitrary ADC conversion type constants */
> +#define ADC_SW				0
> +#define ADC_HW				1
>  
>  /*
>   * GPADC register offsets
> @@ -140,11 +181,27 @@ struct adc_cal_data {
>  };
>  
>  /**
> + * struct ab8500_gpadc_chan_info - per-channel GPADC info
> + * @name: name of the channel
> + * @id: the internal AB8500 ID number for the channel
> + */
> +struct ab8500_gpadc_chan_info {
> +	const char *name;
> +	u8 id;
> +	u8 avg_sample;
> +	u8 trig_edge;
> +	u8 trig_timer;
> +	u8 conv_type;
> +};
> +
> +
> +/**
>   * struct ab8500_gpadc - AB8500 GPADC device information
>   * @dev:			pointer to the struct device
> - * @node:			a list of AB8500 GPADCs, hence prepared for
> -				reentrance
> - * @parent:			pointer to the struct ab8500
> + * @ab8500:			pointer to the struct ab8500
> + * @nchans:			number of IIO channels
> + * @chans:			Internal channel information container
> + * @iio_chans:			IIO channels
>   * @ab8500_gpadc_complete:	pointer to the struct completion, to indicate
>   *				the completion of gpadc conversion
>   * @ab8500_gpadc_lock:		structure of type mutex
> @@ -157,8 +214,10 @@ struct adc_cal_data {
>   */
>  struct ab8500_gpadc {
>  	struct device *dev;
> -	struct list_head node;
> -	struct ab8500 *parent;
> +	struct ab8500 *ab8500;
> +	unsigned int nchans;
> +	struct ab8500_gpadc_chan_info *chans;
> +	struct iio_chan_spec *iio_chans;
>  	struct completion ab8500_gpadc_complete;
>  	struct mutex ab8500_gpadc_lock;
>  	struct regulator *regu;
> @@ -167,29 +226,27 @@ struct ab8500_gpadc {
>  	struct adc_cal_data cal_data[NBR_CAL_INPUTS];
>  };
>  
> -static LIST_HEAD(ab8500_gpadc_list);
> -
> -/**
> - * ab8500_gpadc_get() - returns a reference to the primary AB8500 GPADC
> - * (i.e. the first GPADC in the instance list)
> - */
> -struct ab8500_gpadc *ab8500_gpadc_get(char *name)
> +static struct ab8500_gpadc_chan_info *
> +ab8500_gpadc_get_channel(struct ab8500_gpadc *gpadc, u8 chan)
>  {
> -	struct ab8500_gpadc *gpadc;
> +	struct ab8500_gpadc_chan_info *ch;
> +	int i;
>  
> -	list_for_each_entry(gpadc, &ab8500_gpadc_list, node) {
> -		if (!strcmp(name, dev_name(gpadc->dev)))
> -			return gpadc;
> +	for (i = 0; i < gpadc->nchans; i++) {
> +		ch = &gpadc->chans[i];
> +		if (ch->id == chan)
> +			break;
>  	}
> +	if (i == gpadc->nchans)
> +		return NULL;
>  
> -	return ERR_PTR(-ENOENT);
> +	return ch;
>  }
> -EXPORT_SYMBOL(ab8500_gpadc_get);
>  
>  /**
>   * ab8500_gpadc_ad_to_voltage() - Convert a raw ADC value to a voltage
>   */
> -int ab8500_gpadc_ad_to_voltage(struct ab8500_gpadc *gpadc, u8 channel,
> +static int ab8500_gpadc_ad_to_voltage(struct ab8500_gpadc *gpadc, u8 channel,
>  	int ad_value)
>  {
>  	int res;
> @@ -294,70 +351,11 @@ int ab8500_gpadc_ad_to_voltage(struct ab8500_gpadc *gpadc, u8 channel,
>  	}
>  	return res;
>  }
> -EXPORT_SYMBOL(ab8500_gpadc_ad_to_voltage);
> -
> -/**
> - * ab8500_gpadc_sw_hw_convert() - gpadc conversion
> - * @channel:	analog channel to be converted to digital data
> - * @avg_sample:  number of ADC sample to average
> - * @trig_egde:  selected ADC trig edge
> - * @trig_timer: selected ADC trigger delay timer
> - * @conv_type: selected conversion type (HW or SW conversion)
> - *
> - * This function converts the selected analog i/p to digital
> - * data.
> - */
> -int ab8500_gpadc_sw_hw_convert(struct ab8500_gpadc *gpadc, u8 channel,
> -		u8 avg_sample, u8 trig_edge, u8 trig_timer, u8 conv_type)
> -{
> -	int ad_value;
> -	int voltage;
> -
> -	ad_value = ab8500_gpadc_read_raw(gpadc, channel, avg_sample,
> -			trig_edge, trig_timer, conv_type);
> -
> -	/* On failure retry a second time */
> -	if (ad_value < 0)
> -		ad_value = ab8500_gpadc_read_raw(gpadc, channel, avg_sample,
> -			trig_edge, trig_timer, conv_type);
> -	if (ad_value < 0) {
> -		dev_err(gpadc->dev, "GPADC raw value failed ch: %d\n",
> -				channel);
> -		return ad_value;
> -	}
> -
> -	voltage = ab8500_gpadc_ad_to_voltage(gpadc, channel, ad_value);
> -	if (voltage < 0)
> -		dev_err(gpadc->dev,
> -			"GPADC to voltage conversion failed ch: %d AD: 0x%x\n",
> -			channel, ad_value);
> -
> -	return voltage;
> -}
> -EXPORT_SYMBOL(ab8500_gpadc_sw_hw_convert);
> -
> -/**
> - * ab8500_gpadc_read_raw() - gpadc read
> - * @channel:	analog channel to be read
> - * @avg_sample:  number of ADC sample to average
> - * @trig_edge:  selected trig edge
> - * @trig_timer: selected ADC trigger delay timer
> - * @conv_type: selected conversion type (HW or SW conversion)
> - *
> - * This function obtains the raw ADC value for an hardware conversion,
> - * this then needs to be converted by calling ab8500_gpadc_ad_to_voltage()
> - */
> -int ab8500_gpadc_read_raw(struct ab8500_gpadc *gpadc, u8 channel,
> -		u8 avg_sample, u8 trig_edge, u8 trig_timer, u8 conv_type)
> -{
> -	return ab8500_gpadc_double_read_raw(gpadc, channel, avg_sample,
> -					    trig_edge, trig_timer, conv_type,
> -					    NULL);
> -}
>  
> -int ab8500_gpadc_double_read_raw(struct ab8500_gpadc *gpadc, u8 channel,
> -		u8 avg_sample, u8 trig_edge, u8 trig_timer, u8 conv_type,
> -		int *ibat)
> +static int ab8500_gpadc_read(struct ab8500_gpadc *gpadc, u8 channel,
> +			     u8 avg_sample, u8 trig_edge,
> +			     u8 trig_timer, u8 conv_type,
> +			     int *ibat)
>  {
>  	int ret;
>  	int looplimit = 0;
> @@ -442,7 +440,7 @@ int ab8500_gpadc_double_read_raw(struct ab8500_gpadc *gpadc, u8 channel,
>  		val_reg1 |= EN_BUF | EN_ICHAR;
>  		break;
>  	case BTEMP_BALL:
> -		if (!is_ab8500_2p0_or_earlier(gpadc->parent)) {
> +		if (!is_ab8500_2p0_or_earlier(gpadc->ab8500)) {
>  			val_reg1 |= EN_BUF | BTEMP_PULL_UP;
>  			/*
>  			* Delay might be needed for ABB8500 cut 3.0, if not,
> @@ -593,7 +591,6 @@ int ab8500_gpadc_double_read_raw(struct ab8500_gpadc *gpadc, u8 channel,
>  		"gpadc_conversion: Failed to AD convert channel %d\n", channel);
>  	return ret;
>  }
> -EXPORT_SYMBOL(ab8500_gpadc_read_raw);
>  
>  /**
>   * ab8500_bm_gpadcconvend_handler() - isr for gpadc conversion completion
> @@ -605,9 +602,9 @@ EXPORT_SYMBOL(ab8500_gpadc_read_raw);
>   * can be read from the registers.
>   * Returns IRQ status(IRQ_HANDLED)
>   */
> -static irqreturn_t ab8500_bm_gpadcconvend_handler(int irq, void *_gpadc)
> +static irqreturn_t ab8500_bm_gpadcconvend_handler(int irq, void *data)
>  {
> -	struct ab8500_gpadc *gpadc = _gpadc;
> +	struct ab8500_gpadc *gpadc = data;
>  
>  	complete(&gpadc->ab8500_gpadc_complete);
>  
> @@ -644,7 +641,7 @@ static void ab8500_gpadc_read_calibration_data(struct ab8500_gpadc *gpadc)
>  	s64 V_gain, V_offset, V2A_gain, V2A_offset;
>  	struct ab8500 *ab8500;
>  
> -	ab8500 = gpadc->parent;
> +	ab8500 = gpadc->ab8500;
>  
>  	/* First we read all OTP registers and store the error code */
>  	for (i = 0; i < ARRAY_SIZE(otp_cal_regs); i++) {
> @@ -868,10 +865,68 @@ static void ab8500_gpadc_read_calibration_data(struct ab8500_gpadc *gpadc)
>  		gpadc->cal_data[ADC_INPUT_VBAT].offset);
>  }
>  
> +static int ab8500_gpadc_read_raw(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  int *val, int *val2, long mask)
> +{
> +	struct ab8500_gpadc *gpadc = iio_priv(indio_dev);
> +	const struct ab8500_gpadc_chan_info *ch;
> +	int raw_val;
> +	int processed;
> +
> +	ch = ab8500_gpadc_get_channel(gpadc, chan->address);
> +	if (!ch) {
> +		dev_err(gpadc->dev, "no such channel %lu\n",
> +			chan->address);
> +		return -EINVAL;
> +	}
> +
> +	dev_info(gpadc->dev, "read channel %d\n", ch->id);
> +
> +	raw_val = ab8500_gpadc_read(gpadc, ch->id, ch->avg_sample,
> +				    ch->trig_edge, ch->trig_timer,
> +				    ch->conv_type, NULL);
> +	if (raw_val < 0)
> +		return raw_val;
> +
> +	if (mask == IIO_CHAN_INFO_RAW) {
> +		*val = raw_val;
> +		return IIO_VAL_INT;
> +	}
> +
> +	processed = ab8500_gpadc_ad_to_voltage(gpadc, ch->id, raw_val);
> +	if (processed < 0)
> +		return processed;
> +
> +	/* Return millivolt or milliamps or millicentigrades */
> +	*val = processed * 1000;
> +	return IIO_VAL_INT;
> +}
> +
> +static int ab8500_gpadc_of_xlate(struct iio_dev *indio_dev,
> +				 const struct of_phandle_args *iiospec)
> +{
> +	struct ab8500_gpadc *gpadc = iio_priv(indio_dev);
> +	unsigned int i;
> +
> +	for (i = 0; i < gpadc->nchans; i++)
> +		if (gpadc->iio_chans[i].channel == iiospec->args[0])
> +			return i;
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info ab8500_gpadc_info = {
> +	.driver_module = THIS_MODULE,
> +	.of_xlate = ab8500_gpadc_of_xlate,
> +	.read_raw = ab8500_gpadc_read_raw,
> +};
> +
>  #ifdef CONFIG_PM
>  static int ab8500_gpadc_runtime_suspend(struct device *dev)
>  {
> -	struct ab8500_gpadc *gpadc = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ab8500_gpadc *gpadc = iio_priv(indio_dev);
>  
>  	regulator_disable(gpadc->regu);
>  	return 0;
> @@ -879,7 +934,8 @@ static int ab8500_gpadc_runtime_suspend(struct device *dev)
>  
>  static int ab8500_gpadc_runtime_resume(struct device *dev)
>  {
> -	struct ab8500_gpadc *gpadc = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ab8500_gpadc *gpadc = iio_priv(indio_dev);
>  	int ret;
>  
>  	ret = regulator_enable(gpadc->regu);
> @@ -887,12 +943,11 @@ static int ab8500_gpadc_runtime_resume(struct device *dev)
>  		dev_err(dev, "Failed to enable vtvout LDO: %d\n", ret);
>  	return ret;
>  }
> -#endif
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int ab8500_gpadc_suspend(struct device *dev)
>  {
> -	struct ab8500_gpadc *gpadc = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ab8500_gpadc *gpadc = iio_priv(indio_dev);
>  
>  	mutex_lock(&gpadc->ab8500_gpadc_lock);
>  
> @@ -904,7 +959,8 @@ static int ab8500_gpadc_suspend(struct device *dev)
>  
>  static int ab8500_gpadc_resume(struct device *dev)
>  {
> -	struct ab8500_gpadc *gpadc = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ab8500_gpadc *gpadc = iio_priv(indio_dev);
>  	int ret;
>  
>  	ret = regulator_enable(gpadc->regu);
> @@ -919,114 +975,207 @@ static int ab8500_gpadc_resume(struct device *dev)
>  }
>  #endif
>  
> +static int ab8500_gpadc_parse_channel(struct device *dev,
> +				      struct device_node *np,
> +				      struct ab8500_gpadc_chan_info *ch,
> +				      struct iio_chan_spec *iio_chan)
> +{
> +	const char *name = np->name;
> +	u32 chan;
> +	int ret;
> +
> +	ret = of_property_read_u32(np, "reg", &chan);
> +	if (ret) {
> +		dev_err(dev, "invalid channel number %s\n", name);
> +		return ret;
> +	}
> +	if (chan > BAT_TEMP_AND_IBAT) {
> +		dev_err(dev, "%s too big channel number %d\n", name, chan);
> +		return -EINVAL;
> +	}
> +
> +	iio_chan->channel = chan;
> +	iio_chan->datasheet_name = name;
> +	iio_chan->indexed = 1;
> +	iio_chan->address = chan;
> +	iio_chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +	/* All are voltages */
> +	iio_chan->type = IIO_VOLTAGE;
> +
> +	ch->id = chan;
> +
> +	/* Sensible defaults */
> +	ch->avg_sample = SAMPLE_16;
> +	ch->trig_edge = RISING_EDGE;
> +	ch->conv_type = ADC_SW;
> +	ch->trig_timer = 0;
> +
> +	return 0;
> +}
> +
> +static int ab8500_gpadc_parse_channels(struct ab8500_gpadc *gpadc,
> +				       struct device_node *np)
> +{
> +	struct device_node *child;
> +	struct ab8500_gpadc_chan_info *ch;
> +	int i;
> +
> +	gpadc->nchans = of_get_available_child_count(np);
> +	if (!gpadc->nchans) {
> +		dev_err(gpadc->dev, "no channel children\n");
> +		return -ENODEV;
> +	}
> +	dev_info(gpadc->dev, "found %d ADC channels\n", gpadc->nchans);
> +
> +	gpadc->iio_chans = devm_kcalloc(gpadc->dev, gpadc->nchans,
> +					sizeof(*gpadc->iio_chans), GFP_KERNEL);
> +	if (!gpadc->iio_chans)
> +		return -ENOMEM;
> +
> +	gpadc->chans = devm_kcalloc(gpadc->dev, gpadc->nchans,
> +				    sizeof(*gpadc->chans), GFP_KERNEL);
> +	if (!gpadc->chans)
> +		return -ENOMEM;
> +
> +	i = 0;
> +	for_each_available_child_of_node(np, child) {
> +		struct iio_chan_spec *iio_chan;
> +		int ret;
> +
> +		ch = &gpadc->chans[i];
> +		iio_chan = &gpadc->iio_chans[i];
> +
> +		ret = ab8500_gpadc_parse_channel(gpadc->dev, child, ch, iio_chan);
> +		if (ret) {
> +			of_node_put(child);
> +			return ret;
> +		}
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ab8500_gpadc_probe(struct platform_device *pdev)
>  {
>  	int ret = 0;
>  	struct ab8500_gpadc *gpadc;
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = pdev->dev.of_node;
>  
> -	gpadc = devm_kzalloc(&pdev->dev,
> -			     sizeof(struct ab8500_gpadc), GFP_KERNEL);
> -	if (!gpadc)
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*gpadc));
> +	if (!indio_dev)
>  		return -ENOMEM;
> +	platform_set_drvdata(pdev, indio_dev);
> +	gpadc = iio_priv(indio_dev);
> +
> +	gpadc->dev = dev;
> +	gpadc->ab8500 = dev_get_drvdata(pdev->dev.parent);
> +	mutex_init(&gpadc->ab8500_gpadc_lock);
> +
> +	ret = ab8500_gpadc_parse_channels(gpadc, np);
>  
>  	gpadc->irq_sw = platform_get_irq_byname(pdev, "SW_CONV_END");
> -	if (gpadc->irq_sw < 0)
> -		dev_err(gpadc->dev, "failed to get platform sw_conv_end irq\n");
> +	if (gpadc->irq_sw < 0) {
> +		dev_err(dev, "failed to get platform sw_conv_end irq\n");
> +		return gpadc->irq_sw;
> +	}
>  
>  	gpadc->irq_hw = platform_get_irq_byname(pdev, "HW_CONV_END");
> -	if (gpadc->irq_hw < 0)
> -		dev_err(gpadc->dev, "failed to get platform hw_conv_end irq\n");
> -
> -	gpadc->dev = &pdev->dev;
> -	gpadc->parent = dev_get_drvdata(pdev->dev.parent);
> -	mutex_init(&gpadc->ab8500_gpadc_lock);
> +	if (gpadc->irq_hw < 0) {
> +		dev_err(dev, "failed to get platform hw_conv_end irq\n");
> +		return gpadc->irq_hw;
> +	}
>  
>  	/* Initialize completion used to notify completion of conversion */
>  	init_completion(&gpadc->ab8500_gpadc_complete);
>  
>  	/* Register interrupts */
> -	if (gpadc->irq_sw >= 0) {
> -		ret = request_threaded_irq(gpadc->irq_sw, NULL,
> -			ab8500_bm_gpadcconvend_handler,
> -			IRQF_NO_SUSPEND | IRQF_SHARED | IRQF_ONESHOT,
> -			"ab8500-gpadc-sw",
> -			gpadc);
> -		if (ret < 0) {
> -			dev_err(gpadc->dev,
> -				"Failed to register interrupt irq: %d\n",
> -				gpadc->irq_sw);
> -			goto fail;
> -		}
> +	ret = devm_request_threaded_irq(dev,
> +		gpadc->irq_sw, NULL,
> +		ab8500_bm_gpadcconvend_handler,
> +		IRQF_NO_SUSPEND | IRQF_SHARED | IRQF_ONESHOT,
> +		"ab8500-gpadc-sw",
> +		gpadc);
> +	if (ret < 0) {
> +		dev_err(dev,
> +			"failed to request interrupt irq %d\n",
> +			gpadc->irq_sw);
> +		return ret;
>  	}
>  
> -	if (gpadc->irq_hw >= 0) {
> -		ret = request_threaded_irq(gpadc->irq_hw, NULL,
> -			ab8500_bm_gpadcconvend_handler,
> -			IRQF_NO_SUSPEND | IRQF_SHARED | IRQF_ONESHOT,
> -			"ab8500-gpadc-hw",
> -			gpadc);
> -		if (ret < 0) {
> -			dev_err(gpadc->dev,
> -				"Failed to register interrupt irq: %d\n",
> -				gpadc->irq_hw);
> -			goto fail_irq;
> -		}
> +	ret = devm_request_threaded_irq(dev,
> +		gpadc->irq_hw, NULL,
> +		ab8500_bm_gpadcconvend_handler,
> +		IRQF_NO_SUSPEND | IRQF_SHARED | IRQF_ONESHOT,
> +		"ab8500-gpadc-hw",
> +		gpadc);
> +	if (ret < 0) {
> +		dev_err(dev,
> +			"Failed to register interrupt irq: %d\n",
> +			gpadc->irq_hw);
> +		return ret;
>  	}
>  
> -	/* VTVout LDO used to power up ab8500-GPADC */
> -	gpadc->regu = devm_regulator_get(&pdev->dev, "vddadc");
> +	/* The VTVout LDO used to power the AB8500 GPADC */
> +	gpadc->regu = devm_regulator_get(dev, "vddadc");
>  	if (IS_ERR(gpadc->regu)) {
>  		ret = PTR_ERR(gpadc->regu);
> -		dev_err(gpadc->dev, "failed to get vtvout LDO\n");
> -		goto fail_irq;
> +		dev_err(dev, "failed to get vtvout LDO\n");
> +		return ret;
>  	}
>  
> -	platform_set_drvdata(pdev, gpadc);
> -
>  	ret = regulator_enable(gpadc->regu);
>  	if (ret) {
> -		dev_err(gpadc->dev, "Failed to enable vtvout LDO: %d\n", ret);
> -		goto fail_enable;
> +		dev_err(dev, "failed to enable vtvout LDO: %d\n", ret);
> +		return ret;
>  	}
>  
> -	pm_runtime_set_autosuspend_delay(gpadc->dev, GPADC_AUDOSUSPEND_DELAY);
> -	pm_runtime_use_autosuspend(gpadc->dev);
> -	pm_runtime_set_active(gpadc->dev);
> -	pm_runtime_enable(gpadc->dev);
> +	pm_runtime_set_autosuspend_delay(dev, GPADC_AUDOSUSPEND_DELAY);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
>  
>  	ab8500_gpadc_read_calibration_data(gpadc);
> -	list_add_tail(&gpadc->node, &ab8500_gpadc_list);
> -	dev_dbg(gpadc->dev, "probe success\n");
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->dev.of_node = np;
> +	indio_dev->name = "ab8500-gpadc";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ab8500_gpadc_info;
> +	indio_dev->channels = gpadc->iio_chans;
> +	indio_dev->num_channels = gpadc->nchans;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto out_dis_pm;
> +
> +	dev_info(dev, "AB8500 GPADC initialized\n");
>  
>  	return 0;
>  
> -fail_enable:
> -fail_irq:
> -	free_irq(gpadc->irq_sw, gpadc);
> -	free_irq(gpadc->irq_hw, gpadc);
> -fail:
> +out_dis_pm:
> +	pm_runtime_get_sync(dev);
> +	pm_runtime_disable(dev);
> +	regulator_disable(gpadc->regu);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_put_noidle(dev);
> +
>  	return ret;
>  }
>  
>  static int ab8500_gpadc_remove(struct platform_device *pdev)
>  {
> -	struct ab8500_gpadc *gpadc = platform_get_drvdata(pdev);
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct ab8500_gpadc *gpadc = iio_priv(indio_dev);
>  
> -	/* remove this gpadc entry from the list */
> -	list_del(&gpadc->node);
> -	/* remove interrupt  - completion of Sw ADC conversion */
> -	if (gpadc->irq_sw >= 0)
> -		free_irq(gpadc->irq_sw, gpadc);
> -	if (gpadc->irq_hw >= 0)
> -		free_irq(gpadc->irq_hw, gpadc);
> +	iio_device_unregister(indio_dev);
>  
>  	pm_runtime_get_sync(gpadc->dev);
>  	pm_runtime_disable(gpadc->dev);
> -
>  	regulator_disable(gpadc->regu);
> -
>  	pm_runtime_set_suspended(gpadc->dev);
> -
>  	pm_runtime_put_noidle(gpadc->dev);
>  
>  	return 0;
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 4ce3b6f11830..d64a2447c963 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1022,13 +1022,6 @@ config AB8500_DEBUG
>           Select this option if you want debug information using the debug
>           filesystem, debugfs.
>  
> -config AB8500_GPADC
> -	bool "ST-Ericsson AB8500 GPADC driver"
> -	depends on AB8500_CORE && REGULATOR_AB8500
> -	default y
> -	help
> -	  AB8500 GPADC driver used to convert Acc and battery/ac/usb voltage
> -
>  config MFD_DB8500_PRCMU
>  	bool "ST-Ericsson DB8500 Power Reset Control Management Unit"
>  	depends on UX500_SOC_DB8500
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index dda4d4f73ad7..9870e2b1777a 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -150,7 +150,6 @@ obj-$(CONFIG_ABX500_CORE)	+= abx500-core.o
>  obj-$(CONFIG_AB3100_CORE)	+= ab3100-core.o
>  obj-$(CONFIG_AB3100_OTP)	+= ab3100-otp.o
>  obj-$(CONFIG_AB8500_DEBUG)	+= ab8500-debugfs.o
> -obj-$(CONFIG_AB8500_GPADC)	+= ab8500-gpadc.o
>  obj-$(CONFIG_MFD_DB8500_PRCMU)	+= db8500-prcmu.o
>  # ab8500-core need to come after db8500-prcmu (which provides the channel)
>  obj-$(CONFIG_AB8500_CORE)	+= ab8500-core.o ab8500-sysctrl.o
> diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
> index c1c815241e02..cdb6cdc1002b 100644
> --- a/drivers/mfd/ab8500-debugfs.c
> +++ b/drivers/mfd/ab8500-debugfs.c
> @@ -84,7 +84,6 @@
>  
>  #include <linux/mfd/abx500.h>
>  #include <linux/mfd/abx500/ab8500.h>
> -#include <linux/mfd/abx500/ab8500-gpadc.h>
>  
>  #ifdef CONFIG_DEBUG_FS
>  #include <linux/string.h>
> @@ -103,11 +102,6 @@ static int num_irqs;
>  static struct device_attribute **dev_attr;
>  static char **event_name;
>  
> -static u8 avg_sample = SAMPLE_16;
> -static u8 trig_edge = RISING_EDGE;
> -static u8 conv_type = ADC_SW;
> -static u8 trig_timer;
> -
>  /**
>   * struct ab8500_reg_range
>   * @first: the first address of the range
> @@ -152,7 +146,6 @@ static struct hwreg_cfg hwreg_cfg = {
>  };
>  
>  #define AB8500_NAME_STRING "ab8500"
> -#define AB8500_ADC_NAME_STRING "gpadc"
>  #define AB8500_NUM_BANKS AB8500_DEBUG_FIELD_LAST
>  
>  #define AB8500_REV_REG 0x80
> @@ -1670,1130 +1663,242 @@ static const struct file_operations ab8500_modem_fops = {
>  	.owner = THIS_MODULE,
>  };
>  
> -static int ab8500_gpadc_bat_ctrl_print(struct seq_file *s, void *p)
> +/*
> + * return length of an ASCII numerical value, 0 is string is not a
> + * numerical value.
> + * string shall start at value 1st char.
> + * string can be tailed with \0 or space or newline chars only.
> + * value can be decimal or hexadecimal (prefixed 0x or 0X).
> + */
> +static int strval_len(char *b)
>  {
> -	int bat_ctrl_raw;
> -	int bat_ctrl_convert;
> -	struct ab8500_gpadc *gpadc;
> -
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	bat_ctrl_raw = ab8500_gpadc_read_raw(gpadc, BAT_CTRL,
> -		avg_sample, trig_edge, trig_timer, conv_type);
> -	bat_ctrl_convert = ab8500_gpadc_ad_to_voltage(gpadc,
> -		BAT_CTRL, bat_ctrl_raw);
> -
> -	seq_printf(s, "%d,0x%X\n", bat_ctrl_convert, bat_ctrl_raw);
> +	char *s = b;
>  
> -	return 0;
> +	if ((*s == '0') && ((*(s+1) == 'x') || (*(s+1) == 'X'))) {
> +		s += 2;
> +		for (; *s && (*s != ' ') && (*s != '\n'); s++) {
> +			if (!isxdigit(*s))
> +				return 0;
> +		}
> +	} else {
> +		if (*s == '-')
> +			s++;
> +		for (; *s && (*s != ' ') && (*s != '\n'); s++) {
> +			if (!isdigit(*s))
> +				return 0;
> +		}
> +	}
> +	return (int) (s-b);
>  }
>  
> -static int ab8500_gpadc_bat_ctrl_open(struct inode *inode, struct file *file)
> +/*
> + * parse hwreg input data.
> + * update global hwreg_cfg only if input data syntax is ok.
> + */
> +static ssize_t hwreg_common_write(char *b, struct hwreg_cfg *cfg,
> +		struct device *dev)
>  {
> -	return single_open(file, ab8500_gpadc_bat_ctrl_print,
> -			   inode->i_private);
> -}
> -
> -static const struct file_operations ab8500_gpadc_bat_ctrl_fops = {
> -	.open = ab8500_gpadc_bat_ctrl_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> +	uint write, val = 0;
> +	u8  regvalue;
> +	int ret;
> +	struct hwreg_cfg loc = {
> +		.bank = 0,          /* default: invalid phys addr */
> +		.addr = 0,          /* default: invalid phys addr */
> +		.fmt = 0,           /* default: 32bit access, hex output */
> +		.mask = 0xFFFFFFFF, /* default: no mask */
> +		.shift = 0,         /* default: no bit shift */
> +	};
>  
> -static int ab8500_gpadc_btemp_ball_print(struct seq_file *s, void *p)
> -{
> -	int btemp_ball_raw;
> -	int btemp_ball_convert;
> -	struct ab8500_gpadc *gpadc;
> +	/* read or write ? */
> +	if (!strncmp(b, "read ", 5)) {
> +		write = 0;
> +		b += 5;
> +	} else if (!strncmp(b, "write ", 6)) {
> +		write = 1;
> +		b += 6;
> +	} else
> +		return -EINVAL;
>  
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	btemp_ball_raw = ab8500_gpadc_read_raw(gpadc, BTEMP_BALL,
> -		avg_sample, trig_edge, trig_timer, conv_type);
> -	btemp_ball_convert = ab8500_gpadc_ad_to_voltage(gpadc, BTEMP_BALL,
> -		btemp_ball_raw);
> +	/* OPTIONS -l|-w|-b -s -m -o */
> +	while ((*b == ' ') || (*b == '-')) {
> +		if (*(b-1) != ' ') {
> +			b++;
> +			continue;
> +		}
> +		if ((!strncmp(b, "-d ", 3)) ||
> +				(!strncmp(b, "-dec ", 5))) {
> +			b += (*(b+2) == ' ') ? 3 : 5;
> +			loc.fmt |= (1<<0);
> +		} else if ((!strncmp(b, "-h ", 3)) ||
> +				(!strncmp(b, "-hex ", 5))) {
> +			b += (*(b+2) == ' ') ? 3 : 5;
> +			loc.fmt &= ~(1<<0);
> +		} else if ((!strncmp(b, "-m ", 3)) ||
> +				(!strncmp(b, "-mask ", 6))) {
> +			b += (*(b+2) == ' ') ? 3 : 6;
> +			if (strval_len(b) == 0)
> +				return -EINVAL;
> +			ret = kstrtoul(b, 0, &loc.mask);
> +			if (ret)
> +				return ret;
> +		} else if ((!strncmp(b, "-s ", 3)) ||
> +				(!strncmp(b, "-shift ", 7))) {
> +			b += (*(b+2) == ' ') ? 3 : 7;
> +			if (strval_len(b) == 0)
> +				return -EINVAL;
> +			ret = kstrtol(b, 0, &loc.shift);
> +			if (ret)
> +				return ret;
> +		} else {
> +			return -EINVAL;
> +		}
> +	}
> +	/* get arg BANK and ADDRESS */
> +	if (strval_len(b) == 0)
> +		return -EINVAL;
> +	ret = kstrtouint(b, 0, &loc.bank);
> +	if (ret)
> +		return ret;
> +	while (*b == ' ')
> +		b++;
> +	if (strval_len(b) == 0)
> +		return -EINVAL;
> +	ret = kstrtoul(b, 0, &loc.addr);
> +	if (ret)
> +		return ret;
>  
> -	seq_printf(s, "%d,0x%X\n", btemp_ball_convert, btemp_ball_raw);
> +	if (write) {
> +		while (*b == ' ')
> +			b++;
> +		if (strval_len(b) == 0)
> +			return -EINVAL;
> +		ret = kstrtouint(b, 0, &val);
> +		if (ret)
> +			return ret;
> +	}
>  
> -	return 0;
> -}
> +	/* args are ok, update target cfg (mainly for read) */
> +	*cfg = loc;
>  
> -static int ab8500_gpadc_btemp_ball_open(struct inode *inode,
> -					struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_btemp_ball_print,
> -			   inode->i_private);
> -}
> +#ifdef ABB_HWREG_DEBUG
> +	pr_warn("HWREG request: %s, %s,\n", (write) ? "write" : "read",
> +		REG_FMT_DEC(cfg) ? "decimal" : "hexa");
> +	pr_warn("  addr=0x%08X, mask=0x%X, shift=%d" "value=0x%X\n",
> +		cfg->addr, cfg->mask, cfg->shift, val);
> +#endif
>  
> -static const struct file_operations ab8500_gpadc_btemp_ball_fops = {
> -	.open = ab8500_gpadc_btemp_ball_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> +	if (!write)
> +		return 0;
>  
> -static int ab8500_gpadc_main_charger_v_print(struct seq_file *s, void *p)
> -{
> -	int main_charger_v_raw;
> -	int main_charger_v_convert;
> -	struct ab8500_gpadc *gpadc;
> +	ret = abx500_get_register_interruptible(dev,
> +			(u8)cfg->bank, (u8)cfg->addr, &regvalue);
> +	if (ret < 0) {
> +		dev_err(dev, "abx500_get_reg fail %d, %d\n",
> +			ret, __LINE__);
> +		return -EINVAL;
> +	}
>  
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	main_charger_v_raw = ab8500_gpadc_read_raw(gpadc, MAIN_CHARGER_V,
> -		avg_sample, trig_edge, trig_timer, conv_type);
> -	main_charger_v_convert = ab8500_gpadc_ad_to_voltage(gpadc,
> -		MAIN_CHARGER_V, main_charger_v_raw);
> +	if (cfg->shift >= 0) {
> +		regvalue &= ~(cfg->mask << (cfg->shift));
> +		val = (val & cfg->mask) << (cfg->shift);
> +	} else {
> +		regvalue &= ~(cfg->mask >> (-cfg->shift));
> +		val = (val & cfg->mask) >> (-cfg->shift);
> +	}
> +	val = val | regvalue;
>  
> -	seq_printf(s, "%d,0x%X\n", main_charger_v_convert, main_charger_v_raw);
> +	ret = abx500_set_register_interruptible(dev,
> +			(u8)cfg->bank, (u8)cfg->addr, (u8)val);
> +	if (ret < 0) {
> +		pr_err("abx500_set_reg failed %d, %d", ret, __LINE__);
> +		return -EINVAL;
> +	}
>  
>  	return 0;
>  }
>  
> -static int ab8500_gpadc_main_charger_v_open(struct inode *inode,
> -					    struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_main_charger_v_print,
> -		inode->i_private);
> -}
> -
> -static const struct file_operations ab8500_gpadc_main_charger_v_fops = {
> -	.open = ab8500_gpadc_main_charger_v_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_acc_detect1_print(struct seq_file *s, void *p)
> +static ssize_t ab8500_hwreg_write(struct file *file,
> +	const char __user *user_buf, size_t count, loff_t *ppos)
>  {
> -	int acc_detect1_raw;
> -	int acc_detect1_convert;
> -	struct ab8500_gpadc *gpadc;
> -
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	acc_detect1_raw = ab8500_gpadc_read_raw(gpadc, ACC_DETECT1,
> -		avg_sample, trig_edge, trig_timer, conv_type);
> -	acc_detect1_convert = ab8500_gpadc_ad_to_voltage(gpadc, ACC_DETECT1,
> -		acc_detect1_raw);
> -
> -	seq_printf(s, "%d,0x%X\n", acc_detect1_convert, acc_detect1_raw);
> +	struct device *dev = ((struct seq_file *)(file->private_data))->private;
> +	char buf[128];
> +	int buf_size, ret;
>  
> -	return 0;
> -}
> +	/* Get userspace string and assure termination */
> +	buf_size = min(count, (sizeof(buf)-1));
> +	if (copy_from_user(buf, user_buf, buf_size))
> +		return -EFAULT;
> +	buf[buf_size] = 0;
>  
> -static int ab8500_gpadc_acc_detect1_open(struct inode *inode,
> -					 struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_acc_detect1_print,
> -		inode->i_private);
> +	/* get args and process */
> +	ret = hwreg_common_write(buf, &hwreg_cfg, dev);
> +	return (ret) ? ret : buf_size;
>  }
>  
> -static const struct file_operations ab8500_gpadc_acc_detect1_fops = {
> -	.open = ab8500_gpadc_acc_detect1_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_acc_detect2_print(struct seq_file *s, void *p)
> +/*
> + * - irq subscribe/unsubscribe stuff
> + */
> +static int ab8500_subscribe_unsubscribe_print(struct seq_file *s, void *p)
>  {
> -	int acc_detect2_raw;
> -	int acc_detect2_convert;
> -	struct ab8500_gpadc *gpadc;
> -
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	acc_detect2_raw = ab8500_gpadc_read_raw(gpadc, ACC_DETECT2,
> -		avg_sample, trig_edge, trig_timer, conv_type);
> -	acc_detect2_convert = ab8500_gpadc_ad_to_voltage(gpadc,
> -		ACC_DETECT2, acc_detect2_raw);
> -
> -	seq_printf(s, "%d,0x%X\n", acc_detect2_convert, acc_detect2_raw);
> +	seq_printf(s, "%d\n", irq_first);
>  
>  	return 0;
>  }
>  
> -static int ab8500_gpadc_acc_detect2_open(struct inode *inode,
> -		struct file *file)
> +static int ab8500_subscribe_unsubscribe_open(struct inode *inode,
> +					     struct file *file)
>  {
> -	return single_open(file, ab8500_gpadc_acc_detect2_print,
> +	return single_open(file, ab8500_subscribe_unsubscribe_print,
>  		inode->i_private);
>  }
>  
> -static const struct file_operations ab8500_gpadc_acc_detect2_fops = {
> -	.open = ab8500_gpadc_acc_detect2_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_aux1_print(struct seq_file *s, void *p)
> +/*
> + * Userspace should use poll() on this file. When an event occur
> + * the blocking poll will be released.
> + */
> +static ssize_t show_irq(struct device *dev,
> +			struct device_attribute *attr, char *buf)
>  {
> -	int aux1_raw;
> -	int aux1_convert;
> -	struct ab8500_gpadc *gpadc;
> +	unsigned long name;
> +	unsigned int irq_index;
> +	int err;
>  
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	aux1_raw = ab8500_gpadc_read_raw(gpadc, ADC_AUX1,
> -		avg_sample, trig_edge, trig_timer, conv_type);
> -	aux1_convert = ab8500_gpadc_ad_to_voltage(gpadc, ADC_AUX1,
> -		aux1_raw);
> +	err = kstrtoul(attr->attr.name, 0, &name);
> +	if (err)
> +		return err;
>  
> -	seq_printf(s, "%d,0x%X\n", aux1_convert, aux1_raw);
> +	irq_index = name - irq_first;
> +	if (irq_index >= num_irqs)
> +		return -EINVAL;
>  
> -	return 0;
> +	return sprintf(buf, "%u\n", irq_count[irq_index]);
>  }
>  
> -static int ab8500_gpadc_aux1_open(struct inode *inode, struct file *file)
> +static ssize_t ab8500_subscribe_write(struct file *file,
> +				      const char __user *user_buf,
> +				      size_t count, loff_t *ppos)
>  {
> -	return single_open(file, ab8500_gpadc_aux1_print, inode->i_private);
> -}
> +	struct device *dev = ((struct seq_file *)(file->private_data))->private;
> +	unsigned long user_val;
> +	int err;
> +	unsigned int irq_index;
>  
> -static const struct file_operations ab8500_gpadc_aux1_fops = {
> -	.open = ab8500_gpadc_aux1_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> +	err = kstrtoul_from_user(user_buf, count, 0, &user_val);
> +	if (err)
> +		return err;
>  
> -static int ab8500_gpadc_aux2_print(struct seq_file *s, void *p)
> -{
> -	int aux2_raw;
> -	int aux2_convert;
> -	struct ab8500_gpadc *gpadc;
> +	if (user_val < irq_first) {
> +		dev_err(dev, "debugfs error input < %d\n", irq_first);
> +		return -EINVAL;
> +	}
> +	if (user_val > irq_last) {
> +		dev_err(dev, "debugfs error input > %d\n", irq_last);
> +		return -EINVAL;
> +	}
>  
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	aux2_raw = ab8500_gpadc_read_raw(gpadc, ADC_AUX2,
> -		avg_sample, trig_edge, trig_timer, conv_type);
> -	aux2_convert = ab8500_gpadc_ad_to_voltage(gpadc, ADC_AUX2,
> -		aux2_raw);
> -
> -	seq_printf(s, "%d,0x%X\n", aux2_convert, aux2_raw);
> -
> -	return 0;
> -}
> -
> -static int ab8500_gpadc_aux2_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_aux2_print, inode->i_private);
> -}
> -
> -static const struct file_operations ab8500_gpadc_aux2_fops = {
> -	.open = ab8500_gpadc_aux2_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_main_bat_v_print(struct seq_file *s, void *p)
> -{
> -	int main_bat_v_raw;
> -	int main_bat_v_convert;
> -	struct ab8500_gpadc *gpadc;
> -
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	main_bat_v_raw = ab8500_gpadc_read_raw(gpadc, MAIN_BAT_V,
> -		avg_sample, trig_edge, trig_timer, conv_type);
> -	main_bat_v_convert = ab8500_gpadc_ad_to_voltage(gpadc, MAIN_BAT_V,
> -		main_bat_v_raw);
> -
> -	seq_printf(s, "%d,0x%X\n", main_bat_v_convert, main_bat_v_raw);
> -
> -	return 0;
> -}
> -
> -static int ab8500_gpadc_main_bat_v_open(struct inode *inode,
> -					struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_main_bat_v_print,
> -			   inode->i_private);
> -}
> -
> -static const struct file_operations ab8500_gpadc_main_bat_v_fops = {
> -	.open = ab8500_gpadc_main_bat_v_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_vbus_v_print(struct seq_file *s, void *p)
> -{
> -	int vbus_v_raw;
> -	int vbus_v_convert;
> -	struct ab8500_gpadc *gpadc;
> -
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	vbus_v_raw =  ab8500_gpadc_read_raw(gpadc, VBUS_V,
> -		avg_sample, trig_edge, trig_timer, conv_type);
> -	vbus_v_convert = ab8500_gpadc_ad_to_voltage(gpadc, VBUS_V,
> -		vbus_v_raw);
> -
> -	seq_printf(s, "%d,0x%X\n", vbus_v_convert, vbus_v_raw);
> -
> -	return 0;
> -}
> -
> -static int ab8500_gpadc_vbus_v_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_vbus_v_print, inode->i_private);
> -}
> -
> -static const struct file_operations ab8500_gpadc_vbus_v_fops = {
> -	.open = ab8500_gpadc_vbus_v_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_main_charger_c_print(struct seq_file *s, void *p)
> -{
> -	int main_charger_c_raw;
> -	int main_charger_c_convert;
> -	struct ab8500_gpadc *gpadc;
> -
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	main_charger_c_raw = ab8500_gpadc_read_raw(gpadc, MAIN_CHARGER_C,
> -		avg_sample, trig_edge, trig_timer, conv_type);
> -	main_charger_c_convert = ab8500_gpadc_ad_to_voltage(gpadc,
> -		MAIN_CHARGER_C, main_charger_c_raw);
> -
> -	seq_printf(s, "%d,0x%X\n", main_charger_c_convert, main_charger_c_raw);
> -
> -	return 0;
> -}
> -
> -static int ab8500_gpadc_main_charger_c_open(struct inode *inode,
> -		struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_main_charger_c_print,
> -		inode->i_private);
> -}
> -
> -static const struct file_operations ab8500_gpadc_main_charger_c_fops = {
> -	.open = ab8500_gpadc_main_charger_c_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_usb_charger_c_print(struct seq_file *s, void *p)
> -{
> -	int usb_charger_c_raw;
> -	int usb_charger_c_convert;
> -	struct ab8500_gpadc *gpadc;
> -
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	usb_charger_c_raw = ab8500_gpadc_read_raw(gpadc, USB_CHARGER_C,
> -		avg_sample, trig_edge, trig_timer, conv_type);
> -	usb_charger_c_convert = ab8500_gpadc_ad_to_voltage(gpadc,
> -		USB_CHARGER_C, usb_charger_c_raw);
> -
> -	seq_printf(s, "%d,0x%X\n", usb_charger_c_convert, usb_charger_c_raw);
> -
> -	return 0;
> -}
> -
> -static int ab8500_gpadc_usb_charger_c_open(struct inode *inode,
> -		struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_usb_charger_c_print,
> -		inode->i_private);
> -}
> -
> -static const struct file_operations ab8500_gpadc_usb_charger_c_fops = {
> -	.open = ab8500_gpadc_usb_charger_c_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_bk_bat_v_print(struct seq_file *s, void *p)
> -{
> -	int bk_bat_v_raw;
> -	int bk_bat_v_convert;
> -	struct ab8500_gpadc *gpadc;
> -
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	bk_bat_v_raw = ab8500_gpadc_read_raw(gpadc, BK_BAT_V,
> -		avg_sample, trig_edge, trig_timer, conv_type);
> -	bk_bat_v_convert = ab8500_gpadc_ad_to_voltage(gpadc,
> -		BK_BAT_V, bk_bat_v_raw);
> -
> -	seq_printf(s, "%d,0x%X\n", bk_bat_v_convert, bk_bat_v_raw);
> -
> -	return 0;
> -}
> -
> -static int ab8500_gpadc_bk_bat_v_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_bk_bat_v_print,
> -			   inode->i_private);
> -}
> -
> -static const struct file_operations ab8500_gpadc_bk_bat_v_fops = {
> -	.open = ab8500_gpadc_bk_bat_v_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_die_temp_print(struct seq_file *s, void *p)
> -{
> -	int die_temp_raw;
> -	int die_temp_convert;
> -	struct ab8500_gpadc *gpadc;
> -
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	die_temp_raw = ab8500_gpadc_read_raw(gpadc, DIE_TEMP,
> -		avg_sample, trig_edge, trig_timer, conv_type);
> -	die_temp_convert = ab8500_gpadc_ad_to_voltage(gpadc, DIE_TEMP,
> -		die_temp_raw);
> -
> -	seq_printf(s, "%d,0x%X\n", die_temp_convert, die_temp_raw);
> -
> -	return 0;
> -}
> -
> -static int ab8500_gpadc_die_temp_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_die_temp_print,
> -			   inode->i_private);
> -}
> -
> -static const struct file_operations ab8500_gpadc_die_temp_fops = {
> -	.open = ab8500_gpadc_die_temp_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_usb_id_print(struct seq_file *s, void *p)
> -{
> -	int usb_id_raw;
> -	int usb_id_convert;
> -	struct ab8500_gpadc *gpadc;
> -
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	usb_id_raw = ab8500_gpadc_read_raw(gpadc, USB_ID,
> -		avg_sample, trig_edge, trig_timer, conv_type);
> -	usb_id_convert = ab8500_gpadc_ad_to_voltage(gpadc, USB_ID,
> -		usb_id_raw);
> -
> -	seq_printf(s, "%d,0x%X\n", usb_id_convert, usb_id_raw);
> -
> -	return 0;
> -}
> -
> -static int ab8500_gpadc_usb_id_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_usb_id_print, inode->i_private);
> -}
> -
> -static const struct file_operations ab8500_gpadc_usb_id_fops = {
> -	.open = ab8500_gpadc_usb_id_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8540_gpadc_xtal_temp_print(struct seq_file *s, void *p)
> -{
> -	int xtal_temp_raw;
> -	int xtal_temp_convert;
> -	struct ab8500_gpadc *gpadc;
> -
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	xtal_temp_raw = ab8500_gpadc_read_raw(gpadc, XTAL_TEMP,
> -		avg_sample, trig_edge, trig_timer, conv_type);
> -	xtal_temp_convert = ab8500_gpadc_ad_to_voltage(gpadc, XTAL_TEMP,
> -		xtal_temp_raw);
> -
> -	seq_printf(s, "%d,0x%X\n", xtal_temp_convert, xtal_temp_raw);
> -
> -	return 0;
> -}
> -
> -static int ab8540_gpadc_xtal_temp_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8540_gpadc_xtal_temp_print,
> -		inode->i_private);
> -}
> -
> -static const struct file_operations ab8540_gpadc_xtal_temp_fops = {
> -	.open = ab8540_gpadc_xtal_temp_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8540_gpadc_vbat_true_meas_print(struct seq_file *s, void *p)
> -{
> -	int vbat_true_meas_raw;
> -	int vbat_true_meas_convert;
> -	struct ab8500_gpadc *gpadc;
> -
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	vbat_true_meas_raw = ab8500_gpadc_read_raw(gpadc, VBAT_TRUE_MEAS,
> -		avg_sample, trig_edge, trig_timer, conv_type);
> -	vbat_true_meas_convert =
> -		ab8500_gpadc_ad_to_voltage(gpadc, VBAT_TRUE_MEAS,
> -					   vbat_true_meas_raw);
> -
> -	seq_printf(s, "%d,0x%X\n", vbat_true_meas_convert, vbat_true_meas_raw);
> -
> -	return 0;
> -}
> -
> -static int ab8540_gpadc_vbat_true_meas_open(struct inode *inode,
> -		struct file *file)
> -{
> -	return single_open(file, ab8540_gpadc_vbat_true_meas_print,
> -		inode->i_private);
> -}
> -
> -static const struct file_operations ab8540_gpadc_vbat_true_meas_fops = {
> -	.open = ab8540_gpadc_vbat_true_meas_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8540_gpadc_bat_ctrl_and_ibat_print(struct seq_file *s, void *p)
> -{
> -	int bat_ctrl_raw;
> -	int bat_ctrl_convert;
> -	int ibat_raw;
> -	int ibat_convert;
> -	struct ab8500_gpadc *gpadc;
> -
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	bat_ctrl_raw = ab8500_gpadc_double_read_raw(gpadc, BAT_CTRL_AND_IBAT,
> -		avg_sample, trig_edge, trig_timer, conv_type, &ibat_raw);
> -
> -	bat_ctrl_convert = ab8500_gpadc_ad_to_voltage(gpadc, BAT_CTRL,
> -		bat_ctrl_raw);
> -	ibat_convert = ab8500_gpadc_ad_to_voltage(gpadc, IBAT_VIRTUAL_CHANNEL,
> -		ibat_raw);
> -
> -	seq_printf(s,
> -		   "%d,0x%X\n"
> -		   "%d,0x%X\n",
> -		   bat_ctrl_convert, bat_ctrl_raw,
> -		   ibat_convert, ibat_raw);
> -
> -	return 0;
> -}
> -
> -static int ab8540_gpadc_bat_ctrl_and_ibat_open(struct inode *inode,
> -		struct file *file)
> -{
> -	return single_open(file, ab8540_gpadc_bat_ctrl_and_ibat_print,
> -		inode->i_private);
> -}
> -
> -static const struct file_operations ab8540_gpadc_bat_ctrl_and_ibat_fops = {
> -	.open = ab8540_gpadc_bat_ctrl_and_ibat_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8540_gpadc_vbat_meas_and_ibat_print(struct seq_file *s, void *p)
> -{
> -	int vbat_meas_raw;
> -	int vbat_meas_convert;
> -	int ibat_raw;
> -	int ibat_convert;
> -	struct ab8500_gpadc *gpadc;
> -
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	vbat_meas_raw = ab8500_gpadc_double_read_raw(gpadc, VBAT_MEAS_AND_IBAT,
> -		avg_sample, trig_edge, trig_timer, conv_type, &ibat_raw);
> -	vbat_meas_convert = ab8500_gpadc_ad_to_voltage(gpadc, MAIN_BAT_V,
> -		vbat_meas_raw);
> -	ibat_convert = ab8500_gpadc_ad_to_voltage(gpadc, IBAT_VIRTUAL_CHANNEL,
> -		ibat_raw);
> -
> -	seq_printf(s,
> -		   "%d,0x%X\n"
> -		   "%d,0x%X\n",
> -		   vbat_meas_convert, vbat_meas_raw,
> -		   ibat_convert, ibat_raw);
> -
> -	return 0;
> -}
> -
> -static int ab8540_gpadc_vbat_meas_and_ibat_open(struct inode *inode,
> -		struct file *file)
> -{
> -	return single_open(file, ab8540_gpadc_vbat_meas_and_ibat_print,
> -		inode->i_private);
> -}
> -
> -static const struct file_operations ab8540_gpadc_vbat_meas_and_ibat_fops = {
> -	.open = ab8540_gpadc_vbat_meas_and_ibat_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8540_gpadc_vbat_true_meas_and_ibat_print(struct seq_file *s,
> -						      void *p)
> -{
> -	int vbat_true_meas_raw;
> -	int vbat_true_meas_convert;
> -	int ibat_raw;
> -	int ibat_convert;
> -	struct ab8500_gpadc *gpadc;
> -
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	vbat_true_meas_raw = ab8500_gpadc_double_read_raw(gpadc,
> -			VBAT_TRUE_MEAS_AND_IBAT, avg_sample, trig_edge,
> -			trig_timer, conv_type, &ibat_raw);
> -	vbat_true_meas_convert = ab8500_gpadc_ad_to_voltage(gpadc,
> -			VBAT_TRUE_MEAS, vbat_true_meas_raw);
> -	ibat_convert = ab8500_gpadc_ad_to_voltage(gpadc, IBAT_VIRTUAL_CHANNEL,
> -		ibat_raw);
> -
> -	seq_printf(s,
> -		   "%d,0x%X\n"
> -		   "%d,0x%X\n",
> -		   vbat_true_meas_convert, vbat_true_meas_raw,
> -		   ibat_convert, ibat_raw);
> -
> -	return 0;
> -}
> -
> -static int ab8540_gpadc_vbat_true_meas_and_ibat_open(struct inode *inode,
> -		struct file *file)
> -{
> -	return single_open(file, ab8540_gpadc_vbat_true_meas_and_ibat_print,
> -		inode->i_private);
> -}
> -
> -static const struct file_operations
> -ab8540_gpadc_vbat_true_meas_and_ibat_fops = {
> -	.open = ab8540_gpadc_vbat_true_meas_and_ibat_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8540_gpadc_bat_temp_and_ibat_print(struct seq_file *s, void *p)
> -{
> -	int bat_temp_raw;
> -	int bat_temp_convert;
> -	int ibat_raw;
> -	int ibat_convert;
> -	struct ab8500_gpadc *gpadc;
> -
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	bat_temp_raw = ab8500_gpadc_double_read_raw(gpadc, BAT_TEMP_AND_IBAT,
> -		avg_sample, trig_edge, trig_timer, conv_type, &ibat_raw);
> -	bat_temp_convert = ab8500_gpadc_ad_to_voltage(gpadc, BTEMP_BALL,
> -		bat_temp_raw);
> -	ibat_convert = ab8500_gpadc_ad_to_voltage(gpadc, IBAT_VIRTUAL_CHANNEL,
> -		ibat_raw);
> -
> -	seq_printf(s,
> -		   "%d,0x%X\n"
> -		   "%d,0x%X\n",
> -		   bat_temp_convert, bat_temp_raw,
> -		   ibat_convert, ibat_raw);
> -
> -	return 0;
> -}
> -
> -static int ab8540_gpadc_bat_temp_and_ibat_open(struct inode *inode,
> -		struct file *file)
> -{
> -	return single_open(file, ab8540_gpadc_bat_temp_and_ibat_print,
> -		inode->i_private);
> -}
> -
> -static const struct file_operations ab8540_gpadc_bat_temp_and_ibat_fops = {
> -	.open = ab8540_gpadc_bat_temp_and_ibat_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8540_gpadc_otp_cal_print(struct seq_file *s, void *p)
> -{
> -	struct ab8500_gpadc *gpadc;
> -	u16 vmain_l, vmain_h, btemp_l, btemp_h;
> -	u16 vbat_l, vbat_h, ibat_l, ibat_h;
> -
> -	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	ab8540_gpadc_get_otp(gpadc, &vmain_l, &vmain_h, &btemp_l, &btemp_h,
> -			&vbat_l, &vbat_h, &ibat_l, &ibat_h);
> -	seq_printf(s,
> -		   "VMAIN_L:0x%X\n"
> -		   "VMAIN_H:0x%X\n"
> -		   "BTEMP_L:0x%X\n"
> -		   "BTEMP_H:0x%X\n"
> -		   "VBAT_L:0x%X\n"
> -		   "VBAT_H:0x%X\n"
> -		   "IBAT_L:0x%X\n"
> -		   "IBAT_H:0x%X\n",
> -		   vmain_l, vmain_h, btemp_l, btemp_h,
> -		   vbat_l, vbat_h, ibat_l, ibat_h);
> -
> -	return 0;
> -}
> -
> -static int ab8540_gpadc_otp_cal_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8540_gpadc_otp_cal_print, inode->i_private);
> -}
> -
> -static const struct file_operations ab8540_gpadc_otp_calib_fops = {
> -	.open = ab8540_gpadc_otp_cal_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_avg_sample_print(struct seq_file *s, void *p)
> -{
> -	seq_printf(s, "%d\n", avg_sample);
> -
> -	return 0;
> -}
> -
> -static int ab8500_gpadc_avg_sample_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_avg_sample_print,
> -		inode->i_private);
> -}
> -
> -static ssize_t ab8500_gpadc_avg_sample_write(struct file *file,
> -	const char __user *user_buf,
> -	size_t count, loff_t *ppos)
> -{
> -	struct device *dev = ((struct seq_file *)(file->private_data))->private;
> -	unsigned long user_avg_sample;
> -	int err;
> -
> -	err = kstrtoul_from_user(user_buf, count, 0, &user_avg_sample);
> -	if (err)
> -		return err;
> -
> -	if ((user_avg_sample == SAMPLE_1) || (user_avg_sample == SAMPLE_4)
> -			|| (user_avg_sample == SAMPLE_8)
> -			|| (user_avg_sample == SAMPLE_16)) {
> -		avg_sample = (u8) user_avg_sample;
> -	} else {
> -		dev_err(dev,
> -			"debugfs err input: should be egal to 1, 4, 8 or 16\n");
> -		return -EINVAL;
> -	}
> -
> -	return count;
> -}
> -
> -static const struct file_operations ab8500_gpadc_avg_sample_fops = {
> -	.open = ab8500_gpadc_avg_sample_open,
> -	.read = seq_read,
> -	.write = ab8500_gpadc_avg_sample_write,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_trig_edge_print(struct seq_file *s, void *p)
> -{
> -	seq_printf(s, "%d\n", trig_edge);
> -
> -	return 0;
> -}
> -
> -static int ab8500_gpadc_trig_edge_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_trig_edge_print,
> -		inode->i_private);
> -}
> -
> -static ssize_t ab8500_gpadc_trig_edge_write(struct file *file,
> -	const char __user *user_buf,
> -	size_t count, loff_t *ppos)
> -{
> -	struct device *dev = ((struct seq_file *)(file->private_data))->private;
> -	unsigned long user_trig_edge;
> -	int err;
> -
> -	err = kstrtoul_from_user(user_buf, count, 0, &user_trig_edge);
> -	if (err)
> -		return err;
> -
> -	if ((user_trig_edge == RISING_EDGE)
> -			|| (user_trig_edge == FALLING_EDGE)) {
> -		trig_edge = (u8) user_trig_edge;
> -	} else {
> -		dev_err(dev, "Wrong input:\n"
> -			"Enter 0. Rising edge\n"
> -			"Enter 1. Falling edge\n");
> -		return -EINVAL;
> -	}
> -
> -	return count;
> -}
> -
> -static const struct file_operations ab8500_gpadc_trig_edge_fops = {
> -	.open = ab8500_gpadc_trig_edge_open,
> -	.read = seq_read,
> -	.write = ab8500_gpadc_trig_edge_write,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_trig_timer_print(struct seq_file *s, void *p)
> -{
> -	seq_printf(s, "%d\n", trig_timer);
> -
> -	return 0;
> -}
> -
> -static int ab8500_gpadc_trig_timer_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_trig_timer_print,
> -		inode->i_private);
> -}
> -
> -static ssize_t ab8500_gpadc_trig_timer_write(struct file *file,
> -	const char __user *user_buf,
> -	size_t count, loff_t *ppos)
> -{
> -	struct device *dev = ((struct seq_file *)(file->private_data))->private;
> -	unsigned long user_trig_timer;
> -	int err;
> -
> -	err = kstrtoul_from_user(user_buf, count, 0, &user_trig_timer);
> -	if (err)
> -		return err;
> -
> -	if (user_trig_timer & ~0xFF) {
> -		dev_err(dev,
> -			"debugfs error input: should be between 0 to 255\n");
> -		return -EINVAL;
> -	}
> -
> -	trig_timer = (u8) user_trig_timer;
> -
> -	return count;
> -}
> -
> -static const struct file_operations ab8500_gpadc_trig_timer_fops = {
> -	.open = ab8500_gpadc_trig_timer_open,
> -	.read = seq_read,
> -	.write = ab8500_gpadc_trig_timer_write,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_conv_type_print(struct seq_file *s, void *p)
> -{
> -	seq_printf(s, "%d\n", conv_type);
> -
> -	return 0;
> -}
> -
> -static int ab8500_gpadc_conv_type_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_conv_type_print,
> -		inode->i_private);
> -}
> -
> -static ssize_t ab8500_gpadc_conv_type_write(struct file *file,
> -	const char __user *user_buf,
> -	size_t count, loff_t *ppos)
> -{
> -	struct device *dev = ((struct seq_file *)(file->private_data))->private;
> -	unsigned long user_conv_type;
> -	int err;
> -
> -	err = kstrtoul_from_user(user_buf, count, 0, &user_conv_type);
> -	if (err)
> -		return err;
> -
> -	if ((user_conv_type == ADC_SW)
> -			|| (user_conv_type == ADC_HW)) {
> -		conv_type = (u8) user_conv_type;
> -	} else {
> -		dev_err(dev, "Wrong input:\n"
> -			"Enter 0. ADC SW conversion\n"
> -			"Enter 1. ADC HW conversion\n");
> -		return -EINVAL;
> -	}
> -
> -	return count;
> -}
> -
> -static const struct file_operations ab8500_gpadc_conv_type_fops = {
> -	.open = ab8500_gpadc_conv_type_open,
> -	.read = seq_read,
> -	.write = ab8500_gpadc_conv_type_write,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -/*
> - * return length of an ASCII numerical value, 0 is string is not a
> - * numerical value.
> - * string shall start at value 1st char.
> - * string can be tailed with \0 or space or newline chars only.
> - * value can be decimal or hexadecimal (prefixed 0x or 0X).
> - */
> -static int strval_len(char *b)
> -{
> -	char *s = b;
> -
> -	if ((*s == '0') && ((*(s+1) == 'x') || (*(s+1) == 'X'))) {
> -		s += 2;
> -		for (; *s && (*s != ' ') && (*s != '\n'); s++) {
> -			if (!isxdigit(*s))
> -				return 0;
> -		}
> -	} else {
> -		if (*s == '-')
> -			s++;
> -		for (; *s && (*s != ' ') && (*s != '\n'); s++) {
> -			if (!isdigit(*s))
> -				return 0;
> -		}
> -	}
> -	return (int) (s-b);
> -}
> -
> -/*
> - * parse hwreg input data.
> - * update global hwreg_cfg only if input data syntax is ok.
> - */
> -static ssize_t hwreg_common_write(char *b, struct hwreg_cfg *cfg,
> -		struct device *dev)
> -{
> -	uint write, val = 0;
> -	u8  regvalue;
> -	int ret;
> -	struct hwreg_cfg loc = {
> -		.bank = 0,          /* default: invalid phys addr */
> -		.addr = 0,          /* default: invalid phys addr */
> -		.fmt = 0,           /* default: 32bit access, hex output */
> -		.mask = 0xFFFFFFFF, /* default: no mask */
> -		.shift = 0,         /* default: no bit shift */
> -	};
> -
> -	/* read or write ? */
> -	if (!strncmp(b, "read ", 5)) {
> -		write = 0;
> -		b += 5;
> -	} else if (!strncmp(b, "write ", 6)) {
> -		write = 1;
> -		b += 6;
> -	} else
> -		return -EINVAL;
> -
> -	/* OPTIONS -l|-w|-b -s -m -o */
> -	while ((*b == ' ') || (*b == '-')) {
> -		if (*(b-1) != ' ') {
> -			b++;
> -			continue;
> -		}
> -		if ((!strncmp(b, "-d ", 3)) ||
> -				(!strncmp(b, "-dec ", 5))) {
> -			b += (*(b+2) == ' ') ? 3 : 5;
> -			loc.fmt |= (1<<0);
> -		} else if ((!strncmp(b, "-h ", 3)) ||
> -				(!strncmp(b, "-hex ", 5))) {
> -			b += (*(b+2) == ' ') ? 3 : 5;
> -			loc.fmt &= ~(1<<0);
> -		} else if ((!strncmp(b, "-m ", 3)) ||
> -				(!strncmp(b, "-mask ", 6))) {
> -			b += (*(b+2) == ' ') ? 3 : 6;
> -			if (strval_len(b) == 0)
> -				return -EINVAL;
> -			ret = kstrtoul(b, 0, &loc.mask);
> -			if (ret)
> -				return ret;
> -		} else if ((!strncmp(b, "-s ", 3)) ||
> -				(!strncmp(b, "-shift ", 7))) {
> -			b += (*(b+2) == ' ') ? 3 : 7;
> -			if (strval_len(b) == 0)
> -				return -EINVAL;
> -			ret = kstrtol(b, 0, &loc.shift);
> -			if (ret)
> -				return ret;
> -		} else {
> -			return -EINVAL;
> -		}
> -	}
> -	/* get arg BANK and ADDRESS */
> -	if (strval_len(b) == 0)
> -		return -EINVAL;
> -	ret = kstrtouint(b, 0, &loc.bank);
> -	if (ret)
> -		return ret;
> -	while (*b == ' ')
> -		b++;
> -	if (strval_len(b) == 0)
> -		return -EINVAL;
> -	ret = kstrtoul(b, 0, &loc.addr);
> -	if (ret)
> -		return ret;
> -
> -	if (write) {
> -		while (*b == ' ')
> -			b++;
> -		if (strval_len(b) == 0)
> -			return -EINVAL;
> -		ret = kstrtouint(b, 0, &val);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	/* args are ok, update target cfg (mainly for read) */
> -	*cfg = loc;
> -
> -#ifdef ABB_HWREG_DEBUG
> -	pr_warn("HWREG request: %s, %s,\n", (write) ? "write" : "read",
> -		REG_FMT_DEC(cfg) ? "decimal" : "hexa");
> -	pr_warn("  addr=0x%08X, mask=0x%X, shift=%d" "value=0x%X\n",
> -		cfg->addr, cfg->mask, cfg->shift, val);
> -#endif
> -
> -	if (!write)
> -		return 0;
> -
> -	ret = abx500_get_register_interruptible(dev,
> -			(u8)cfg->bank, (u8)cfg->addr, &regvalue);
> -	if (ret < 0) {
> -		dev_err(dev, "abx500_get_reg fail %d, %d\n",
> -			ret, __LINE__);
> -		return -EINVAL;
> -	}
> -
> -	if (cfg->shift >= 0) {
> -		regvalue &= ~(cfg->mask << (cfg->shift));
> -		val = (val & cfg->mask) << (cfg->shift);
> -	} else {
> -		regvalue &= ~(cfg->mask >> (-cfg->shift));
> -		val = (val & cfg->mask) >> (-cfg->shift);
> -	}
> -	val = val | regvalue;
> -
> -	ret = abx500_set_register_interruptible(dev,
> -			(u8)cfg->bank, (u8)cfg->addr, (u8)val);
> -	if (ret < 0) {
> -		pr_err("abx500_set_reg failed %d, %d", ret, __LINE__);
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static ssize_t ab8500_hwreg_write(struct file *file,
> -	const char __user *user_buf, size_t count, loff_t *ppos)
> -{
> -	struct device *dev = ((struct seq_file *)(file->private_data))->private;
> -	char buf[128];
> -	int buf_size, ret;
> -
> -	/* Get userspace string and assure termination */
> -	buf_size = min(count, (sizeof(buf)-1));
> -	if (copy_from_user(buf, user_buf, buf_size))
> -		return -EFAULT;
> -	buf[buf_size] = 0;
> -
> -	/* get args and process */
> -	ret = hwreg_common_write(buf, &hwreg_cfg, dev);
> -	return (ret) ? ret : buf_size;
> -}
> -
> -/*
> - * - irq subscribe/unsubscribe stuff
> - */
> -static int ab8500_subscribe_unsubscribe_print(struct seq_file *s, void *p)
> -{
> -	seq_printf(s, "%d\n", irq_first);
> -
> -	return 0;
> -}
> -
> -static int ab8500_subscribe_unsubscribe_open(struct inode *inode,
> -					     struct file *file)
> -{
> -	return single_open(file, ab8500_subscribe_unsubscribe_print,
> -		inode->i_private);
> -}
> -
> -/*
> - * Userspace should use poll() on this file. When an event occur
> - * the blocking poll will be released.
> - */
> -static ssize_t show_irq(struct device *dev,
> -			struct device_attribute *attr, char *buf)
> -{
> -	unsigned long name;
> -	unsigned int irq_index;
> -	int err;
> -
> -	err = kstrtoul(attr->attr.name, 0, &name);
> -	if (err)
> -		return err;
> -
> -	irq_index = name - irq_first;
> -	if (irq_index >= num_irqs)
> -		return -EINVAL;
> -
> -	return sprintf(buf, "%u\n", irq_count[irq_index]);
> -}
> -
> -static ssize_t ab8500_subscribe_write(struct file *file,
> -				      const char __user *user_buf,
> -				      size_t count, loff_t *ppos)
> -{
> -	struct device *dev = ((struct seq_file *)(file->private_data))->private;
> -	unsigned long user_val;
> -	int err;
> -	unsigned int irq_index;
> -
> -	err = kstrtoul_from_user(user_buf, count, 0, &user_val);
> -	if (err)
> -		return err;
> -
> -	if (user_val < irq_first) {
> -		dev_err(dev, "debugfs error input < %d\n", irq_first);
> -		return -EINVAL;
> -	}
> -	if (user_val > irq_last) {
> -		dev_err(dev, "debugfs error input > %d\n", irq_last);
> -		return -EINVAL;
> -	}
> -
> -	irq_index = user_val - irq_first;
> -	if (irq_index >= num_irqs)
> -		return -EINVAL;
> +	irq_index = user_val - irq_first;
> +	if (irq_index >= num_irqs)
> +		return -EINVAL;
>  
>  	/*
>  	 * This will create a sysfs file named <irq-nr> which userspace can
> @@ -2939,7 +2044,6 @@ static const struct file_operations ab8500_hwreg_fops = {
>  };
>  
>  static struct dentry *ab8500_dir;
> -static struct dentry *ab8500_gpadc_dir;
>  
>  static int ab8500_debug_probe(struct platform_device *plf)
>  {
> @@ -2991,11 +2095,6 @@ static int ab8500_debug_probe(struct platform_device *plf)
>  	if (!ab8500_dir)
>  		goto err;
>  
> -	ab8500_gpadc_dir = debugfs_create_dir(AB8500_ADC_NAME_STRING,
> -					      ab8500_dir);
> -	if (!ab8500_gpadc_dir)
> -		goto err;
> -
>  	file = debugfs_create_file("all-bank-registers", S_IRUGO, ab8500_dir,
>  				   &plf->dev, &ab8500_registers_fops);
>  	if (!file)
> @@ -3066,165 +2165,6 @@ static int ab8500_debug_probe(struct platform_device *plf)
>  	if (!file)
>  		goto err;
>  
> -	file = debugfs_create_file("bat_ctrl", (S_IRUGO | S_IWUSR | S_IWGRP),
> -				   ab8500_gpadc_dir, &plf->dev,
> -				   &ab8500_gpadc_bat_ctrl_fops);
> -	if (!file)
> -		goto err;
> -
> -	file = debugfs_create_file("btemp_ball", (S_IRUGO | S_IWUSR | S_IWGRP),
> -				   ab8500_gpadc_dir,
> -				   &plf->dev, &ab8500_gpadc_btemp_ball_fops);
> -	if (!file)
> -		goto err;
> -
> -	file = debugfs_create_file("main_charger_v",
> -				   (S_IRUGO | S_IWUSR | S_IWGRP),
> -				   ab8500_gpadc_dir, &plf->dev,
> -				   &ab8500_gpadc_main_charger_v_fops);
> -	if (!file)
> -		goto err;
> -
> -	file = debugfs_create_file("acc_detect1",
> -				   (S_IRUGO | S_IWUSR | S_IWGRP),
> -				   ab8500_gpadc_dir, &plf->dev,
> -				   &ab8500_gpadc_acc_detect1_fops);
> -	if (!file)
> -		goto err;
> -
> -	file = debugfs_create_file("acc_detect2",
> -				   (S_IRUGO | S_IWUSR | S_IWGRP),
> -				   ab8500_gpadc_dir, &plf->dev,
> -				   &ab8500_gpadc_acc_detect2_fops);
> -	if (!file)
> -		goto err;
> -
> -	file = debugfs_create_file("adc_aux1", (S_IRUGO | S_IWUSR | S_IWGRP),
> -				   ab8500_gpadc_dir, &plf->dev,
> -				   &ab8500_gpadc_aux1_fops);
> -	if (!file)
> -		goto err;
> -
> -	file = debugfs_create_file("adc_aux2", (S_IRUGO | S_IWUSR | S_IWGRP),
> -				   ab8500_gpadc_dir, &plf->dev,
> -				   &ab8500_gpadc_aux2_fops);
> -	if (!file)
> -		goto err;
> -
> -	file = debugfs_create_file("main_bat_v", (S_IRUGO | S_IWUSR | S_IWGRP),
> -				   ab8500_gpadc_dir, &plf->dev,
> -				   &ab8500_gpadc_main_bat_v_fops);
> -	if (!file)
> -		goto err;
> -
> -	file = debugfs_create_file("vbus_v", (S_IRUGO | S_IWUSR | S_IWGRP),
> -				   ab8500_gpadc_dir, &plf->dev,
> -				   &ab8500_gpadc_vbus_v_fops);
> -	if (!file)
> -		goto err;
> -
> -	file = debugfs_create_file("main_charger_c",
> -				   (S_IRUGO | S_IWUSR | S_IWGRP),
> -				   ab8500_gpadc_dir, &plf->dev,
> -				   &ab8500_gpadc_main_charger_c_fops);
> -	if (!file)
> -		goto err;
> -
> -	file = debugfs_create_file("usb_charger_c",
> -				   (S_IRUGO | S_IWUSR | S_IWGRP),
> -				   ab8500_gpadc_dir,
> -				   &plf->dev, &ab8500_gpadc_usb_charger_c_fops);
> -	if (!file)
> -		goto err;
> -
> -	file = debugfs_create_file("bk_bat_v", (S_IRUGO | S_IWUSR | S_IWGRP),
> -				   ab8500_gpadc_dir, &plf->dev,
> -				   &ab8500_gpadc_bk_bat_v_fops);
> -	if (!file)
> -		goto err;
> -
> -	file = debugfs_create_file("die_temp", (S_IRUGO | S_IWUSR | S_IWGRP),
> -				   ab8500_gpadc_dir, &plf->dev,
> -				   &ab8500_gpadc_die_temp_fops);
> -	if (!file)
> -		goto err;
> -
> -	file = debugfs_create_file("usb_id", (S_IRUGO | S_IWUSR | S_IWGRP),
> -				   ab8500_gpadc_dir, &plf->dev,
> -				   &ab8500_gpadc_usb_id_fops);
> -	if (!file)
> -		goto err;
> -
> -	if (is_ab8540(ab8500)) {
> -		file = debugfs_create_file("xtal_temp",
> -					   (S_IRUGO | S_IWUSR | S_IWGRP),
> -					   ab8500_gpadc_dir, &plf->dev,
> -					   &ab8540_gpadc_xtal_temp_fops);
> -		if (!file)
> -			goto err;
> -		file = debugfs_create_file("vbattruemeas",
> -					   (S_IRUGO | S_IWUSR | S_IWGRP),
> -					   ab8500_gpadc_dir, &plf->dev,
> -					   &ab8540_gpadc_vbat_true_meas_fops);
> -		if (!file)
> -			goto err;
> -		file = debugfs_create_file("batctrl_and_ibat",
> -					(S_IRUGO | S_IWUGO),
> -					ab8500_gpadc_dir,
> -					&plf->dev,
> -					&ab8540_gpadc_bat_ctrl_and_ibat_fops);
> -		if (!file)
> -			goto err;
> -		file = debugfs_create_file("vbatmeas_and_ibat",
> -					(S_IRUGO | S_IWUGO),
> -					ab8500_gpadc_dir, &plf->dev,
> -					&ab8540_gpadc_vbat_meas_and_ibat_fops);
> -		if (!file)
> -			goto err;
> -		file = debugfs_create_file("vbattruemeas_and_ibat",
> -				(S_IRUGO | S_IWUGO),
> -				ab8500_gpadc_dir,
> -				&plf->dev,
> -				&ab8540_gpadc_vbat_true_meas_and_ibat_fops);
> -		if (!file)
> -			goto err;
> -		file = debugfs_create_file("battemp_and_ibat",
> -			(S_IRUGO | S_IWUGO),
> -			ab8500_gpadc_dir,
> -			&plf->dev, &ab8540_gpadc_bat_temp_and_ibat_fops);
> -		if (!file)
> -			goto err;
> -		file = debugfs_create_file("otp_calib",
> -				(S_IRUGO | S_IWUSR | S_IWGRP),
> -				ab8500_gpadc_dir,
> -				&plf->dev, &ab8540_gpadc_otp_calib_fops);
> -		if (!file)
> -			goto err;
> -	}
> -	file = debugfs_create_file("avg_sample", (S_IRUGO | S_IWUSR | S_IWGRP),
> -				   ab8500_gpadc_dir, &plf->dev,
> -				   &ab8500_gpadc_avg_sample_fops);
> -	if (!file)
> -		goto err;
> -
> -	file = debugfs_create_file("trig_edge", (S_IRUGO | S_IWUSR | S_IWGRP),
> -				   ab8500_gpadc_dir, &plf->dev,
> -				   &ab8500_gpadc_trig_edge_fops);
> -	if (!file)
> -		goto err;
> -
> -	file = debugfs_create_file("trig_timer", (S_IRUGO | S_IWUSR | S_IWGRP),
> -				   ab8500_gpadc_dir, &plf->dev,
> -				   &ab8500_gpadc_trig_timer_fops);
> -	if (!file)
> -		goto err;
> -
> -	file = debugfs_create_file("conv_type", (S_IRUGO | S_IWUSR | S_IWGRP),
> -				   ab8500_gpadc_dir, &plf->dev,
> -				   &ab8500_gpadc_conv_type_fops);
> -	if (!file)
> -		goto err;
> -
>  	return 0;
>  
>  err:
> diff --git a/include/linux/mfd/abx500/ab8500-gpadc.h b/include/linux/mfd/abx500/ab8500-gpadc.h
> deleted file mode 100644
> index 49ded001049b..000000000000
> --- a/include/linux/mfd/abx500/ab8500-gpadc.h
> +++ /dev/null
> @@ -1,75 +0,0 @@
> -/*
> - * Copyright (C) 2010 ST-Ericsson SA
> - * Licensed under GPLv2.
> - *
> - * Author: Arun R Murthy <arun.murthy-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> - * Author: Daniel Willerud <daniel.willerud-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> - * Author: M'boumba Cedric Madianga <cedric.madianga-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> - */
> -
> -#ifndef	_AB8500_GPADC_H
> -#define _AB8500_GPADC_H
> -
> -/* GPADC source: From datasheet(ADCSwSel[4:0] in GPADCCtrl2
> - * and ADCHwSel[4:0] in GPADCCtrl3 ) */
> -#define BAT_CTRL		0x01
> -#define BTEMP_BALL		0x02
> -#define MAIN_CHARGER_V		0x03
> -#define ACC_DETECT1		0x04
> -#define ACC_DETECT2		0x05
> -#define ADC_AUX1		0x06
> -#define ADC_AUX2		0x07
> -#define MAIN_BAT_V		0x08
> -#define VBUS_V			0x09
> -#define MAIN_CHARGER_C		0x0A
> -#define USB_CHARGER_C		0x0B
> -#define BK_BAT_V		0x0C
> -#define DIE_TEMP		0x0D
> -#define USB_ID			0x0E
> -#define XTAL_TEMP		0x12
> -#define VBAT_TRUE_MEAS		0x13
> -#define BAT_CTRL_AND_IBAT	0x1C
> -#define VBAT_MEAS_AND_IBAT	0x1D
> -#define VBAT_TRUE_MEAS_AND_IBAT	0x1E
> -#define BAT_TEMP_AND_IBAT	0x1F
> -
> -/* Virtual channel used only for ibat convertion to ampere
> - * Battery current conversion (ibat) cannot be requested as a single conversion
> - *  but it is always in combination with other input requests
> - */
> -#define IBAT_VIRTUAL_CHANNEL		0xFF
> -
> -#define SAMPLE_1        1
> -#define SAMPLE_4        4
> -#define SAMPLE_8        8
> -#define SAMPLE_16       16
> -#define RISING_EDGE     0
> -#define FALLING_EDGE    1
> -
> -/* Arbitrary ADC conversion type constants */
> -#define ADC_SW				0
> -#define ADC_HW				1
> -
> -struct ab8500_gpadc;
> -
> -struct ab8500_gpadc *ab8500_gpadc_get(char *name);
> -int ab8500_gpadc_sw_hw_convert(struct ab8500_gpadc *gpadc, u8 channel,
> -		u8 avg_sample, u8 trig_edge, u8 trig_timer, u8 conv_type);
> -static inline int ab8500_gpadc_convert(struct ab8500_gpadc *gpadc, u8 channel)
> -{
> -	return ab8500_gpadc_sw_hw_convert(gpadc, channel,
> -			SAMPLE_16, 0, 0, ADC_SW);
> -}
> -
> -int ab8500_gpadc_read_raw(struct ab8500_gpadc *gpadc, u8 channel,
> -		u8 avg_sample, u8 trig_edge, u8 trig_timer, u8 conv_type);
> -int ab8500_gpadc_double_read_raw(struct ab8500_gpadc *gpadc, u8 channel,
> -		u8 avg_sample, u8 trig_edge, u8 trig_timer, u8 conv_type,
> -		int *ibat);
> -int ab8500_gpadc_ad_to_voltage(struct ab8500_gpadc *gpadc,
> -		u8 channel, int ad_value);
> -void ab8540_gpadc_get_otp(struct ab8500_gpadc *gpadc,
> -			u16 *vmain_l, u16 *vmain_h, u16 *btemp_l, u16 *btemp_h,
> -			u16 *vbat_l, u16 *vbat_h, u16 *ibat_l, u16 *ibat_h);
> -
> -#endif /* _AB8500_GPADC_H */

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
