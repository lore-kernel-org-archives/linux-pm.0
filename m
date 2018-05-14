From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH] PM / core: refactor PM_OPS initializers
Date: Mon, 14 May 2018 10:21:46 +0200
Message-ID: <20180514082146.4318-1-a.hajda@samsung.com>
References: <CGME20180514082201eucas1p1549ae992aeeef0906a2cccb5da96533f@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pm@vger.kernel.org

With current implementation of PM_OPS initializers users should annotate
all PM callbacks with __maybe_unused attribute to prevent compiler from
complaining in case respective option is not enabled. Using ternary
operator with IS_ENABLED(symbol) as a condition allows to avoid marking
these functions with __maybe_unused.
Solution was tested successfully with multiple versions of gcc since
4.9.4 up to 7.2.1. No functional changes has been observed and callbacks
were compiled out if not used, as before.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 include/linux/pm.h | 61 ++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 37 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index e723b78d8357..59f333922c15 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -313,50 +313,37 @@ struct dev_pm_ops {
 	int (*runtime_idle)(struct device *dev);
 };
 
-#ifdef CONFIG_PM_SLEEP
+#define PM_SLEEP_PTR(ptr) (IS_ENABLED(CONFIG_PM_SLEEP) ? (ptr) : NULL)
+#define PM_PTR(ptr) (IS_ENABLED(CONFIG_PM) ? (ptr) : NULL)
+
 #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-	.suspend = suspend_fn, \
-	.resume = resume_fn, \
-	.freeze = suspend_fn, \
-	.thaw = resume_fn, \
-	.poweroff = suspend_fn, \
-	.restore = resume_fn,
-#else
-#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
-#endif
+	.suspend = PM_SLEEP_PTR(suspend_fn), \
+	.resume = PM_SLEEP_PTR(resume_fn), \
+	.freeze = PM_SLEEP_PTR(suspend_fn), \
+	.thaw = PM_SLEEP_PTR(resume_fn), \
+	.poweroff = PM_SLEEP_PTR(suspend_fn), \
+	.restore = PM_SLEEP_PTR(resume_fn),
 
-#ifdef CONFIG_PM_SLEEP
 #define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-	.suspend_late = suspend_fn, \
-	.resume_early = resume_fn, \
-	.freeze_late = suspend_fn, \
-	.thaw_early = resume_fn, \
-	.poweroff_late = suspend_fn, \
-	.restore_early = resume_fn,
-#else
-#define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
-#endif
+	.suspend_late = PM_SLEEP_PTR(suspend_fn), \
+	.resume_early = PM_SLEEP_PTR(resume_fn), \
+	.freeze_late = PM_SLEEP_PTR(suspend_fn), \
+	.thaw_early = PM_SLEEP_PTR(resume_fn), \
+	.poweroff_late = PM_SLEEP_PTR(suspend_fn), \
+	.restore_early = PM_SLEEP_PTR(resume_fn),
 
-#ifdef CONFIG_PM_SLEEP
 #define SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-	.suspend_noirq = suspend_fn, \
-	.resume_noirq = resume_fn, \
-	.freeze_noirq = suspend_fn, \
-	.thaw_noirq = resume_fn, \
-	.poweroff_noirq = suspend_fn, \
-	.restore_noirq = resume_fn,
-#else
-#define SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
-#endif
+	.suspend_noirq = PM_SLEEP_PTR(suspend_fn), \
+	.resume_noirq = PM_SLEEP_PTR(resume_fn), \
+	.freeze_noirq = PM_SLEEP_PTR(suspend_fn), \
+	.thaw_noirq = PM_SLEEP_PTR(resume_fn), \
+	.poweroff_noirq = PM_SLEEP_PTR(suspend_fn), \
+	.restore_noirq = PM_SLEEP_PTR(resume_fn),
 
-#ifdef CONFIG_PM
 #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
-	.runtime_suspend = suspend_fn, \
-	.runtime_resume = resume_fn, \
-	.runtime_idle = idle_fn,
-#else
-#define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
-#endif
+	.runtime_suspend = PM_PTR(suspend_fn), \
+	.runtime_resume = PM_PTR(resume_fn), \
+	.runtime_idle = PM_PTR(idle_fn),
 
 /*
  * Use this if you want to use the same suspend and resume callbacks for suspend
-- 
2.17.0
