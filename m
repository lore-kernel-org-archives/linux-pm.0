From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM: use pm_runtime_put_sync in system resume
Date: Tue, 15 Dec 2009 17:10:25 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912151708530.2643-100000@iolanthe.rowland.org>
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

This patch (as1317) fixes a bug in the PM core.  When a device is
resumed following a system sleep, the core decrements the device's
runtime PM usage counter but doesn't issue an idle notification if the
counter reaches 0.  This could prevent an otherwise unused device from
being runtime-suspended again after the system sleep.

The fix is to call pm_runtime_put_sync() instead of
pm_runtime_put_noidle().

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/drivers/base/power/main.c
===================================================================
--- usb-2.6.orig/drivers/base/power/main.c
+++ usb-2.6/drivers/base/power/main.c
@@ -521,7 +521,7 @@ static void dpm_complete(pm_message_t st
 			mutex_unlock(&dpm_list_mtx);
 
 			device_complete(dev, state);
-			pm_runtime_put_noidle(dev);
+			pm_runtime_put_sync(dev);
 
 			mutex_lock(&dpm_list_mtx);
 		}
@@ -772,7 +772,7 @@ static int dpm_prepare(pm_message_t stat
 		pm_runtime_get_noresume(dev);
 		if (pm_runtime_barrier(dev) && device_may_wakeup(dev)) {
 			/* Wake-up requested during system sleep transition. */
-			pm_runtime_put_noidle(dev);
+			pm_runtime_put_sync(dev);
 			error = -EBUSY;
 		} else {
 			error = device_prepare(dev, state);
