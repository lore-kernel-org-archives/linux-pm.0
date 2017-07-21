From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / sleep: Put pm_test under CONFIG_PM_SLEEP_DEBUG
Date: Fri, 21 Jul 2017 14:44:02 +0200
Message-ID: <4416493.C4EHevmRhr@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The pm_test sysfs attribute is under CONFIG_PM_DEBUG, but it doesn't
make sense to provide it if CONFIG_PM_SLEEP is unset, so put it under
CONFIG_PM_SLEEP_DEBUG instead.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/main.c  |    8 +++-----
 kernel/power/power.h |    2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

Index: linux-pm/kernel/power/main.c
===================================================================
--- linux-pm.orig/kernel/power/main.c
+++ linux-pm/kernel/power/main.c
@@ -150,7 +150,7 @@ static ssize_t mem_sleep_store(struct ko
 power_attr(mem_sleep);
 #endif /* CONFIG_SUSPEND */
 
-#ifdef CONFIG_PM_DEBUG
+#ifdef CONFIG_PM_SLEEP_DEBUG
 int pm_test_level = TEST_NONE;
 
 static const char * const pm_tests[__TEST_AFTER_LAST] = {
@@ -211,7 +211,7 @@ static ssize_t pm_test_store(struct kobj
 }
 
 power_attr(pm_test);
-#endif /* CONFIG_PM_DEBUG */
+#endif /* CONFIG_PM_SLEEP_DEBUG */
 
 #ifdef CONFIG_DEBUG_FS
 static char *suspend_step_name(enum suspend_stat_step step)
@@ -746,10 +746,8 @@ static struct attribute * g[] = {
 	&wake_lock_attr.attr,
 	&wake_unlock_attr.attr,
 #endif
-#ifdef CONFIG_PM_DEBUG
-	&pm_test_attr.attr,
-#endif
 #ifdef CONFIG_PM_SLEEP_DEBUG
+	&pm_test_attr.attr,
 	&pm_print_times_attr.attr,
 	&pm_wakeup_irq_attr.attr,
 	&pm_debug_messages_attr.attr,
Index: linux-pm/kernel/power/power.h
===================================================================
--- linux-pm.orig/kernel/power/power.h
+++ linux-pm/kernel/power/power.h
@@ -245,7 +245,7 @@ enum {
 #define TEST_FIRST	TEST_NONE
 #define TEST_MAX	(__TEST_AFTER_LAST - 1)
 
-#ifdef CONFIG_PM_DEBUG
+#ifdef CONFIG_PM_SLEEP_DEBUG
 extern int pm_test_level;
 #else
 #define pm_test_level	(TEST_NONE)
