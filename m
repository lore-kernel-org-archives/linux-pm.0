From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] driver core: Fix possible supplier PM-usage counter imbalance
Date: Fri, 15 Feb 2019 15:37:28 +0100
Message-ID: <CAPDyKFoAtviRYuFxJLNrD_J0bGbMTca3O8EN8THg6+d3BNq3vQ@mail.gmail.com>
References: <5510642.nRbR3bcduN@aspire.rjw.lan> <9351473.C2nPJoyFsE@aspire.rjw.lan>
 <2ed95b05-317c-59bb-498a-b5481e54bcf6@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2ed95b05-317c-59bb-498a-b5481e54bcf6@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-tegra <linux-tegra@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 15 Feb 2019 at 12:00, Jon Hunter <jonathanh@nvidia.com> wrote:
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
> I noticed that yesterday's and today's -next were no longer booting on
> one of our Tegra boards (Tegra210 Jetson TX2) because networking is
> failing. The ethernet chip is a USB device and looking at the bootlogs I
> can see that the Tegra XHCI driver is failing ...
>
>  tegra-xusb 70090000.usb: xHCI host controller not responding, assume dead
>  tegra-xusb 70090000.usb: HC died; cleaning up
>
> The Tegra XHCI driver uses multiple power-domains and uses
> device_link_add() to attach them. So now I am wondering if there is
> something that we have got wrong in our implementation. However, I don't
> see the device being probed deferred on boot or anything like that.
>
> The driver in question is drivers/usb/host/xhci-tegra.c and we add the
> links in the function tegra_xusb_powerdomain_init() which is before RPM
> is enabled. Let me know if you have any thoughts.

If you are willing to help debugging then I am offering my assistance.

I would start by enabling CONFIG_PM_ADVANCED_DEBUG, which gives you
some more information about the runtime PM state of the device, like
the usage count for example.
I would also add a couple of prints in
tegra_xusb_runtime_suspend|resume() and in the ->power_on|off()
callbacks for the corresponding genpds, to see when those gets called.

While I was testing $subject patch I also used a local debug patch,
which adds a sysfs node that can be used to get the state of linked
suppliers for a consumer device. Feel free to use it, attached below.

Of course, the interesting part is the comparison of what happens with
and without $subject patch.

From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 Feb 2019 15:37:44 +0100
Subject: [PATCH] PM / Runtime: Add sysfs for runtime counting of suppliers

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/sysfs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index d713738ce796..ce5c188cdf54 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -537,6 +537,25 @@ static ssize_t runtime_enabled_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(runtime_enabled);

+static ssize_t runtime_suppliers_show(struct device *dev,
+                                 struct device_attribute *attr, char *buf)
+{
+       struct device_link *link;
+       int chars = 0;
+
+       list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
+
+               if (!(link->flags & DL_FLAG_PM_RUNTIME))
+                       continue;
+
+               chars += sprintf(buf + chars, "%s %d\n",
+                               dev_name(link->supplier),
+                               refcount_read(&link->rpm_active));
+       }
+       return chars;
+}
+static DEVICE_ATTR_RO(runtime_suppliers);
+
 #ifdef CONFIG_PM_SLEEP
 static ssize_t async_show(struct device *dev, struct device_attribute *attr,
                          char *buf)
@@ -572,6 +591,7 @@ static struct attribute *power_attrs[] = {
        &dev_attr_runtime_usage.attr,
        &dev_attr_runtime_active_kids.attr,
        &dev_attr_runtime_enabled.attr,
+       &dev_attr_runtime_suppliers.attr,
 #endif /* CONFIG_PM_ADVANCED_DEBUG */
        NULL,
 };
-- 
2.17.1

Kind regards
Uffe
