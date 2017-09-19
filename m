From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM: core: Fix device_pm_check_callbacks()
Date: Tue, 19 Sep 2017 02:22:39 +0200
Message-ID: <3846381.3WURMMlb6k@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47571 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750791AbdISAbn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2017 20:31:43 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The device_pm_check_callbacks() function doesn't check legacy
->suspend and ->resume callback pointers under the device's
bus type, class and driver, so in some cases it may set the
no_pm_callbacks flag for the device incorrectly and then the
callbacks may be skipped during system suspend/resume, which
shouldn't happen.

Fixes: aa8e54b55947 (PM / sleep: Go direct_complete if driver has no callbacks)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1860,10 +1860,13 @@ void device_pm_check_callbacks(struct de
 {
 	spin_lock_irq(&dev->power.lock);
 	dev->power.no_pm_callbacks =
-		(!dev->bus || pm_ops_is_empty(dev->bus->pm)) &&
-		(!dev->class || pm_ops_is_empty(dev->class->pm)) &&
+		(!dev->bus || (pm_ops_is_empty(dev->bus->pm) &&
+		 !dev->bus->suspend && !dev->bus->resume)) &&
+		(!dev->class || (pm_ops_is_empty(dev->class->pm) &&
+		 !dev->class->suspend && !dev->class->resume)) &&
 		(!dev->type || pm_ops_is_empty(dev->type->pm)) &&
 		(!dev->pm_domain || pm_ops_is_empty(&dev->pm_domain->ops)) &&
-		(!dev->driver || pm_ops_is_empty(dev->driver->pm));
+		(!dev->driver || (pm_ops_is_empty(dev->driver->pm) &&
+		 !dev->driver->suspend && !dev->driver->resume));
 	spin_unlock_irq(&dev->power.lock);
 }
