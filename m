From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / runtime: Drop children check from __pm_runtime_set_status()
Date: Sun, 12 Nov 2017 01:27:30 +0100
Message-ID: <1713438.irjm9MTSvo@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44956 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752199AbdKLA1k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Nov 2017 19:27:40 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The check for "active" children in __pm_runtime_set_status(), when
trying to set the parent device status to "suspended", doesn't
really make sense, because in fact it is not invalid to set the
status of a device with runtime PM disabled to "suspended" in any
case.  It is invalid to enable runtime PM for a device with its
status set to "suspended" while its child_count reference counter
is nonzero, but the check in __pm_runtime_set_status() doesn't
really cover that situation.

For this reason, drop the children check from __pm_runtime_set_status()
and add a check against child_count reference counters of "suspended"
devices to pm_runtime_enable().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |   30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -1101,29 +1101,13 @@ int __pm_runtime_set_status(struct devic
 		goto out;
 	}
 
-	if (dev->power.runtime_status == status)
+	if (dev->power.runtime_status == status || !parent)
 		goto out_set;
 
 	if (status == RPM_SUSPENDED) {
-		/*
-		 * It is invalid to suspend a device with an active child,
-		 * unless it has been set to ignore its children.
-		 */
-		if (!dev->power.ignore_children &&
-			atomic_read(&dev->power.child_count)) {
-			dev_err(dev, "runtime PM trying to suspend device but active child\n");
-			error = -EBUSY;
-			goto out;
-		}
-
-		if (parent) {
-			atomic_add_unless(&parent->power.child_count, -1, 0);
-			notify_parent = !parent->power.ignore_children;
-		}
-		goto out_set;
-	}
-
-	if (parent) {
+		atomic_add_unless(&parent->power.child_count, -1, 0);
+		notify_parent = !parent->power.ignore_children;
+	} else {
 		spin_lock_nested(&parent->power.lock, SINGLE_DEPTH_NESTING);
 
 		/*
@@ -1307,6 +1291,12 @@ void pm_runtime_enable(struct device *de
 	else
 		dev_warn(dev, "Unbalanced %s!\n", __func__);
 
+	WARN(dev->power.runtime_status == RPM_SUSPENDED &&
+	     !dev->power.ignore_children &&
+	     atomic_read(&dev->power.child_count) > 0,
+	     "Enabling runtime PM for inactive device (%s) with active children\n",
+	     dev_name(dev));
+
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 }
 EXPORT_SYMBOL_GPL(pm_runtime_enable);
