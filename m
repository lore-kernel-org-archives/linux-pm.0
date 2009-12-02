From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM: fix a lockdep warning in runtime.c
Date: Wed, 2 Dec 2009 15:56:27 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912021553010.3041-100000@iolanthe.rowland.org>
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

This patch (as1309) fixes a lockdep warning in
__pm_runtime_set_status().  This is the one place where the runtime PM
framework acquires a nested power.lock, and the nesting is never more
than one deep.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

If anybody is using the runtime PM framework in 2.6.32 then this 
should be pushed before the final release.



Index: usb-2.6/drivers/base/power/runtime.c
===================================================================
--- usb-2.6.orig/drivers/base/power/runtime.c
+++ usb-2.6/drivers/base/power/runtime.c
@@ -10,6 +10,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/jiffies.h>
 
+#define	RPM_LOCK_PARENT		1
+
 static int __pm_runtime_resume(struct device *dev, bool from_wq);
 static int __pm_request_idle(struct device *dev);
 static int __pm_request_resume(struct device *dev);
@@ -793,7 +795,7 @@ int __pm_runtime_set_status(struct devic
 	}
 
 	if (parent) {
-		spin_lock(&parent->power.lock);
+		spin_lock_nested(&parent->power.lock, RPM_LOCK_PARENT);
 
 		/*
 		 * It is invalid to put an active child under a parent that is
