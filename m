From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM: allow runtime_suspend methods to call
	pm_schedule_suspend
Date: Fri, 19 Mar 2010 11:51:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1003191149150.1300-100000@iolanthe.rowland.org>
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

This patch (as1361) changes the runtime PM interface slightly; it
allows suspend requests to be scheduled while the runtime_suspend
method is running.  If the method succeeds then the scheduled request
is cancelled, whereas if the method fails then an idle notification is
sent only if no request was scheduled.

Being able to schedule suspend requests from within a runtime_suspend
method is useful for drivers that need to test for idleness and
suspend the device all while holding a single spinlock, or for drivers
that want to check for idleness by polling.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/drivers/base/power/runtime.c
===================================================================
--- usb-2.6.orig/drivers/base/power/runtime.c
+++ usb-2.6/drivers/base/power/runtime.c
@@ -229,14 +229,16 @@ int __pm_runtime_suspend(struct device *
 
 	if (retval) {
 		dev->power.runtime_status = RPM_ACTIVE;
-		pm_runtime_cancel_pending(dev);
-
 		if (retval == -EAGAIN || retval == -EBUSY) {
-			notify = true;
+			if (dev->power.timer_expires == 0)
+				notify = true;
 			dev->power.runtime_error = 0;
+		} else {
+			pm_runtime_cancel_pending(dev);
 		}
 	} else {
 		dev->power.runtime_status = RPM_SUSPENDED;
+		pm_runtime_deactivate_timer(dev);
 
 		if (dev->parent) {
 			parent = dev->parent;
@@ -659,8 +661,6 @@ int pm_schedule_suspend(struct device *d
 
 	if (dev->power.runtime_status == RPM_SUSPENDED)
 		retval = 1;
-	else if (dev->power.runtime_status == RPM_SUSPENDING)
-		retval = -EINPROGRESS;
 	else if (atomic_read(&dev->power.usage_count) > 0
 	    || dev->power.disable_depth > 0)
 		retval = -EAGAIN;
