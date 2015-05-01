From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH] PM / sleep: Let devices force direct_complete
Date: Fri,  1 May 2015 12:03:30 +0200
Message-ID: <1430474611-25560-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38518 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbbEAKEU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2015 06:04:20 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

Introduce a new per-device flag power.force_direct_complete that will
instruct the PM core to let that device remain in runtime suspend when
the system goes into a sleep power state, regardless of the PM state of
any of its descendants.

This is needed because otherwise it would be needed to get dozens of
drivers to implement the prepare() callback and be runtime PM active
even if they don't have a 1-to-1 relationship with a piece of HW.

This only applies to devices that aren't wakeup-capable, as those would
need to setup their IRQs as wakeup-capable in their prepare() callbacks.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Hi,

I'm sending this as a standalone patch as suggested by Alan.

Thanks,

Tomeu

---
 Documentation/power/runtime_pm.txt | 10 ++++++++++
 drivers/base/power/main.c          | 14 ++++++++++----
 include/linux/pm.h                 |  1 +
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
index 44fe1d2..3b0c68d 100644
--- a/Documentation/power/runtime_pm.txt
+++ b/Documentation/power/runtime_pm.txt
@@ -665,6 +665,16 @@ as appropriate.  This only applies to system suspend transitions that are not
 related to hibernation (see Documentation/power/devices.txt for more
 information).
 
+For devices that know that can remain runtime suspended when the system
+transitions to a sleep state regardless of the PM state of their descendants,
+the flag power.force_direct_complete can be set on their device structures.
+This can be useful when a real device has several virtual devices as
+descendants and it would be very cumbersome to make sure that they return a
+positive value in their .prepare() callback and have runtime PM enabled. Usage
+of power.force_direct_complete is only allowed to devices that aren't
+wakeup-capable, as they would need to set their IRQs as wakeups in their
+.prepare() callbacks before the system transitions to a sleep state.
+
 The PM core does its best to reduce the probability of race conditions between
 the runtime PM and system suspend/resume (and hibernation) callbacks by carrying
 out the following operations:
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 3d874ec..7b962f5 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1438,7 +1438,9 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 		if (parent) {
 			spin_lock_irq(&parent->power.lock);
 
-			dev->parent->power.direct_complete = false;
+			if (!dev->parent->power.force_direct_complete)
+				dev->parent->power.direct_complete = false;
+
 			if (dev->power.wakeup_path
 			    && !dev->parent->power.ignore_children)
 				dev->parent->power.wakeup_path = true;
@@ -1605,9 +1607,13 @@ static int device_prepare(struct device *dev, pm_message_t state)
 	 * will do the same thing with all of its descendants".  This only
 	 * applies to suspend transitions, however.
 	 */
-	spin_lock_irq(&dev->power.lock);
-	dev->power.direct_complete = ret > 0 && state.event == PM_EVENT_SUSPEND;
-	spin_unlock_irq(&dev->power.lock);
+	if (state.event == PM_EVENT_SUSPEND) {
+		spin_lock_irq(&dev->power.lock);
+		dev->power.direct_complete = ret > 0 ||
+			(dev->power.force_direct_complete &&
+			 !device_can_wakeup(dev));
+		spin_unlock_irq(&dev->power.lock);
+	}
 	return 0;
 }
 
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 2d29c64..2e41cfd 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -553,6 +553,7 @@ struct dev_pm_info {
 	bool			ignore_children:1;
 	bool			early_init:1;	/* Owned by the PM core */
 	bool			direct_complete:1;	/* Owned by the PM core */
+	bool			force_direct_complete:1;
 	spinlock_t		lock;
 #ifdef CONFIG_PM_SLEEP
 	struct list_head	entry;
-- 
2.3.6

