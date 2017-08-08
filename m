From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/2] PM / sleep: Export the setting of pm_debug_messages_on
Date: Tue,  8 Aug 2017 15:41:14 -0700
Message-ID: <1502232075-23832-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1502232075-23832-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1502232075-23832-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, mario.limonciello@dell.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lukas@wunner.de, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Added a function to export the value of pm_debug_messages_on, so that
other parts of the system can use this flag to enable/disable executing
PM debug code.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 include/linux/suspend.h | 6 ++++++
 kernel/power/main.c     | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 8c3b0b1..5d4b3a3 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -496,6 +496,10 @@ static inline void unlock_system_sleep(void) {}
 #ifdef CONFIG_PM_SLEEP_DEBUG
 extern bool pm_print_times_enabled;
 extern __printf(2, 3) void __pm_pr_dbg(bool defer, const char *fmt, ...);
+
+/* Return the value of pm_debug_messages_on */
+bool pm_debug_messages_enabled(void);
+
 #else
 #define pm_print_times_enabled	(false)
 
@@ -503,6 +507,8 @@ extern __printf(2, 3) void __pm_pr_dbg(bool defer, const char *fmt, ...);
 
 #define __pm_pr_dbg(defer, fmt, ...) \
 	no_printk(KERN_DEBUG fmt, ##__VA_ARGS__)
+
+static inline bool pm_debug_messages_enabled(void) { return false; }
 #endif
 
 #define pm_pr_dbg(fmt, ...) \
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 3074ea4..afb7f00 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -363,6 +363,11 @@ power_attr_ro(pm_wakeup_irq);
 
 static bool pm_debug_messages_on __read_mostly;
 
+bool pm_debug_messages_enabled(void)
+{
+	return pm_debug_messages_on;
+}
+
 static ssize_t pm_debug_messages_show(struct kobject *kobj,
 				      struct kobj_attribute *attr, char *buf)
 {
-- 
2.7.5

