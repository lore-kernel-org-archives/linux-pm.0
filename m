From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 18/21] mfd: htc-pasic3: Prepare driver for leds-pasic3
Date: Tue, 18 Aug 2015 07:52:07 +0100
Message-ID: <20150818065207.GC6180@x1>
References: <cover.1439843482.git.petr.cvek@tul.cz>
 <55D25ABC.1000405@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33864 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbbHRGwL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2015 02:52:11 -0400
Received: by wicne3 with SMTP id ne3so91873136wic.1
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2015 23:52:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55D25ABC.1000405@tul.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 18 Aug 2015, Petr Cvek wrote:

> Fix register definitions and prepare structures for new leds-pasic3
> driver.
>=20
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> ---
>  drivers/mfd/htc-pasic3.c       | 54 ++++++++++++++++-----------
>  include/linux/mfd/htc-pasic3.h | 85 +++++++++++++++++++++++++++++++-=
----------
>  2 files changed, 97 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/mfd/htc-pasic3.c b/drivers/mfd/htc-pasic3.c
> index e88d4f6..16e156d 100644
> --- a/drivers/mfd/htc-pasic3.c
> +++ b/drivers/mfd/htc-pasic3.c
> @@ -3,6 +3,9 @@
>   *
>   * Copyright (C) 2006 Philipp Zabel <philipp.zabel@gmail.com>
>   *
> + * 2015:	Added registers for LED and RESET, see htc-pasic3.h
> + *		-- Petr Cvek
> + *

This is pretty unconventional.

Please look to see what others have done.

>   * This program is free software; you can redistribute it and/or mod=
ify
>   * it under the terms of the GNU General Public License as published=
 by
>   * the Free Software Foundation; version 2 of the License.
> @@ -21,15 +24,10 @@
>  #include <linux/mfd/htc-pasic3.h>
>  #include <linux/slab.h>
> =20
> -struct pasic3_data {
> -	void __iomem *mapping;
> -	unsigned int bus_shift;
> -};
> -
>  #define REG_ADDR  5
>  #define REG_DATA  6
> =20
> -#define READ_MODE 0x80
> +#define READ_MODE BIT(7)
> =20
>  /*
>   * write to a secondary register on the PASIC3
> @@ -76,24 +74,36 @@ static struct mfd_cell led_cell __initdata =3D {
>  static int ds1wm_enable(struct platform_device *pdev)
>  {
>  	struct device *dev =3D pdev->dev.parent;
> -	int c;
> +	struct pasic3_data *asic =3D platform_get_drvdata(pdev);
> +	unsigned long flags;
> +	u8 c;
> +
> +	spin_lock_irqsave(&asic->lock, flags);
> +
> +	c =3D pasic3_read_register(dev, PASIC3_GPIO);
> +	pasic3_write_register(dev, PASIC3_GPIO, c & ~DS1WM_NEN);
> =20
> -	c =3D pasic3_read_register(dev, 0x28);
> -	pasic3_write_register(dev, 0x28, c & 0x7f);
> +	spin_unlock_irqrestore(&asic->lock, flags);
> =20
> -	dev_dbg(dev, "DS1WM OWM_EN low (active) %02x\n", c & 0x7f);
> +	dev_dbg(dev, "DS1WM OWM_EN low (active) %02lx\n", c & ~DS1WM_NEN);
>  	return 0;
>  }
> =20
>  static int ds1wm_disable(struct platform_device *pdev)
>  {
>  	struct device *dev =3D pdev->dev.parent;
> -	int c;
> +	struct pasic3_data *asic =3D platform_get_drvdata(pdev);
> +	unsigned long flags;
> +	u8 c;
> +
> +	spin_lock_irqsave(&asic->lock, flags);
> +
> +	c =3D pasic3_read_register(dev, PASIC3_GPIO);
> +	pasic3_write_register(dev, PASIC3_GPIO, c | DS1WM_NEN);
> =20
> -	c =3D pasic3_read_register(dev, 0x28);
> -	pasic3_write_register(dev, 0x28, c | 0x80);
> +	spin_unlock_irqrestore(&asic->lock, flags);
> =20
> -	dev_dbg(dev, "DS1WM OWM_EN high (inactive) %02x\n", c | 0x80);
> +	dev_dbg(dev, "DS1WM OWM_EN high (inactive) %02lx\n", c | DS1WM_NEN)=
;
>  	return 0;
>  }
> =20
> @@ -130,6 +140,7 @@ static int __init pasic3_probe(struct platform_de=
vice *pdev)
>  	struct device *dev =3D &pdev->dev;
>  	struct pasic3_data *asic;
>  	struct resource *r;
> +	struct pasic3_leds_pdata *leds_pdata;
>  	int ret;
>  	int irq =3D 0;
> =20
> @@ -162,6 +173,8 @@ static int __init pasic3_probe(struct platform_de=
vice *pdev)
>  	/* calculate bus shift from mem resource */
>  	asic->bus_shift =3D (resource_size(r) - 5) >> 3;
> =20
> +	spin_lock_init(&asic->lock);
> +
>  	if (pdata && pdata->clock_rate) {
>  		ds1wm_pdata.clock_rate =3D pdata->clock_rate;
>  		/* the first 5 PASIC3 registers control the DS1WM */
> @@ -172,13 +185,12 @@ static int __init pasic3_probe(struct platform_=
device *pdev)
>  			dev_warn(dev, "failed to register DS1WM\n");
>  	}
> =20
> -	if (pdata && pdata->led_pdata) {
> -		led_cell.platform_data =3D pdata->led_pdata;
> -		led_cell.pdata_size =3D sizeof(struct pasic3_leds_machinfo);
> -		ret =3D mfd_add_devices(&pdev->dev, pdev->id, &led_cell, 1, r,
> -				      0, NULL);
> -		if (ret < 0)
> -			dev_warn(dev, "failed to register LED device\n");
> +	if (pdata && pdata->pasic3_leds) {
> +		leds_pdata =3D dev_get_platdata(&pdata->pasic3_leds->dev);

Whoa!  You're passing a pointer to a device through pdata?

I don't like that at all.  Please explain.

> +		if (leds_pdata) {
> +			leds_pdata->mfd_dev =3D dev;
> +			platform_device_register(pdata->pasic3_leds);

What's the idea here?

> +		}
>  	}
> =20
>  	return 0;
> diff --git a/include/linux/mfd/htc-pasic3.h b/include/linux/mfd/htc-p=
asic3.h
> index 3d3ed67..91a27b6 100644
> --- a/include/linux/mfd/htc-pasic3.h
> +++ b/include/linux/mfd/htc-pasic3.h
> @@ -2,6 +2,7 @@
>   * HTC PASIC3 driver - LEDs and DS1WM
>   *
>   * Copyright (c) 2007 Philipp Zabel <philipp.zabel@gmail.com>
> + * Copyright (c) 2015 Petr Cvek <petr.cvek@tul.cz>
>   *
>   * This file is subject to the terms and conditions of the GNU Gener=
al Public
>   * License.  See the file COPYING in the main directory of this arch=
ive for
> @@ -18,37 +19,79 @@
>  extern void pasic3_write_register(struct device *dev, u32 reg, u8 va=
l);
>  extern u8 pasic3_read_register(struct device *dev, u32 reg);
> =20
> -/*
> - * mask for registers 0x20,0x21,0x22
> - */
> -#define PASIC3_MASK_LED0 0x04
> -#define PASIC3_MASK_LED1 0x08
> -#define PASIC3_MASK_LED2 0x40
> +#define PASIC3_CH0_DELAY_ON	0x00
> +#define PASIC3_CH0_DELAY_OFF	0x01
> +#define PASIC3_CH1_DELAY_ON	0x02
> +#define PASIC3_CH1_DELAY_OFF	0x03
> +#define PASIC3_CH2_DELAY_ON	0x04
> +#define PASIC3_CH2_DELAY_OFF	0x05
> +#define PASIC3_DELAY_MASK	0x7f
> +
> +#define PASIC3_CH_CONTROL	0x06
> +#define		R06_CH0_EN		BIT(0)
> +#define		R06_CH1_EN		BIT(1)
> +#define		R06_CH2_EN		BIT(2)
> +#define		R06_CH0_FORCE_ON	BIT(3)
> +#define		R06_CH1_FORCE_ON	BIT(4)
> +#define		R06_CH2_FORCE_ON	BIT(5)
> =20
>  /*
> - * bits in register 0x06
> + * pwm_ch0_out | force_on | (bit0 & bit1 & bit2)
> + * pwm_ch1_out | force_on | (bit0 & bit1 & bit2)
> + * pwm_ch2_out | force_on | (bit2?bit0:(bit0 & ! bit1))

Please space this out properly.

>   */
> -#define PASIC3_BIT2_LED0 0x08
> -#define PASIC3_BIT2_LED1 0x10
> -#define PASIC3_BIT2_LED2 0x20
> +
> +#define PASIC3_MASK_A	0x20
> +#define PASIC3_MASK_B	0x21
> +#define PASIC3_MASK_C	0x22
> +#define		MASK_CH0	BIT(2)
> +#define		MASK_CH1	BIT(3)
> +#define		MASK_CH2	BIT(6)
> +#define PASIC3_GPIO	0x28
> +#define		DS1WM_NEN	BIT(7)
> +#define PASIC3_SYS	0x2a
> +
> +/* NORMAL_RST, CAM_PWR_RST and UNKNOWN will autoclear, set STATUS */
> +#define		NORMAL_RST	BIT(0)
> +#define		CAM_PWR_RST	BIT(1)
> +#define		UNKNOWN	BIT(2)
> +#define		STATUS_NORMAL_RST	BIT(4)
> +#define		STATUS_CAM_PWR_RST	BIT(5)
> +#define		STATUS_UNKNOWN		BIT(6)
> +
> +/* FIXME/TODO reset sources */
> +#define PASIC3_RST_EN	0x2c
> +#define		EN_NORMAL_RST	0x40
> +#define		EN_DOOR_RST	0x42
> =20
>  struct pasic3_led {
> -	struct led_classdev         led;
> -	unsigned int                hw_num;
> -	unsigned int                bit2;
> -	unsigned int                mask;
> -	struct pasic3_leds_machinfo *pdata;
> +	char	name[24];
> +	char	default_trigger[80];
> +	int	hw_num;
> +	u8	bit_blink_en;
> +	u8	bit_force_on;
> +	u8	bit_mask;
> +	u8	reg_delay_on;
> +	u8	reg_delay_off;
>  };
> =20
> -struct pasic3_leds_machinfo {
> -	unsigned int      num_leds;
> -	unsigned int      power_gpio;
> +struct pasic3_leds_pdata {
>  	struct pasic3_led *leds;
> +	int num_leds;
> +	int power_gpio;
> +	int power_gpio_users;
> +	struct device *mfd_dev;
>  };
> =20
> -struct pasic3_platform_data {
> -	struct pasic3_leds_machinfo *led_pdata;
> -	unsigned int                 clock_rate;
> +struct pasic3_data {
> +	void __iomem *mapping;
> +	unsigned int bus_shift;
> +	spinlock_t lock;
>  };
> =20
> +struct pasic3_platform_data {
> +	unsigned int clock_rate;
> +	struct pasic3_led *leds;
> +	struct platform_device *pasic3_leds;
> +};

If you can separate these with a TAB like the rest of the file, that
would be preferred.

>  #endif

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
