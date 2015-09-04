From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFC v0 2/9] suspend: Add getter function to report if freezing is active
Date: Fri,  4 Sep 2015 15:34:55 +0200
Message-ID: <1441373702-31796-3-git-send-email-daniel.wagner@bmw-carit.de>
References: <1441373702-31796-1-git-send-email-daniel.wagner@bmw-carit.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441373702-31796-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Instead encode the FREEZE state via the CPU state we allow the
interesting subsystems (MCE, microcode) to query the power
subsystem directly. Most notifiers are not interested at all
in this information so rather have explicit calls to freeze_active()
instead adding complexity to the rest of the users of the CPU
notifiers.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/suspend.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 5efe743..5e15ade 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -216,6 +216,11 @@ static inline bool idle_should_freeze(void)
 	return unlikely(suspend_freeze_state == FREEZE_STATE_ENTER);
 }
 
+static inline bool freeze_active(void)
+{
+	return unlikely(suspend_freeze_state != FREEZE_STATE_NONE);
+}
+
 extern void freeze_set_ops(const struct platform_freeze_ops *ops);
 extern void freeze_wake(void);
 
@@ -244,6 +249,7 @@ extern int pm_suspend(suspend_state_t state);
 static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
 static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
 static inline bool idle_should_freeze(void) { return false; }
+static inline bool freeze_active(void) { return false; }
 static inline void freeze_set_ops(const struct platform_freeze_ops *ops) {}
 static inline void freeze_wake(void) {}
 #endif /* !CONFIG_SUSPEND */
-- 
2.4.3
