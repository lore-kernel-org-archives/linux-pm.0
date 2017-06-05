From: Mark Salyzyn <salyzyn@android.com>
Subject: PM / Hibernation: Print wall time at hibernation entry and exit
Date: Mon,  5 Jun 2017 12:31:15 -0700
Message-ID: <20170605193157.59875-2-salyzyn@android.com>
References: <20170605193157.59875-1-salyzyn@android.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33360 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFETdq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2017 15:33:46 -0400
Received: by mail-pf0-f176.google.com with SMTP id 83so29755734pfr.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Jun 2017 12:33:45 -0700 (PDT)
In-Reply-To: <20170605193157.59875-1-salyzyn@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Mark Salyzyn <salyzyn@android.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>

Permits power state and battery life diagnosis.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
---
 kernel/power/hibernate.c | 2 ++
 kernel/power/power.h     | 1 +
 kernel/power/suspend.c   | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index a8b978c35a6a..0a8b7315d298 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -342,6 +342,7 @@ int hibernation_snapshot(int platform_mode)
 	pm_message_t msg;
 	int error;
 
+	pm_suspend_marker("entry hibernation");
 	pm_suspend_clear_flags();
 	error = platform_begin(platform_mode);
 	if (error)
@@ -409,6 +410,7 @@ int hibernation_snapshot(int platform_mode)
 	thaw_kernel_threads();
  Cleanup:
 	swsusp_free();
+	pm_suspend_marker("exit hibernation");
 	goto Close;
 }
 
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 7fdc40d31b7d..08f63ae27a31 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -194,6 +194,7 @@ extern const char *pm_states[];
 extern const char *mem_sleep_states[];
 extern suspend_state_t mem_sleep_current;
 
+extern void pm_suspend_marker(const char *annotation);
 extern int suspend_devices_and_enter(suspend_state_t state);
 #else /* !CONFIG_SUSPEND */
 #define mem_sleep_current	PM_SUSPEND_ON
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 464175f04bc5..69da2b880bde 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -564,7 +564,7 @@ static int enter_state(suspend_state_t state)
 	return error;
 }
 
-static void pm_suspend_marker(char *annotation)
+void pm_suspend_marker(const char *annotation)
 {
 	struct timespec ts;
 	struct rtc_time tm;
-- 
2.13.0.506.g27d5fe0cd-goog
