From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] PM-runtime: Take suppliers into account in __pm_runtime_set_status()
Date: Mon, 11 Feb 2019 16:50:57 +0100
Message-ID: <CAPDyKFqnWgjZ1icajdzbaQ_HW-2ec0-npEU_nAWvSVEpZMzSRA@mail.gmail.com>
References: <3917694.ab5GGAjohB@aspire.rjw.lan> <1634058.cXDNg15SOd@aspire.rjw.lan>
 <CAPDyKFpWCT9CcmxqqWk+S8tSPz_at56UCnk3EVBab-TnScHw8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpWCT9CcmxqqWk+S8tSPz_at56UCnk3EVBab-TnScHw8Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <jroedel@suse.de>
List-Id: linux-pm@vger.kernel.org

On Mon, 11 Feb 2019 at 14:27, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 7 Feb 2019 at 19:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If the target device has any suppliers, as reflected by device links
> > to them, __pm_runtime_set_status() does not take them into account,
> > which is not consistent with the other parts of the PM-runtime
> > framework and may lead to programming mistakes.
> >
> > Modify __pm_runtime_set_status() to take suppliers into account by
> > activating them upfront if the new status is RPM_ACTIVE and
> > deactivating them on exit if the new status is RPM_SUSPENDED.
> >
> > If the activation of one of the suppliers fails, the new status
> > will be RPM_SUSPENDED and the (remaining) suppliers will be
> > deactivated on exit (the child count of the device's parent
> > will be dropped too then).
> >
> > Of course, adding device links locking to __pm_runtime_set_status()
> > means that it cannot be run fron interrupt context, so make it use
> > spin_lock_irq() and spin_unlock_irq() instead of spin_lock_irqsave()
> > and spin_unlock_irqrestore(), respectively.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Rafael, thanks for working on this!
>
> I am running some tests at my side, but still not achieving the
> behavior I expect to. Will let you know when I have more details, but
> first some comments below.

Alright, this is what I found.

When I call pm_runtime_set_suspended(), in the ->probe() error path of
my RPM test driver (I am removing the device link afterwards), then my
expectation was that this should allow the supplier to become runtime
suspended (sooner or later). This isn't the case, as it turns out the
runtime PM usage count of the supplier, still remains 1 after the
probe failure.

My observation is that with $subject patch, the link->rpm_active count
is now reaching 1, before it stayed at 2 - so one step forward. :-)

However, the reason to why the runtime PM usage count never reaches 0,
is because of the call to pm_runtime_get_noresume(supplier) in
device_link_rpm_prepare(), which is called from device_link_add().

To solve the problem, it seems like we need to call
pm_runtime_put(supplier), in case the device link is deleted while the
consumer is still probing.

>
> > ---
> >  drivers/base/power/runtime.c |   45 ++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 40 insertions(+), 5 deletions(-)
> >
> > Index: linux-pm/drivers/base/power/runtime.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/runtime.c
> > +++ linux-pm/drivers/base/power/runtime.c
> > @@ -1102,20 +1102,43 @@ EXPORT_SYMBOL_GPL(pm_runtime_get_if_in_u
> >   * and the device parent's counter of unsuspended children is modified to
> >   * reflect the new status.  If the new status is RPM_SUSPENDED, an idle
> >   * notification request for the parent is submitted.
> > + *
> > + * If @dev has any suppliers (as reflected by device links to them), and @status
> > + * is RPM_ACTIVE, they will be activated upfront and if the activation of one
> > + * of them fails, the status of @dev will be changed to RPM_SUSPENDED (instead
> > + * of the @status value) and the suppliers will be deacticated on exit.  The
> > + * error returned by the failing supplier activation will be returned in that
> > + * case.
> >   */
> >  int __pm_runtime_set_status(struct device *dev, unsigned int status)
> >  {
> >         struct device *parent = dev->parent;
> > -       unsigned long flags;
> >         bool notify_parent = false;
> >         int error = 0;
> >
> >         if (status != RPM_ACTIVE && status != RPM_SUSPENDED)
> >                 return -EINVAL;
> >
> > -       spin_lock_irqsave(&dev->power.lock, flags);
> > +       /*
> > +        * If the new status is RPM_ACTIVE, the suppliers can be activated
> > +        * upfront regardless of the current status, because next time
> > +        * rpm_put_suppliers() runs, the rpm_active refcounts of the links
> > +        * involved will be dropped down to one anyway.
> > +        */
> > +       if (status == RPM_ACTIVE) {
> > +               int idx = device_links_read_lock();
> > +
> > +               error = rpm_get_suppliers(dev);
> > +               if (error)
> > +                       status = RPM_SUSPENDED;
> > +
> > +               device_links_read_unlock(idx);
> > +       }
>
> This doesn't look right to me, and more importantly, this isn't
> consistent with how we treat a parent/child.
>
> More precisely, I think you need to check "if
> (!dev->power.runtime_error && !dev->power.disable_depth)" and also
> whether "dev->power.runtime_status == status", before deciding to call
> rpm_get_suppliers() above. Otherwise you may end up resuming suppliers
> and/or increasing the link->rpm_active count, when you shouldn't.
>
> In other words, expecting __pm_runtime_set_status() to be called in
> "balanced" manner isn't correct.
>
> > +
> > +       spin_lock_irq(&dev->power.lock);
> >
> >         if (!dev->power.runtime_error && !dev->power.disable_depth) {
> > +               status = dev->power.runtime_status;
> >                 error = -EAGAIN;
> >                 goto out;
> >         }
> > @@ -1147,19 +1170,31 @@ int __pm_runtime_set_status(struct devic
> >
> >                 spin_unlock(&parent->power.lock);
> >
> > -               if (error)
> > +               if (error) {
> > +                       status = RPM_SUSPENDED;
> >                         goto out;
> > +               }
> >         }
> >
> >   out_set:
> >         __update_runtime_status(dev, status);
> > -       dev->power.runtime_error = 0;
> > +       if (!error)
> > +               dev->power.runtime_error = 0;
> > +
> >   out:
> > -       spin_unlock_irqrestore(&dev->power.lock, flags);
> > +       spin_unlock_irq(&dev->power.lock);
> >
> >         if (notify_parent)
> >                 pm_request_idle(parent);
> >
> > +       if (status == RPM_SUSPENDED) {
> > +               int idx = device_links_read_lock();
> > +
> > +               rpm_put_suppliers(dev);
> > +
> > +               device_links_read_unlock(idx);
> > +       }
> > +
> >         return error;
> >  }
> >  EXPORT_SYMBOL_GPL(__pm_runtime_set_status);
> >
>
> Kind regards
> Uffe
