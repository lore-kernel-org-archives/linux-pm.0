From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM: make wakeup flags available whenever
	CONFIG_PM is set
Date: Mon, 10 Mar 2008 14:44:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803101436100.5082-100000@iolanthe.rowland.org>
References: <200803101606.37723.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803101606.37723.rjw@sisk.pl>
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

The various wakeup flags and their accessor macros in struct
dev_pm_info should be available whenever CONFIG_PM is enabled, not
just when CONFIG_PM_SLEEP is on.  Otherwise remote wakeup won't always
be configurable for runtime power management.  This patch (as1056)
fixes the oversight.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: David Brownell <david-b@pacbell.net>

---

Index: usb-2.6/include/linux/pm.h
===================================================================
--- usb-2.6.orig/include/linux/pm.h
+++ usb-2.6/include/linux/pm.h
@@ -183,8 +183,8 @@ typedef struct pm_message {
 struct dev_pm_info {
 	pm_message_t		power_state;
 	unsigned		can_wakeup:1;
-#ifdef	CONFIG_PM_SLEEP
 	unsigned		should_wakeup:1;
+#ifdef	CONFIG_PM_SLEEP
 	struct list_head	entry;
 #endif
 };
@@ -197,11 +197,6 @@ extern void device_resume(void);
 extern int device_suspend(pm_message_t state);
 extern int device_prepare_suspend(pm_message_t state);
 
-#define device_set_wakeup_enable(dev,val) \
-	((dev)->power.should_wakeup = !!(val))
-#define device_may_wakeup(dev) \
-	(device_can_wakeup(dev) && (dev)->power.should_wakeup)
-
 extern void __suspend_report_result(const char *function, void *fn, int ret);
 
 #define suspend_report_result(fn, ret)					\
@@ -209,6 +204,35 @@ extern void __suspend_report_result(cons
 		__suspend_report_result(__FUNCTION__, fn, ret);		\
 	} while (0)
 
+#else /* !CONFIG_PM_SLEEP */
+
+static inline int device_suspend(pm_message_t state)
+{
+	return 0;
+}
+
+#define suspend_report_result(fn, ret) 		do {} while (0)
+
+#endif /* !CONFIG_PM_SLEEP */
+
+#ifdef CONFIG_PM
+
+/* changes to device_may_wakeup take effect on the next pm state change.
+ * by default, devices should wakeup if they can.
+ */
+#define device_can_wakeup(dev) \
+	((dev)->power.can_wakeup)
+#define device_init_wakeup(dev,val) \
+	do { \
+		device_can_wakeup(dev) = !!(val); \
+		device_set_wakeup_enable(dev,val); \
+	} while(0)
+
+#define device_set_wakeup_enable(dev,val) \
+	((dev)->power.should_wakeup = !!(val))
+#define device_may_wakeup(dev) \
+	(device_can_wakeup(dev) && (dev)->power.should_wakeup)
+
 /*
  * Platform hook to activate device wakeup capability, if that's not already
  * handled by enable_irq_wake() etc.
@@ -223,35 +247,19 @@ static inline int call_platform_enable_w
 	return 0;
 }
 
-#else /* !CONFIG_PM_SLEEP */
-
-static inline int device_suspend(pm_message_t state)
-{
-	return 0;
-}
-
-#define device_set_wakeup_enable(dev,val)	do{}while(0)
-#define device_may_wakeup(dev)			(0)
+#else /* !CONFIG_PM */
 
-#define suspend_report_result(fn, ret) do { } while (0)
+#define device_can_wakeup(dev)			0
+#define device_init_wakeup(dev,val)		do {} while (0)
+#define device_set_wakeup_enable(dev,val)	do {} while (0)
+#define device_may_wakeup(dev)			0
 
 static inline int call_platform_enable_wakeup(struct device *dev, int is_on)
 {
 	return 0;
 }
 
-#endif /* !CONFIG_PM_SLEEP */
-
-/* changes to device_may_wakeup take effect on the next pm state change.
- * by default, devices should wakeup if they can.
- */
-#define device_can_wakeup(dev) \
-	((dev)->power.can_wakeup)
-#define device_init_wakeup(dev,val) \
-	do { \
-		device_can_wakeup(dev) = !!(val); \
-		device_set_wakeup_enable(dev,val); \
-	} while(0)
+#endif /* !CONFIG_PM */
 
 /*
  * Global Power Management flags
Index: usb-2.6/drivers/base/power/main.c
===================================================================
--- usb-2.6.orig/drivers/base/power/main.c
+++ usb-2.6/drivers/base/power/main.c
@@ -56,8 +56,6 @@ static DEFINE_MUTEX(dpm_list_mtx);
 
 static DECLARE_RWSEM(pm_sleep_rwsem);
 
-int (*platform_enable_wakeup)(struct device *dev, int is_on);
-
 /**
  *	device_pm_add - add a device to the list of active devices
  *	@dev:	Device to be added to the list
Index: usb-2.6/drivers/base/power/sysfs.c
===================================================================
--- usb-2.6.orig/drivers/base/power/sysfs.c
+++ usb-2.6/drivers/base/power/sysfs.c
@@ -6,6 +6,8 @@
 #include <linux/string.h>
 #include "power.h"
 
+int (*platform_enable_wakeup)(struct device *dev, int is_on);
+
 
 /*
  *	wakeup - Report/change current wakeup option for device
