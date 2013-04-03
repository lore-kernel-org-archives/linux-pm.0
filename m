From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 7/9] intel: cpuidle: remove stop/start critical timings
Date: Wed,  3 Apr 2013 14:15:20 +0200
Message-ID: <1364991322-20585-7-git-send-email-daniel.lezcano@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:45730 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760614Ab3DCMPp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Apr 2013 08:15:45 -0400
Received: by mail-wi0-f180.google.com with SMTP id c10so1436376wiw.13
        for <linux-pm@vger.kernel.org>; Wed, 03 Apr 2013 05:15:44 -0700 (PDT)
In-Reply-To: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com, swarren@wwwdotorg.org, linux-tegra@vger.kernel.org, horms+renesas@verge.net.au, santosh.shilimkar@ti.com, arnd@arndb.de, lenb@kernel.org, nsekhar@ti.com, josephl@nvidia.com, deepthi@linux.vnet.ibm.com

The start/stop_critical_timings are called from arch/x86/kernel/process.c
in the cpu_idle loop function.

Remove the ones in the cpuidle driver.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/idle/intel_idle.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 5d66750..c99c31e 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -339,7 +339,6 @@ static int intel_idle(struct cpuidle_device *dev,
 	if (!(lapic_timer_reliable_states & (1 << (cstate))))
 		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
 
-	stop_critical_timings();
 	if (!need_resched()) {
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
@@ -348,8 +347,6 @@ static int intel_idle(struct cpuidle_device *dev,
 			__mwait(eax, ecx);
 	}
 
-	start_critical_timings();
-
 	if (!(lapic_timer_reliable_states & (1 << (cstate))))
 		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
 
-- 
1.7.9.5

