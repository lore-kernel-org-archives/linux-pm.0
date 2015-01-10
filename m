From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 3/7] iio: Add support for DA9150 GPADC
Date: Sat, 10 Jan 2015 22:19:15 +0000
Message-ID: <54B1A563.5080404@kernel.org>
References: <cover.1419264383.git.Adam.Thomson.Opensource@diasemi.com> <58b7b001b38662c36595412f96c7d2eb5c3adcad.1419264383.git.Adam.Thomson.Opensource@diasemi.com> <54A976D2.9040104@kernel.org> <2E89032DDAA8B9408CB92943514A0337AB526A19@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337AB526A19-68WUHU125fLLPO1uwJ3ImwLouzNaz+3S@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 07/01/15 16:03, Opensource [Adam Thomson] wrote:
> On January 4, 2015 17:22, Jonathan Cameron wrote:
> 
>> On 22/12/14 16:51, Adam Thomson wrote:
>>> This patch adds support for DA9150 Charger & Fuel-Gauge IC GPADC.
>>>
>>> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
>> One last query from me.
>>
>> Using the extended channel names in IIO is only really appropriate when
>> they don't correspond to simple pins on the side of the chip. For those
>> just drop the extname bit.  Some of the channels you have here, definitely
>> need them though.
>>
>> Drop those first 4 or convince me otherwise and add
>> Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> 
> Have added responses below. If the comments are accepted then I'll respin
> and add you're 'Acked-by'. Is that ok?
> 
Not accepted as yet :)
>>> +#define DA9150_GPADC_CHANNEL_PROCESSED(_id, _hw_id, _type, _ext_name)
>> 	\
>>> +	DA9150_GPADC_CHANNEL(_id, _hw_id, _type,			\
>>> +			     BIT(IIO_CHAN_INFO_PROCESSED), _ext_name)
>>> +
>>> +/* Supported channels */
>>> +static const struct iio_chan_spec da9150_gpadc_channels[] = {
>>> +	DA9150_GPADC_CHANNEL_PROCESSED(GPIOA, GPIOA_6V, IIO_VOLTAGE,
>> "GPIOA"),
>>> +	DA9150_GPADC_CHANNEL_PROCESSED(GPIOB, GPIOB_6V, IIO_VOLTAGE,
>> "GPIOB"),
>>> +	DA9150_GPADC_CHANNEL_PROCESSED(GPIOC, GPIOC_6V, IIO_VOLTAGE,
>> "GPIOC"),
>>> +	DA9150_GPADC_CHANNEL_PROCESSED(GPIOD, GPIOD_6V, IIO_VOLTAGE,
>> "GPIOD"),
>> I'm not sure some of these really deserve extended names.  Those are usually
>> reserved for naming strange internal adc channels etc.  These first 4 are
>> presumably just for input pins?  Those should just be channels 0..3
>> On another note, unless you want really weird sysfs attribute names, the
>> extended names want to be lowercase.
>>
> 
> I'd prefer to keep the names because the input pins are muxed with GPIOs of the
> chip, so thought it sensible to show that this is the case. Am happy to change
> to lower-case to follow convention.
Hmm.  It's a bit of an oddity as the point of the naming
is about the uses, not which pins they are on.  If we exposed the
'datasheet_name' parameter directly rather than just using it internally
I'd suggest relying on that - but clearly you want it to be apparent
in the interface.  Whether that is useful is the question I'd raise
here (and is the reason datasheet_name is not exposed.

The obvious question is does userspace care?  Answer is probably not.

It cares what is being measured but this is about what pins it is
on and doesn't provide any information on what is connected to them.


> 
>>> +	DA9150_GPADC_CHANNEL_PROCESSED(IBUS, IBUS_SENSE, IIO_CURRENT,
>> "IBUS"),
>>> +	DA9150_GPADC_CHANNEL_PROCESSED(VBUS, VBUS_DIV_, IIO_VOLTAGE,
>> "VBUS"),
>>> +	DA9150_GPADC_CHANNEL_RAW(ID, ID, IIO_VOLTAGE, "ID"),
>> You hae an identifier voltage? That's certainly unusual but if so - fair enough
>> and it defintely needs the extname!
> 
> Thanks for pointing that out. Having checked again, this is not needed and can
> be dispensed with.
> 
>>> +	DA9150_GPADC_CHANNEL_PROCESSED(VSYS, VSYS, IIO_VOLTAGE, "VSYS"),
>>> +	DA9150_GPADC_CHANNEL_SCALED(VBAT, VBAT, IIO_VOLTAGE, "VBAT"),
>>> +	DA9150_GPADC_CHANNEL_RAW(TBAT, TBAT, IIO_VOLTAGE, "TBAT"),
>>> +	DA9150_GPADC_CHANNEL_SCALED(TJUNC_CORE, TJUNC_CORE,
>> IIO_TEMP,
>>> +				    "TJUNC_CORE"),
>> tjunc_core is a good use of extname ;)
>>> +	DA9150_GPADC_CHANNEL_SCALED(TJUNC_OVP, TJUNC_OVP, IIO_TEMP,
>>> +				    "TJUNC_OVP"),
>>> +};
>>> +
>>> +/* Default maps used by da9150-charger */
>>> +static struct iio_map da9150_gpadc_default_maps[] = {
>>> +	{
>>> +		.consumer_dev_name = "da9150-charger",
>>> +		.consumer_channel = "CHAN_IBUS",
>>> +		.adc_channel_label = "IBUS",
>>> +	},
>>> +	{
>>> +		.consumer_dev_name = "da9150-charger",
>>> +		.consumer_channel = "CHAN_VBUS",
>>> +		.adc_channel_label = "VBUS",
>>> +	},
>>> +	{
>>> +		.consumer_dev_name = "da9150-charger",
>>> +		.consumer_channel = "CHAN_TJUNC",
>>> +		.adc_channel_label = "TJUNC_CORE",
>>> +	},
>>> +	{
>>> +		.consumer_dev_name = "da9150-charger",
>>> +		.consumer_channel = "CHAN_VBAT",
>>> +		.adc_channel_label = "VBAT",
>>> +	},
>>> +	{},
>>> +};
>>> +
>>> +static int da9150_gpadc_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct da9150 *da9150 = dev_get_drvdata(dev->parent);
>>> +	struct da9150_gpadc *gpadc;
>>> +	struct iio_dev *indio_dev;
>>> +	int irq, ret;
>>> +
>>> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*gpadc));
>>> +	if (!indio_dev) {
>>> +		dev_err(&pdev->dev, "Failed to allocate IIO device\n");
>>> +		return -ENOMEM;
>>> +	}
>>> +	gpadc = iio_priv(indio_dev);
>>> +
>>> +	platform_set_drvdata(pdev, indio_dev);
>>> +	gpadc->da9150 = da9150;
>>> +	gpadc->dev = dev;
>>> +	mutex_init(&gpadc->lock);
>>> +	init_completion(&gpadc->complete);
>>> +
>>> +	irq = platform_get_irq_byname(pdev, "GPADC");
>>> +	if (irq < 0) {
>>> +		dev_err(dev, "Failed to get IRQ: %d\n", irq);
>>> +		return irq;
>>> +	}
>>> +
>>> +	ret = devm_request_threaded_irq(dev, irq, NULL, da9150_gpadc_irq,
>>> +					IRQF_ONESHOT, "GPADC", gpadc);
>>> +	if (ret) {
>>> +		dev_err(dev, "Failed to request IRQ %d: %d\n", irq, ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = iio_map_array_register(indio_dev, da9150_gpadc_default_maps);
>>> +	if (ret) {
>>> +		dev_err(dev, "Failed to register IIO maps: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	indio_dev->name = dev_name(dev);
>>> +	indio_dev->dev.parent = dev;
>>> +	indio_dev->dev.of_node = pdev->dev.of_node;
>>> +	indio_dev->info = &da9150_gpadc_info;
>>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>>> +	indio_dev->channels = da9150_gpadc_channels;
>>> +	indio_dev->num_channels = ARRAY_SIZE(da9150_gpadc_channels);
>>> +
>>> +	ret = iio_device_register(indio_dev);
>>> +	if (ret) {
>>> +		dev_err(dev, "Failed to register IIO device: %d\n", ret);
>>> +		goto iio_map_unreg;
>>> +	}
>>> +
>>> +	return 0;
>>> +
>>> +iio_map_unreg:
>>> +	iio_map_array_unregister(indio_dev);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int da9150_gpadc_remove(struct platform_device *pdev)
>>> +{
>>> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>>> +
>>> +	iio_device_unregister(indio_dev);
>>> +	iio_map_array_unregister(indio_dev);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static struct platform_driver da9150_gpadc_driver = {
>>> +	.driver = {
>>> +		.name = "da9150-gpadc",
>>> +	},
>>> +	.probe = da9150_gpadc_probe,
>>> +	.remove = da9150_gpadc_remove,
>>> +};
>>> +
>>> +module_platform_driver(da9150_gpadc_driver);
>>> +
>>> +MODULE_DESCRIPTION("GPADC Driver for DA9150");
>>> +MODULE_AUTHOR("Adam Thomson
>> <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>");
>>> +MODULE_LICENSE("GPL");
>>> --
>>> 1.9.3
>>>
