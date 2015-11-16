From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] genirq: Add runtime resume/suspend support for
 IRQ chips
Date: Mon, 16 Nov 2015 11:48:42 +0100
Message-ID: <CAMuHMdW2L1gYO7cNjeeaBTcQQdEXc9q45E1sZj-=TPwokkGx2g@mail.gmail.com>
References: <1447166377-19707-1-git-send-email-jonathanh@nvidia.com>
	<1447166377-19707-2-git-send-email-jonathanh@nvidia.com>
	<7hio56dctz.fsf@deeprootsystems.com>
	<5645A6F6.6020202@nvidia.com>
	<alpine.DEB.2.11.1511131456440.3987@nanos>
	<5649A603.6020308@nvidia.com>
	<CAMuHMdXazgRcw=+O-w+PsZpwiW8iCwZ8MmhNSjcOoZGRP45Y6Q@mail.gmail.com>
	<5649B135.8050800@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5649B135.8050800-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Jon,

On Mon, Nov 16, 2015 at 11:34 AM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> On 16/11/15 09:49, Geert Uytterhoeven wrote:
>> On Mon, Nov 16, 2015 at 10:46 AM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>> On 13/11/15 20:01, Thomas Gleixner wrote:
>>>> On Fri, 13 Nov 2015, Jon Hunter wrote:
>>>>> On 12/11/15 23:20, Kevin Hilman wrote:
>>>>>> If all the RPM devices in the domain go idle, it will be powered off
>>>>>> independently of the status of the irqchip because the irqchip isn't
>>>>>> using RPM.
>>>>>
>>>>> That's dependent on how the irqchip uses these helpers. If these helpers
>>>>> invoke RPM then that will not be the case.
>>>>
>>>> You need a very proper description of how that domain is working. If
>>>> all devices are idle, it's not necessary correct to power down the
>>>> irqchip as is might serve other devices as well.
>>>
>>> Agreed. The irqchip should only be powered down if there are no
>>> interrupts in-use/requested. Runtime-pm will keep a reference count for
>>> all requested IRQs.
>>
>> That means the irqchip won't be powered down automatically when the
>> last user is powered down, unless all users release their irqs during
>> suspend.
>
> Right.
>
>> Handling it automatically needs more bookkeeping than a simple reference
>> count.
>
> So what would you suggest? Adding a pm_runtime_register_irq() API that
> would register an IRQ with the device that you want RPM to handle? Not
> sure if there is a better/easier way to handle this.

The irqchip needs to keep track how many times request_irq() has been
called, cfr. your suggestion above.

On the other side, the system needs to keep track how many times request_irq()
has been called for each irqchip, so it can subtract those numbers from the
irqchip's counters during suspend of the device, and re-add them during resume.
So we need at least a "struct device *" parameter for request_irq().
devm_request_irq() already has that, but not all drivers use that.

However, I think this should be looked at into the context of "[RFD]
Functional dependencies between devices".
https://lwn.net/Articles/662205/
https://lkml.org/lkml/2015/10/27/388

There can be other dependencies than interrupts between devices.
All functions using dependencies need a "struct device *" parameter to
record information.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
