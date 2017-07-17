From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2] PM / suspend: Add suspend_target_state()
Date: Mon, 17 Jul 2017 13:06:28 -0700
Message-ID: <20170717200628.7018-1-f.fainelli@gmail.com>
References: <20170716023610.4658-1-f.fainelli@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35540 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdGQUGd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jul 2017 16:06:33 -0400
In-Reply-To: <20170716023610.4658-1-f.fainelli@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Have the core suspend/resume framework store the system-wide suspend
state (suspend_state_t) we are about to enter, and expose it to drivers
via suspend_target_state() in order to retrieve that. The state is
assigned in suspend_devices_and_enter().

This is useful for platform specific drivers that may need to take a
slightly different suspend/resume path based on the system's
suspend/resume state being entered.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- rename platform_suspend_target_state() -> suspend_target_state()
- directly export the suspend_state_t value and assign it in
  suspend_devices_and_enter()

 include/linux/suspend.h |  2 ++
 kernel/power/suspend.c  | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 0b1cf32edfd7..7b70e7d6a006 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -202,6 +202,7 @@ struct platform_freeze_ops {
  */
 extern void suspend_set_ops(const struct platform_suspend_ops *ops);
 extern int suspend_valid_only_mem(suspend_state_t state);
+extern suspend_state_t suspend_target_state(void);
 
 extern unsigned int pm_suspend_global_flags;
 
@@ -281,6 +282,7 @@ static inline bool pm_resume_via_firmware(void) { return false; }
 
 static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
 static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
+static inline suspend_state_t suspend_target_state(void) { return -ENOSYS; }
 static inline bool idle_should_freeze(void) { return false; }
 static inline void __init pm_states_init(void) {}
 static inline void freeze_set_ops(const struct platform_freeze_ops *ops) {}
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 3ecf275d7e44..a296d6e25d52 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -47,6 +47,7 @@ const char *mem_sleep_states[PM_SUSPEND_MAX];
 
 suspend_state_t mem_sleep_current = PM_SUSPEND_FREEZE;
 static suspend_state_t mem_sleep_default = PM_SUSPEND_MEM;
+static suspend_state_t pm_suspend_target_state;
 
 unsigned int pm_suspend_global_flags;
 EXPORT_SYMBOL_GPL(pm_suspend_global_flags);
@@ -202,6 +203,18 @@ void suspend_set_ops(const struct platform_suspend_ops *ops)
 EXPORT_SYMBOL_GPL(suspend_set_ops);
 
 /**
+ * suspend_target_state - Return the system wide suspend state.
+ *
+ * The pm_suspend_target_state becomes valid during
+ * suspend_devices_and_enter().
+ */
+suspend_state_t suspend_target_state(void)
+{
+	return pm_suspend_target_state;
+}
+EXPORT_SYMBOL_GPL(suspend_target_state);
+
+/**
  * suspend_valid_only_mem - Generic memory-only valid callback.
  *
  * Platform drivers that implement mem suspend only and only need to check for
@@ -456,6 +469,8 @@ int suspend_devices_and_enter(suspend_state_t state)
 	if (!sleep_state_supported(state))
 		return -ENOSYS;
 
+	pm_suspend_target_state = state;
+
 	error = platform_suspend_begin(state);
 	if (error)
 		goto Close;
-- 
2.9.3
