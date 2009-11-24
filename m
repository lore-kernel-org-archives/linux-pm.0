From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM: fix irq enable/disable in runtime PM code
Date: Tue, 24 Nov 2009 15:22:07 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911241520190.2881-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

This patch (as1305) fixes a bug in the irq-enable settings and removes
some related overhead in the runtime PM code.

	In __pm_runtime_resume(), within the scope of the original
	spin_lock_irq(), we know that irqs are disabled.  There's no
	reason to go through a pair of enable/disable cycles when
	acquiring and releasing the parent's lock.

	In __pm_runtime_set_status(), irqs are already disabled when
	the parent's lock is acquired, and they must remain disabled
	when it is released.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/drivers/base/power/runtime.c
===================================================================
--- usb-2.6.orig/drivers/base/power/runtime.c
+++ usb-2.6/drivers/base/power/runtime.c
@@ -332,11 +332,11 @@ int __pm_runtime_resume(struct device *d
 		 * necessary.
 		 */
 		parent = dev->parent;
-		spin_unlock_irq(&dev->power.lock);
+		spin_unlock(&dev->power.lock);
 
 		pm_runtime_get_noresume(parent);
 
-		spin_lock_irq(&parent->power.lock);
+		spin_lock(&parent->power.lock);
 		/*
 		 * We can resume if the parent's run-time PM is disabled or it
 		 * is set to ignore children.
@@ -347,9 +347,9 @@ int __pm_runtime_resume(struct device *d
 			if (parent->power.runtime_status != RPM_ACTIVE)
 				retval = -EBUSY;
 		}
-		spin_unlock_irq(&parent->power.lock);
+		spin_unlock(&parent->power.lock);
 
-		spin_lock_irq(&dev->power.lock);
+		spin_lock(&dev->power.lock);
 		if (retval)
 			goto out;
 		goto repeat;
@@ -781,7 +781,7 @@ int __pm_runtime_set_status(struct devic
 	}
 
 	if (parent) {
-		spin_lock_irq(&parent->power.lock);
+		spin_lock(&parent->power.lock);
 
 		/*
 		 * It is invalid to put an active child under a parent that is
@@ -797,7 +797,7 @@ int __pm_runtime_set_status(struct devic
 				atomic_inc(&parent->power.child_count);
 		}
 
-		spin_unlock_irq(&parent->power.lock);
+		spin_unlock(&parent->power.lock);
 
 		if (error)
 			goto out;
