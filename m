From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4 3/3] iio: adc: add support for Allwinner SoCs ADC
Date: Sun, 4 Sep 2016 15:35:18 +0100
Message-ID: <272fb672-602c-1757-be9f-eadf928b330c@kernel.org>
References: <1472738705-20145-1-git-send-email-quentin.schulz@free-electrons.com>
 <1472738705-20145-4-git-send-email-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <1472738705-20145-4-git-send-email-quentin.schulz@free-electrons.com>
Sender: linux-hwmon-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>, jdelvare@suse.com, Guenter Roeck <linux@roeck-us.net>, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org, lee.jones@linaro.org
Cc: thomas.petazzoni@free-electrons.com, antoine.tenart@free-electrons.com, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 01/09/16 15:05, Quentin Schulz wrote:
> The Allwinner SoCs all have an ADC that can also act as a touchscreen
> controller and a thermal sensor. This patch adds the ADC driver which is
> based on the MFD for the same SoCs ADC.
> 
> This also registers the thermal adc channel in the iio map array so
> iio_hwmon could use it without modifying the Device Tree. This registers
> the driver in the thermal framework.
> 
> This driver probes on three different platform_device_id to take into
> account slight differences (registers bit and temperature computation)
> between Allwinner SoCs ADCs.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
One utterly trivial point about unrolling code ordering inline.

Other than the bit about patch 1 I'm basically happy with this..
However I would like some input (i.e. an Ack) from thermal given this
sets up a thermal zone.

Zhang or Eduardo, could you take a quick look at this and confirm you
are happy with it?

Thanks,

Jonathan
> ---
> 
> v4:
>  - rename files and variables from sunxi* to sun4i*,
>  - shorten sunxi_gpadc_soc_specific structure to soc_specific,
>  - factorize sysfs ADC and temp read_raws,
>  - use cached values when read_raw times out (except before a first value
>    is gotten),
>  - remove mutex locks and unlocks from runtime_pm functions,
>  - factorize irq initializations,
>  - initialize temp_data and fifo_data values to -1 (error value),
>  - "impersonate" MFD to register in thermal framework,
>  - deactivate hardware interrupts one by one when probe fails or when
>    removing driver instead of blindly deactivating all hardware interrupts,
>  - selects THERMAL_OF in Kconfig,
> 
> v3:
>  - correct wrapping,
>  - add comment about thermal sensor inner working,
>  - move defines in mfd header,
>  - use structure to define SoC specific registers or behaviour,
>  - attach this structure to the device according to of_device_id of the
>    platform device,
>  - use new mutex instead of iio_dev mutex,
>  - use atomic flags to avoid race between request_irq and disable_irq in
>    probe,
>  - switch from processed value to raw, offset and scale values for
>    temperature ADC channel,
>  - remove faulty sentinel in iio_chan_spec array,
>  - add pm_runtime support,
>  - register thermal sensor in thermal framework (forgotten since the
>    beginning whereas it is present in current sun4i-ts driver),
>  - remove useless ret variables to store return value of regmap_reads,
>  - move comments on thermal sensor acquisition period in code instead of
>    header,
>  - adding goto label to unregister iio_map_array when failing to register
>    iio_dev,
> 
> v2:
>  - add SUNXI_GPADC_ prefixes for defines,
>  - correct typo in Kconfig,
>  - reorder alphabetically includes, makefile,
>  - add license header,
>  - fix architecture variations not being handled in interrupt handlers or
>    read raw functions,
>  - fix unability to return negative values from thermal sensor,
>  - add gotos to reduce code repetition,
>  - fix irq variable being unsigned int instead of int,
>  - remove useless dev_err and dev_info,
>  - deactivate all interrupts if probe fails,
>  - fix iio_device_register on NULL variable,
>  - deactivate ADC in the IP when probe fails or when removing driver,
> 
>  drivers/iio/adc/Kconfig           |  13 +
>  drivers/iio/adc/Makefile          |   1 +
>  drivers/iio/adc/sun4i-gpadc-iio.c | 525 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 539 insertions(+)
>  create mode 100644 drivers/iio/adc/sun4i-gpadc-iio.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 25378c5..ea36a4f 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -384,6 +384,19 @@ config ROCKCHIP_SARADC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rockchip_saradc.
>  
> +config SUN4I_GPADC
> +	tristate "Support for the Allwinner SoCs GPADC"
> +	depends on IIO
> +	depends on MFD_SUN4I_GPADC
> +	select THERMAL_OF
> +	help
> +	  Say yes here to build support for Allwinner (A10, A13 and A31) SoCs
> +	  GPADC. This ADC provides 4 channels which can be used as an ADC or as
> +	  a touchscreen input and one channel for thermal sensor.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called sun4i-gpadc-iio.
> +
>  config TI_ADC081C
>  	tristate "Texas Instruments ADC081C/ADC101C/ADC121C family"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 38638d4..204372d 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
>  obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
>  obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
>  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
> +obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>  obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
>  obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> new file mode 100644
> index 0000000..a93d36d
> --- /dev/null
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -0,0 +1,525 @@
> +/* ADC driver for sunxi platforms' (A10, A13 and A31) GPADC
> + *
> + * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons>
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + *
> + * The Allwinner SoCs all have an ADC that can also act as a touchscreen
> + * controller and a thermal sensor.
> + * The thermal sensor works only when the ADC acts as a touchscreen controller
> + * and is configured to throw an interrupt every fixed periods of time (let say
> + * every X seconds).
> + * One would be tempted to disable the IP on the hardware side rather than
> + * disabling interrupts to save some power but that reset the internal clock of
> + * the IP, resulting in having to wait X seconds every time we want to read the
> + * value of the thermal sensor.
> + * This is also the reason of using autosuspend in pm_runtime. If there were no
> + * autosuspend, the thermal sensor would need X seconds after every
> + * pm_runtime_get_sync to get a value from the ADC. The autosuspend allows the
> + * thermal sensor to be requested again in a certain time span before it gets
> + * shutdown for not being used.
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/thermal.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/driver.h>
> +#include <linux/iio/machine.h>
> +#include <linux/mfd/sun4i-gpadc-mfd.h>
> +
> +const unsigned int sun4i_gpadc_chan_select(unsigned int chan)
> +{
> +	return SUN4I_GPADC_CTRL1_ADC_CHAN_SELECT(chan);
> +}
> +
> +const unsigned int sun6i_gpadc_chan_select(unsigned int chan)
> +{
> +	return SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(chan);
> +}
> +
> +struct soc_specific {
> +	const int		temp_offset;
> +	const int		temp_scale;
> +	const unsigned int	tp_mode_en;
> +	const unsigned int	tp_adc_select;
> +	const unsigned int	(*adc_chan_select)(unsigned int chan);
> +};
> +
> +static const struct soc_specific sun4i_gpadc_soc_specific = {
> +	.temp_offset = -1932,
> +	.temp_scale = 133,
> +	.tp_mode_en = SUN4I_GPADC_CTRL1_TP_MODE_EN,
> +	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
> +	.adc_chan_select = &sun4i_gpadc_chan_select,
> +};
> +
> +static const struct soc_specific sun5i_gpadc_soc_specific = {
> +	.temp_offset = -1447,
> +	.temp_scale = 100,
> +	.tp_mode_en = SUN4I_GPADC_CTRL1_TP_MODE_EN,
> +	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
> +	.adc_chan_select = &sun4i_gpadc_chan_select,
> +};
> +
> +static const struct soc_specific sun6i_gpadc_soc_specific = {
> +	.temp_offset = -1623,
> +	.temp_scale = 167,
> +	.tp_mode_en = SUN6I_GPADC_CTRL1_TP_MODE_EN,
> +	.tp_adc_select = SUN6I_GPADC_CTRL1_TP_ADC_SELECT,
> +	.adc_chan_select = &sun6i_gpadc_chan_select,
> +};
> +
> +struct sun4i_gpadc_dev {
> +	struct iio_dev			*indio_dev;
> +	void __iomem			*regs;
> +	struct completion		completion;
> +	int				temp_data;
> +	u32				adc_data;
> +	struct regmap			*regmap;
> +	unsigned int			fifo_data_irq;
> +	atomic_t			ignore_fifo_data_irq;
> +	unsigned int			temp_data_irq;
> +	atomic_t			ignore_temp_data_irq;
> +	const struct soc_specific	*soc_specific;
> +	/* prevents concurrent reads of temperature and ADC */
> +	struct mutex			mutex;
> +};
> +
> +#define SUN4I_GPADC_ADC_CHANNEL(_channel, _name) {		\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = _channel,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.datasheet_name = _name,				\
> +}
> +
> +static struct iio_map sun4i_gpadc_hwmon_maps[] = {
> +	{
> +		.adc_channel_label = "temp_adc",
> +		.consumer_dev_name = "iio_hwmon.0",
> +	},
> +	{ /* sentinel */ },
> +};
> +
> +static const struct iio_chan_spec sun4i_gpadc_channels[] = {
> +	SUN4I_GPADC_ADC_CHANNEL(0, "adc_chan0"),
> +	SUN4I_GPADC_ADC_CHANNEL(1, "adc_chan1"),
> +	SUN4I_GPADC_ADC_CHANNEL(2, "adc_chan2"),
> +	SUN4I_GPADC_ADC_CHANNEL(3, "adc_chan3"),
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
> +		.datasheet_name = "temp_adc",
> +	},
> +};
> +
> +static int sun4i_gpadc_read(struct iio_dev *indio_dev, int channel, int *val,
> +			    unsigned int irq)
> +{
> +	struct sun4i_gpadc_dev *info = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	pm_runtime_get_sync(indio_dev->dev.parent);
> +	mutex_lock(&info->mutex);
> +
> +	reinit_completion(&info->completion);
> +
> +	regmap_write(info->regmap, SUN4I_GPADC_INT_FIFOC,
> +		     SUN4I_GPADC_INT_FIFOC_TP_FIFO_TRIG_LEVEL(1) |
> +		     SUN4I_GPADC_INT_FIFOC_TP_FIFO_FLUSH);
> +	if (irq == info->fifo_data_irq) {
> +		regmap_write(info->regmap, SUN4I_GPADC_CTRL1,
> +			     info->soc_specific->tp_mode_en |
> +			     info->soc_specific->tp_adc_select |
> +			     info->soc_specific->adc_chan_select(channel));
> +	} else {
> +		/*
> +		 * The temperature sensor returns valid data only when the ADC
> +		 * operates in touchscreen mode.
> +		 */
> +		regmap_write(info->regmap, SUN4I_GPADC_CTRL1,
> +			     info->soc_specific->tp_mode_en);
> +	}
> +
> +	enable_irq(irq);
> +
> +	if (!wait_for_completion_timeout(&info->completion,
> +					 msecs_to_jiffies(100))) {
> +		if ((irq == info->fifo_data_irq && info->adc_data == -1) ||
> +		    (irq == info->temp_data_irq && info->temp_data == -1)) {
> +			ret = -ETIMEDOUT;
> +			goto out;
> +		}
> +	}
> +
> +	if (irq == info->fifo_data_irq)
> +		*val = info->adc_data;
> +	else
> +		*val = info->temp_data;
> +
> +out:
> +	disable_irq(irq);
> +	mutex_unlock(&info->mutex);
> +	pm_runtime_mark_last_busy(indio_dev->dev.parent);
> +	pm_runtime_put_autosuspend(indio_dev->dev.parent);
> +
> +	return ret;
> +}
> +
> +static int sun4i_gpadc_adc_read(struct iio_dev *indio_dev, int channel,
> +				int *val)
> +{
> +	struct sun4i_gpadc_dev *info = iio_priv(indio_dev);
> +
> +	return sun4i_gpadc_read(indio_dev, channel, val, info->fifo_data_irq);
> +}
> +
> +static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
> +{
> +	struct sun4i_gpadc_dev *info = iio_priv(indio_dev);
> +
> +	return sun4i_gpadc_read(indio_dev, 0, val, info->temp_data_irq);
> +}
> +
> +static int sun4i_gpadc_temp_offset(struct iio_dev *indio_dev, int *val)
> +{
> +	struct sun4i_gpadc_dev *info = iio_priv(indio_dev);
> +
> +	*val = info->soc_specific->temp_offset;
> +
> +	return 0;
> +}
> +
> +static int sun4i_gpadc_temp_scale(struct iio_dev *indio_dev, int *val)
> +{
> +	struct sun4i_gpadc_dev *info = iio_priv(indio_dev);
> +
> +	*val = info->soc_specific->temp_scale;
> +
> +	return 0;
> +}
> +
> +static int sun4i_gpadc_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan, int *val,
> +				int *val2, long mask)
> +{
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OFFSET:
> +		ret = sun4i_gpadc_temp_offset(indio_dev, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type == IIO_VOLTAGE) {
> +			ret = sun4i_gpadc_adc_read(indio_dev, chan->channel,
> +						   val);
> +			if (ret)
> +				return ret;
> +		} else {
> +			ret = sun4i_gpadc_temp_read(indio_dev, val);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = sun4i_gpadc_temp_scale(indio_dev, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info sun4i_gpadc_iio_info = {
> +	.read_raw = sun4i_gpadc_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static irqreturn_t sun4i_gpadc_temp_data_irq_handler(int irq, void *dev_id)
> +{
> +	struct sun4i_gpadc_dev *info = dev_id;
> +
> +	if (atomic_read(&info->ignore_temp_data_irq))
> +		return IRQ_HANDLED;
> +
> +	if (!regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, &info->temp_data))
> +		complete(&info->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t sun4i_gpadc_fifo_data_irq_handler(int irq, void *dev_id)
> +{
> +	struct sun4i_gpadc_dev *info = dev_id;
> +
> +	if (atomic_read(&info->ignore_fifo_data_irq))
> +		return IRQ_HANDLED;
> +
> +	if (!regmap_read(info->regmap, SUN4I_GPADC_DATA, &info->adc_data))
> +		complete(&info->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int sun4i_gpadc_runtime_suspend(struct device *dev)
> +{
> +	struct sun4i_gpadc_dev *info = iio_priv(dev_get_drvdata(dev));
> +
> +	/* Disable the ADC on IP */
> +	regmap_write(info->regmap, SUN4I_GPADC_CTRL1, 0);
> +	/* Disable temperature sensor on IP */
> +	regmap_write(info->regmap, SUN4I_GPADC_TPR, 0);
> +
> +	return 0;
> +}
> +
> +static int sun4i_gpadc_runtime_resume(struct device *dev)
> +{
> +	struct sun4i_gpadc_dev *info = iio_priv(dev_get_drvdata(dev));
> +
> +	/* clkin = 6MHz */
> +	regmap_write(info->regmap, SUN4I_GPADC_CTRL0,
> +		     SUN4I_GPADC_CTRL0_ADC_CLK_DIVIDER(2) |
> +		     SUN4I_GPADC_CTRL0_FS_DIV(7) |
> +		     SUN4I_GPADC_CTRL0_T_ACQ(63));
> +	regmap_write(info->regmap, SUN4I_GPADC_CTRL1,
> +		     info->soc_specific->tp_mode_en);
> +	regmap_write(info->regmap, SUN4I_GPADC_CTRL3,
> +		     SUN4I_GPADC_CTRL3_FILTER_EN |
> +		     SUN4I_GPADC_CTRL3_FILTER_TYPE(1));
> +	/* period = SUN4I_GPADC_TPR_TEMP_PERIOD * 256 * 16 / clkin; ~1.3s */
> +	regmap_write(info->regmap, SUN4I_GPADC_TPR,
> +		     SUN4I_GPADC_TPR_TEMP_ENABLE |
> +		     SUN4I_GPADC_TPR_TEMP_PERIOD(1953));
> +
> +	return 0;
> +}
> +
> +static int sun4i_gpadc_get_temp(void *data, int *temp)
> +{
> +	struct sun4i_gpadc_dev *info = (struct sun4i_gpadc_dev *)data;
> +	int val, scale, offset;
> +
> +	/* If reading temperature times out, take stored previous value. */
> +	if (sun4i_gpadc_temp_read(info->indio_dev, &val))
> +		val = info->temp_data;
> +	sun4i_gpadc_temp_scale(info->indio_dev, &scale);
> +	sun4i_gpadc_temp_offset(info->indio_dev, &offset);
> +
> +	*temp = (val + offset) * scale;
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops sun4i_ts_tz_ops = {
> +	.get_temp = &sun4i_gpadc_get_temp,
> +};
> +
> +static const struct dev_pm_ops sun4i_gpadc_pm_ops = {
> +	.runtime_suspend = &sun4i_gpadc_runtime_suspend,
> +	.runtime_resume = &sun4i_gpadc_runtime_resume,
> +};
> +
> +static int sun4i_irq_init(struct platform_device *pdev, const char *name,
> +			  irq_handler_t handler, const char *devname,
> +			  unsigned int *irq, atomic_t *atomic)
> +{
> +	int ret;
> +	struct sun4i_gpadc_mfd_dev *mfd_dev = dev_get_drvdata(pdev->dev.parent);
> +	struct sun4i_gpadc_dev *info = iio_priv(dev_get_drvdata(&pdev->dev));
> +
> +	/*
> +	 * Once the interrupt is activated, the IP continuously performs
> +	 * conversions thus throws interrupts. The interrupt is activated right
> +	 * after being requested but we want to control when these interrupts
> +	 * occurs thus we disable it right after being requested. However, an
> +	 * interrupt might occur between these two instructions and we have to
> +	 * make sure that does not happen, by using atomic flags. We set the
> +	 * flag before requesting the interrupt and unset it right after
> +	 * disabling the interrupt. When an interrupt occurs between these two
> +	 * instructions, reading the atomic flag will tell us to ignore the
> +	 * interrupt.
> +	 */
> +	atomic_set(atomic, 1);
> +
> +	*irq = platform_get_irq_byname(pdev, name);
> +	if (*irq < 0) {
> +		dev_err(&pdev->dev, "no %s interrupt registered\n", name);
> +		return *irq;
> +	}
> +
> +	*irq = regmap_irq_get_virq(mfd_dev->regmap_irqc, *irq);
> +	ret = devm_request_any_context_irq(&pdev->dev, *irq, handler, 0,
> +					   devname, info);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "could not request %s interrupt: %d\n",
> +			name, ret);
> +		return ret;
> +	}
> +
> +	disable_irq(*irq);
> +	atomic_set(atomic, 0);
> +
> +	return 0;
> +}
> +
> +static int sun4i_gpadc_probe(struct platform_device *pdev)
> +{
> +	struct sun4i_gpadc_dev *info;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +	struct sun4i_gpadc_mfd_dev *sun4i_gpadc_mfd_dev;
> +	struct thermal_zone_device *tzd;
> +
> +	sun4i_gpadc_mfd_dev = dev_get_drvdata(pdev->dev.parent);
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	mutex_init(&info->mutex);
> +	info->regmap = sun4i_gpadc_mfd_dev->regmap;
> +	info->indio_dev = indio_dev;
> +	info->temp_data = -1;
> +	info->adc_data = -1;
> +	init_completion(&info->completion);
> +	indio_dev->name = dev_name(&pdev->dev);
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->dev.of_node = pdev->dev.of_node;
> +	indio_dev->info = &sun4i_gpadc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->num_channels = ARRAY_SIZE(sun4i_gpadc_channels);
> +	indio_dev->channels = sun4i_gpadc_channels;
> +
> +	info->soc_specific = (struct soc_specific *)platform_get_device_id(pdev)->driver_data;
> +
> +	tzd = devm_thermal_zone_of_sensor_register(pdev->dev.parent, 0, info,
> +						   &sun4i_ts_tz_ops);
> +	if (IS_ERR(tzd)) {
> +		dev_err(&pdev->dev, "could not register thermal sensor: %ld\n",
> +			PTR_ERR(tzd));
> +		return PTR_ERR(tzd);
> +	}
> +
> +	pm_runtime_set_autosuspend_delay(&pdev->dev,
> +					 SUN4I_GPADC_AUTOSUSPEND_DELAY);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	ret = sun4i_irq_init(pdev, "TEMP_DATA_PENDING",
> +			     sun4i_gpadc_temp_data_irq_handler, "temp_data",
> +			     &info->temp_data_irq, &info->ignore_temp_data_irq);
> +	if (ret < 0)
> +		goto err;
> +
> +	ret = sun4i_irq_init(pdev, "FIFO_DATA_PENDING",
> +			     sun4i_gpadc_fifo_data_irq_handler, "fifo_data",
> +			     &info->fifo_data_irq, &info->ignore_fifo_data_irq);
> +	if (ret < 0)
> +		goto err_temp_irq;
> +
> +	ret = iio_map_array_register(indio_dev, sun4i_gpadc_hwmon_maps);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to register iio map array\n");
> +		goto err_fifo_irq;
> +	}
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "could not register the device\n");
> +		goto err_map;
> +	}
> +
> +	return 0;
> +
> +err_map:
> +	iio_map_array_unregister(indio_dev);
> +
> +err_fifo_irq:
> +	/* Disable FIFO_DATA_PENDING interrupt on hardware side. */
> +	regmap_update_bits(info->regmap, SUN4I_GPADC_INT_FIFOC,
> +			   SUN4I_GPADC_INT_FIFOC_TP_DATA_IRQ_EN,
> +			   0);
> +
> +err_temp_irq:
> +	/* Disable TEMP_DATA_PENDING interrupt on hardware side. */
> +	regmap_update_bits(info->regmap, SUN4I_GPADC_INT_FIFOC,
> +			   SUN4I_GPADC_INT_FIFOC_TEMP_IRQ_EN,
> +			   0);
> +
> +err:
> +	pm_runtime_put(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return ret;
> +}
> +
> +static int sun4i_gpadc_remove(struct platform_device *pdev)
> +{
> +	struct sun4i_gpadc_dev *info;
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +
> +	info = iio_priv(indio_dev);
> +	iio_device_unregister(indio_dev);
> +	iio_map_array_unregister(indio_dev);
> +	pm_runtime_put(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
Its really minor but in the interests of 'obviously correct' making
review easy I'd rather everything in the remove was in the reverse order
of probe (and hence the same as the error path in probe for most of it).

That would put the pm_runtime stuff last I think..

If you weren't rerolling anyway over patch 1 I'd probably have just let
this go, but might as well make this trivial change as well.


> +	/*
> +	 * Disable TEMP_DATA_PENDING and FIFO_DATA_PENDING interrupts on
> +	 * hardware side.
> +	 */
> +	regmap_update_bits(info->regmap, SUN4I_GPADC_INT_FIFOC,
> +			   SUN4I_GPADC_INT_FIFOC_TEMP_IRQ_EN |
> +				SUN4I_GPADC_INT_FIFOC_TP_DATA_IRQ_EN,
> +			   0);
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id sun4i_gpadc_id[] = {
> +	{ "sun4i-a10-gpadc-iio", (kernel_ulong_t)&sun4i_gpadc_soc_specific },
> +	{ "sun5i-a13-gpadc-iio", (kernel_ulong_t)&sun5i_gpadc_soc_specific },
> +	{ "sun6i-a31-gpadc-iio", (kernel_ulong_t)&sun6i_gpadc_soc_specific },
> +	{ /* sentinel */ },
> +};
> +
> +static struct platform_driver sun4i_gpadc_driver = {
> +	.driver = {
> +		.name = "sun4i-gpadc-iio",
> +		.pm = &sun4i_gpadc_pm_ops,
> +	},
> +	.id_table = sun4i_gpadc_id,
> +	.probe = sun4i_gpadc_probe,
> +	.remove = sun4i_gpadc_remove,
> +};
> +
> +module_platform_driver(sun4i_gpadc_driver);
> +
> +MODULE_DESCRIPTION("ADC driver for sunxi platforms");
> +MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
> +MODULE_LICENSE("GPL v2");
> 

