From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 2/4] ACPI: ac: Add acpi_ac_unregister() function
Date: Mon, 20 Mar 2017 14:21:48 +0100
Message-ID: <20170320132150.18771-2-hdegoede@redhat.com>
References: <20170320132150.18771-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170320132150.18771-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On some systems we have a native PMIC driver which provides Mains
monitoring, while the ACPI ac driver is broken on these systems
due to bad DSTDs or because of missing vendor specific ACPI opregion
(e.g. BMOP opregion) support, which the ACPI ac device in the dsdt
relies on. This leads for example to a ADP1 power_supply which reports
itself as always online even if no mains are connected.

This commit adds an acpi_ac_unregister() function which native PMIC
drivers can call after successfully registering their own power_supply
to unregister the (potentially broken) ACPI-ac power_supply.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Fix capitalization in commit msg
-Minor style cleanups
---
 drivers/acpi/ac.c          | 43 ++++++++++++++++++++++++++++++++++++++-----
 include/linux/power/acpi.h |  6 ++++++
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index f71b756..b42affb 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -26,11 +26,13 @@
 #include <linux/types.h>
 #include <linux/dmi.h>
 #include <linux/delay.h>
+#include <linux/mutex.h>
 #ifdef CONFIG_ACPI_PROCFS_POWER
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #endif
 #include <linux/platform_device.h>
+#include <linux/power/acpi.h>
 #include <linux/power_supply.h>
 #include <linux/acpi.h>
 #include "battery.h"
@@ -422,17 +424,27 @@ static int acpi_ac_remove(struct acpi_device *device)
 	return 0;
 }
 
+enum init_state_enum { AC_NONE, AC_INITIALIZED, AC_EXITED };
+
+static enum init_state_enum init_state;
+static DEFINE_MUTEX(init_state_mutex);
+
 static int __init acpi_ac_init(void)
 {
-	int result;
+	int result, ret = -ENODEV;
 
 	if (acpi_disabled)
 		return -ENODEV;
 
+	/* Check if acpi_ac_unregister() got called before _init() */
+	mutex_lock(&init_state_mutex);
+	if (init_state != AC_NONE)
+		goto out_unlock;
+
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_ac_dir = acpi_lock_ac_dir();
 	if (!acpi_ac_dir)
-		return -ENODEV;
+		goto out_unlock;
 #endif
 
 
@@ -441,18 +453,39 @@ static int __init acpi_ac_init(void)
 #ifdef CONFIG_ACPI_PROCFS_POWER
 		acpi_unlock_ac_dir(acpi_ac_dir);
 #endif
-		return -ENODEV;
+		goto out_unlock;
 	}
 
-	return 0;
+	init_state = AC_INITIALIZED;
+	ret = 0;
+
+out_unlock:
+	mutex_unlock(&init_state_mutex);
+	return ret;
 }
 
-static void __exit acpi_ac_exit(void)
+void acpi_ac_unregister(void)
 {
+	/* Check if _init() is done and only do unregister once */
+	mutex_lock(&init_state_mutex);
+	if (init_state != AC_INITIALIZED)
+		goto out_exit;
+
 	acpi_bus_unregister_driver(&acpi_ac_driver);
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_unlock_ac_dir(acpi_ac_dir);
 #endif
+
+out_exit:
+	init_state = AC_EXITED;
+	mutex_unlock(&init_state_mutex);
 }
+EXPORT_SYMBOL_GPL(acpi_ac_unregister);
+
+static void __exit acpi_ac_exit(void)
+{
+	acpi_ac_unregister();
+}
+
 module_init(acpi_ac_init);
 module_exit(acpi_ac_exit);
diff --git a/include/linux/power/acpi.h b/include/linux/power/acpi.h
index 83bdfb9..b50ae69 100644
--- a/include/linux/power/acpi.h
+++ b/include/linux/power/acpi.h
@@ -15,4 +15,10 @@ void acpi_battery_unregister(void);
 static inline void acpi_battery_unregister(void) {}
 #endif
 
+#if IS_ENABLED(CONFIG_ACPI_AC)
+void acpi_ac_unregister(void);
+#else
+static inline void acpi_ac_unregister(void) {}
+#endif
+
 #endif
-- 
2.9.3

