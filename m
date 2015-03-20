From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] driver core / PM: Add PM domain callbacks for device setup/cleanup
Date: Fri, 20 Mar 2015 13:31:46 +0100
Message-ID: <178365735.3ZOqcVG98c@vostro.rjw.lan>
References: <3533423.QQDErEmeTO@vostro.rjw.lan> <CAPDyKFr-c+SNKw1+5BE_8K0_jWMNavkEX5+dhST8b9Ggzx-cyw@mail.gmail.com> <CAPDyKFpvBvWOM0V0jAbz4tTQEvtzp8A6naV316p7S1sAYF43uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56657 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750827AbbCTMHu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2015 08:07:50 -0400
In-Reply-To: <CAPDyKFpvBvWOM0V0jAbz4tTQEvtzp8A6naV316p7S1sAYF43uw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Friday, March 20, 2015 12:37:47 PM Ulf Hansson wrote:
> On 20 March 2015 at 08:45, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On 19 March 2015 at 22:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Subject: driver core / PM: Add PM domain callbacks for device setup/cleanup
> >>
> >> If PM domains are in use, it may be necessary to prepare the code
> >> handling a PM domain for driver probing.  For example, in some
> >> cases device drivers rely on the ability to power on the devices
> >> with the help of the IO runtime PM framework and the PM domain
> >> code needs to be ready for that.  Also, if that code has not been
> >> fully initialized yet, the driver probing should be deferred.
> >>
> >> Moreover, after the probing is complete, it may be necessary to
> >> put the PM domain in question into the state reflecting the current
> >> needs of the devices in it, for example, so that power is not drawn
> >> in vain.  The same should be done after removing a driver from
> >> a device, as the PM domain state may need to be changed to reflect
> >> the new situation.
> >>
> >> For these reasons, introduce new PM domain callbacks, ->activate
> >> and ->sync, called, respectively, before probing for a device
> >> driver and after the probing has been completed or the driver
> >> has been removed.
> >>
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > This looks good to me!
> >
> > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> I was a bit too quick acking this a minor fix is needed. See below.
> 
> >
> >> ---
> >>> ---
> >>>
> >>> This is an update without the additional bus type callbacks.  This should
> >>> be suffucient at this point for the use cases we have.
> >>>
> >>> I've decided to also call ->sync on driver removal as that is consistent
> >>> with what happens for failing probe.
> >>>
> >>> ---
> >>
> >> One more update.
> >>
> >> I've realized that in the PM domain's ->sync callback is called after
> >> clearing the device's driver field (in the failed probe or driver removal
> >> case) rather than before it, that could be used to distinguish between the
> >> two cases (successful probe vs no driver), so I reworked the patch accordingly.
> >>
> >> ---
> >>  drivers/base/dd.c  |   16 ++++++++++++++++
> >>  include/linux/pm.h |    6 ++++++
> >>  2 files changed, 22 insertions(+)
> >>
> >> Index: linux-pm/include/linux/pm.h
> >> ===================================================================
> >> --- linux-pm.orig/include/linux/pm.h
> >> +++ linux-pm/include/linux/pm.h
> >> @@ -603,10 +603,16 @@ extern void dev_pm_put_subsys_data(struc
> >>   * Power domains provide callbacks that are executed during system suspend,
> >>   * hibernation, system resume and during runtime PM transitions along with
> >>   * subsystem-level and driver-level callbacks.
> >> + *
> >> + * @detach: Called when removing a device from the domain.
> >> + * @activate: Called before executing probe routines for bus types and drivers.
> >> + * @sync: Called after driver probe and removal.
> >>   */
> >>  struct dev_pm_domain {
> >>         struct dev_pm_ops       ops;
> >>         void (*detach)(struct device *dev, bool power_off);
> >> +       int (*activate)(struct device *dev);
> >> +       void (*sync)(struct device *dev);
> >>  };
> >>
> >>  /*
> >> Index: linux-pm/drivers/base/dd.c
> >> ===================================================================
> >> --- linux-pm.orig/drivers/base/dd.c
> >> +++ linux-pm/drivers/base/dd.c
> >> @@ -279,6 +279,7 @@ static int really_probe(struct device *d
> >>  {
> >>         int ret = 0;
> >>         int local_trigger_count = atomic_read(&deferred_trigger_count);
> >> +       struct dev_pm_domain *pm_domain = dev->pm_domain;
> >>
> >>         atomic_inc(&probe_count);
> >>         pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
> >> @@ -298,6 +299,12 @@ static int really_probe(struct device *d
> >>                 goto probe_failed;
> >>         }
> >>
> 
> 
> 
> >> +       if (pm_domain && pm_domain->activate) {
> 
> You need to re-fetch the pm_domain pointer at this point, since it
> will be updated during ->probe().

Right.

> Maybe it's just safer to always do the following check:
> 
> if (dev->pm_domain && dev->pm_domain->activate|sync)

Yes, it is.

Well, overoptimization.  I seem to always forget to avoid them. :-)

Will send a v3 with that fixed and the Dmitry's comment taken into account
shortly.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
