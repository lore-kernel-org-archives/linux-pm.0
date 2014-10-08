From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Powering down unused PM domains (was: Re: [PATCH 0/4] PM / Domains: Fix race conditions during boot)
Date: Wed, 08 Oct 2014 15:49:38 +0200
Message-ID: <4392705.brmbgySLJa@vostro.rjw.lan>
References: <CAMuHMdUwbOEfLcu_UVKq_iHx5Qzn7ne1+cwt58C0ntTZBf1esg@mail.gmail.com> <CAPDyKFrJ7x-MS79OqxPOUWVearpp6AQP160+9QXnhVXWnH9aWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrJ7x-MS79OqxPOUWVearpp6AQP160+9QXnhVXWnH9aWw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, October 08, 2014 02:00:50 PM Ulf Hansson wrote:
> On 7 October 2014 21:09, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Hi Ulf,
> >
> > On Tue, Sep 30, 2014 at 2:43 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >> Instead, let's improve the situation, by preventing genpd from powering
> >> off any of the PM domains until late_init. At that point genpd already
> >> tries to power off unused PM domains, so it seems like a decent match.
> >
> > Note that powering off unused PM domains is currently limited to
> > CONFIG_PM_RUNTIME=y.
> > If CONFIG_PM_RUNTIME is disabled, unused PM domains are not powered down,
> > and may even stay powered-up during system suspend.
> 
> Right. That's obviously not an acceptable behaviour, we can do better.
> 
> >
> > With CONFIG_PM_RUNTIME=y, we have:
> >   A1. All PM domains are powered up during initialization.
> >   A2. After initialization, all unused PM domains are powered down by the
> >       genpd_poweroff_unused() late_initcall.
> >       "unused" means PM domains containing no active devices and no active
> >       subdomains. I.e. PM domains containing (a) only suspended devices, or
> >       (b) no[*] devices at all will be powered down.
> >   A3. PM domains will be powered up or down, depending on devices moving from
> >       inactive to active state, or vice versa. This includes system suspend,
> >       which can be considered some form of devices moving to an inactive
> >       state.
> >
> > In contrast, with CONFIG_PM_RUNTIME=n, we have:
> >   B1. All PM domains are powered up during initialization,
> >   B2. After initialization, PM domains just stay powered up,
> >   B3. PM domains will be powered down on system suspend, and powered up on
> >       system resume, based on the dev_pm_ops of the PM domain each device
> >       belongs to.
> >
> > While operation A2 is PM domain-centric (it walks the list of genpd domains),
> > A3 and B3 are device-centric (A3 operates on one specific device, B3 walks the
> > list of devices).
> > Hence B3 never touches PM domains that don't contain any devices[*].
> > So these PM domains are kept powered-up if CONFIG_PM_RUNTIME=n, even on
> > system suspend.
> >
> > Shouldn't PM domains without devices be powered down at some point?
> > When? In B2, or in B3?
> 
> I agree with Rafael and Sylwester, that it would be an advantage if PM
> domains can be initialized in powered off state. Simply because, those
> may then be left in powered off state all the time, if they are
> unused.
> 
> That's been my long term approach, but let's see if we can get there
> without the intermediate step proposed in this patchset...
> 
> Now, to support the above and to solve the race conditions, we need to
> be able to power up the PM domain, prior probing of a device. I am
> thinking of a solution aimed to affect subsystem level code (buses)
> and not drivers, since we need keep the impact on a reasonable level.

That sounds like a good approach to me.

Also that should work regardless of whether or not the drivers in question
implement runtime PM callbacks.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
