From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC][Patch 1/3] Add device_pm_move_*() API.
Date: Tue, 3 Mar 2009 11:21:00 +0100
Message-ID: <20090303112100.41c0bcde@gondolin>
References: <20090224165311.5d103b67@gondolin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090224165311.5d103b67@gondolin>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, "Rafael J.
	Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Marcel Holtmann <marcel@>
List-Id: linux-pm@vger.kernel.org

dpm_list currently relies on the fact that child devices will
be registered after their parents to get a correct suspend
order. However, using device_move() destroys this assumption, as
an already registered device may be moved under a newly registered
one.

This problem was discussed in the thread starting at
https://lists.linux-foundation.org/pipermail/linux-pm/2007-July/014428.html
The consensus seemed to be that it would be best if drivers
were offered a set of function for manipulating dpm_list.

This patch does the following:
- Export device_pm_{lock,unlock} so that drivers may lock the
  dpm_list in order to avoid races.
- Introduce device_pm_move_*() functions that manipulate dpm_list.
  Those function must be called with the dpm_list mutex held.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/core.c       |    4 ++
 drivers/base/power/main.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm.h        |   19 ++++++++++++
 3 files changed, 91 insertions(+)

--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -32,6 +32,9 @@
  * because children are guaranteed to be discovered after parents, and
  * are inserted at the back of the list on discovery.
  *
+ * However, since device_move() destroys this assumption, callers
+ * need to fix up the dpm_list if they use device_move().
+ *
  * Since device_pm_add() may be called with a device semaphore held,
  * we must never try to acquire a device semaphore while holding
  * dpm_list_mutex.
@@ -54,6 +57,7 @@ void device_pm_lock(void)
 {
 	mutex_lock(&dpm_list_mtx);
 }
+EXPORT_SYMBOL_GPL(device_pm_lock);
 
 /**
  *	device_pm_unlock - unlock the list of active devices used by the PM core
@@ -62,6 +66,7 @@ void device_pm_unlock(void)
 {
 	mutex_unlock(&dpm_list_mtx);
 }
+EXPORT_SYMBOL_GPL(device_pm_unlock);
 
 /**
  *	device_pm_add - add a device to the list of active devices
@@ -107,6 +112,69 @@ void device_pm_remove(struct device *dev
 }
 
 /**
+ *	device_pm_move_before - move device in dpm_list
+ *	@deva:	Device to move in dpm_list
+ *	@devb:	Device @deva should come before
+ *
+ *	The purpose of this function is to allow reordering of
+ *	dpm_list after calling device_move().
+ *	Callers need to hold the dpm_list mutex.
+ */
+void device_pm_move_before(struct device *deva, struct device *devb)
+{
+	BUG_ON(!mutex_is_locked(&dpm_list_mtx));
+	pr_debug("PM: Moving %s:%s before %s:%s\n",
+		 deva->bus ? deva->bus->name : "No Bus",
+		 kobject_name(&deva->kobj),
+		 devb->bus ? devb->bus->name : "No Bus",
+		 kobject_name(&devb->kobj));
+	/* Delete deva from dpm_list and reinsert before devb. */
+	list_move_tail(&deva->power.entry, &devb->power.entry);
+}
+EXPORT_SYMBOL_GPL(device_pm_move_before);
+
+/**
+ *	device_pm_move_after - move device in dpm_list
+ *	@deva:	Device to move in dpm_list
+ *	@devb:	Device @deva should come after
+ *
+ *	The purpose of this function is to allow reordering of
+ *	dpm_list after calling device_move().
+ *	Callers need to hold the dpm_list mutex.
+ */
+void device_pm_move_after(struct device *deva, struct device *devb)
+{
+	BUG_ON(!mutex_is_locked(&dpm_list_mtx));
+	pr_debug("PM: Moving %s:%s after %s:%s\n",
+		 deva->bus ? deva->bus->name : "No Bus",
+		 kobject_name(&deva->kobj),
+		 devb->bus ? devb->bus->name : "No Bus",
+		 kobject_name(&devb->kobj));
+	/* Delete deva from dpm_list and reinsert after devb. */
+	list_move(&deva->power.entry, &devb->power.entry);
+}
+EXPORT_SYMBOL_GPL(device_pm_move_after);
+
+/**
+ *	device_pm_move_last - move device to end of dpm_list
+ *	@dev:	Device to move in dpm_list
+ *
+ *	The purpose of this function is to allow reordering of
+ *	dpm_list after calling device_move().
+ *	Callers need to hold the dpm_list mutex.
+ *	@dev must not have any children.
+ */
+void device_pm_move_last(struct device *dev)
+{
+	BUG_ON(!mutex_is_locked(&dpm_list_mtx));
+	pr_debug("PM: Moving %s:%s to end of list\n",
+		 dev->bus ? dev->bus->name : "No Bus",
+		 kobject_name(&dev->kobj));
+	list_move(&dev->power.entry, &dpm_list);
+}
+EXPORT_SYMBOL_GPL(device_pm_move_last);
+
+/**
  *	pm_op - execute the PM operation appropiate for given PM event
  *	@dev:	Device.
  *	@ops:	PM operations to choose from.
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -398,15 +398,34 @@ extern void __suspend_report_result(cons
 		__suspend_report_result(__func__, fn, ret);		\
 	} while (0)
 
+extern void device_pm_move_before(struct device *deva, struct device *devb);
+extern void device_pm_move_after(struct device *deva, struct device *devb);
+extern void device_pm_move_last(struct device *dev);
 #else /* !CONFIG_PM_SLEEP */
 
+#define device_pm_lock() do {} while (0)
 static inline int device_suspend(pm_message_t state)
 {
 	return 0;
 }
 
+#define device_pm_unlock() do {} while (0)
+
 #define suspend_report_result(fn, ret)		do {} while (0)
 
+static inline void device_pm_move_before(struct device *deva,
+					 struct device *devb)
+{
+}
+
+static inline void device_pm_move_after(struct device *deva,
+					struct device *devb)
+{
+}
+
+static inline void device_pm_move_last(struct device *dev)
+{
+}
 #endif /* !CONFIG_PM_SLEEP */
 
 /*
--- linux-2.6.orig/drivers/base/core.c
+++ linux-2.6/drivers/base/core.c
@@ -1563,6 +1563,10 @@ out:
  * device_move - moves a device to a new parent
  * @dev: the pointer to the struct device to be moved
  * @new_parent: the new parent of the device (can by NULL)
+ *
+ * Note: device_move() does not change the ancestral order as reflected
+ * in dpm_list; you will need to do it yourself using the device_pm_move_*
+ * functions.
  */
 int device_move(struct device *dev, struct device *new_parent)
 {
