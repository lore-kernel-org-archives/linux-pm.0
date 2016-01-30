From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM: Avoid false-positive warnings in dev_pm_domain_set()
Date: Sat, 30 Jan 2016 12:54:29 +0100
Message-ID: <80793506.EZRY3UmSeu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is a WARN_ON() in dev_pm_domain_set() that triggers on attempts
to set the pm_domain pointer for devices with a driver bound.

However, that WARN_ON() triggers on attempts to clear the pointer
too and the test it uses is based on checking the device's
p->knode_driver pointer which still is set when the device bus
type's/driver's ->remove callback has been executed.  This
leads to false-positive warnings when bus type code calls
dev_pm_domain_set() to clear the pm_domain pointer after
invoking the driver's ->remove() callback.

To avoid those false-positives, make dev_pm_domain_set() check
if the pointer passed to it is NULL and skip the warning in
that case.

Fixes: 989561de9b51 (PM / Domains: add setter for dev.pm_domain)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/base/power/common.c
===================================================================
--- linux-pm.orig/drivers/base/power/common.c
+++ linux-pm/drivers/base/power/common.c
@@ -146,7 +146,7 @@ void dev_pm_domain_set(struct device *de
 	if (dev->pm_domain == pd)
 		return;
 
-	WARN(device_is_bound(dev),
+	WARN(pd && device_is_bound(dev),
 	     "PM domains can only be changed for unbound devices\n");
 	dev->pm_domain = pd;
 	device_pm_check_callbacks(dev);
