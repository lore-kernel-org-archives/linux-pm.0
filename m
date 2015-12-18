From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH V2 3/8] genirq: Add runtime power management support
 for IRQ chips
Date: Fri, 18 Dec 2015 10:20:29 +0000
Message-ID: <5673DDED.5000307@nvidia.com>
References: <1450349309-8107-1-git-send-email-jonathanh@nvidia.com>
 <1450349309-8107-4-git-send-email-jonathanh@nvidia.com>
 <CACRpkdZXBPQv0ftZJEyE_Q7X_nTpY=3Cd_PTCnK-nHMyqmmBqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14777 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbbLRKUg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Dec 2015 05:20:36 -0500
In-Reply-To: <CACRpkdZXBPQv0ftZJEyE_Q7X_nTpY=3Cd_PTCnK-nHMyqmmBqg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Jiang Liu <jiang.liu@linux.intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Soren Brinkmann <soren.brinkmann@xilinx.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>



On 17/12/15 13:19, Linus Walleij wrote:
> On Thu, Dec 17, 2015 at 11:48 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
> 
> (Adding Rafael and linux-pm to To: list)
> 
>> Some IRQ chips may be located in a power domain outside of the CPU
>> subsystem and hence will require device specific runtime power management.
>> In order to support such IRQ chips, add a pointer for a device structure
>> to the irq_chip structure, and if this pointer is populated by the IRQ
>> chip driver and the flag CHIP_HAS_RPM is set, then the pm_runtime_get/put
>> APIs for this chip will be called when an IRQ is requested/freed,
>> respectively.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> 
> Overall I like what you're trying to do. This will enable e.g. I2C
> GPIO supplying expanders to power down if none of its lines are
> used for IRQs. (Read below on the suspend() case for even
> better stuff we can do!)
> 
> (...)
>> @@ -307,6 +307,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
>>  /**
>>   * struct irq_chip - hardware interrupt chip descriptor
>>   *
>> + * @dev:               pointer to associated device
> (...)
>>  struct irq_chip {
>> +       struct device   *dev;
> 
> In struct gpio_chip I just this merge window have to merge a gigantic
> patch renaming this from "dev" to "parent" because we need to add
> a *real* struct device dev; to gpio_chip.
> 
> So for the advent that we may in the future need a real struct device
> inside irq_chip, name this .parent already today, please.

Ok, fine with me.

>> +/* Inline functions for support of irq chips that require runtime pm */
>> +static inline int chip_pm_get(struct irq_desc *desc)
>> +{
>> +       int retval = 0;
>> +
>> +       if (desc->irq_data.chip->dev &&
>> +           desc->irq_data.chip->flags & IRQCHIP_HAS_RPM)
>> +               retval = pm_runtime_get_sync(desc->irq_data.chip->dev);
>> +
>> +       return (retval < 0) ? retval : 0;
>> +}
> 
> That is boiling all PM upward into the platform_device or whatever
> it is containing this. But we're not just in it for runtime_pm_suspend()
> and runtime_pm_resume(). We also have regular suspend() and
> resume(). And ideally that should be handled by the same
> callbacks.

Yes, I have purposely not tried to handle suspend here as I have left it
to be handle by suspend_device_irqs() called during system suspend.

I don't follow why we need to handle regular suspend here? Or is this
for chips that do not support runtime-pm?

> First: what if the device contain any wakeup-flagged IRQs?

So today with this patch, the IRQ chip would only be runtime suspended
if all IRQs are freed. So it should not impact wakeups. Unless I am
missing something?

> I think there is something missing here. The suspend() usecase
> is not handled by this patch, but we need to think about that
> here as well. I think irqchips on GPIO expanders (for example)
> should be powered down on suspend() *unless* one or more of
> its IRQs is flagged as wakeup, and in that case it should
> *not* be powered down, instead it should just mask all
> non-wakeup IRQs and restore them on resume().
> 
> Second: it's soo easy to get something wrong here. It'd be good
> if the kernel was helpful. What about something like:
> 
> if (desc->irq_data.chip->dev) {
>     if (desc->irq_data.chip->flags & IRQCHIP_HAS_RPM)
>            retval = pm_runtime_get_sync(desc->irq_data.chip->dev)
>     else if (pm_runtime_enabled(desc->irq_data.chip->dev))
>            dev_warn_once(desc->irq_data.chip->dev, "irqchip not
> flagged for RPM but has runtime PM enabled! weird.\n");
> }
>
> As I see it, a device that supplies an irqchip, has runtime PM but
> is *NOT* setting IRQCHIP_HAS_RPM just *have* to be looked
> at in detail, and deserve to have this littering its dmesg so we can
> fix it. It just makes no real sense. It more sounds like a recepie for
> missing interrupts otherwise.

Yes, I agree, additional checking such as the above would be helpful.
Thanks.

Cheers
Jon
