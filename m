From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/2] PM: Fix potential issue with failing
	asynchronous suspend
Date: Mon, 20 Sep 2010 20:00:44 +0200
Message-ID: <201009202000.45147.rjw__8376.53950225121$1285005972$gmane$org@sisk.pl>
References: <201009201957.40995.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009201957.40995.rjw@sisk.pl>
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
Cc: Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Colin Cross <ccross@android.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM: Fix potential issue with failing asynchronous suspend

There is a potential issue with the asynchronous suspend code that
a device driver suspending asynchronously may not notice that it
should back off.  There are two failing scenarions, (1) when the
driver is waiting for a driver suspending synchronously to complete
and that second driver returns error code, in which case async_error
won't be set and the waiting driver will continue suspending and (2)
after the driver has called device_pm_wait_for_dev() and the waited
for driver returns error code, in which case the caller of
device_pm_wait_for_dev() will not know that there was an error and
will continue suspending.

To fix this issue make __device_suspend() set async_error, so
async_suspend() doesn't need to set it any more, and make
device_pm_wait_for_dev() return async_error, so that its callers
can check whether or not they should continue suspending.

No more changes are necessary, since device_pm_wait_for_dev() in
not used by any drivers' suspend routines.

Reported-by: Colin Cross <ccross@android.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |   15 +++++++++------
 include/linux/pm.h        |    7 +++++--
 2 files changed, 14 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -51,6 +51,8 @@ static pm_message_t pm_transition;
  */
 static bool transition_started;
 
+static int async_error;
+
 /**
  * device_pm_init - Initialize the PM-related part of a device object.
  * @dev: Device object being initialized.
@@ -602,6 +604,7 @@ static void dpm_resume(pm_message_t stat
 	INIT_LIST_HEAD(&list);
 	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
+	async_error = 0;
 
 	list_for_each_entry(dev, &dpm_list, power.entry) {
 		if (dev->power.status < DPM_OFF)
@@ -831,8 +834,6 @@ static int legacy_suspend(struct device 
 	return error;
 }
 
-static int async_error;
-
 /**
  * device_suspend - Execute "suspend" callbacks for given device.
  * @dev: Device to handle.
@@ -887,6 +888,9 @@ static int __device_suspend(struct devic
 	device_unlock(dev);
 	complete_all(&dev->power.completion);
 
+	if (error)
+		async_error = error;
+
 	return error;
 }
 
@@ -896,10 +900,8 @@ static void async_suspend(void *data, as
 	int error;
 
 	error = __device_suspend(dev, pm_transition, true);
-	if (error) {
+	if (error)
 		pm_dev_err(dev, pm_transition, " async", error);
-		async_error = error;
-	}
 
 	put_device(dev);
 }
@@ -1087,8 +1089,9 @@ EXPORT_SYMBOL_GPL(__suspend_report_resul
  * @dev: Device to wait for.
  * @subordinate: Device that needs to wait for @dev.
  */
-void device_pm_wait_for_dev(struct device *subordinate, struct device *dev)
+int device_pm_wait_for_dev(struct device *subordinate, struct device *dev)
 {
 	dpm_wait(dev, subordinate->power.async_suspend);
+	return async_error;
 }
 EXPORT_SYMBOL_GPL(device_pm_wait_for_dev);
Index: linux-2.6/include/linux/pm.h
===================================================================
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -559,7 +559,7 @@ extern void __suspend_report_result(cons
 		__suspend_report_result(__func__, fn, ret);		\
 	} while (0)
 
-extern void device_pm_wait_for_dev(struct device *sub, struct device *dev);
+extern int device_pm_wait_for_dev(struct device *sub, struct device *dev);
 #else /* !CONFIG_PM_SLEEP */
 
 #define device_pm_lock() do {} while (0)
@@ -572,7 +572,10 @@ static inline int dpm_suspend_start(pm_m
 
 #define suspend_report_result(fn, ret)		do {} while (0)
 
-static inline void device_pm_wait_for_dev(struct device *a, struct device *b) {}
+static inline int device_pm_wait_for_dev(struct device *a, struct device *b)
+{
+	return 0;
+}
 #endif /* !CONFIG_PM_SLEEP */
 
 /* How to reorder dpm_list after device_move() */
