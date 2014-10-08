From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Powering down unused PM domains (was: Re: [PATCH 0/4] PM /
 Domains: Fix race conditions during boot)
Date: Wed, 8 Oct 2014 14:00:50 +0200
Message-ID: <CAPDyKFrJ7x-MS79OqxPOUWVearpp6AQP160+9QXnhVXWnH9aWw@mail.gmail.com>
References: <CAMuHMdUwbOEfLcu_UVKq_iHx5Qzn7ne1+cwt58C0ntTZBf1esg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUwbOEfLcu_UVKq_iHx5Qzn7ne1+cwt58C0ntTZBf1esg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 7 October 2014 21:09, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Tue, Sep 30, 2014 at 2:43 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Instead, let's improve the situation, by preventing genpd from powering
>> off any of the PM domains until late_init. At that point genpd already
>> tries to power off unused PM domains, so it seems like a decent match.
>
> Note that powering off unused PM domains is currently limited to
> CONFIG_PM_RUNTIME=y.
> If CONFIG_PM_RUNTIME is disabled, unused PM domains are not powered down,
> and may even stay powered-up during system suspend.

Right. That's obviously not an acceptable behaviour, we can do better.

>
> With CONFIG_PM_RUNTIME=y, we have:
>   A1. All PM domains are powered up during initialization.
>   A2. After initialization, all unused PM domains are powered down by the
>       genpd_poweroff_unused() late_initcall.
>       "unused" means PM domains containing no active devices and no active
>       subdomains. I.e. PM domains containing (a) only suspended devices, or
>       (b) no[*] devices at all will be powered down.
>   A3. PM domains will be powered up or down, depending on devices moving from
>       inactive to active state, or vice versa. This includes system suspend,
>       which can be considered some form of devices moving to an inactive
>       state.
>
> In contrast, with CONFIG_PM_RUNTIME=n, we have:
>   B1. All PM domains are powered up during initialization,
>   B2. After initialization, PM domains just stay powered up,
>   B3. PM domains will be powered down on system suspend, and powered up on
>       system resume, based on the dev_pm_ops of the PM domain each device
>       belongs to.
>
> While operation A2 is PM domain-centric (it walks the list of genpd domains),
> A3 and B3 are device-centric (A3 operates on one specific device, B3 walks the
> list of devices).
> Hence B3 never touches PM domains that don't contain any devices[*].
> So these PM domains are kept powered-up if CONFIG_PM_RUNTIME=n, even on
> system suspend.
>
> Shouldn't PM domains without devices be powered down at some point?
> When? In B2, or in B3?

I agree with Rafael and Sylwester, that it would be an advantage if PM
domains can be initialized in powered off state. Simply because, those
may then be left in powered off state all the time, if they are
unused.

That's been my long term approach, but let's see if we can get there
without the intermediate step proposed in this patchset...

Now, to support the above and to solve the race conditions, we need to
be able to power up the PM domain, prior probing of a device. I am
thinking of a solution aimed to affect subsystem level code (buses)
and not drivers, since we need keep the impact on a reasonable level.

Let's see what I will come up with. I have some ideas that I am trying out...

>
> Thanks for your suggestions!
>
> [*] It may sound strange to have a PM domain without devices. However, this may
>     happen due to incomplete device trees, or for devices without existing
>     bindings or without Linux support.

I understand.

I guess another valid argument is the kernel configuration. The
corresponding driver which normally would handle the device may
intentionally not even been build into the kernel. Certainly we must
not leave those unused PM domains in powered up state.

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> P.S. Will any of you be at ELC-E next week, for further PM domain discussions?

That would have been great, but I won't be there. Unless I schedule a
last minute trip. :-)

Kind regards
Uffe
