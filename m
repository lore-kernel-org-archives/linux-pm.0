From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: [PATCH] PM-Trace: add pm-trace support for suspending phase
Date: Mon, 09 Feb 2015 12:03:23 +0800
Message-ID: <54D8318B.2060703@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61635 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752975AbbBIED3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 8 Feb 2015 23:03:29 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "rjw@rjwysocki.net >> Rafael J. Wysocki" <rjw@rjwysocki.net>, pavel@ucw.cz, len.brown@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

>From ec9c0f24e800461361eaf8b280abe4272b00772d Mon Sep 17 00:00:00 2001
From: Zhonghui Fu <zhonghui.fu@linux.intel.com>
Date: Mon, 9 Feb 2015 11:09:22 +0800
Subject: [PATCH] PM-Trace: add pm-trace support for suspending phase

Occasinally, the system can't come back up after suspend/resume
due to problems of device suspending phase. This patch make
PM_TRACE infrastructure cover device suspending phase of
suspend/resume process, and the information in RTC can tell
develpers which device suspending function make system hang.

Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
---
 arch/x86/include/asm/resume-trace.h |    2 +-
 drivers/base/power/main.c           |   30 +++++++++++++++++++++---------
 include/linux/resume-trace.h        |    2 +-
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/resume-trace.h b/arch/x86/include/asm/resume-trace.h
index 3ff1c2c..0ca2215 100644
--- a/arch/x86/include/asm/resume-trace.h
+++ b/arch/x86/include/asm/resume-trace.h
@@ -3,7 +3,7 @@
 
 #include <asm/asm.h>
 
-#define TRACE_RESUME(user)					\
+#define TRACE_SUSPEND_RESUME(user)				\
 do {								\
 	if (pm_trace_enabled) {					\
 		const void *tracedata;				\
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 9717d5f..d2070b5 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -477,7 +477,7 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
 	int error = 0;
 
 	TRACE_DEVICE(dev);
-	TRACE_RESUME(0);
+	TRACE_SUSPEND_RESUME(0);
 
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Out;
@@ -511,7 +511,7 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
 
  Out:
 	complete_all(&dev->power.completion);
-	TRACE_RESUME(error);
+	TRACE_SUSPEND_RESUME(error);
 	return error;
 }
 
@@ -606,7 +606,7 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
 	int error = 0;
 
 	TRACE_DEVICE(dev);
-	TRACE_RESUME(0);
+	TRACE_SUSPEND_RESUME(0);
 
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Out;
@@ -639,7 +639,7 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
 	dev->power.is_late_suspended = false;
 
  Out:
-	TRACE_RESUME(error);
+	TRACE_SUSPEND_RESUME(error);
 
 	pm_runtime_enable(dev);
 	complete_all(&dev->power.completion);
@@ -735,7 +735,7 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 	DECLARE_DPM_WATCHDOG_ON_STACK(wd);
 
 	TRACE_DEVICE(dev);
-	TRACE_RESUME(0);
+	TRACE_SUSPEND_RESUME(0);
 
 	if (dev->power.syscore)
 		goto Complete;
@@ -811,7 +811,7 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
  Complete:
 	complete_all(&dev->power.completion);
 
-	TRACE_RESUME(error);
+	TRACE_SUSPEND_RESUME(error);
 
 	return error;
 }
@@ -1017,6 +1017,9 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 	char *info = NULL;
 	int error = 0;
 
+	TRACE_DEVICE(dev);
+	TRACE_SUSPEND_RESUME(0);
+
 	if (async_error)
 		goto Complete;
 
@@ -1057,6 +1060,7 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 
 Complete:
 	complete_all(&dev->power.completion);
+	TRACE_SUSPEND_RESUME(error);
 	return error;
 }
 
@@ -1078,7 +1082,7 @@ static int device_suspend_noirq(struct device *dev)
 {
 	reinit_completion(&dev->power.completion);
 
-	if (pm_async_enabled && dev->power.async_suspend) {
+	if (is_async(dev)) {
 		get_device(dev);
 		async_schedule(async_suspend_noirq, dev);
 		return 0;
@@ -1157,6 +1161,9 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
 	char *info = NULL;
 	int error = 0;
 
+	TRACE_DEVICE(dev);
+	TRACE_SUSPEND_RESUME(0);
+
 	__pm_runtime_disable(dev, false);
 
 	if (async_error)
@@ -1198,6 +1205,7 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
 		async_error = error;
 
 Complete:
+	TRACE_SUSPEND_RESUME(error);
 	complete_all(&dev->power.completion);
 	return error;
 }
@@ -1219,7 +1227,7 @@ static int device_suspend_late(struct device *dev)
 {
 	reinit_completion(&dev->power.completion);
 
-	if (pm_async_enabled && dev->power.async_suspend) {
+	if (is_async(dev)) {
 		get_device(dev);
 		async_schedule(async_suspend_late, dev);
 		return 0;
@@ -1338,6 +1346,9 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	int error = 0;
 	DECLARE_DPM_WATCHDOG_ON_STACK(wd);
 
+	TRACE_DEVICE(dev);
+	TRACE_SUSPEND_RESUME(0);
+
 	dpm_wait_for_children(dev, async);
 
 	if (async_error)
@@ -1444,6 +1455,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	if (error)
 		async_error = error;
 
+	TRACE_SUSPEND_RESUME(error);
 	return error;
 }
 
@@ -1465,7 +1477,7 @@ static int device_suspend(struct device *dev)
 {
 	reinit_completion(&dev->power.completion);
 
-	if (pm_async_enabled && dev->power.async_suspend) {
+	if (is_async(dev)) {
 		get_device(dev);
 		async_schedule(async_suspend, dev);
 		return 0;
diff --git a/include/linux/resume-trace.h b/include/linux/resume-trace.h
index f31db23..9080f25 100644
--- a/include/linux/resume-trace.h
+++ b/include/linux/resume-trace.h
@@ -27,7 +27,7 @@ extern int show_trace_dev_match(char *buf, size_t size);
 static inline int pm_trace_is_enabled(void) { return 0; }
 
 #define TRACE_DEVICE(dev) do { } while (0)
-#define TRACE_RESUME(dev) do { } while (0)
+#define TRACE_SUSPEND_RESUME(dev) do { } while (0)
 
 #endif
 
-- 1.7.1

