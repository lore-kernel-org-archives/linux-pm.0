From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 2/2] PM: fix async resume following suspend
	failure
Date: Fri, 17 Jun 2011 16:08:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106171606430.2143-100000@iolanthe.rowland.org>
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

The PM core doesn't handle suspend failures correctly when it comes to
asynchronously suspended devices.  These devices are moved onto the
dpm_suspended_list as soon as the corresponding async thread is
started up, and they remain on the list even if they fail to suspend
or the sleep transition is cancelled before they get suspended.  As a
result, when the PM core unwinds the transition, it tries to resume
the devices even though they were never suspended.

This patch (as1474) fixes the problem by adding a new "is_suspended"
flag to dev_pm_info.  Devices are resumed only if the flag is set.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Rafael, you may want these two patches to go into the stable kernels.  
I'll leave that decision to you.



 drivers/base/power/main.c |    8 +++++---
 include/linux/pm.h        |    1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

Index: usb-3.0/include/linux/pm.h
===================================================================
--- usb-3.0.orig/include/linux/pm.h
+++ usb-3.0/include/linux/pm.h
@@ -426,6 +426,7 @@ struct dev_pm_info {
 	unsigned int		can_wakeup:1;
 	unsigned int		async_suspend:1;
 	bool			is_prepared:1;	/* Owned by the PM core */
+	bool			is_suspended:1;	/* Ditto */
 	spinlock_t		lock;
 #ifdef CONFIG_PM_SLEEP
 	struct list_head	entry;
Index: usb-3.0/drivers/base/power/main.c
===================================================================
--- usb-3.0.orig/drivers/base/power/main.c
+++ usb-3.0/drivers/base/power/main.c
@@ -57,7 +57,7 @@ static int async_error;
  */
 void device_pm_init(struct device *dev)
 {
-	dev->power.is_prepared = false;
+	dev->power.is_prepared = dev->power.is_suspended = false;
 	init_completion(&dev->power.completion);
 	complete_all(&dev->power.completion);
 	dev->power.wakeup = NULL;
@@ -552,6 +552,7 @@ static int device_resume(struct device *
 	}
 
  End:
+	dev->power.is_suspended = false;
 	device_unlock(dev);
 	complete_all(&dev->power.completion);
 
@@ -596,7 +597,7 @@ void dpm_resume(pm_message_t state)
 
 	list_for_each_entry(dev, &dpm_suspended_list, power.entry) {
 		INIT_COMPLETION(dev->power.completion);
-		if (is_async(dev)) {
+		if (is_async(dev) && dev->power.is_suspended) {
 			get_device(dev);
 			async_schedule(async_resume, dev);
 		}
@@ -605,7 +606,7 @@ void dpm_resume(pm_message_t state)
 	while (!list_empty(&dpm_suspended_list)) {
 		dev = to_device(dpm_suspended_list.next);
 		get_device(dev);
-		if (!is_async(dev)) {
+		if (!is_async(dev) && dev->power.is_suspended) {
 			int error;
 
 			mutex_unlock(&dpm_list_mtx);
@@ -881,6 +882,7 @@ static int __device_suspend(struct devic
 	}
 
  End:
+	dev->power.is_suspended = !error;
 	device_unlock(dev);
 	complete_all(&dev->power.completion);
 
