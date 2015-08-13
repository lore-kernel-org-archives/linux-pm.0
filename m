From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v1 RFC] This patch repairs HTC Magician machine (PXA27x)
 support
Date: Thu, 13 Aug 2015 10:10:00 +0200
Message-ID: <55CC50D8.5000706@samsung.com>
References: <55CBCDED.8010409@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
In-reply-to: <55CBCDED.8010409@tul.cz>
Sender: linux-leds-owner@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Philipp Zabel <philipp.zabel@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Petr,

This is review only of the LED subsystem related part of this patch,.

On 08/13/2015 12:51 AM, Petr Cvek wrote:
> Fixing original code: Problems to successful boot due to the bad LCD
> power sequence (wrongly configured GPIO).
>
> Add/fix platform data and helper function for various hardware
> (touchscreen, audio, USB device, ...).
>
> Add new discovered GPIOs and fix names by GPIO context.
>
> Add new LEDs driver.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> ---
>   arch/arm/mach-pxa/Kconfig                 |    1 +
>   arch/arm/mach-pxa/include/mach/magician.h |   21 +-
>   arch/arm/mach-pxa/magician.c              | 1148 ++++++++++++++++++=
+++++------
>   drivers/leds/Kconfig                      |    9 +
>   drivers/leds/Makefile                     |    1 +
>   drivers/leds/leds-pasic3.c                |  192 +++++
>   drivers/mfd/htc-pasic3.c                  |  115 ++-
>   include/linux/mfd/htc-pasic3.h            |   69 +-
>   8 files changed, 1293 insertions(+), 263 deletions(-)
>   create mode 100644 drivers/leds/leds-pasic3.c
>

[...]

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
> index 0000000..ecb0557
> --- /dev/null
> +++ b/drivers/leds/leds-pasic3.c
> @@ -0,0 +1,192 @@
> +/*
> + * AIC3 (or PASIC3) LED driver for HTC Magician/Alpine/.. (not Compa=
q ASIC3)
> + *
> + * Copyright (c) 2015 Petr Cvek <petr.cvek@tul.cz>
> + *
> + * Based on leds-asic3.c driver
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/leds.h>
> +#include <linux/slab.h>
> +

This empty line is not required.

> +#include <linux/mfd/htc-pasic3.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>

Please keep alphabetical order across all includes.

> +/*
> + * 1 tick is around 62-63 ms, blinking settings (on+off):
> + *	Min: 1+1 ticks ~125ms
> + *	Max: 127+127 ticks ~15=E2=80=AF875ms
> + * Sometimes takes time to change after write (counter overflow?)
> + */
> +
> +#define MS_TO_CLK(ms)	DIV_ROUND_CLOSEST(((ms)*1024), 64000)
> +#define CLK_TO_MS(clk)	(((clk)*64000)/1024)
> +#define MAX_CLK		254		/* 127 + 127 (2x 7 bit reg) */
> +#define MAX_MS		CLK_TO_MS(MAX_CLK)
> +
> +static void brightness_set(struct led_classdev *cdev,
> +	enum led_brightness value)
> +{
> +	struct platform_device *pdev =3D to_platform_device(cdev->dev->pare=
nt);
> +	const struct mfd_cell *cell =3D mfd_get_cell(pdev);
> +	struct pasic3_led *led;
> +	struct device *dev;
> +	u8 val;
> +
> +	if (!cell->platform_data) {
> +		pr_err("No platform data\n");
> +		return;
> +	}
> +
> +	led =3D cell->platform_data;
> +	dev =3D pdev->dev.parent;
> +
> +	if (value =3D=3D LED_OFF) {
> +		val =3D pasic3_read_register(dev, PASIC3_CH_CONTROL);
> +		pasic3_write_register(dev, PASIC3_CH_CONTROL,
> +			val & ~(led->bit_blink_en | led->bit_force_on));
> +
> +		val =3D pasic3_read_register(dev, PASIC3_MASK_A);
> +		pasic3_write_register(dev, PASIC3_MASK_A, val & ~led->bit_mask);

I think that you need spin_lock protection as setting brightness
is not an atomic operation here. Moreover pasic3_write_register
calls __raw_writeb twice, without spin_lock protection. This function
is used also in drivers/mfd/htc-pasic3.c - shouldn't it be fixed?

> +	} else {
> +		val =3D pasic3_read_register(dev, PASIC3_CH_CONTROL);
> +		pasic3_write_register(dev, PASIC3_CH_CONTROL,
> +			val | led->bit_force_on);
> +	}
> +}
> +
> +static int blink_set(struct led_classdev *cdev,
> +	unsigned long *delay_on,
> +	unsigned long *delay_off)
> +{
> +	struct platform_device *pdev =3D to_platform_device(cdev->dev->pare=
nt);
> +	const struct mfd_cell *cell =3D mfd_get_cell(pdev);
> +	struct device *dev;
> +	struct pasic3_led *led;
> +	u32 on, off;
> +	u8 val;
> +
> +	if (!cell->platform_data) {
> +		pr_err("No platform data\n");
> +		return -EINVAL;
> +	}
> +
> +	if (*delay_on > MAX_MS || *delay_off > MAX_MS)
> +		return -EINVAL;
> +
> +	if (*delay_on =3D=3D 0 && *delay_off =3D=3D 0) {
> +		/* If both are zero then a sensible default should be chosen */
> +		on =3D MS_TO_CLK(500);
> +		off =3D MS_TO_CLK(500);
> +	} else {
> +		on =3D MS_TO_CLK(*delay_on);
> +		off =3D MS_TO_CLK(*delay_off);
> +		if ((on + off) > MAX_CLK)
> +			return -EINVAL;
> +		/* Minimal value must be 1 */
> +		on =3D on ? on : 1;
> +		off =3D off ? off : 1;
> +	}
> +
> +	led =3D cell->platform_data;
> +	dev =3D pdev->dev.parent;
> +
> +	pasic3_write_register(dev, led->reg_delay_on, on);
> +	pasic3_write_register(dev, led->reg_delay_off, off);
> +
> +	val =3D pasic3_read_register(dev, PASIC3_CH_CONTROL);
> +	pasic3_write_register(dev, PASIC3_CH_CONTROL, val | led->bit_blink_=
en);

Ditto.

> +	*delay_on =3D CLK_TO_MS(on);
> +	*delay_off =3D CLK_TO_MS(off);
> +
> +	return 0;
> +}
> +
> +static int pasic3_led_probe(struct platform_device *pdev)
> +{
> +	struct pasic3_led *led =3D dev_get_platdata(&pdev->dev);
> +	int ret;
> +
> +	ret =3D mfd_cell_enable(pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	led->cdev.flags =3D LED_CORE_SUSPENDRESUME;
> +	led->cdev.brightness_set =3D brightness_set;
> +	led->cdev.blink_set =3D blink_set;

You need to set also led->cdev.name. What is the name of your
LED in the sysfs now?

> +	ret =3D led_classdev_register(&pdev->dev, &led->cdev);
> +	if (ret < 0)
> +		goto out;

Please use devm_led_classdev_register.

> +	return 0;
> +
> +out:
> +	(void) mfd_cell_disable(pdev);
> +	return ret;
> +}
> +
> +static int pasic3_led_remove(struct platform_device *pdev)
> +{
> +	struct pasic3_led *led =3D dev_get_platdata(&pdev->dev);
> +
> +	led_classdev_unregister(&led->cdev);
> +
> +	return mfd_cell_disable(pdev);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int pasic3_led_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	const struct mfd_cell *cell =3D mfd_get_cell(pdev);
> +	int ret;
> +
> +	ret =3D 0;
> +	if (cell->suspend)
> +		ret =3D (*cell->suspend)(pdev);
> +
> +	return ret;
> +}
> +
> +static int pasic3_led_resume(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	const struct mfd_cell *cell =3D mfd_get_cell(pdev);
> +	int ret;
> +
> +	ret =3D 0;
> +	if (cell->resume)
> +		ret =3D (*cell->resume)(pdev);
> +
> +	return ret;
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

[...]

--=20
Best Regards,
Jacek Anaszewski
