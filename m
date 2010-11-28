From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM: Prevent dpm_prepare() from returning errors
	unnecessarily
Date: Sun, 28 Nov 2010 13:12:49 +0100
Message-ID: <201011281312.49949.rjw__30647.9714498439$1290946502$gmane$org@sisk.pl>
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
To: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Currently dpm_prepare() returns error code if it finds that a device
being suspended has a pending runtime resume request.  However, it
should not do that if the checking for wakeup events is not enabled.
On the other hand, if the checking for wakeup events is enabled, it
can return error when a wakeup event is detected, regardless of its
source.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/async.h>
+#include <linux/suspend.h>
 
 #include "../base.h"
 #include "power.h"
@@ -1052,8 +1053,10 @@ static int dpm_prepare(pm_message_t stat
 		mutex_unlock(&dpm_list_mtx);
 
 		pm_runtime_get_noresume(dev);
-		if (pm_runtime_barrier(dev) && device_may_wakeup(dev)) {
-			/* Wake-up requested during system sleep transition. */
+		if (pm_runtime_barrier(dev) && device_may_wakeup(dev))
+			pm_wakeup_event(dev, 0);
+
+		if (pm_check_wakeup_events()) {
 			pm_runtime_put_sync(dev);
 			error = -EBUSY;
 		} else {
@@ -1068,8 +1071,8 @@ static int dpm_prepare(pm_message_t stat
 				error = 0;
 				continue;
 			}
-			printk(KERN_ERR "PM: Failed to prepare device %s "
-				"for power transition: error %d\n",
+			printk(KERN_INFO "PM: Device %s not prepared "
+				"for power transition: code %d\n",
 				kobject_name(&dev->kobj), error);
 			put_device(dev);
 			break;
