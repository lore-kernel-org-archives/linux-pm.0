From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2 04/21] ARM: pxa: magician: Add, fix and init (new) GPIOs
Date: Tue, 18 Aug 2015 21:01:09 +0200
Message-ID: <87mvxo8lqi.fsf@belgarion.home>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D258E9.9010303@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:34794 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbbHRTFQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2015 15:05:16 -0400
In-Reply-To: <55D258E9.9010303@tul.cz> (Petr Cvek's message of "Mon, 17 Aug
	2015 23:58:01 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Add new GPIOs, fix some GPIO names and initialization (EGPIO, LCD power on
> sequence).
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> ---
>  arch/arm/mach-pxa/include/mach/magician.h |  39 ++++---
>  arch/arm/mach-pxa/magician.c              | 166 +++++++++++++++++++++++-------
>  2 files changed, 153 insertions(+), 52 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/include/mach/magician.h b/arch/arm/mach-pxa/include/mach/magician.h
> index ba6a6e1..d19e504 100644
> --- a/arch/arm/mach-pxa/include/mach/magician.h
> +++ b/arch/arm/mach-pxa/include/mach/magician.h
> @@ -21,10 +21,10 @@
>  
>  #define GPIO0_MAGICIAN_KEY_POWER		0
>  #define GPIO9_MAGICIAN_UNKNOWN			9
> -#define GPIO10_MAGICIAN_GSM_IRQ			10
> +#define GPIO10_MAGICIAN_GSM_IRQ		10
Whitespace/indentation changes ?

>  #define GPIO11_MAGICIAN_GSM_OUT1		11
>  #define GPIO13_MAGICIAN_CPLD_IRQ		13
> -#define GPIO18_MAGICIAN_UNKNOWN			18
> +#define GPIO18_MAGICIAN_UNKNOWN		18
Ditto.

> @@ -32,8 +32,10 @@
>  #define GPIO37_MAGICIAN_KEY_HANGUP		37
>  #define GPIO38_MAGICIAN_KEY_CONTACTS		38
>  #define GPIO40_MAGICIAN_GSM_OUT2		40
> -#define GPIO48_MAGICIAN_UNKNOWN			48
> -#define GPIO56_MAGICIAN_UNKNOWN			56
> +#define GPIO46_MAGICIAN_IR_RX			46
> +#define GPIO47_MAGICIAN_IR_TX			47
> +#define GPIO48_MAGICIAN_UNKNOWN		48
> +#define GPIO56_MAGICIAN_UNKNOWN		56
Ditto for 48, 56 ?

>  #define GPIO57_MAGICIAN_CAM_RESET		57
>  #define GPIO75_MAGICIAN_SAMSUNG_POWER		75
>  #define GPIO83_MAGICIAN_nIR_EN			83
> @@ -51,15 +53,17 @@
>  #define GPIO100_MAGICIAN_KEY_VOL_UP		100
>  #define GPIO101_MAGICIAN_KEY_VOL_DOWN 		101
>  #define GPIO102_MAGICIAN_KEY_PHONE		102
> -#define GPIO103_MAGICIAN_LED_KP			103
> -#define GPIO104_MAGICIAN_LCD_POWER_1 		104
> -#define GPIO105_MAGICIAN_LCD_POWER_2		105
> -#define GPIO106_MAGICIAN_LCD_POWER_3		106
> +#define GPIO103_MAGICIAN_LED_KP		103
Ditto ?
> +#define GPIO104_MAGICIAN_LCD_VOFF_EN		104
> +#define GPIO105_MAGICIAN_LCD_VON_EN		105
> +#define GPIO106_MAGICIAN_LCD_DCDC_NRESET	106
>  #define GPIO107_MAGICIAN_DS1WM_IRQ		107
>  #define GPIO108_MAGICIAN_GSM_READY		108
>  #define GPIO114_MAGICIAN_UNKNOWN		114
>  #define GPIO115_MAGICIAN_nPEN_IRQ		115
>  #define GPIO116_MAGICIAN_nCAM_EN		116
> +#define GPIO117_MAGICIAN_I2C_SCL		117
> +#define GPIO118_MAGICIAN_I2C_SDA		118
>  #define GPIO119_MAGICIAN_UNKNOWN		119
>  #define GPIO120_MAGICIAN_UNKNOWN		120
>  
> @@ -78,7 +82,7 @@
>   * CPLD EGPIOs
>   */
>  
> -#define MAGICIAN_EGPIO_BASE			PXA_NR_BUILTIN_GPIO
> +#define MAGICIAN_EGPIO_BASE	PXA_NR_BUILTIN_GPIO
Ditto ?

>From here onward, I'll suppose you'll catch all whitespace/indentation changes
and extract them towards patch 01/21 ...

>  /* input */
>  
> -#define EGPIO_MAGICIAN_CABLE_STATE_AC		MAGICIAN_EGPIO(4, 0)
> -#define EGPIO_MAGICIAN_CABLE_STATE_USB		MAGICIAN_EGPIO(4, 1)
> +/* AC=1, USB=0 */
> +#define EGPIO_MAGICIAN_CABLE_TYPE		MAGICIAN_EGPIO(4, 0)
> +/* =1 when AC or USB cable inserted */
> +#define EGPIO_MAGICIAN_CABLE_INSERT1		MAGICIAN_EGPIO(4, 1)
The naming makes me uneasy : it's rather vague "cable insert".
If AC and USB are the only charging methods, why not have something like
"EGPIO_MAGICIAN_POWERED" or the like ?

>  	GPIO10_GPIO,	/* GSM_IRQ */
>  	GPIO13_GPIO,	/* CPLD_IRQ */
>  	GPIO107_GPIO,	/* DS1WM_IRQ */
>  	GPIO108_GPIO,	/* GSM_READY */
>  	GPIO115_GPIO,	/* nPEN_IRQ */
>  
> -	/* I2C */
> -	GPIO117_I2C_SCL,
> -	GPIO118_I2C_SDA,
Okay so that are no I2C devices on magician ? Why keep GPIO119_MAGICIAN_I2C_* at
the beginning of the file then ?

> +	MFP_CFG_OUT(GPIO40, AF0, DRIVE_LOW),	/* FIXME GSM? */
> +	MFP_CFG_OUT(GPIO87, AF0, DRIVE_LOW),	/* FIXME GSM? */
> +
> +	/* Left GPIOs (undefined here):
> +	 * 18, 49 : bootloader=VLIO?, WinM=TODO
> +	 * 48 : AF0/out0
> +	 * 56 : AF0/out0
> +	 * 74 : bootloader=AF0/output
> +	 * 86 : bootloader=AF0/input (but should be gsm reset???)
> +	 * 114 : AF0/out0
> +	 * 119 : AF0/out0
> +	 * 120 : AF0/out
> +	 * 1 : dedicated reset, AF0/output
> +	 * 13 : cpld irq, output (??)
> +	 */
This is not describing current code. This doesn't belong to this file, even if I
know how frustrating it is to reverse engineer all these gpios. I created a wiki
web page will all GPIOs to let go my frustration in the past :)

> @@ -241,8 +324,9 @@ static struct htc_egpio_chip egpio_chips[] = {
>  
>  		/*
>  		 * Depends on modules configuration
> +		 * Things like MMC and LCD should be enabled
>  		 */
> -		.initial_values = 0x40,
> +		.initial_values = 0x21a0c0,
Aren't they enabled by each driver upon its probe() ? What if MMC nor LCD is
compiled in the kernel ?

> @@ -343,21 +427,19 @@ static void samsung_lcd_power(int on, struct fb_var_screeninfo *si)
>  			gpio_set_value(GPIO75_MAGICIAN_SAMSUNG_POWER, 1);
>  		else
>  			gpio_set_value(EGPIO_MAGICIAN_LCD_POWER, 1);
> -		mdelay(10);
> -		gpio_set_value(GPIO106_MAGICIAN_LCD_POWER_3, 1);
> -		mdelay(10);
> -		gpio_set_value(GPIO104_MAGICIAN_LCD_POWER_1, 1);
> -		mdelay(30);
> -		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 1);
> -		mdelay(10);
> +		mdelay(6);
> +		gpio_set_value(GPIO106_MAGICIAN_LCD_DCDC_NRESET, 1);
> +		mdelay(6);	/* Avdd -> Voff >5ms */
> +		gpio_set_value(GPIO104_MAGICIAN_LCD_VOFF_EN, 1);
> +		mdelay(16);	/* Voff -> Von >(5+10)ms */
> +		gpio_set_value(GPIO105_MAGICIAN_LCD_VON_EN, 1);
>  	} else {
> -		mdelay(10);
> -		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 0);
> -		mdelay(30);
> -		gpio_set_value(GPIO104_MAGICIAN_LCD_POWER_1, 0);
> -		mdelay(10);
> -		gpio_set_value(GPIO106_MAGICIAN_LCD_POWER_3, 0);
> -		mdelay(10);
> +		gpio_set_value(GPIO105_MAGICIAN_LCD_VON_EN, 0);
> +		mdelay(16);
> +		gpio_set_value(GPIO104_MAGICIAN_LCD_VOFF_EN, 0);
> +		mdelay(6);
> +		gpio_set_value(GPIO106_MAGICIAN_LCD_DCDC_NRESET, 0);
> +		mdelay(6);
You're changing the timings here, right ? This should be an appart patch. What
is the reason of the change by the way ?

Cheers.

-- 
Robert

PS: My workforce is done for today, next review tomorrow.
