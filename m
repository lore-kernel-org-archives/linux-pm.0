From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH ver. 3] PM: allow for usage_count > 0 in
	pm_runtime_get()
Date: Mon, 7 Dec 2009 10:51:21 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912071049040.3064-100000@iolanthe.rowland.org>
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

This patch (as1308c) fixes __pm_runtime_get().  Currently the routine
will resume a device if the prior usage count was 0.  But this isn't
right; thanks to pm_runtime_get_noresume() the usage count can be
positive even while the device is suspended.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Rafael:

This patch contains the most important part of the patch you rejected
last week, leaving out the semantic changes you didn't like.  It really
does fix a bug, and it should be sent to Linus before the merge window
closes.

Alan Stern


Index: usb-2.6/drivers/base/power/runtime.c
===================================================================
--- usb-2.6.orig/drivers/base/power/runtime.c
+++ usb-2.6/drivers/base/power/runtime.c
@@ -699,15 +699,15 @@ EXPORT_SYMBOL_GPL(pm_request_resume);
  * @dev: Device to handle.
  * @sync: If set and the device is suspended, resume it synchronously.
  *
- * Increment the usage count of the device and if it was zero previously,
- * resume it or submit a resume request for it, depending on the value of @sync.
+ * Increment the usage count of the device and resume it or submit a resume
+ * request for it, depending on the value of @sync.
  */
 int __pm_runtime_get(struct device *dev, bool sync)
 {
-	int retval = 1;
+	int retval;
 
-	if (atomic_add_return(1, &dev->power.usage_count) == 1)
-		retval = sync ? pm_runtime_resume(dev) : pm_request_resume(dev);
+	atomic_inc(&dev->power.usage_count);
+	retval = sync ? pm_runtime_resume(dev) : pm_request_resume(dev);
 
 	return retval;
 }
