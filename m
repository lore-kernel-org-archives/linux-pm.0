From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/2] PM / suspend: Add platform_suspend_target_state()
Date: Sat, 15 Jul 2017 19:36:09 -0700
Message-ID: <20170716023610.4658-2-f.fainelli@gmail.com>
References: <20170623010837.11199-1-f.fainelli@gmail.com>
 <20170716023610.4658-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170716023610.4658-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Add an optional platform_suspend_ops callback: target_state, and a
helper function globally visible to get this called:
platform_suspend_target_state().

This is useful for platform specific drivers that may need to take a
slightly different suspend/resume path based on the system's
suspend/resume state being entered.

Although this callback is optional and documented as such, it requires
a platform_suspend_ops::begin callback to be implemented in order to
provide an accurate suspend/resume state within the driver that
implements this platform_suspend_ops.

An enumeration: platform_target_state is defined which currently defines
the standard ACPI_S[1-4] states and can be extended with platform
specific suspend states.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/linux/suspend.h | 25 +++++++++++++++++++++++++
 kernel/power/suspend.c  | 15 +++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 0b1cf32edfd7..6e6cc0778816 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -50,6 +50,16 @@ enum suspend_stat_step {
 	SUSPEND_RESUME
 };
 
+enum platform_target_state {
+	PLATFORM_STATE_UNKNOWN = -1,
+	PLATFORM_STATE_WORKING = 0,
+	PLATFORM_STATE_ACPI_S1,
+	PLATFORM_STATE_ACPI_S2,
+	PLATFORM_STATE_ACPI_S3,
+	PLATFORM_STATE_ACPI_S4,
+	/* Add platform specific states here */
+};
+
 struct suspend_stats {
 	int	success;
 	int	fail;
@@ -172,6 +182,15 @@ static inline void dpm_save_failed_step(enum suspend_stat_step step)
  *	Called by the PM core if the suspending of devices fails.
  *	This callback is optional and should only be implemented by platforms
  *	which require special recovery actions in that situation.
+ *
+ * @target_state: Returns the suspend state the suspend_ops will be entering.
+ * 	Called by device drivers that need to know the platform specific suspend
+ * 	state the system is about to enter.
+ * 	This callback is optional and should only be implemented by platforms
+ * 	which require special handling of power management states within
+ * 	drivers. It does require @begin to be implemented to provide the suspend
+ * 	state. Return value is platform_suspend_ops specific, and may be a 1:1
+ * 	mapping to suspend_state_t when relevant.
  */
 struct platform_suspend_ops {
 	int (*valid)(suspend_state_t state);
@@ -184,6 +203,7 @@ struct platform_suspend_ops {
 	bool (*suspend_again)(void);
 	void (*end)(void);
 	void (*recover)(void);
+	enum platform_target_state (*target_state)(void);
 };
 
 struct platform_freeze_ops {
@@ -202,6 +222,7 @@ struct platform_freeze_ops {
  */
 extern void suspend_set_ops(const struct platform_suspend_ops *ops);
 extern int suspend_valid_only_mem(suspend_state_t state);
+extern enum platform_target_state platform_suspend_target_state(void);
 
 extern unsigned int pm_suspend_global_flags;
 
@@ -281,6 +302,10 @@ static inline bool pm_resume_via_firmware(void) { return false; }
 
 static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
 static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
+static inline int platform_suspend_target_state(void)
+{
+	return PLATFORM_STATE_UNKNOWN;
+}
 static inline bool idle_should_freeze(void) { return false; }
 static inline void __init pm_states_init(void) {}
 static inline void freeze_set_ops(const struct platform_freeze_ops *ops) {}
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 3ecf275d7e44..cd1b62f23b0e 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -202,6 +202,21 @@ void suspend_set_ops(const struct platform_suspend_ops *ops)
 EXPORT_SYMBOL_GPL(suspend_set_ops);
 
 /**
+ * platform_suspend_target_state - Return the platform specific suspend state.
+ * a begin() callback is necessary in order to fill this information correctly
+ * for callers.
+ */
+enum platform_target_state platform_suspend_target_state(void)
+{
+	if (!suspend_ops || !suspend_ops->target_state ||
+	    (suspend_ops->target_state && !suspend_ops->begin))
+		return -ENOTSUPP;
+
+	return suspend_ops->target_state();
+}
+EXPORT_SYMBOL_GPL(platform_suspend_target_state);
+
+/**
  * suspend_valid_only_mem - Generic memory-only valid callback.
  *
  * Platform drivers that implement mem suspend only and only need to check for
-- 
2.9.3
