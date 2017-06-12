From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/3] PM: Constify info string used in messages
Date: Mon, 12 Jun 2017 17:19:32 +0200
Message-ID: <20170612151933.7588-2-krzk@kernel.org>
References: <20170612151933.7588-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170612151933.7588-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-pm@vger.kernel.org

The 'info' string appearing in many places points to a .rodata string so
it should be passes as pointer to const.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/base/power/main.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 924a5ba7aa27..6add28799f6d 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -208,7 +208,8 @@ static ktime_t initcall_debug_start(struct device *dev)
 }
 
 static void initcall_debug_report(struct device *dev, ktime_t calltime,
-				  int error, pm_message_t state, char *info)
+				  int error, pm_message_t state,
+				  const char *info)
 {
 	ktime_t rettime;
 	s64 nsecs;
@@ -403,21 +404,22 @@ static pm_callback_t pm_noirq_op(const struct dev_pm_ops *ops, pm_message_t stat
 	return NULL;
 }
 
-static void pm_dev_dbg(struct device *dev, pm_message_t state, char *info)
+static void pm_dev_dbg(struct device *dev, pm_message_t state, const char *info)
 {
 	dev_dbg(dev, "%s%s%s\n", info, pm_verb(state.event),
 		((state.event & PM_EVENT_SLEEP) && device_may_wakeup(dev)) ?
 		", may wakeup" : "");
 }
 
-static void pm_dev_err(struct device *dev, pm_message_t state, char *info,
+static void pm_dev_err(struct device *dev, pm_message_t state, const char *info,
 			int error)
 {
 	printk(KERN_ERR "PM: Device %s failed to %s%s: error %d\n",
 		dev_name(dev), pm_verb(state.event), info, error);
 }
 
-static void dpm_show_time(ktime_t starttime, pm_message_t state, char *info)
+static void dpm_show_time(ktime_t starttime, pm_message_t state,
+			  const char *info)
 {
 	ktime_t calltime;
 	u64 usecs64;
@@ -435,7 +437,7 @@ static void dpm_show_time(ktime_t starttime, pm_message_t state, char *info)
 }
 
 static int dpm_run_callback(pm_callback_t cb, struct device *dev,
-			    pm_message_t state, char *info)
+			    pm_message_t state, const char *info)
 {
 	ktime_t calltime;
 	int error;
@@ -535,7 +537,7 @@ static void dpm_watchdog_clear(struct dpm_watchdog *wd)
 static int device_resume_noirq(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
-	char *info = NULL;
+	const char *info = NULL;
 	int error = 0;
 
 	TRACE_DEVICE(dev);
@@ -665,7 +667,7 @@ void dpm_resume_noirq(pm_message_t state)
 static int device_resume_early(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
-	char *info = NULL;
+	const char *info = NULL;
 	int error = 0;
 
 	TRACE_DEVICE(dev);
@@ -793,7 +795,7 @@ EXPORT_SYMBOL_GPL(dpm_resume_start);
 static int device_resume(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
-	char *info = NULL;
+	const char *info = NULL;
 	int error = 0;
 	DECLARE_DPM_WATCHDOG_ON_STACK(wd);
 
@@ -955,7 +957,7 @@ void dpm_resume(pm_message_t state)
 static void device_complete(struct device *dev, pm_message_t state)
 {
 	void (*callback)(struct device *) = NULL;
-	char *info = NULL;
+	const char *info = NULL;
 
 	if (dev->power.syscore)
 		return;
@@ -1080,7 +1082,7 @@ static pm_message_t resume_event(pm_message_t sleep_state)
 static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
-	char *info = NULL;
+	const char *info = NULL;
 	int error = 0;
 
 	TRACE_DEVICE(dev);
@@ -1225,7 +1227,7 @@ int dpm_suspend_noirq(pm_message_t state)
 static int __device_suspend_late(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
-	char *info = NULL;
+	const char *info = NULL;
 	int error = 0;
 
 	TRACE_DEVICE(dev);
@@ -1384,7 +1386,7 @@ EXPORT_SYMBOL_GPL(dpm_suspend_end);
  */
 static int legacy_suspend(struct device *dev, pm_message_t state,
 			  int (*cb)(struct device *dev, pm_message_t state),
-			  char *info)
+			  const char *info)
 {
 	int error;
 	ktime_t calltime;
@@ -1426,7 +1428,7 @@ static void dpm_clear_suppliers_direct_complete(struct device *dev)
 static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
-	char *info = NULL;
+	const char *info = NULL;
 	int error = 0;
 	DECLARE_DPM_WATCHDOG_ON_STACK(wd);
 
-- 
2.9.3
