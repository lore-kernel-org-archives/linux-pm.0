From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v3] PM / suspend: Export pm_suspend_target_state
Date: Mon, 17 Jul 2017 15:10:59 -0700
Message-ID: <20170717221059.6523-1-f.fainelli@gmail.com>
References: <20170716023610.4658-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170716023610.4658-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Have the core suspend/resume framework store the system-wide suspend
state (suspend_state_t) we are about to enter, and expose it to drivers
via pm_suspend_target_state in order to retrieve that. The state is
assigned in suspend_devices_and_enter().

This is useful for platform specific drivers that may need to take a
slightly different suspend/resume path based on the system's
suspend/resume state being entered.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v3:

- just export pm_suspend_target_state without a helper function

Changes in v2:

- rename platform_suspend_target_state() -> suspend_target_state()
- directly export the suspend_state_t value and assign it in
  suspend_devices_and_enter()

 include/linux/suspend.h | 1 +
 kernel/power/suspend.c  | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 0b1cf32edfd7..2159f6841768 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -427,6 +427,7 @@ extern int unregister_pm_notifier(struct notifier_block *nb);
 /* drivers/base/power/wakeup.c */
 extern bool events_check_enabled;
 extern unsigned int pm_wakeup_irq;
+extern suspend_state_t pm_suspend_target_state;
 
 extern bool pm_wakeup_pending(void);
 extern void pm_system_wakeup(void);
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 3ecf275d7e44..1aecdaf22ab5 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -47,6 +47,8 @@ const char *mem_sleep_states[PM_SUSPEND_MAX];
 
 suspend_state_t mem_sleep_current = PM_SUSPEND_FREEZE;
 static suspend_state_t mem_sleep_default = PM_SUSPEND_MEM;
+suspend_state_t pm_suspend_target_state;
+EXPORT_SYMBOL_GPL(pm_suspend_target_state);
 
 unsigned int pm_suspend_global_flags;
 EXPORT_SYMBOL_GPL(pm_suspend_global_flags);
@@ -456,6 +458,8 @@ int suspend_devices_and_enter(suspend_state_t state)
 	if (!sleep_state_supported(state))
 		return -ENOSYS;
 
+	pm_suspend_target_state = state;
+
 	error = platform_suspend_begin(state);
 	if (error)
 		goto Close;
-- 
2.9.3
