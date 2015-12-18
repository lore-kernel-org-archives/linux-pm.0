From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH V2 8/8] irqchip/gic: Add support for tegra AGIC
 interrupt controller
Date: Fri, 18 Dec 2015 10:44:27 +0000
Message-ID: <5673E38B.7060702@nvidia.com>
References: <1450349309-8107-1-git-send-email-jonathanh@nvidia.com>
 <1450349309-8107-9-git-send-email-jonathanh@nvidia.com>
 <CACRpkdZT42rpKsVtNYdCuL_i0xWngvKSMSVUy1bLmPtxHhG5ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16215 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbbLRKoe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Dec 2015 05:44:34 -0500
In-Reply-To: <CACRpkdZT42rpKsVtNYdCuL_i0xWngvKSMSVUy1bLmPtxHhG5ew@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Jiang Liu <jiang.liu@linux.intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Soren Brinkmann <soren.brinkmann@xilinx.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>


On 17/12/15 13:32, Linus Walleij wrote:
> On Thu, Dec 17, 2015 at 11:48 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
> 
>> Add a driver for the Tegra-AGIC interrupt controller which is compatible
>> with the ARM GIC-400 interrupt controller.
> (...)
>> +static const struct dev_pm_ops gic_pm_ops = {
>> +       SET_RUNTIME_PM_OPS(gic_runtime_suspend,
>> +                          gic_runtime_resume, NULL)
>> +       SET_SYSTEM_SLEEP_PM_OPS(gic_suspend, gic_resume)
>> +};
> 
> Now you do what I commented on in the earlier patch: assign
> the runtime PM functions to normal suspend/resume.
> 
> This will have the effect of inhibiting any IRQs marked for
> wakeup on the GIC, even if you just want to go to sleep until
> something happens, will it not?
> 
> You should turn on the alarm clock before going to bed, not
> turn it off, as figure of speak ...

Yes I am alway having problems with my alarm, may be this is why ;-)

I see what you are saying, so if there are any wake-ups enabled then we
should not suspend the chip. Right?

Cheers
Jon
