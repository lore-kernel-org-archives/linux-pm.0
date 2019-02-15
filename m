From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] driver core: Fix possible supplier PM-usage counter imbalance
Date: Fri, 15 Feb 2019 12:57:18 +0100
Message-ID: <CAJZ5v0jOi7W9JNMRtymO-SkApekzSwDmLONkwRJPvY0O1KkfFQ@mail.gmail.com>
References: <5510642.nRbR3bcduN@aspire.rjw.lan> <9351473.C2nPJoyFsE@aspire.rjw.lan>
 <2ed95b05-317c-59bb-498a-b5481e54bcf6@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2ed95b05-317c-59bb-498a-b5481e54bcf6@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-tegra <linux-tegra@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 15, 2019 at 12:00 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>
> Hi Rafael,
>
> On 12/02/2019 12:08, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If a stateless device link to a certain supplier with
> > DL_FLAG_PM_RUNTIME set in the flags is added and then removed by the
> > consumer driver's probe callback, the supplier's PM-runtime usage
> > counter will be nonzero after that which effectively causes the
> > supplier to remain "always on" going forward.
> >
> > Namely, device_link_add() called to add the link invokes
> > device_link_rpm_prepare() which notices that the consumer driver is
> > probing, so it increments the supplier's PM-runtime usage counter
> > with the assumption that the link will stay around until
> > pm_runtime_put_suppliers() is called by driver_probe_device(),
> > but if the link goes away before that point, the supplier's
> > PM-runtime usage counter will remain nonzero.
> >
> > To prevent that from happening, first rework pm_runtime_get_suppliers()
> > and pm_runtime_put_suppliers() to use the rpm_active refounts of device
> > links and make the latter only drop rpm_active and the supplier's
> > PM-runtime usage counter for each link by one, unless rpm_active is
> > one already for it.  Next, modify device_link_add() to bump up the
> > new link's rpm_active refcount and the suppliers PM-runtime usage
> > counter by two, to prevent pm_runtime_put_suppliers(), if it is
> > called subsequently, from suspending the supplier prematurely (in
> > case its PM-runtime usage counter goes down to 0 in there).
> >
> > Due to the way rpm_put_suppliers() works, this change does not
> > affect runtime suspend of the consumer ends of new device links (or,
> > generally, device links for which DL_FLAG_PM_RUNTIME has just been
> > set).
> >
> > Fixes: e2f3cd831a28 ("driver core: Fix handling of runtime PM flags in device_link_add()")
> > Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Note that the issue had been there before commit e2f3cd831a28, but it was
> > overlooked by that commit and this change is a fix on top of it, so make
> > the Fixes: tag point to commit e2f3cd831a28 (instead of an earlier one
> > that the patch will not be applicable to).
>
> I noticed that yesterday's and today's -next were no longer booting on
> one of our Tegra boards (Tegra210 Jetson TX2) because networking is
> failing. The ethernet chip is a USB device and looking at the bootlogs I
> can see that the Tegra XHCI driver is failing ...

Is it failing because of this particular commit?  That is, does
reverting the entire commit help?

>  tegra-xusb 70090000.usb: xHCI host controller not responding, assume dead
>  tegra-xusb 70090000.usb: HC died; cleaning up
>
> The Tegra XHCI driver uses multiple power-domains and uses
> device_link_add() to attach them. So now I am wondering if there is
> something that we have got wrong in our implementation. However, I don't
> see the device being probed deferred on boot or anything like that.

It won't be, because you use stateless links.

> The driver in question is drivers/usb/host/xhci-tegra.c and we add the
> links in the function tegra_xusb_powerdomain_init() which is before RPM
> is enabled. Let me know if you have any thoughts.

Well, if it breaks, then there is a bug somewhere.  I'm not seeing it
now, but let's dig into this.

Since you don't pass DL_FLAG_RPM_ACTIVE to device_link_add(), the
changes related to that don't matter.

The links are not there before your probe function runs.  It adds the
links and then pm_runtime_put_suppliers() sees them, but since
link->rpm_active is one for the new links, it won't do anything with
them.

Well, there is a difference, but if it matters, then something fishy
is going on IMO.  Before this change pm_runtime_put_suppliers() would
do pm_runtime_put() on the new links' suppliers and (because their
PM-runtime usage counters are both one at that point) it will actually
try to suspend the suppliers.  It should be easy enough to verify if
this really matters, stay tuned.
