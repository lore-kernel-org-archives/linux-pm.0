From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH v4 2/3] drivercore: Bind/unbind power domain on probe/remove
Date: Thu, 08 May 2014 14:49:14 +0200
Message-ID: <1399553355-6615-3-git-send-email-t.figa@samsung.com>
References: <1399553355-6615-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:23529 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243AbaEHMt1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 May 2014 08:49:27 -0400
In-reply-to: <1399553355-6615-1-git-send-email-t.figa@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Stephen Boyd <sboyd@codeaurora.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@linaro.org>, Philipp Zabel <philipp.zabel@gmail.com>, Tomasz Figa <tomasz.fi>

On a number of platforms, devices are part of controllable power
domains, which need to be enabled before such devices can be accessed
and may be powered down when the device is idle to save some power.
This means that on systems that support power domain control using
generic power domains subsystem, it is necessary to add device to its
power domain before binding a driver to it and remove it from its power
domain after its driver is unbound to make sure that an unused device
does not affect power domain state.

Since this is not limited to particular busses and specific
archs/platforms, it is more convenient to do the above directly in
driver core, just as done with pinctrl default configuration. This patch
adds necessary code to really_probe() and __device_release_driver() to
achieve this and maintain consistent stack-like ordering of operations
happening when binding and unbinding a driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>
[on i.MX6 GK802]
Tested-by: Philipp Zabel <philipp.zabel@gmail.com>
Reviewed-by: Mark Brown <broonie@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/dd.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 62ec61e..9489b3a 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -23,6 +23,7 @@
 #include <linux/kthread.h>
 #include <linux/wait.h>
 #include <linux/async.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/devinfo.h>
 
@@ -287,6 +288,11 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 
 	dev->driver = drv;
 
+	/* If using genpd, bind power domain now before probing */
+	ret = genpd_bind_domain(dev);
+	if (ret)
+		goto probe_failed;
+
 	/* If using pinctrl, bind pins now before probing */
 	ret = pinctrl_bind_pins(dev);
 	if (ret)
@@ -317,6 +323,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 probe_failed:
 	devres_release_all(dev);
 	driver_sysfs_remove(dev);
+	genpd_unbind_domain(dev);
 	dev->driver = NULL;
 	dev_set_drvdata(dev, NULL);
 
@@ -530,7 +537,7 @@ static void __device_release_driver(struct device *dev)
 			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 						     BUS_NOTIFY_UNBOUND_DRIVER,
 						     dev);
-
+		genpd_unbind_domain(dev);
 	}
 }
 
-- 
1.9.2

