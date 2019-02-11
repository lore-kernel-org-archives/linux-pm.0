From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] PM-runtime: Take suppliers into account in __pm_runtime_set_status()
Date: Tue, 12 Feb 2019 00:05:07 +0100
Message-ID: <CAJZ5v0hV-G_U=XV1N=rpEv1LMgB+jjB3kVEoHKUasd2p3QP5Bg@mail.gmail.com>
References: <3917694.ab5GGAjohB@aspire.rjw.lan> <1634058.cXDNg15SOd@aspire.rjw.lan>
 <CAPDyKFpWCT9CcmxqqWk+S8tSPz_at56UCnk3EVBab-TnScHw8Q@mail.gmail.com> <CAPDyKFqnWgjZ1icajdzbaQ_HW-2ec0-npEU_nAWvSVEpZMzSRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqnWgjZ1icajdzbaQ_HW-2ec0-npEU_nAWvSVEpZMzSRA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <jroedel@suse.de>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 11, 2019 at 4:51 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 11 Feb 2019 at 14:27, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 7 Feb 2019 at 19:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > If the target device has any suppliers, as reflected by device links
> > > to them, __pm_runtime_set_status() does not take them into account,
> > > which is not consistent with the other parts of the PM-runtime
> > > framework and may lead to programming mistakes.
> > >
> > > Modify __pm_runtime_set_status() to take suppliers into account by
> > > activating them upfront if the new status is RPM_ACTIVE and
> > > deactivating them on exit if the new status is RPM_SUSPENDED.
> > >
> > > If the activation of one of the suppliers fails, the new status
> > > will be RPM_SUSPENDED and the (remaining) suppliers will be
> > > deactivated on exit (the child count of the device's parent
> > > will be dropped too then).
> > >
> > > Of course, adding device links locking to __pm_runtime_set_status()
> > > means that it cannot be run fron interrupt context, so make it use
> > > spin_lock_irq() and spin_unlock_irq() instead of spin_lock_irqsave()
> > > and spin_unlock_irqrestore(), respectively.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Rafael, thanks for working on this!
> >
> > I am running some tests at my side, but still not achieving the
> > behavior I expect to. Will let you know when I have more details, but
> > first some comments below.
>
> Alright, this is what I found.
>
> When I call pm_runtime_set_suspended(), in the ->probe() error path of
> my RPM test driver (I am removing the device link afterwards), then my
> expectation was that this should allow the supplier to become runtime
> suspended (sooner or later). This isn't the case, as it turns out the
> runtime PM usage count of the supplier, still remains 1 after the
> probe failure.
>
> My observation is that with $subject patch, the link->rpm_active count
> is now reaching 1, before it stayed at 2 - so one step forward. :-)
>
> However, the reason to why the runtime PM usage count never reaches 0,
> is because of the call to pm_runtime_get_noresume(supplier) in
> device_link_rpm_prepare(), which is called from device_link_add().

That was there previously, I've just moved it to device_link_rpm_prepare().

But good catch!

> To solve the problem, it seems like we need to call
> pm_runtime_put(supplier), in case the device link is deleted while the
> consumer is still probing.

I'd rather change the way pm_runtime_get/put_suppliers() work, so that
they use the rpm_active refcount, but pm_runtime_put_suppliers() only
drops it by one - unless it is one already.

Then, when adding a new link with DL_FLAG_RPM_ACTIVE,
device_link_add() only needs to increment its rpm_active *twice*
(instead of doing that once as to does now), so it will stay above one
after the subsequent pm_runtime_put_suppliers() - and if it goes away
in the meantime, then it will be cleaned up by the removal.

In turn, if a link is created without DL_FLAG_RPM_ACTIVE, its
rpm_active is one and then pm_runtime_put_suppliers() will just skip
it.

A patch will follow. :-)
