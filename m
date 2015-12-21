From: Bibek Basu <bbasu@nvidia.com>
Subject: [PATCH] PM / sleep: console flush during suspend if no_console_suspend enabled
Date: Mon, 21 Dec 2015 12:01:40 +0530
Message-ID: <1450679500-6185-1-git-send-email-bbasu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16050 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbbLUGbq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2015 01:31:46 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, bbasu@nvidia.com

On multicore CPUs, sometimes debug console logs are not flushed
if you have VT consoles also enabled. Reason being console_lock
is taken by secondary/nonboot cpus which are  disabled as part
of suspend.This patch flushes the console before disabling
nonboot cpus

Signed-off-by: Bibek Basu <bbasu@nvidia.com>
---
 kernel/power/suspend.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index f9fe133..42c5912 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -352,6 +352,16 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 		goto Platform_wake;
 	}
 
+	/*
+	 * Flush console buffer if console_suspend_enabled cleared.
+	 * This will enable console flush if console_lock is taken
+	 * by nonboot cpus which will soon be disabled below.
+	 */
+	if (!console_suspend_enabled) {
+		console_lock();
+		console_unlock();
+	}
+
 	error = disable_nonboot_cpus();
 	if (error || suspend_test(TEST_CPUS))
 		goto Enable_cpus;
-- 
2.1.4

