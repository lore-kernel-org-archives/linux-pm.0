From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / sleep: Fix broken builds without CONFIG_PM_SLEEP_DEBUG
Date: Tue, 15 Sep 2015 13:42:21 +0530
Message-ID: <e7097f9c9cc28de234486e3f3865bf9bbea92aac.1442304707.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, alexandra.yates@linux.intel.com, Viresh Kumar <viresh.kumar@linaro.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

The variable 'wakeup_irq' is defined within #ifdef CONFIG_PM_SLEEP_DEBUG
and used outside of it. And that breaks kernel build:

/home/viresh/linux/drivers/base/power/wakeup.c:871: undefined reference to `wakeup_irq'
/home/viresh/drivers/base/power/wakeup.c:871: undefined reference to `wakeup_irq'

Fix it by defining the variable outside of the ifdef.

Fixes: d1e59c235322 ("PM / sleep: Report interrupt that caused system wakeup")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/power/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 9880bf888a5b..f97a188f4ccc 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -235,6 +235,9 @@ late_initcall(pm_debugfs_init);
 
 #endif /* CONFIG_PM_SLEEP */
 
+/* IRQ number which causes system wakeup */
+unsigned int wakeup_irq;
+
 #ifdef CONFIG_PM_SLEEP_DEBUG
 /*
  * pm_print_times: print time taken by devices to suspend and resume.
@@ -273,7 +276,6 @@ static inline void pm_print_times_init(void)
 	pm_print_times_enabled = !!initcall_debug;
 }
 
-unsigned int wakeup_irq;
 static ssize_t pm_wakeup_irq_show(struct kobject *kobj,
 					struct kobj_attribute *attr,
 					char *buf)
-- 
2.4.0
