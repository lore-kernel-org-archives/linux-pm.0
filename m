From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 03/04] PM: Runtime PM v11 - add debug printouts
Date: Fri, 31 Jul 2009 21:27:08 +0900
Message-ID: <20090731122708.31004.73723.sendpatchset@rx1.opensource.se>
References: <20090731122639.31004.95390.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090731122639.31004.95390.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds dev_dbg() printouts to the Runtime PM
code. Just add a #define DEBUG at the top of the file
to get suspend and resume printouts. Also add a missing
newline to the pm_runtime_enable() printout while at it.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/base/power/runtime.c |   41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

--- 0017/drivers/base/power/runtime.c
+++ work/drivers/base/power/runtime.c	2009-07-31 19:48:32.000000000 +0900
@@ -125,16 +125,22 @@ int __pm_runtime_suspend(struct device *
 	bool notify = false;
 	int retval = 0;
 
+	dev_dbg(dev, "__pm_runtime_suspend() %d!\n", from_wq);
  repeat:
-	if (dev->power.runtime_failure)
-		return -EINVAL;
+	if (dev->power.runtime_failure) {
+		retval = -EINVAL;
+		goto out;
+	}
 
 	pm_runtime_deactivate_timer(dev);
 
 	if (dev->power.request_pending) {
 		/* Pending resume requests take precedence over us. */
-		if (dev->power.request == RPM_REQ_RESUME)
-			return -EAGAIN;
+		if (dev->power.request == RPM_REQ_RESUME) {
+			retval = -EAGAIN;
+			goto out;
+		}
+
 		/* Other pending requests need to be canceled. */
 		dev->power.request = RPM_REQ_NONE;
 	}
@@ -148,13 +154,15 @@ int __pm_runtime_suspend(struct device *
 	else if (!pm_children_suspended(dev))
 		retval = -EBUSY;
 	if (retval)
-		return retval;
+		goto out;
 
 	if (dev->power.runtime_status == RPM_SUSPENDING) {
 		DEFINE_WAIT(wait);
 
-		if (from_wq)
-			return -EINPROGRESS;
+		if (from_wq) {
+			retval = -EINPROGRESS;
+			goto out;
+		}
 
 		/* Wait for the other suspend running in parallel with us. */
 		for (;;) {
@@ -217,6 +225,8 @@ int __pm_runtime_suspend(struct device *
 		pm_runtime_idle(dev);
 
 	spin_lock_irq(&dev->power.lock);
+ out:
+	dev_dbg(dev, "__pm_runtime_suspend() returns %d!\n", retval);
 
 	return retval;
 }
@@ -256,9 +266,12 @@ int __pm_runtime_resume(struct device *d
 	struct device *parent = NULL;
 	int retval = 0;
 
+	dev_dbg(dev, "__pm_runtime_resume() %d!\n", from_wq);
  repeat:
-	if (dev->power.runtime_failure)
-		return -EINVAL;
+	if (dev->power.runtime_failure) {
+		retval = -EINVAL;
+		goto out;
+	}
 
 	pm_runtime_cancel_pending(dev);
 
@@ -267,7 +280,7 @@ int __pm_runtime_resume(struct device *d
 	else if (dev->power.disable_depth > 0)
 		retval = -EAGAIN;
 	if (retval)
-		return retval;
+		goto out;
 
 	if (dev->power.runtime_status == RPM_RESUMING
 	    || dev->power.runtime_status == RPM_SUSPENDING) {
@@ -276,7 +289,9 @@ int __pm_runtime_resume(struct device *d
 		if (from_wq) {
 			if (dev->power.runtime_status == RPM_SUSPENDING)
 				dev->power.deferred_resume = true;
-			return -EINPROGRESS;
+
+			retval = -EINPROGRESS;
+			goto out;
 		}
 
 		/* Wait for the operation carried out in parallel with us. */
@@ -347,6 +362,8 @@ int __pm_runtime_resume(struct device *d
 		pm_request_idle(dev);
 
 	spin_lock_irq(&dev->power.lock);
+ out:
+	dev_dbg(dev, "__pm_runtime_resume() returns %d!\n", retval);
 
 	return retval;
 }
@@ -771,7 +788,7 @@ void pm_runtime_enable(struct device *de
 	if (dev->power.disable_depth > 0)
 		dev->power.disable_depth--;
 	else
-		dev_warn(dev, "Unbalanced %s!", __func__);
+		dev_warn(dev, "Unbalanced %s!\n", __func__);
 
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 }
