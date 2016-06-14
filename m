From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] PM: Make pm_prepare_console() return void
Date: Tue, 14 Jun 2016 16:23:22 +0200
Message-ID: <1465914202-423-1-git-send-email-bp@alien8.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:53352 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbcFNOXZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 Jun 2016 10:23:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

Nothing is using its return value so change it to return void.

No functionality change.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 include/linux/suspend.h | 5 ++---
 kernel/power/console.c  | 8 ++++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 8b6ec7ef0854..7693e39b14fe 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -18,12 +18,11 @@ static inline void pm_set_vt_switch(int do_switch)
 #endif
 
 #ifdef CONFIG_VT_CONSOLE_SLEEP
-extern int pm_prepare_console(void);
+extern void pm_prepare_console(void);
 extern void pm_restore_console(void);
 #else
-static inline int pm_prepare_console(void)
+static inline void pm_prepare_console(void)
 {
-	return 0;
 }
 
 static inline void pm_restore_console(void)
diff --git a/kernel/power/console.c b/kernel/power/console.c
index aba9c545a0e3..0e781798b0b3 100644
--- a/kernel/power/console.c
+++ b/kernel/power/console.c
@@ -126,17 +126,17 @@ out:
 	return ret;
 }
 
-int pm_prepare_console(void)
+void pm_prepare_console(void)
 {
 	if (!pm_vt_switch())
-		return 0;
+		return;
 
 	orig_fgconsole = vt_move_to_console(SUSPEND_CONSOLE, 1);
 	if (orig_fgconsole < 0)
-		return 1;
+		return;
 
 	orig_kmsg = vt_kmsg_redirect(SUSPEND_CONSOLE);
-	return 0;
+	return;
 }
 
 void pm_restore_console(void)
-- 
2.7.3

