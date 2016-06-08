From: Mason <slash.tmp@free.fr>
Subject: Re: Platform-specific suspend/resume code in drivers
Date: Wed, 8 Jun 2016 23:26:24 +0200
Message-ID: <57588D80.4010502@free.fr>
References: <Pine.LNX.4.44L0.1606081340050.2191-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:54814 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbcFHV05 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 8 Jun 2016 17:26:57 -0400
In-Reply-To: <Pine.LNX.4.44L0.1606081340050.2191-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Pavel Machek <pavel@ucw.cz>, Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>, Sebastian Frias <sf84@laposte.net>, Mark Rutland <mark.rutland@arm.com>

On 08/06/2016 19:45, Alan Stern wrote:

> On Wed, 8 Jun 2016, Mason wrote:
> 
>> On 07/06/2016 17:06, Alan Stern wrote:
>>
>>> On Tue, 7 Jun 2016, Mason wrote:
>>>
>>>> Another point of confusion for me is this: drivers are supposed to
>>>> be shared among platforms, right? So my platform-specific suspend
>>>> code should be enabled only if my platform is detected at run-time?
>>>
>>> Is your device platform-specific?  If it is then the driver is also
>>> platform-specific, and so no part of the driver will be called at
>>> runtime unless your platform is detected.
>>
>> Specifically, my platform uses
>> drivers/net/ethernet/aurora/nb8800.c  => 3 entries in of_match_table.
>> drivers/tty/serial/8250/8250_core.c (CONFIG_SERIAL_8250_RT288X variant)
>>
>> and also the XHCI USB3 driver, and AHCI SATA driver, wouldn't I need to
>> save the context for these too?
> 
> Those drivers should already take care of their own contexts.  Is 
> there anything platform-specific you need to do in addition?

Take the eth driver, for example:

  http://lxr.free-electrons.com/source/drivers/net/ethernet/aurora/nb8800.c

It doesn't have any suspend/resume callbacks.

Would that make the suspend request fail?


> Consider xHCI as an example case -- what more does it need?

Lemme see...

http://lxr.free-electrons.com/source/drivers/usb/host/xhci-plat.c

#ifdef CONFIG_PM_SLEEP
static int xhci_plat_suspend(struct device *dev)
{
	struct usb_hcd	*hcd = dev_get_drvdata(dev);
	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);

	/*
	 * xhci_suspend() needs `do_wakeup` to know whether host is allowed
	 * to do wakeup during suspend. Since xhci_plat_suspend is currently
	 * only designed for system suspend, device_may_wakeup() is enough
	 * to dertermine whether host is allowed to do wakeup. Need to
	 * reconsider this when xhci_plat_suspend enlarges its scope, e.g.,
	 * also applies to runtime suspend.
	 */
	return xhci_suspend(xhci, device_may_wakeup(dev));
}

static int xhci_plat_resume(struct device *dev)
{
	struct usb_hcd	*hcd = dev_get_drvdata(dev);
	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);

	return xhci_resume(xhci, 0);
}

static const struct dev_pm_ops xhci_plat_pm_ops = {
	SET_SYSTEM_SLEEP_PM_OPS(xhci_plat_suspend, xhci_plat_resume)
};
#define DEV_PM_OPS	(&xhci_plat_pm_ops)


(Side note: they guarded the code with CONFIG_PM_SLEEP, rather
than CONFIG_SUSPEND. Why?)

Looking at xhci_suspend, it does call xhci_save_registers()
so perhaps this specific driver already saves the context
required to resume correctly after a full power-down.

>>> If the device isn't platform-specific then the driver has to work on a 
>>> bunch of different platforms.  It should be written to be 
>>> platform-independent as much as possible.
>>>
>>>> So this means I need to add in the probe function, for every driver
>>>> my platform uses:
>>>>
>>>>   if (platform == MY_PLATFORM) {
>>>>     ops.suspend = my_suspend;
>>>>     ops.resume  = my_resume;
>>>>   }
>>>>
>>>> Is that correct?
>>>
>>> No.  For one thing, you only have to worry about the 
>>> platform-independent drivers -- you know that the platform-specific 
>>> ones won't get used unless your platform is present.
>>
>> I guess the thermal driver is platform-specific, but most devices
>> are third-party IP blocks, so there is a "common" driver upstream.
>> But I would need a platform-specific suspend/resume sequence,
>> just for my platform.
> 
> Why?  What sort of platform-specific things do you need to do?

Save the value of the MMIO registers which will be lost when the
chip is powered down.


>>> For another, the driver should be written in a way that doesn't require
>>> this sort of code.  The ops pointer (not any of the structure's members
>>> -- a pointer to the structure) should be set by the platform-dependent
>>> part of the driver that handles initialization.
>>
>> I don't understand. If my platform loses context on suspend, then
>> I must save/restore it. But this wasteful operation should not be
>> imposed on other platforms.
> 
> More details, please.

I'm confused. I must have misunderstood something fundamental, and my
explanations come out wrong. Let me try again.

On this SoC (as most SoCs) device registers are mapped into memory.
When this system is suspended, it was decided that we would
1) put the RAM in self-refresh mode
2) power everything down, but the RAM

So the contents of RAM are preserved, but the contents of the device
registers will be lost. (And this context loss is platform specific;
other SoCs may decide to keep some devices powered.) Anyway, when
the chip is powered back up, some/most device registers need to be
restored to their pre-suspend value.

For example, the reset value for a CTRL register might default to
DISABLE_DEVICE, but obviously the probe function would have toggled
that to ENABLE_DEVICE.

Am I not making sense?

Regards.
