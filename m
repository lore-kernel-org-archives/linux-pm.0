From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 1/4] PM: Use a different list of devices for
	each stage of device suspend
Date: Mon, 13 Dec 2010 01:29:55 +0100
Message-ID: <201012130129.55483.rjw__26137.0198954411$1292200603$gmane$org@sisk.pl>
References: <201012130128.31243.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012130128.31243.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Instead of keeping all devices in the same list during system suspend
and resume, regardless of what suspend-resume callbacks have been
executed for them already, use separate lists of devices that have
had their ->prepare(), ->suspend() and ->suspend_noirq() callbacks
executed.  This will allow us to simplify the core device suspend and
resume routines.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |   53 ++++++++++++++++------------------------------
 1 file changed, 19 insertions(+), 34 deletions(-)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -42,6 +42,9 @@
  */
 
 LIST_HEAD(dpm_list);
+LIST_HEAD(dpm_prepared_list);
+LIST_HEAD(dpm_suspended_list);
+LIST_HEAD(dpm_noirq_list);
 
 static DEFINE_MUTEX(dpm_list_mtx);
 static pm_message_t pm_transition;
@@ -476,14 +479,12 @@ End:
  */
 void dpm_resume_noirq(pm_message_t state)
 {
-	struct list_head list;
 	ktime_t starttime = ktime_get();
 
-	INIT_LIST_HEAD(&list);
 	mutex_lock(&dpm_list_mtx);
 	transition_started = false;
-	while (!list_empty(&dpm_list)) {
-		struct device *dev = to_device(dpm_list.next);
+	while (!list_empty(&dpm_noirq_list)) {
+		struct device *dev = to_device(dpm_noirq_list.next);
 
 		get_device(dev);
 		if (dev->power.status > DPM_OFF) {
@@ -499,10 +500,9 @@ void dpm_resume_noirq(pm_message_t state
 				pm_dev_err(dev, state, " early", error);
 		}
 		if (!list_empty(&dev->power.entry))
-			list_move_tail(&dev->power.entry, &list);
+			list_move_tail(&dev->power.entry, &dpm_suspended_list);
 		put_device(dev);
 	}
-	list_splice(&list, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
 	dpm_show_time(starttime, state, "early");
 	resume_device_irqs();
@@ -611,16 +611,14 @@ static bool is_async(struct device *dev)
  */
 static void dpm_resume(pm_message_t state)
 {
-	struct list_head list;
 	struct device *dev;
 	ktime_t starttime = ktime_get();
 
-	INIT_LIST_HEAD(&list);
 	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
 	async_error = 0;
 
-	list_for_each_entry(dev, &dpm_list, power.entry) {
+	list_for_each_entry(dev, &dpm_suspended_list, power.entry) {
 		if (dev->power.status < DPM_OFF)
 			continue;
 
@@ -631,8 +629,8 @@ static void dpm_resume(pm_message_t stat
 		}
 	}
 
-	while (!list_empty(&dpm_list)) {
-		dev = to_device(dpm_list.next);
+	while (!list_empty(&dpm_suspended_list)) {
+		dev = to_device(dpm_suspended_list.next);
 		get_device(dev);
 		if (dev->power.status >= DPM_OFF && !is_async(dev)) {
 			int error;
@@ -644,15 +642,11 @@ static void dpm_resume(pm_message_t stat
 			mutex_lock(&dpm_list_mtx);
 			if (error)
 				pm_dev_err(dev, state, "", error);
-		} else if (dev->power.status == DPM_SUSPENDING) {
-			/* Allow new children of the device to be registered */
-			dev->power.status = DPM_RESUMING;
 		}
 		if (!list_empty(&dev->power.entry))
-			list_move_tail(&dev->power.entry, &list);
+			list_move_tail(&dev->power.entry, &dpm_prepared_list);
 		put_device(dev);
 	}
-	list_splice(&list, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
 	dpm_show_time(starttime, state, NULL);
@@ -699,8 +693,8 @@ static void dpm_complete(pm_message_t st
 	INIT_LIST_HEAD(&list);
 	mutex_lock(&dpm_list_mtx);
 	transition_started = false;
-	while (!list_empty(&dpm_list)) {
-		struct device *dev = to_device(dpm_list.prev);
+	while (!list_empty(&dpm_prepared_list)) {
+		struct device *dev = to_device(dpm_prepared_list.prev);
 
 		get_device(dev);
 		if (dev->power.status > DPM_ON) {
@@ -803,15 +797,13 @@ End:
  */
 int dpm_suspend_noirq(pm_message_t state)
 {
-	struct list_head list;
 	ktime_t starttime = ktime_get();
 	int error = 0;
 
-	INIT_LIST_HEAD(&list);
 	suspend_device_irqs();
 	mutex_lock(&dpm_list_mtx);
-	while (!list_empty(&dpm_list)) {
-		struct device *dev = to_device(dpm_list.prev);
+	while (!list_empty(&dpm_suspended_list)) {
+		struct device *dev = to_device(dpm_suspended_list.prev);
 
 		get_device(dev);
 		mutex_unlock(&dpm_list_mtx);
@@ -826,10 +818,9 @@ int dpm_suspend_noirq(pm_message_t state
 		}
 		dev->power.status = DPM_OFF_IRQ;
 		if (!list_empty(&dev->power.entry))
-			list_move(&dev->power.entry, &list);
+			list_move(&dev->power.entry, &dpm_noirq_list);
 		put_device(dev);
 	}
-	list_splice_tail(&list, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
 	if (error)
 		dpm_resume_noirq(resume_event(state));
@@ -957,16 +948,14 @@ static int device_suspend(struct device
  */
 static int dpm_suspend(pm_message_t state)
 {
-	struct list_head list;
 	ktime_t starttime = ktime_get();
 	int error = 0;
 
-	INIT_LIST_HEAD(&list);
 	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
 	async_error = 0;
-	while (!list_empty(&dpm_list)) {
-		struct device *dev = to_device(dpm_list.prev);
+	while (!list_empty(&dpm_prepared_list)) {
+		struct device *dev = to_device(dpm_prepared_list.prev);
 
 		get_device(dev);
 		mutex_unlock(&dpm_list_mtx);
@@ -980,12 +969,11 @@ static int dpm_suspend(pm_message_t stat
 			break;
 		}
 		if (!list_empty(&dev->power.entry))
-			list_move(&dev->power.entry, &list);
+			list_move(&dev->power.entry, &dpm_suspended_list);
 		put_device(dev);
 		if (async_error)
 			break;
 	}
-	list_splice(&list, dpm_list.prev);
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
 	if (!error)
@@ -1044,10 +1032,8 @@ static int device_prepare(struct device
  */
 static int dpm_prepare(pm_message_t state)
 {
-	struct list_head list;
 	int error = 0;
 
-	INIT_LIST_HEAD(&list);
 	mutex_lock(&dpm_list_mtx);
 	transition_started = true;
 	while (!list_empty(&dpm_list)) {
@@ -1084,10 +1070,9 @@ static int dpm_prepare(pm_message_t stat
 		}
 		dev->power.status = DPM_SUSPENDING;
 		if (!list_empty(&dev->power.entry))
-			list_move_tail(&dev->power.entry, &list);
+			list_move_tail(&dev->power.entry, &dpm_prepared_list);
 		put_device(dev);
 	}
-	list_splice(&list, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
 	return error;
 }
