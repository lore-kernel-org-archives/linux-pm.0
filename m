From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] genirq: Add runtime resume/suspend support for
 IRQ chips
Date: Tue, 17 Nov 2015 11:57:12 +0000
Message-ID: <564B1618.10806@nvidia.com>
References: <1447166377-19707-1-git-send-email-jonathanh@nvidia.com>
 <1447166377-19707-2-git-send-email-jonathanh@nvidia.com>
 <7hio56dctz.fsf@deeprootsystems.com> <5645A6F6.6020202@nvidia.com>
 <alpine.DEB.2.11.1511131456440.3987@nanos> <5649A603.6020308@nvidia.com>
 <CAMuHMdXazgRcw=+O-w+PsZpwiW8iCwZ8MmhNSjcOoZGRP45Y6Q@mail.gmail.com>
 <5649B135.8050800@nvidia.com>
 <CAMuHMdW2L1gYO7cNjeeaBTcQQdEXc9q45E1sZj-=TPwokkGx2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdW2L1gYO7cNjeeaBTcQQdEXc9q45E1sZj-=TPwokkGx2g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Geert,

On 16/11/15 10:48, Geert Uytterhoeven wrote:
> On Mon, Nov 16, 2015 at 11:34 AM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:

[snip]

>>> Handling it automatically needs more bookkeeping than a simple reference
>>> count.
>>
>> So what would you suggest? Adding a pm_runtime_register_irq() API that
>> would register an IRQ with the device that you want RPM to handle? Not
>> sure if there is a better/easier way to handle this.
> 
> The irqchip needs to keep track how many times request_irq() has been
> called, cfr. your suggestion above.
> 
> On the other side, the system needs to keep track how many times request_irq()
> has been called for each irqchip, so it can subtract those numbers from the
> irqchip's counters during suspend of the device, and re-add them during resume.
> So we need at least a "struct device *" parameter for request_irq().
> devm_request_irq() already has that, but not all drivers use that.

Yes that would make sense. However, I am wondering if the
syscore suspend/resume operators could be used here to do something
like ...

	pm_runtime_disable(dev);
	if (!pm_runtime_status_suspended(dev))
		chip->irq_runtime_suspend(data);

> However, I think this should be looked at into the context of "[RFD]
> Functional dependencies between devices".
> https://lwn.net/Articles/662205/
> https://lkml.org/lkml/2015/10/27/388
> 
> There can be other dependencies than interrupts between devices.
> All functions using dependencies need a "struct device *" parameter to
> record information.

Yes I like the sound of that. That would be ideal. However, I am
guessing that that is a way off at the moment ...

Cheers
Jon
