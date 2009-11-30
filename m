From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM: use deferred_resume flag in pm_request_resume
Date: Mon, 30 Nov 2009 11:32:51 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911301131510.4478-100000@iolanthe.rowland.org>
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

This patch (as1307) adds a small optimization to
__pm_request_resume().  If the device is currently being suspended,
there's no need to queue a work routine to resume it.  Setting the
deferred_resume flag will suffice.  (There's also a minor improvement
to the function's code layout: An unnecessary "else" is removed.)

Also, the patch clarifies the usage of the deferred_resume flag.  It
is meaningful only while a suspend is in progress, so it should be
cleared just before a suspend starts, not just after one ends.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/drivers/base/power/runtime.c
===================================================================
--- usb-2.6.orig/drivers/base/power/runtime.c
+++ usb-2.6/drivers/base/power/runtime.c
@@ -189,6 +189,7 @@ int __pm_runtime_suspend(struct device *
 	}
 
 	dev->power.runtime_status = RPM_SUSPENDING;
+	dev->power.deferred_resume = false;
 
 	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend) {
 		spin_unlock_irq(&dev->power.lock);
@@ -204,7 +205,6 @@ int __pm_runtime_suspend(struct device *
 	if (retval) {
 		dev->power.runtime_status = RPM_ACTIVE;
 		pm_runtime_cancel_pending(dev);
-		dev->power.deferred_resume = false;
 
 		if (retval == -EAGAIN || retval == -EBUSY) {
 			notify = true;
@@ -221,7 +221,6 @@ int __pm_runtime_suspend(struct device *
 	wake_up_all(&dev->power.wait_queue);
 
 	if (dev->power.deferred_resume) {
-		dev->power.deferred_resume = false;
 		__pm_runtime_resume(dev, false);
 		retval = -EAGAIN;
 		goto out;
@@ -663,13 +662,17 @@ static int __pm_request_resume(struct de
 
 	pm_runtime_deactivate_timer(dev);
 
+	if (dev->power.runtime_status == RPM_SUSPENDING) {
+		dev->power.deferred_resume = true;
+		return retval;
+	}
 	if (dev->power.request_pending) {
 		/* If non-resume request is pending, we can overtake it. */
 		dev->power.request = retval ? RPM_REQ_NONE : RPM_REQ_RESUME;
 		return retval;
-	} else if (retval) {
-		return retval;
 	}
+	if (retval)
+		return retval;
 
 	dev->power.request = RPM_REQ_RESUME;
 	dev->power.request_pending = true;
