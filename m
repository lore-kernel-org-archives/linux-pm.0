From: Petr Cvek <petr.cvek@tul.cz>
Subject: Re: [PATCH v2 04/21] ARM: pxa: magician: Add, fix and init (new)
 GPIOs
Date: Wed, 19 Aug 2015 00:46:25 +0200
Message-ID: <55D3B5C1.2070806@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D258E9.9010303@tul.cz>
 <87mvxo8lqi.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:39364 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754087AbbHRWna (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 18 Aug 2015 18:43:30 -0400
In-Reply-To: <87mvxo8lqi.fsf@belgarion.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Dne 18.8.2015 v 21:01 Robert Jarzmik napsal(a):
> 
> From here onward, I'll suppose you'll catch all whitespace/indentation changes
> and extract them towards patch 01/21 ...

OK

> 
>>  /* input */
>>  
>> -#define EGPIO_MAGICIAN_CABLE_STATE_AC		MAGICIAN_EGPIO(4, 0)
>> -#define EGPIO_MAGICIAN_CABLE_STATE_USB		MAGICIAN_EGPIO(4, 1)
>> +/* AC=1, USB=0 */
>> +#define EGPIO_MAGICIAN_CABLE_TYPE		MAGICIAN_EGPIO(4, 0)
>> +/* =1 when AC or USB cable inserted */
>> +#define EGPIO_MAGICIAN_CABLE_INSERT1		MAGICIAN_EGPIO(4, 1)
> The naming makes me uneasy : it's rather vague "cable insert".
> If AC and USB are the only charging methods, why not have something like
> "EGPIO_MAGICIAN_POWERED" or the like ?

I don't see why not, but there are two GPIOs and it may turn out they have different function. I found it only for power/usb cable insertion. For example they may differ when usb device is connected (magician is now a host) but I did not test it (yet, phone does not generate vbus power).

> 
>>  	GPIO10_GPIO,	/* GSM_IRQ */
>>  	GPIO13_GPIO,	/* CPLD_IRQ */
>>  	GPIO107_GPIO,	/* DS1WM_IRQ */
>>  	GPIO108_GPIO,	/* GSM_READY */
>>  	GPIO115_GPIO,	/* nPEN_IRQ */
>>  
>> -	/* I2C */
>> -	GPIO117_I2C_SCL,
>> -	GPIO118_I2C_SDA,
> Okay so that are no I2C devices on magician ? Why keep GPIO119_MAGICIAN_I2C_* at
> the beginning of the file then ?

It is a duplicite definition.

	http://lxr.free-electrons.com/source/arch/arm/mach-pxa/magician.c#L60

and in the same array again at:

	http://lxr.free-electrons.com/source/arch/arm/mach-pxa/magician.c#L118

> 
>> +	MFP_CFG_OUT(GPIO40, AF0, DRIVE_LOW),	/* FIXME GSM? */
>> +	MFP_CFG_OUT(GPIO87, AF0, DRIVE_LOW),	/* FIXME GSM? */
>> +
>> +	/* Left GPIOs (undefined here):
>> +	 * 18, 49 : bootloader=VLIO?, WinM=TODO
>> +	 * 48 : AF0/out0
>> +	 * 56 : AF0/out0
>> +	 * 74 : bootloader=AF0/output
>> +	 * 86 : bootloader=AF0/input (but should be gsm reset???)
>> +	 * 114 : AF0/out0
>> +	 * 119 : AF0/out0
>> +	 * 120 : AF0/out
>> +	 * 1 : dedicated reset, AF0/output
>> +	 * 13 : cpld irq, output (??)
>> +	 */
> This is not describing current code. This doesn't belong to this file, even if I
> know how frustrating it is to reverse engineer all these gpios. I created a wiki
> web page will all GPIOs to let go my frustration in the past :)

OK I can create file in Documentation for that (at least one pin has a different direction in kernel vs bootloader).

BTW on xda wiki?

> 
>> @@ -241,8 +324,9 @@ static struct htc_egpio_chip egpio_chips[] = {
>>  
>>  		/*
>>  		 * Depends on modules configuration
>> +		 * Things like MMC and LCD should be enabled
>>  		 */
>> -		.initial_values = 0x40,
>> +		.initial_values = 0x21a0c0,
> Aren't they enabled by each driver upon its probe() ? What if MMC nor LCD is
> compiled in the kernel ?
> 

Some of it is from time kernel did not get to rootfs detection: 0x8000 for to be able to read panic errors (before a backlight driver is loaded - which is BTW not working now in vanilla). 0x80 should be for a valid LCD power sequence (broken one causes invalid voltages on LCD power lines). 0x2000 is RESET for soundcard as original 0x40 is for GSM. MMC can be probably changed to "0" now when everything is working. 0x200000 as 500mA charging should be enabled (for safety) as sometimes boot on weak accu can cause overcurrent, which will hardreset the phone.


>> @@ -343,21 +427,19 @@ static void samsung_lcd_power(int on, struct fb_var_screeninfo *si)
>>  			gpio_set_value(GPIO75_MAGICIAN_SAMSUNG_POWER, 1);
>>  		else
>>  			gpio_set_value(EGPIO_MAGICIAN_LCD_POWER, 1);
>> -		mdelay(10);
>> -		gpio_set_value(GPIO106_MAGICIAN_LCD_POWER_3, 1);
>> -		mdelay(10);
>> -		gpio_set_value(GPIO104_MAGICIAN_LCD_POWER_1, 1);
>> -		mdelay(30);
>> -		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 1);
>> -		mdelay(10);
>> +		mdelay(6);
>> +		gpio_set_value(GPIO106_MAGICIAN_LCD_DCDC_NRESET, 1);
>> +		mdelay(6);	/* Avdd -> Voff >5ms */
>> +		gpio_set_value(GPIO104_MAGICIAN_LCD_VOFF_EN, 1);
>> +		mdelay(16);	/* Voff -> Von >(5+10)ms */
>> +		gpio_set_value(GPIO105_MAGICIAN_LCD_VON_EN, 1);
>>  	} else {
>> -		mdelay(10);
>> -		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 0);
>> -		mdelay(30);
>> -		gpio_set_value(GPIO104_MAGICIAN_LCD_POWER_1, 0);
>> -		mdelay(10);
>> -		gpio_set_value(GPIO106_MAGICIAN_LCD_POWER_3, 0);
>> -		mdelay(10);
>> +		gpio_set_value(GPIO105_MAGICIAN_LCD_VON_EN, 0);
>> +		mdelay(16);
>> +		gpio_set_value(GPIO104_MAGICIAN_LCD_VOFF_EN, 0);
>> +		mdelay(6);
>> +		gpio_set_value(GPIO106_MAGICIAN_LCD_DCDC_NRESET, 0);
>> +		mdelay(6);
> You're changing the timings here, right ? This should be an appart patch. What
> is the reason of the change by the way ?

Faster reaction, one change from msleep to mdelay (in toppoly LCD) and reading a datasheet for a valid sequence.

> 
> Cheers.
> 
Best regards,
Petr

