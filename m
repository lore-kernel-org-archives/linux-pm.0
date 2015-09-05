From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2 00/21] ARM: pxa: magician: Rework HTC Magician support
Date: Sat, 05 Sep 2015 12:10:21 +0200
Message-ID: <87fv2txjle.fsf@belgarion.home>
References: <55D2583B.8040602@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:51947 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbbIEKPP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 5 Sep 2015 06:15:15 -0400
In-Reply-To: <55D2583B.8040602@tul.cz> (Petr Cvek's message of "Mon, 17 Aug
	2015 23:55:07 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>, philipp.zabel@gmail.com
Cc: daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> This patchset will clean, fix and finally add multiple PXA devices
> to HTC Magician machine. Also it adds leds-pasic3 driver to LED subsystem.
> This driver require changes into htc-pasic3 structures, which are used
> exclusively by magician.c code.
>
> Petr Cvek (21):
>   ARM: pxa: magician: Fix Kconfig for magician to always include
>     htc-egpio
>   ARM: pxa: magician: Fix indentation and whitespaces
>   ARM: pxa: magician: Fix comments, debug functions and print strings
>   ARM: pxa: magician: Add, fix and init (new) GPIOs
>   ARM: pxa: magician: Add support for ADS7846 touchscreen
>   ARM: pxa: magician: Add normal and power I2C definition
>   ARM: pxa: magician: Fix IrDA pdata and redundant GPIO request
>   ARM: pxa: magician: Add StrataFlash Vpp GPIO and alternative driver
>   ARM: pxa: magician: Add OV9640 camera support
>   ARM: pxa: magician: Add UDA1380 sound support
>   ARM: pxa: magician: Add MAX1586 Vcore regulator support
>   ARM: pxa: magician: Add PXA27x UDC support
>   ARM: pxa: magician: Fix charging source and add NiCd backup charging
>   ARM: pxa: magician: Fix PXA USB OHCI port enable flags
>   ARM: pxa: magician: Fix PWM backlight regulator
>   ARM: pxa: magician: Add support for alternative LCD backlight
>   ARM: pxa: magician: Remove (temporarily) pasic3 LED support
>   mfd: htc-pasic3: Prepare driver for leds-pasic3
>   leds: leds-pasic3: Add support for PASIC3 LED controller
>   ARM: pxa: magician: Re-add pdata for new leds-pasic3 driver
>   ARM: pxa: magician: Move platform_add_devices() to the end of
>     magician_init()

Hi Petr,

If you want several of these patches targeted at v4.3, I need to know which ones
(in arch/arm/mach-pxa) are pure fixes without which magician is broken.

And a confirmation from Philip on this list would make my life easier.

Cheers.

-- 
Robert
