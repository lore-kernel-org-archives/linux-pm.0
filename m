From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 1/2] PM: Remove pm_parent from dev_pm_info
Date: Sat, 9 Jun 2007 23:31:21 +0200
Message-ID: <200706092331.22140.rjw@sisk.pl>
References: <200706092329.08166.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706092329.08166.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The pm_parent member of struct dev_pm_info (defined in include/linux/pm.h) is
only used to check if the device's parent is in the right state while the
device is being suspended or resumed.  However, this can be done just as well
with the help of the parent pointer in struct device, so pm_parent can be
removed along with some code that handles it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 drivers/base/power/main.c    |   36 ++++++++++--------------------------
 drivers/base/power/resume.c  |    7 +++----
 drivers/base/power/suspend.c |    7 +++----
 include/linux/pm.h           |    3 ---
 4 files changed, 16 insertions(+), 37 deletions(-)

Index: linux-2.6.22-rc4/drivers/base/power/main.c
===================================================================
--- linux-2.6.22-rc4.orig/drivers/base/power/main.c	2007-06-08 13:09:16.000000000 +0200
+++ linux-2.6.22-rc4/drivers/base/power/main.c	2007-06-09 22:19:44.000000000 +0200
@@ -31,28 +31,7 @@ DEFINE_MUTEX(dpm_list_mtx);
 
 int (*platform_enable_wakeup)(struct device *dev, int is_on);
 
-
-/**
- *	device_pm_set_parent - Specify power dependency.
- *	@dev:		Device who needs power.
- *	@parent:	Device that supplies power.
- *
- *	This function is used to manually describe a power-dependency
- *	relationship. It may be used to specify a transversal relationship
- *	(where the power supplier is not the physical (or electrical)
- *	ancestor of a specific device.
- *	The effect of this is that the supplier will not be powered down
- *	before the power dependent.
- */
-
-void device_pm_set_parent(struct device * dev, struct device * parent)
-{
-	put_device(dev->power.pm_parent);
-	dev->power.pm_parent = get_device(parent);
-}
-EXPORT_SYMBOL_GPL(device_pm_set_parent);
-
-int device_pm_add(struct device * dev)
+int device_pm_add(struct device *dev)
 {
 	int error;
 
@@ -61,21 +40,26 @@ int device_pm_add(struct device * dev)
 		 kobject_name(&dev->kobj));
 	mutex_lock(&dpm_list_mtx);
 	list_add_tail(&dev->power.entry, &dpm_active);
-	device_pm_set_parent(dev, dev->parent);
-	if ((error = dpm_sysfs_add(dev)))
+	/*
+	 * The device's parent must not be released until the device itself is
+	 * removed from the dpm_active list.
+	 */
+	get_device(dev->parent);
+	error = dpm_sysfs_add(dev);
+	if (error)
 		list_del(&dev->power.entry);
 	mutex_unlock(&dpm_list_mtx);
 	return error;
 }
 
-void device_pm_remove(struct device * dev)
+void device_pm_remove(struct device *dev)
 {
 	pr_debug("PM: Removing info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus",
 		 kobject_name(&dev->kobj));
 	mutex_lock(&dpm_list_mtx);
 	dpm_sysfs_remove(dev);
-	put_device(dev->power.pm_parent);
+	put_device(dev->parent);
 	list_del_init(&dev->power.entry);
 	mutex_unlock(&dpm_list_mtx);
 }
Index: linux-2.6.22-rc4/drivers/base/power/resume.c
===================================================================
--- linux-2.6.22-rc4.orig/drivers/base/power/resume.c	2007-06-08 13:09:16.000000000 +0200
+++ linux-2.6.22-rc4/drivers/base/power/resume.c	2007-06-09 21:12:43.000000000 +0200
@@ -29,12 +29,11 @@ int resume_device(struct device * dev)
 
 	down(&dev->sem);
 
-	if (dev->power.pm_parent
-			&& dev->power.pm_parent->power.power_state.event) {
+	if (dev->parent && dev->parent->power.power_state.event) {
 		dev_err(dev, "PM: resume from %d, parent %s still %d\n",
 			dev->power.power_state.event,
-			dev->power.pm_parent->bus_id,
-			dev->power.pm_parent->power.power_state.event);
+			dev->parent->bus_id,
+			dev->parent->power.power_state.event);
 	}
 
 	if (dev->bus && dev->bus->resume) {
Index: linux-2.6.22-rc4/drivers/base/power/suspend.c
===================================================================
--- linux-2.6.22-rc4.orig/drivers/base/power/suspend.c	2007-06-08 13:09:16.000000000 +0200
+++ linux-2.6.22-rc4/drivers/base/power/suspend.c	2007-06-09 21:12:40.000000000 +0200
@@ -55,13 +55,12 @@ int suspend_device(struct device * dev, 
 		dev_dbg(dev, "PM: suspend %d-->%d\n",
 			dev->power.power_state.event, state.event);
 	}
-	if (dev->power.pm_parent
-			&& dev->power.pm_parent->power.power_state.event) {
+	if (dev->parent && dev->parent->power.power_state.event) {
 		dev_err(dev,
 			"PM: suspend %d->%d, parent %s already %d\n",
 			dev->power.power_state.event, state.event,
-			dev->power.pm_parent->bus_id,
-			dev->power.pm_parent->power.power_state.event);
+			dev->parent->bus_id,
+			dev->parent->power.power_state.event);
 	}
 
 	dev->power.prev_state = dev->power.power_state;
Index: linux-2.6.22-rc4/include/linux/pm.h
===================================================================
--- linux-2.6.22-rc4.orig/include/linux/pm.h	2007-06-08 13:09:17.000000000 +0200
+++ linux-2.6.22-rc4/include/linux/pm.h	2007-06-09 21:12:45.000000000 +0200
@@ -237,13 +237,10 @@ struct dev_pm_info {
 	unsigned		should_wakeup:1;
 	pm_message_t		prev_state;
 	void			* saved_state;
-	struct device		* pm_parent;
 	struct list_head	entry;
 #endif
 };
 
-extern void device_pm_set_parent(struct device * dev, struct device * parent);
-
 extern int device_power_down(pm_message_t state);
 extern void device_power_up(void);
 extern void device_resume(void);
