From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v2 19/21] leds: leds-pasic3: Add support for PASIC3 LED
 controller
Date: Tue, 18 Aug 2015 12:27:01 +0200
Message-ID: <55D30875.3090103@samsung.com>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D25ADC.10703@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
In-reply-to: <55D25ADC.10703@tul.cz>
Sender: linux-leds-owner@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Petr,

On 08/18/2015 12:06 AM, Petr Cvek wrote:
> Add support for LEDs inside the PASIC3 chip.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> ---
>   drivers/leds/Kconfig       |   9 ++
>   drivers/leds/Makefile      |   1 +
>   drivers/leds/leds-pasic3.c | 232 ++++++++++++++++++++++++++++++++++=
+++++++++++
>   3 files changed, 242 insertions(+)
>   create mode 100644 drivers/leds/leds-pasic3.c
>
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 9ad35f7..516ba65 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -586,6 +586,15 @@ config LEDS_PM8941_WLED
>   	  This option enables support for the 'White' LED block
>   	  on Qualcomm PM8941 PMICs.
>
> +config LEDS_PASIC3
> +	tristate "LED support for the HTC Magician/Alpine PASIC3"
> +	depends on LEDS_CLASS
> +	depends on HTC_PASIC3
> +	select REGMAP
> +	help
> +	  This option enables support for the PASIC3 chip (different chip
> +	  than Compaq ASIC3).
> +
>   comment "LED Triggers"
>   source "drivers/leds/trigger/Kconfig"
>
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 8d6a24a..b1c659c 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_LEDS_VERSATILE)		+=3D leds-versatile.o
>   obj-$(CONFIG_LEDS_MENF21BMC)		+=3D leds-menf21bmc.o
>   obj-$(CONFIG_LEDS_PM8941_WLED)		+=3D leds-pm8941-wled.o
>   obj-$(CONFIG_LEDS_KTD2692)		+=3D leds-ktd2692.o
> +obj-$(CONFIG_LEDS_PASIC3)		+=3D leds-pasic3.o
>
>   # LED SPI Drivers
>   obj-$(CONFIG_LEDS_DAC124S085)		+=3D leds-dac124s085.o
> diff --git a/drivers/leds/leds-pasic3.c b/drivers/leds/leds-pasic3.c
> new file mode 100644
> index 0000000..0f95230
> --- /dev/null
> +++ b/drivers/leds/leds-pasic3.c
> @@ -0,0 +1,232 @@
> +/*
> + * AIC3 (or PASIC3) LED driver for HTC Magician/Alpine/.. (not Compa=
q ASIC3)

s/AIC3/ASIC3/

I am a bit confused. What's the relation between ASIC3 and PASIC3?

> + *
> + * Copyright (c) 2015 Petr Cvek <petr.cvek@tul.cz>
> + *
> + * CLK to MS calculation based on leds-asic3.c
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under  the terms of the GNU General  Public License as published =
by the
> + * Free Software Foundation;  either version 2 of the License, or (a=
t your
> + * option) any later version.
> + *
> + */
> +
> +#include <linux/gpio.h>
> +#include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/mfd/htc-pasic3.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +/*
> + * 1 tick is around 62-63 ms, blinking settings (on+off):
> + *	Min: 1+1 ticks ~125ms
> + *	Max: 127+127 ticks ~15=E2=80=AF875ms
> + * HW sometimes takes time to change (counter overflow after write?)
> + */
> +
> +#define MS_TO_CLK(ms)	DIV_ROUND_CLOSEST(((ms)*1024), 64000)
> +#define CLK_TO_MS(clk)	(((clk)*64000)/1024)
> +#define MAX_CLK		254		/* 127 + 127 (2x 7 bit reg) */
> +#define MAX_MS		CLK_TO_MS(MAX_CLK)
> +
> +spinlock_t lock;

Please move it to the struct pasic3_leds_data.

> +
> +static void brightness_set(struct led_classdev *cdev,
> +	enum led_brightness value)
> +{
> +	struct platform_device *pdev =3D to_platform_device(cdev->dev->pare=
nt);
> +	struct pasic3_led *led =3D dev_get_platdata(cdev->dev);
> +	struct pasic3_leds_pdata *pdata =3D dev_get_platdata(&pdev->dev);
> +	unsigned long flags;
> +	u8 val;
> +
> +	spin_lock_irqsave(&lock, flags);
> +
> +	if (value =3D=3D LED_OFF) {
> +		val =3D pasic3_read_register(pdata->mfd_dev, PASIC3_CH_CONTROL);
> +		pasic3_write_register(pdata->mfd_dev, PASIC3_CH_CONTROL,
> +			val & ~(led->bit_blink_en | led->bit_force_on));
> +
> +		val =3D pasic3_read_register(pdata->mfd_dev, PASIC3_MASK_A);
> +		pasic3_write_register(pdata->mfd_dev, PASIC3_MASK_A,
> +			val & ~led->bit_mask);
> +
> +		if (pdata->power_gpio) {
> +			pdata->power_gpio_users--;

Now it is possible that power_gpio_users will have negative value.
You should check the value before decrementing it.

> +
> +			if (pdata->power_gpio_users =3D=3D 0)
> +				gpio_set_value(pdata->power_gpio, 0);
> +		}
> +	} else {
> +		if (pdata->power_gpio) {
> +			pdata->power_gpio_users++;
> +
> +			if (pdata->power_gpio_users !=3D 0)
> +				gpio_set_value(pdata->power_gpio, 1);
> +		}


Now you are setting power_gpio_users to 1 each time brightness is set,
whereas it should be set to 1 only if it was 0.

This could be changed to:

if (pdata->power_gpio_users =3D=3D 0)
	gpio_set_value(pdata->power_gpio, 1);

pdata->power_gpio_users++;

> +
> +		val =3D pasic3_read_register(pdata->mfd_dev, PASIC3_CH_CONTROL);
> +		pasic3_write_register(pdata->mfd_dev, PASIC3_CH_CONTROL,
> +			val | led->bit_force_on);
> +	}
> +
> +	spin_unlock_irqrestore(&lock, flags);
> +}
> +
> +static int blink_set(struct led_classdev *cdev,
> +	unsigned long *delay_on, unsigned long *delay_off)
> +{
> +	struct platform_device *pdev =3D to_platform_device(cdev->dev->pare=
nt);
> +	struct pasic3_led *led =3D dev_get_platdata(cdev->dev);
> +	struct pasic3_leds_pdata *pdata =3D dev_get_platdata(&pdev->dev);
> +	unsigned long flags;
> +	u32 on, off;
> +	u8 val;
> +	if (*delay_on > MAX_MS || *delay_off > MAX_MS)
> +		return -EINVAL;
> +
> +	if (*delay_on =3D=3D 0 && *delay_off =3D=3D 0) {
> +		/* Choose sensible default delays */
> +		on =3D MS_TO_CLK(500);
> +		off =3D MS_TO_CLK(500);
> +	} else {
> +		on =3D MS_TO_CLK(*delay_on);
> +		off =3D MS_TO_CLK(*delay_off);
> +		if ((on + off) > MAX_CLK)
> +			return -EINVAL;
> +		/* Minimal on/off value must be 1 */
> +		on =3D on ? on : 1;
> +		off =3D off ? off : 1;
> +	}
> +
> +	spin_lock_irqsave(&lock, flags);

Shouldn't you check if also power_gpio state doesn't need to be altered
here?

> +
> +	pasic3_write_register(pdata->mfd_dev, led->reg_delay_on, on);
> +	pasic3_write_register(pdata->mfd_dev, led->reg_delay_off, off);
> +
> +	val =3D pasic3_read_register(pdata->mfd_dev, PASIC3_CH_CONTROL);
> +	pasic3_write_register(pdata->mfd_dev, PASIC3_CH_CONTROL,
> +		val | led->bit_blink_en);
> +
> +	spin_unlock_irqrestore(&lock, flags);
> +
> +	*delay_on =3D CLK_TO_MS(on);
> +	*delay_off =3D CLK_TO_MS(off);
> +
> +	return 0;
> +}
> +
> +static int pasic3_led_probe(struct platform_device *pdev)
> +{
> +	struct pasic3_leds_pdata *pdata =3D dev_get_platdata(&pdev->dev);
> +	struct led_classdev *cdev;
> +	int ret;
> +	int i;
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "no platform data\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!pdata->leds) {
> +		dev_err(&pdev->dev, "no leds data\n");
> +		return -EINVAL;
> +	}
> +
> +	if (pdata->power_gpio) {
> +		pdata->power_gpio_users =3D 0;
> +
> +		ret =3D gpio_request(pdata->power_gpio,
> +			"Red-Blue LED Power");

Please use devm_gpio_request. Then you will not need pasic3_led_remove.

> +		if (ret < 0) {
> +			dev_warn(&pdev->dev, "failed to request power GPIO\n");
> +			goto err;
> +		}
> +	}
> +
> +	spin_lock_init(&lock);
> +
> +	cdev =3D devm_kzalloc(&pdev->dev,
> +		sizeof(struct led_classdev) * pdata->num_leds, GFP_KERNEL);
> +	if (!cdev) {
> +		ret =3D -ENOMEM;
> +		goto err;
> +	}
> +
> +	for (i =3D 0; i < pdata->num_leds; i++) {
> +		cdev[i].name =3D pdata->leds[i].name;
> +		cdev[i].default_trigger =3D pdata->leds[i].default_trigger;
> +		cdev[i].flags =3D LED_CORE_SUSPENDRESUME;
> +		cdev[i].brightness_set =3D brightness_set;
> +		cdev[i].blink_set =3D blink_set;
> +
> +		ret =3D devm_led_classdev_register(&pdev->dev, &cdev[i]);
> +		if (ret < 0)
> +			goto err;
> +
> +		cdev[i].dev->platform_data =3D &pdata->leds[i];
> +	}
> +
> +	return 0;
> +
> +err:
> +	if (pdata->power_gpio)
> +		gpio_free(pdata->power_gpio);
> +
> +	return ret;
> +}
> +
> +static int pasic3_led_remove(struct platform_device *pdev)
> +{
> +	struct pasic3_leds_pdata *pdata =3D dev_get_platdata(&pdev->dev);
> +
> +	if (pdata->power_gpio)
> +		gpio_free(pdata->power_gpio);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int pasic3_led_suspend(struct device *dev)
> +{
> +	struct pasic3_leds_pdata *pdata =3D dev_get_platdata(dev);
> +
> +	if (pdata->power_gpio)
> +		gpio_set_value(pdata->power_gpio, 0);
> +
> +	return 0;
> +}
> +
> +static int pasic3_led_resume(struct device *dev)
> +{
> +	struct pasic3_leds_pdata *pdata =3D dev_get_platdata(dev);
> +
> +	if (pdata->power_gpio)
> +		gpio_set_value(pdata->power_gpio, 1);
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(pasic3_led_pm_ops, pasic3_led_suspend,
> +	pasic3_led_resume);
> +
> +static struct platform_driver pasic3_led_driver =3D {
> +	.probe		=3D pasic3_led_probe,
> +	.remove		=3D pasic3_led_remove,
> +	.driver		=3D {
> +		.name	=3D "leds-pasic3",
> +		.pm	=3D &pasic3_led_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(pasic3_led_driver);
> +
> +MODULE_AUTHOR("Petr Cvek <petr.cvek@tul.cz>");
> +MODULE_DESCRIPTION("HTC Magician PASIC3 LED driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:leds-pasic3");
>


--=20
Best Regards,
Jacek Anaszewski
