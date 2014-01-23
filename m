From: dirk.brandewie@gmail.com
Subject: [PATCH] intel_pstate: Remove periodic P state boost
Date: Thu, 23 Jan 2014 08:48:27 -0800
Message-ID: <1390495707-6297-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:41368 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbaAWQsh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2014 11:48:37 -0500
Received: by mail-pb0-f43.google.com with SMTP id md12so2053477pbc.16
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2014 08:48:37 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

Remove the periodic P state boost.  This code required for some corner
case benchmark tests.  The calculation of the required P state was
incorrect/inaccurate and would not allow P state increase.

This was resolved by a combination of commits:
  2134ed4 cpufreq / intel_pstate: Change to scale off of max P-state
  d253d2a intel_pstate: Improve accuracy by not truncating until final result

reference:
  https://bugzilla.kernel.org/show_bug.cgi?id=64271

Reported-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index d51f17ed..5a060eb 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -84,8 +84,6 @@ struct cpudata {
 	struct pstate_data pstate;
 	struct _pid pid;
 
-	int min_pstate_count;
-
 	u64	prev_aperf;
 	u64	prev_mperf;
 	int	sample_ptr;
@@ -568,15 +566,6 @@ static void intel_pstate_timer_func(unsigned long __data)
 
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

