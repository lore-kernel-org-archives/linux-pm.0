From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/4] PM / Domains: Fix race conditions during boot
Date: Wed, 01 Oct 2014 22:31:39 +0200
Message-ID: <2138676.3O5bPrOhTg@vostro.rjw.lan>
References: <1412081033-8136-1-git-send-email-ulf.hansson@linaro.org> <6902885.zdj1puMRg5@vostro.rjw.lan> <CAPDyKFoUUyN2Tqt+RmiyVfB4ymqTiQ-TT1Z6ZvWS87ZGKi-Cog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61600 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750945AbaJAULk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Oct 2014 16:11:40 -0400
In-Reply-To: <CAPDyKFoUUyN2Tqt+RmiyVfB4ymqTiQ-TT1Z6ZvWS87ZGKi-Cog@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>

On Wednesday, October 01, 2014 09:35:45 AM Ulf Hansson wrote:
> On 30 September 2014 22:08, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, September 30, 2014 02:43:49 PM Ulf Hansson wrote:
> >> When there are more than one device in a PM domain these will obviously
> >> be probed at different times. Depending on timing and the implemented
> >> support for runtime PM in a driver/subsystem, genpd may be advised to
> >> power off a PM domain after a successful probe sequence.
> >>
> >> Ideally we should have relied on the driver/subsystem, through runtime
> >> PM, to bring their device's PM domain into powered state prior doing
> >> probing if such requirement exist.
> >>
> >> Since this is not a common practice by drivers/subsystems, enforcing
> >> such a change doesn't seem viable.
> >>
> >> Instead, let's improve the situation, by preventing genpd from powering
> >> off any of the PM domains until late_init. At that point genpd already
> >> tries to power off unused PM domains, so it seems like a decent match.
> >>
> >> Cases which can't be covered within the window of until late_init needs
> >> to be adressed separately and likely through a more common long term
> >> solution.
> >
> > The history here is that we started with something like what the patches
> > do and then realized that on some systems we don't want certain power domains
> > to be powered on even for a while (for reasons I can't recall today,
> > unfortunately).  So this may not be the case any more, but I'm not actually
> > sure and it would be good to check.
> >
> > Also I'm pretty sure we'd like to do the opposite (that is, leave things
> > in low-power states until we need to access them) going forward, so I'm
> > seeing this as a step back.
> 
> I agree that this would be the best set up and this is my intent to
> have genpd support in the long run. But, today, genpd together with
> how drivers/subsystems handles ->probe() just doesn't work. We need to
> fix that first.
> 
> >
> > What's the real motivation here?
> 
> Let me try to summarize the arguments.
> 
> 1) Even if CONFIG_PM_RUNTIME is enabled, we have no mechanism to use
> for drivers/subsystems to bring device's PM domains into powered state
> before doing ->probe(). Well, of course, they could use
> pm_runtime_get_sync() in that path, but that's just not the common
> practice and there are good reasons to why.
> 
> So, even if we figured out a solution for drivers/subsystems to
> support the above, it's not reasonable to think we can adopt each of
> them shortly. We need a fix in genpd.

My concern is that if we change the default behavior today, people will see
power regressions on some platforms.  Surely, power regressions are not as
bad as functional regressions, but we can't say we don't care.

Did you consider adding some handling of that to driver_probe_device()?
We do a barrier in there, but conceivably we could do more if a PM domain
is attached.

> 2) For !CONFIG_PM_RUNTIME, drivers/subsystem are completely unable to
> bring a PM domain into powered state. The only solution is to make
> sure the PM domain gets initialized in powered state.

That is a special case and it should be addressed as such in my view.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
