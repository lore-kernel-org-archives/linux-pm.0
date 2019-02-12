From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] PM-runtime: Fix __pm_runtime_set_status() race with
 runtime resume
Date: Tue, 12 Feb 2019 19:27:50 +0100
Message-ID: <CAPDyKFpNWrVCW9xwwsWf=vGukEkSj4qYs58terDy0tmmrhyLDw@mail.gmail.com>
References: <5510642.nRbR3bcduN@aspire.rjw.lan> <1670239.00ZbddH1IV@aspire.rjw.lan>
 <CAPDyKFoR+evmvDehgTJvxcZ70ZLTqU5J4To_c=2vYdOk26h92w@mail.gmail.com> <CAJZ5v0jv6dboQd=iu9pHA_B2HzCEhd2WaN3-732S9px_u6MA-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jv6dboQd=iu9pHA_B2HzCEhd2WaN3-732S9px_u6MA-w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 12 Feb 2019 at 17:28, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Feb 12, 2019 at 5:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 12 Feb 2019 at 13:10, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Commit 4080ab083000 ("PM-runtime: Take suppliers into account in
> > > __pm_runtime_set_status()") introduced a race condition that may
> > > trigger if __pm_runtime_set_status() is used incorrectly (that is,
> > > if it is called when PM-runtime is enabled for the target device
> > > and working).
> > >
> > > In that case, if the original PM-runtime status of the device is
> > > RPM_SUSPENDED, a runtime resume of the device may occur after
> > > __pm_runtime_set_status() has dropped its power.lock spinlock
> > > and before deactivating its suppliers, so the suppliers may be
> > > deactivated while the device is PM-runtime-active which may lead
> > > to functional issues.
> > >
> > > To avoid that, modify __pm_runtime_set_status() to check whether
> > > or not PM-runtime is enabled for the device before activating its
> > > suppliers (if the new status is RPM_ACTIVE) and either return an
> > > error if that's the case or increment the device's disable_depth
> > > counter to prevent PM-runtime from being enabled for it while
> > > the remaining part of the function is running (disable_depth is
> > > then decremented on the way out).
> > >
> > > Fixes: 4080ab083000 ("PM-runtime: Take suppliers into account in __pm_runtime_set_status()")
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/base/power/runtime.c |   24 ++++++++++++++++++------
> > >  1 file changed, 18 insertions(+), 6 deletions(-)
> > >
> > > Index: linux-pm/drivers/base/power/runtime.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/base/power/runtime.c
> > > +++ linux-pm/drivers/base/power/runtime.c
> > > @@ -1129,6 +1129,22 @@ int __pm_runtime_set_status(struct devic
> > >         if (status != RPM_ACTIVE && status != RPM_SUSPENDED)
> > >                 return -EINVAL;
> > >
> > > +       spin_lock_irq(&dev->power.lock);
> > > +
> > > +       /*
> > > +        * Prevent PM-runtime from being enabled for the device or return an
> > > +        * error if it is enabled already and working.
> > > +        */
> > > +       if (dev->power.runtime_error || dev->power.disable_depth)
> > > +               dev->power.disable_depth++;
> > > +       else
> > > +               error = -EAGAIN;
> > > +
> > > +       spin_unlock_irq(&dev->power.lock);
> > > +
> > > +       if (error)
> > > +               return error;
> > > +
> > >         /*
> > >          * If the new status is RPM_ACTIVE, the suppliers can be activated
> > >          * upfront regardless of the current status, because next time
> > > @@ -1147,12 +1163,6 @@ int __pm_runtime_set_status(struct devic
> > >
> > >         spin_lock_irq(&dev->power.lock);
> > >
> > > -       if (!dev->power.runtime_error && !dev->power.disable_depth) {
> > > -               status = dev->power.runtime_status;
> > > -               error = -EAGAIN;
> > > -               goto out;
> > > -       }
> > > -
> > >         if (dev->power.runtime_status == status || !parent)
> > >                 goto out_set;
> > >
> > > @@ -1205,6 +1215,8 @@ int __pm_runtime_set_status(struct devic
> > >                 device_links_read_unlock(idx);
> > >         }
> > >
> > > +       pm_runtime_enable(dev);
> >
> > pm_runtime_enable() uses spin_lock_irqsave(), rather than
> > spin_lock_irq() - is there a reason to why you want to allow that
> > here, but not earlier in the function?
>
> Device links locking cannot be used in interrupt context.

I get that, but thanks for clarifying.

However, then why did you convert __pm_runtime_set_status() from using
spin_lock_irqsave() to spin_lock_irq() in commit "PM-runtime: Take
suppliers into account in __pm_runtime_set_status()"?

As far as I can tell, the spin_lock is not being held while we operate
on the device links anyway. Or is this just to give the caller an
indication what kind of context the function can be called from?

Kind regards
Uffe
