From: Len Brown <lenb@kernel.org>
Subject: [PATCH] PM: ACPI and APM must not be enabled at the same
	time
Date: Sun, 20 May 2007 00:42:43 -0400
Message-ID: <200705200042.43535.lenb__22589.1878399581$1179636329$gmane$org@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, "Robert P. J. Day" <rpjday@mindspring.com>
List-Id: linux-pm@vger.kernel.org

ACPI and APM used "pm_active" to guarantee that
they would not be simultaneously active.

But pm_active was recently moved under CONFIG_PM_LEGACY,
so that without CONFIG_PM_LEGACY, pm_active became a NOP --
allowing ACPI and APM to both be simultaneously enabled.
This caused unpredictable results, including boot hangs.

Further, the code under CONFIG_PM_LEGACY is scheduled
for removal.

So replace pm_active with pm_flags.
pm_flags depends only on CONFIG_PM,
which is present for both CONFIG_APM and CONFIG_ACPI.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/i386/kernel/apm.c    |   10 +++-------
 drivers/acpi/bus.c        |    7 ++-----
 include/linux/pm.h        |    9 +++++++++
 include/linux/pm_legacy.h |    6 ------
 kernel/power/main.c       |    3 +++
 kernel/power/pm.c         |    4 ----
 6 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
index 4112afe..3afa20d 100644
--- a/arch/i386/kernel/apm.c
+++ b/arch/i386/kernel/apm.c
@@ -2255,14 +2255,12 @@ static int __init apm_init(void)
 		apm_info.disabled = 1;
 		return -ENODEV;
 	}
-	if (PM_IS_ACTIVE()) {
+	if (pm_flags & PM_ACPI) {
 		printk(KERN_NOTICE "apm: overridden by ACPI.\n");
 		apm_info.disabled = 1;
 		return -ENODEV;
 	}
-#ifdef CONFIG_PM_LEGACY
-	pm_active = 1;
-#endif
+	pm_flags |= PM_APM;
 
 	/*
 	 * Set up a segment that references the real mode segment 0x40
@@ -2366,9 +2364,7 @@ static void __exit apm_exit(void)
 		kthread_stop(kapmd_task);
 		kapmd_task = NULL;
 	}
-#ifdef CONFIG_PM_LEGACY
-	pm_active = 0;
-#endif
+	pm_flags &= ~PM_APM;
 }
 
 module_init(apm_init);
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index e5084ec..064998c 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -29,7 +29,6 @@
 #include <linux/list.h>
 #include <linux/sched.h>
 #include <linux/pm.h>
-#include <linux/pm_legacy.h>
 #include <linux/device.h>
 #include <linux/proc_fs.h>
 #ifdef CONFIG_X86
@@ -755,16 +754,14 @@ static int __init acpi_init(void)
 	result = acpi_bus_init();
 
 	if (!result) {
-#ifdef CONFIG_PM_LEGACY
-		if (!PM_IS_ACTIVE())
-			pm_active = 1;
+		if (!(pm_flags & PM_APM))
+			pm_flags |= PM_ACPI;
 		else {
 			printk(KERN_INFO PREFIX
 			       "APM is already active, exiting\n");
 			disable_acpi();
 			result = -ENODEV;
 		}
-#endif
 	} else
 		disable_acpi();
 
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 87545e0..c35f2fc 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -319,6 +319,15 @@ static inline int call_platform_enable_wakeup(struct device *dev, int is_on)
 		device_set_wakeup_enable(dev,val); \
 	} while(0)
 
+/*
+ * Global Power Management flags
+ * Used to keep APM and ACPI from both being active
+ */
+extern unsigned int	pm_flags;
+
+#define PM_APM	1
+#define PM_ACPI	2
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_PM_H */
diff --git a/include/linux/pm_legacy.h b/include/linux/pm_legacy.h
index 514729a..446f4f4 100644
--- a/include/linux/pm_legacy.h
+++ b/include/linux/pm_legacy.h
@@ -4,10 +4,6 @@
 
 #ifdef CONFIG_PM_LEGACY
 
-extern int pm_active;
-
-#define PM_IS_ACTIVE() (pm_active != 0)
-
 /*
  * Register a device with power management
  */
@@ -21,8 +17,6 @@ int __deprecated pm_send_all(pm_request_t rqst, void *data);
 
 #else /* CONFIG_PM_LEGACY */
 
-#define PM_IS_ACTIVE() 0
-
 static inline struct pm_dev *pm_register(pm_dev_t type,
 					 unsigned long id,
 					 pm_callback callback)
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 8812985..0c02ac3 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -29,6 +29,9 @@
 
 DEFINE_MUTEX(pm_mutex);
 
+unsigned int pm_flags;
+EXPORT_SYMBOL(pm_flags);
+
 struct pm_ops *pm_ops;
 
 /**
diff --git a/kernel/power/pm.c b/kernel/power/pm.c
index c50d152..60c73fa 100644
--- a/kernel/power/pm.c
+++ b/kernel/power/pm.c
@@ -27,8 +27,6 @@
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
 
-int pm_active;
-
 /*
  *	Locking notes:
  *		pm_devs_lock can be a semaphore providing pm ops are not called
@@ -204,6 +202,4 @@ int pm_send_all(pm_request_t rqst, void *data)
 
 EXPORT_SYMBOL(pm_register);
 EXPORT_SYMBOL(pm_send_all);
-EXPORT_SYMBOL(pm_active);
-
 
