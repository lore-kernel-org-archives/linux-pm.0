From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / wakeup: Set power.can_wakeup if wakeup_sysfs_add() fails
Date: Wed, 02 Aug 2017 01:32:44 +0200
Message-ID: <1650146.ozLLNlAB8h@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45922 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750853AbdHAXkw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2017 19:40:52 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Currently, an error from wakeup_sysfs_add() in
device_set_wakeup_capable() causes the device's power.can_wakeup
flag to remain unset even though the device technically is capable
of signaling wakeup.

If wakeup_sysfs_add() fails user space may not be able to enable
the device to wake up the system from sleep states, but at least
for some devices that does not matter.

For this reason, set or clear power.can_wakeup upfront and if
wakeup_sysfs_add() returns an error, print a message to the log.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/wakeup.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/base/power/wakeup.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeup.c
+++ linux-pm/drivers/base/power/wakeup.c
@@ -412,15 +412,17 @@ void device_set_wakeup_capable(struct de
 	if (!!dev->power.can_wakeup == !!capable)
 		return;
 
+	dev->power.can_wakeup = capable;
 	if (device_is_registered(dev) && !list_empty(&dev->power.entry)) {
 		if (capable) {
-			if (wakeup_sysfs_add(dev))
-				return;
+			int ret = wakeup_sysfs_add(dev);
+
+			if (ret)
+				dev_info(dev, "Wakeup sysfs attributes not added\n");
 		} else {
 			wakeup_sysfs_remove(dev);
 		}
 	}
-	dev->power.can_wakeup = capable;
 }
 EXPORT_SYMBOL_GPL(device_set_wakeup_capable);
 
