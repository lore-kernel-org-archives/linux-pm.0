From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] PM: Avoid false-positive warnings in dev_pm_domain_set()
Date: Mon,  1 Feb 2016 16:12:58 +0200
Message-ID: <1454335978-21467-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:42225 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932244AbcBAONe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 1 Feb 2016 09:13:34 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

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
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/power/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 93ed14c..f6a9ad5 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -146,7 +146,7 @@ void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd)
 	if (dev->pm_domain == pd)
 		return;
 
-	WARN(device_is_bound(dev),
+	WARN(pd && device_is_bound(dev),
 	     "PM domains can only be changed for unbound devices\n");
 	dev->pm_domain = pd;
 	device_pm_check_callbacks(dev);
-- 
2.7.0

