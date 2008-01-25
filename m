From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 1/5] PM: Export device_pm_schedule_removal
Date: Fri, 25 Jan 2008 01:30:25 +0100
Message-ID: <200801250130.26591.rjw@sisk.pl>
References: <200801250127.21966.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801250127.21966.rjw@sisk.pl>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Buesch <mb@bu3sch.de>, LKML <linux-kernel@vger.kernel.org>, Alessandro Rubini <rubini@vision.unipv.it>, pm list <linux-pm@lists.linux-foundation.org>, bcm43xx-dev@lists.berlios.de
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Move the declaration of device_pm_schedule_removal() to device.h
and make it exported, as it will be used directly by some drivers
for unregistering device objects during suspend/resume cycles in a
safe way.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c  |    1 +
 drivers/base/power/power.h |    1 -
 include/linux/device.h     |    6 ++++++
 3 files changed, 7 insertions(+), 1 deletion(-)

Index: linux-2.6.24-rc8-mm1/drivers/base/power/main.c
===================================================================
--- linux-2.6.24-rc8-mm1.orig/drivers/base/power/main.c
+++ linux-2.6.24-rc8-mm1/drivers/base/power/main.c
@@ -129,6 +129,7 @@ void device_pm_schedule_removal(struct d
 	list_move_tail(&dev->power.entry, &dpm_destroy);
 	mutex_unlock(&dpm_list_mtx);
 }
+EXPORT_SYMBOL_GPL(device_pm_schedule_removal);
 
 /**
  *	pm_sleep_lock - mutual exclusion for registration and suspend
Index: linux-2.6.24-rc8-mm1/include/linux/device.h
===================================================================
--- linux-2.6.24-rc8-mm1.orig/include/linux/device.h
+++ linux-2.6.24-rc8-mm1/include/linux/device.h
@@ -532,11 +532,17 @@ extern struct device *device_create(stru
 extern void device_destroy(struct class *cls, dev_t devt);
 #ifdef CONFIG_PM_SLEEP
 extern void destroy_suspended_device(struct class *cls, dev_t devt);
+extern void device_pm_schedule_removal(struct device *);
 #else /* !CONFIG_PM_SLEEP */
 static inline void destroy_suspended_device(struct class *cls, dev_t devt)
 {
 	device_destroy(cls, devt);
 }
+
+static inline void device_pm_schedule_removal(struct device *dev)
+{
+	device_unregister(dev);
+}
 #endif /* !CONFIG_PM_SLEEP */
 
 /*
Index: linux-2.6.24-rc8-mm1/drivers/base/power/power.h
===================================================================
--- linux-2.6.24-rc8-mm1.orig/drivers/base/power/power.h
+++ linux-2.6.24-rc8-mm1/drivers/base/power/power.h
@@ -13,7 +13,6 @@ static inline struct device *to_device(s
 
 extern void device_pm_add(struct device *);
 extern void device_pm_remove(struct device *);
-extern void device_pm_schedule_removal(struct device *);
 extern int pm_sleep_lock(void);
 extern void pm_sleep_unlock(void);
 
