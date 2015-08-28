From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2 12/21] ARM: pxa: magician: Add PXA27x UDC support
Date: Fri, 28 Aug 2015 11:58:30 +0200
Message-ID: <871ten3fax.fsf@belgarion.home>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D25A06.9030507@tul.cz>
	<87twrt6fh5.fsf@belgarion.home> <55D652D0.90903@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:52200 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbbH1KDC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2015 06:03:02 -0400
In-Reply-To: <55D652D0.90903@tul.cz> (Petr Cvek's message of "Fri, 21 Aug 2015
	00:21:04 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Dne 20.8.2015 v 19:23 Robert Jarzmik napsal(a):
>> Petr Cvek <petr.cvek@tul.cz> writes:
>>> +static void magician_udc_command(int cmd)
>>> +{
>>> +	if (cmd == PXA2XX_UDC_CMD_CONNECT)
>>> +		UP2OCR |= UP2OCR_DPPUE | UP2OCR_DPPUBE;
>>> +	else if (cmd == PXA2XX_UDC_CMD_DISCONNECT)
>>> +		UP2OCR &= ~(UP2OCR_DPPUE | UP2OCR_DPPUBE);
>>> +}
>>> +
>>> +/* HACK, shared USB connected state with pda-power */
>>> +int my_usb_online = 1;
>> Definitely not, a global (ie. non static variable) is not something I'll let
>> in. Besides, can't a "gpio_get_value()" give the same level of information ?
>
> I will gladly remove it, but I want my phone to be able to charge and work as
> USB device (and maybe as USB host).
Okay, I understand that, but see below.

>> 
>>> +static int magician_udc_is_connected(void)
>>> +{
>>> +	/* Shared with pda_power or gpio-vbus */
>>> +	return my_usb_online;
>> gpio_get_value() something ?
>> 
>
> I need to use EGPIO_MAGICIAN_CABLE_INSERT1 GPIO in pda_power to be able to detect source for charging.
>
>>> +}
>>> +
>>> +static struct pxa2xx_udc_mach_info magician_udc_info __initdata = {
>>> +	.udc_command		= magician_udc_command,
>>> +	.udc_is_connected	= magician_udc_is_connected,
>> I don't think udc_is_connected is a field used by pxa27x_udc.c, it it ? The VBus
>> connection information comes from a transciever, usually from gpio_vbus driver
>> nowadays.
>
> Really? Well I guess I took a bad route :-D (when I tried to learn how to add an
> udc support). As there are two ways to define udc_is_connected, would it be
> possible to remove this field altogether (only mioa701 and lubbock have relevant
> use, but if this function is never called, then it is dead code)?
>
> Do you know which code / source is responsible for gpio_vbus -> pxa27x_udc
> communication about inserted cable? I will need to put some assert for
> testing.
Yes.
 - hooking: udc->transceiver = usb_get_phy(USB_PHY_TYPE_USB2);
 - detection: gpio_vbus_work()
   -> usb_gadget_vbus_connect()
     -> pxa_udc_vbus_session()

>>> @@ -1175,6 +1207,11 @@ static struct platform_device *devices[] __initdata = {
>>>  
>>>  	/* NOTICE mutually exclusive with PXA I2C */
>>>  	&i2c_gpio_bus_alt,
>>> +
>>> +	/* NOTICE mutually exclusive with UDC*/
>> Euh why so ?
>> In arch/arm/mach-pxa/mioa701.c they cooperate, why can't they for magician ?
>
> In mioa701 the GPIO13_nUSB_DETECT GPIO is requested by gpio_vbus driver, used in
> pda_power (without request) and "used" in PXA UDC driver without request. It is
> basically similar solution as my (ugly) global variable.
>
> Solution: I will try to use that second new GPIO (EGPIO_MAGICIAN_CABLE_INSERT2)
> for that, so there is no GPIO request dependency. I may create new names for
> them (magician.h).
Cool.
And if by chance you find an even cleaner solution, don't hesitate to modify
mioa701, hein ? ;)

Cheers.

-- 
Robert
