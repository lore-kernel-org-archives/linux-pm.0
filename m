From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM: Use dev_name() in core device suspend and
	resume routines
Date: Thu, 16 Dec 2010 01:05:04 +0100
Message-ID: <201012160105.04833.rjw__22975.4485925243$1292458077$gmane$org@sisk.pl>
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

Use dev_name() wherever applicable in drivers/base/power/main.c.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |   25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -88,8 +88,7 @@ void device_pm_unlock(void)
 void device_pm_add(struct device *dev)
 {
 	pr_debug("PM: Adding info for %s:%s\n",
-		 dev->bus ? dev->bus->name : "No Bus",
-		 kobject_name(&dev->kobj));
+		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
 	mutex_lock(&dpm_list_mtx);
 	if (dev->parent && dev->parent->power.in_suspend)
 		dev_warn(dev, "parent %s should not be sleeping\n",
@@ -105,8 +104,7 @@ void device_pm_add(struct device *dev)
 void device_pm_remove(struct device *dev)
 {
 	pr_debug("PM: Removing info for %s:%s\n",
-		 dev->bus ? dev->bus->name : "No Bus",
-		 kobject_name(&dev->kobj));
+		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
 	complete_all(&dev->power.completion);
 	mutex_lock(&dpm_list_mtx);
 	list_del_init(&dev->power.entry);
@@ -123,10 +121,8 @@ void device_pm_remove(struct device *dev
 void device_pm_move_before(struct device *deva, struct device *devb)
 {
 	pr_debug("PM: Moving %s:%s before %s:%s\n",
-		 deva->bus ? deva->bus->name : "No Bus",
-		 kobject_name(&deva->kobj),
-		 devb->bus ? devb->bus->name : "No Bus",
-		 kobject_name(&devb->kobj));
+		 deva->bus ? deva->bus->name : "No Bus", dev_name(deva),
+		 devb->bus ? devb->bus->name : "No Bus", dev_name(devb));
 	/* Delete deva from dpm_list and reinsert before devb. */
 	list_move_tail(&deva->power.entry, &devb->power.entry);
 }
@@ -139,10 +135,8 @@ void device_pm_move_before(struct device
 void device_pm_move_after(struct device *deva, struct device *devb)
 {
 	pr_debug("PM: Moving %s:%s after %s:%s\n",
-		 deva->bus ? deva->bus->name : "No Bus",
-		 kobject_name(&deva->kobj),
-		 devb->bus ? devb->bus->name : "No Bus",
-		 kobject_name(&devb->kobj));
+		 deva->bus ? deva->bus->name : "No Bus", dev_name(deva),
+		 devb->bus ? devb->bus->name : "No Bus", dev_name(devb));
 	/* Delete deva from dpm_list and reinsert after devb. */
 	list_move(&deva->power.entry, &devb->power.entry);
 }
@@ -154,8 +148,7 @@ void device_pm_move_after(struct device
 void device_pm_move_last(struct device *dev)
 {
 	pr_debug("PM: Moving %s:%s to end of list\n",
-		 dev->bus ? dev->bus->name : "No Bus",
-		 kobject_name(&dev->kobj));
+		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
 	list_move_tail(&dev->power.entry, &dpm_list);
 }
 
@@ -393,7 +386,7 @@ static void pm_dev_err(struct device *de
 			int error)
 {
 	printk(KERN_ERR "PM: Device %s failed to %s%s: error %d\n",
-		kobject_name(&dev->kobj), pm_verb(state.event), info, error);
+		dev_name(dev), pm_verb(state.event), info, error);
 }
 
 static void dpm_show_time(ktime_t starttime, pm_message_t state, char *info)
@@ -1028,7 +1021,7 @@ static int dpm_prepare(pm_message_t stat
 			}
 			printk(KERN_INFO "PM: Device %s not prepared "
 				"for power transition: code %d\n",
-				kobject_name(&dev->kobj), error);
+				dev_name(dev), error);
 			put_device(dev);
 			break;
 		}
