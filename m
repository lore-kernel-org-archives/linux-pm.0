From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3] driver core / PM: Add PM domain callbacks for device setup/cleanup
Date: Fri, 20 Mar 2015 13:59:27 +0100
Message-ID: <3289026.ADmXXipokh@vostro.rjw.lan>
References: <3533423.QQDErEmeTO@vostro.rjw.lan> <1810625.BTgaNclHRk@vostro.rjw.lan> <1654636.FxBHsexDm1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49960 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750764AbbCTMf3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2015 08:35:29 -0400
In-Reply-To: <1654636.FxBHsexDm1@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If PM domains are in use, it may be necessary to prepare the code
handling a PM domain for driver probing.  For example, in some
cases device drivers rely on the ability to power on the devices
with the help of the IO runtime PM framework and the PM domain
code needs to be ready for that.  Also, if that code has not been
fully initialized yet, the driver probing should be deferred.

Moreover, after the probing is complete, it may be necessary to
put the PM domain in question into the state reflecting the current
needs of the devices in it, for example, so that power is not drawn
in vain.  The same should be done after removing a driver from
a device, as the PM domain state may need to be changed to reflect
the new situation.

For these reasons, introduce new PM domain callbacks, ->activate,
->sync and ->dismiss called, respectively, before probing for a
device driver, after the probing has completed successfully and
if the probing has failed or the driver has been removed.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

One more update taking Dmitry's comments into account and fixing an
overoptimization bug spotted by Ulf.

And this actually contains the patch this time (clicked on "Send" too
early last time, sorry about that).

---
 drivers/base/dd.c  |   14 ++++++++++++++
 include/linux/pm.h |    8 ++++++++
 2 files changed, 22 insertions(+)

Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -603,10 +603,18 @@ extern void dev_pm_put_subsys_data(struc
  * Power domains provide callbacks that are executed during system suspend,
  * hibernation, system resume and during runtime PM transitions along with
  * subsystem-level and driver-level callbacks.
+ *
+ * @detach: Called when removing a device from the domain.
+ * @activate: Called before executing probe routines for bus types and drivers.
+ * @sync: Called after successful driver probe.
+ * @dismiss: Called after unsuccessful driver probe and after driver removal.
  */
 struct dev_pm_domain {
 	struct dev_pm_ops	ops;
 	void (*detach)(struct device *dev, bool power_off);
+	int (*activate)(struct device *dev);
+	void (*sync)(struct device *dev);
+	void (*dismiss)(struct device *dev);
 };
 
 /*
Index: linux-pm/drivers/base/dd.c
===================================================================
--- linux-pm.orig/drivers/base/dd.c
+++ linux-pm/drivers/base/dd.c
@@ -298,6 +298,12 @@ static int really_probe(struct device *d
 		goto probe_failed;
 	}
 
+	if (dev->pm_domain && dev->pm_domain->activate) {
+		ret = dev->pm_domain->activate(dev);
+		if (ret)
+			goto probe_failed;
+	}
+
 	if (dev->bus->probe) {
 		ret = dev->bus->probe(dev);
 		if (ret)
@@ -308,6 +314,9 @@ static int really_probe(struct device *d
 			goto probe_failed;
 	}
 
+	if (dev->pm_domain && dev->pm_domain->sync)
+		dev->pm_domain->sync(dev);
+
 	driver_bound(dev);
 	ret = 1;
 	pr_debug("bus: '%s': %s: bound device %s to driver %s\n",
@@ -319,6 +328,8 @@ probe_failed:
 	driver_sysfs_remove(dev);
 	dev->driver = NULL;
 	dev_set_drvdata(dev, NULL);
+	if (dev->pm_domain && dev->pm_domain->dismiss)
+		dev->pm_domain->dismiss(dev);
 
 	if (ret == -EPROBE_DEFER) {
 		/* Driver requested deferred probing */
@@ -525,6 +536,9 @@ static void __device_release_driver(stru
 		devres_release_all(dev);
 		dev->driver = NULL;
 		dev_set_drvdata(dev, NULL);
+		if (dev->pm_domain && dev->pm_domain->dismiss)
+			dev->pm_domain->dismiss(dev);
+
 		klist_remove(&dev->p->knode_driver);
 		if (dev->bus)
 			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,

