From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/5] PM / Sleep: Add macro to define common late/early system PM callbacks
Date: Wed, 27 Nov 2013 16:34:59 +0100
Message-ID: <1385566500-7666-5-git-send-email-ulf.hansson@linaro.org>
References: <1385566500-7666-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385566500-7666-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-pm@vger.kernel.org

We use the same approach as for the existing SET_SYSTEM_SLEEP_PM_OPS,
but for the late and early callbacks instead.

The new SET_LATE_SYSTEM_SLEEP_PM_OPS, defined for CONFIG_PM_SLEEP, will
point ->suspend_late, ->freeze_late and ->poweroff_late to the same
function. Vice verse happens for ->resume_early, ->thaw_early and
->restore_early.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 529657c..fb0f1db 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -311,6 +311,18 @@ struct dev_pm_ops {
 #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
 #endif
 
+#ifdef CONFIG_PM_SLEEP
+#define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	.suspend_late = suspend_fn, \
+	.resume_early = resume_fn, \
+	.freeze_late = suspend_fn, \
+	.thaw_early = resume_fn, \
+	.poweroff_late = suspend_fn, \
+	.restore_early = resume_fn,
+#else
+#define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
+#endif
+
 #ifdef CONFIG_PM_RUNTIME
 #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 	.runtime_suspend = suspend_fn, \
-- 
1.7.9.5
