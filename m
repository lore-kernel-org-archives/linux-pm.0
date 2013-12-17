From: dirk.brandewie@gmail.com
Subject: [PATCH 2/2] intel_pstate: Remove periodic P state boost
Date: Tue, 17 Dec 2013 09:42:07 -0800
Message-ID: <1387302127-7614-2-git-send-email-dirk.j.brandewie@intel.com>
References: <1387302127-7614-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:39675 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754912Ab3LQRmT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2013 12:42:19 -0500
Received: by mail-pd0-f177.google.com with SMTP id q10so7055655pdj.36
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2013 09:42:18 -0800 (PST)
In-Reply-To: <1387302127-7614-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

Remove the periodic P state boost.  This code required for some corner
case benchmark tests.  The calculation of the required P state was
incorrect/inaccurate and would not allow P state increase.

This was fixed by a combination of commits:
  2134ed4 cpufreq / intel_pstate: Change to scale off of max P-state
  d253d2a intel_pstate: Improve accuracy by not truncating until final result

Fixes Bug:
  https://bugzilla.kernel.org/show_bug.cgi?id=64271

Reported-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 4cc4534..5bafccc 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -92,8 +92,6 @@ struct cpudata {
 	struct vid_data vid;
 	struct _pid pid;
 
-	int min_pstate_count;
-
 	u64	prev_aperf;
 	u64	prev_mperf;
 	int	sample_ptr;
@@ -617,15 +615,6 @@ static void intel_pstate_timer_func(unsigned long __data)
 
 	intel_pstate_sample(cpu);
 	intel_pstate_adjust_busy_pstate(cpu);
-
-	if (cpu->pstate.current_pstate == cpu->pstate.min_pstate) {
-		cpu->min_pstate_count++;
-		if (!(cpu->min_pstate_count % 5)) {
-			intel_pstate_set_pstate(cpu, cpu->pstate.max_pstate);
-		}
-	} else
-		cpu->min_pstate_count = 0;
-
 	intel_pstate_set_sample_time(cpu);
 }
 
-- 
1.8.3.1

