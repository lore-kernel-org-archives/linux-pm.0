From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
Date: Tue, 04 Nov 2014 02:43:54 +0100
Message-ID: <2024276.CFr3nVUAlA@vostro.rjw.lan>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org> <5370046.DXkB0EA6xC@vostro.rjw.lan> <CAPDyKFo_sxW8bE=C29fyfsqOO0tk_=eYFRkCVFRWc2kUx_bQHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52401 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750877AbaKDBXK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Nov 2014 20:23:10 -0500
In-Reply-To: <CAPDyKFo_sxW8bE=C29fyfsqOO0tk_=eYFRkCVFRWc2kUx_bQHA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron

On Monday, November 03, 2014 03:03:46 PM Ulf Hansson wrote:
> On 1 November 2014 01:20, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Friday, October 31, 2014 10:16:14 AM Ulf Hansson wrote:
> >> On 24 October 2014 18:12, Kevin Hilman <khilman@kernel.org> wrote:
> >> > Ulf Hansson <ulf.hansson@linaro.org> writes:
> >> >
> >> >> Changes in v3:
> >> >>       -Rework the entire intermediate step which was suggested in v2.
> >> >>        That means solving the race condition, but also cope with PM domains
> >> >>        that are initialized in powered off state.
> >> >>
> >> >> Changes in v2:
> >> >>       -Added some acks.
> >> >>       -Updated commit messages.
> >> >>       -Included a wider audience of the patchset. V1 was lacking SoC
> >> >>        maintainers.
> >> >>
> >> >> Here are link to the first patchset, were some discussion started.
> >> >> http://marc.info/?l=linux-pm&m=141208104729597&w=2
> >> >>
> >> >> There may be more than one device in a PM domain which then will be
> >> >> probed at different points in time.
> >> >>
> >> >> Depending on timing and runtime PM support, in for the device related
> >> >> driver/subsystem, a PM domain may be advised to power off after a
> >> >> successful probe sequence.
> >> >>
> >> >> A general requirement for a device within a PM domain, is that the
> >> >> PM domain must stay powered during the probe sequence. To cope with
> >> >> such requirement, let's add two new APIs, dev_pm_domain_get|put().
> >> >>
> >> >> These APIs are intended to be invoked from subsystem-level code and the
> >> >> calls between get/put needs to be balanced.
> >> >>
> >> >> dev_pm_domain_get(), tells the PM domain that it needs to increase a
> >> >> usage count and to keep supplying power. dev_pm_domain_put(), does the
> >> >> opposite.
> >> >
> >> > I'm confused. Why arent' pm_runtime_get*() and pm_runtime_put*() working?
> >>
> >> See, below.
> >>
> >> >
> >> > What's not explained here (or what I'm not understanding) is why a PM
> >> > domain is powering off if it has active devices.
> >>
> >> It doesn't. The problem is that using pm_runtime_get_sync() in this
> >> path is not working.
> >>
> >> Now, I failed to include some of the important information from
> >> previous discussions around this patchset. Let me iterate the patchset
> >> with better commit messages, but let's first continue this thread.
> >>
> >> Here are some of the previous discussion:
> >>
> >> http://marc.info/?l=linux-pm&m=141270897014653&w=2
> >> http://marc.info/?l=linux-pm&m=141208104729597&w=2
> >>
> >> Below is a summary of why I think "pm_runtime_get_sync()" isn't working for us.
> >>
> >> 1)
> >> It's bad practice to use pm_runtime_get_sync() in the ->probe() path,
> >
> > Honestly, I'm no longer amused.
> >
> >> to bring your resources to full power. The consequence would be a
> >> driver that requires CONFIG_PM_RUNTIME to be even functional, which
> >> just isn't acceptable.
> >
> > Sorry, but this is utter nonsense.
> 
> I admit, I was too vague while stating this. Looking at the big
> picture you are obviously right.
> 
> I should have referred to those SOCs/buses/drivers that I am working/looking at.
> 
> >
> > CONFIG_PM_RUNTIME unset means "no runtime PM at all", so all drivers can expect
> > everything they need to be always on.  If that is not the case, then someone is
> > doing runtime PM behind the scenes and therefore cheating.  Or in different
> > words, for CONFIG_PM_RUNTIME unset bus types, platforms etc must ensure that
> > everything is on from the drivers' perspective.
> 
> I don't think I have stated anything that isn't in agreement with the above?
> 
> While I am struggling in making my points clearer, it seems like we
> look a bit differently upon how runtime PM are being deployed.
> 
> For those drivers I am working on, it's common that these handles
> runtime PM resources, like for example clocks. The clocks needs to be
> enabled for the driver to handle I/O, but those may also be gated at
> request inactivity to save power. That means, the clocks may be
> considered as both functional clocks and runtime PM resources.
> 
> Therefore, the driver must enable its clocks during ->probe() and
> without relying on CONFIG_PM_RUNTIME to be set. Similar to what you
> stated for the buses above.
> 
> To also cope with the scenario where CONFIG_PM_RUNTIME is set, drivers
> must update the device's runtime PM status using
> pm_runtime_set_active(), to synchronize the state with the runtime PM
> core. Otherwise we will get clock unbalance issues while
> gating/ungating the clocks from the runtime PM callbacks.

Generally, there are two or even three levels of runtime PM handling,
driver, (possibly) bus type and (possibly) PM domain (and multiple levels
of these are possible in principle).  All of them have to be initialized
at different times.

Quite arguably, the PM domain and/or bus type runtime PM handling should
be initialized even before registerind the device or during device
registration.  Doing that later may be too late.  When the device has been
registered, runtime PM should work to an extent allowing the driver to access
the device and configure it further after calling pm_runtime_resume().

Of course, if ->probe() is to call pm_runtime_resume() for this purpose,
it must take the fact that the driver's own ->runtime_resume() may be called
as a result of this into account.  That's why I'm asking whether or not the
core should call pm_runtime_resume() before calling really_probe() in a
followup branch of this thread.

The driver's own runtime PM handling must be initialized in the driver and
the only place suitable for that is ->probe().  However, it needs to be done
*before* the driver's own ->runtime_resume() or ->runtime_suspend() callback
is executed.  If that is done properly, it should be possible to cover
both the CONFIG_PM_RUNTIME set/unset cases in that code.

And I wouldn't recommend anyone to do the runtime PM initialization in
->runtime_resume() (when it is called for the first time), as that would be
error prone and fragile.

> The AMBA bus and some of its drivers a good example of how this has
> been implemented:
> driver/amba/bus.c
> drivers/mmc/host/mmci.c
> drivers/spi/spi-pl022.c
> 
> This conclusion I have made from this is:
> - Using pm_runtime_get_sync() during the ->probe() path to explicitly
> power up a PM domain, is not suitable as the _common_ solution to
> solve the race condition. It certainly may work for some scenarios,
> but not for those I am looking at.

I think, however, that it might work if the core calls pm_runtime_get_sync()
from driver_probe_device().

> >
> > If that is the case, then calling pm_runtime_get_sync() from ->probe
> > for CONFIG_PM_RUNTIME unset simply doesn't matter.
> >
> > Now, for CONFIG_PM_RUNTIME enabled, if power domains are in use, doing
> > pm_runtime_get_sync() from ->probe is the only way the driver can ensure
> > in a non-racy way that the device will be accessible going forward.
> >
> > Why?  Simply because the probing need not happen during system initialization.
> > It very well may take places when the other devices in the same domain have
> > beein in use for quite a while and have been using runtime PM (in which
> > case the domain may go off at any time unless it is explicityly prevented from
> > doing that).
> 
> For PM domains that are initialized in powered off state, we can't
> rely on CONFIG_PM_RUNTIME and thus not on pm_runtime_get_sync() to
> power on these PM domains. We need a different mechanism, which is
> suggested in this v3 patchset.

That is quite simple to address, though.  You can register a bus type
notifier that will power up the domain on BUS_NOTIFY_ADD_DEVICE events
(where the target device belongs to the domain), and do that only for
CONFIG_PM_RUNTIME unset (otherwise runtime PM should take care of this).

> The requirement of being able to initialize PM domains in powered off
> state, was raised during review of v2 of this patchset. I do realize
> that's not easy for you to keep track and remember of all discussions.
> I apologize for not providing this as the topmost important argument
> to why pm_runtime_get_sync() can't be used, in my reply to Kevin.

OK

It looks like we need an agreement on what to do and what the expectations
should be for each driver core operation at the high level.  That is,
what ->probe() should expect, what ->remove() should expect, what the
state after executing each of them should be for CONFIG_PM_RUNTIME set and
unset etc.  Otherwise we'll always have various bus types doing what *they*
think is appropriate and not agreeing with each other.

--
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
