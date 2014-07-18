From: dirk.brandewie@gmail.com
Subject: [PATCH 09/11] cpufreq: intel_pstate: Simplify P state adjustment logic.
Date: Fri, 18 Jul 2014 08:37:26 -0700
Message-ID: <1405697848-13546-11-git-send-email-dirk.j.brandewie@intel.com>
References: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:63696 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422773AbaGRPhz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jul 2014 11:37:55 -0400
Received: by mail-pd0-f180.google.com with SMTP id y13so5223257pdi.11
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2014 08:37:54 -0700 (PDT)
In-Reply-To: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, Stratos Karafotis <stratosk@semaphore.gr>

From: Stratos Karafotis <stratosk@semaphore.gr>

Simplify the code by removing the inline functions pstate_increase and
pstate_decrease and use directly the intel_pstate_set_pstate.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
Acked-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ff3c562..33a09da 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -530,21 +530,6 @@ static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
 	pstate_funcs.set(cpu, pstate);
 }
 
-static inline void intel_pstate_pstate_increase(struct cpudata *cpu, int steps)
-{
-	int target;
-	target = cpu->pstate.current_pstate + steps;
-
-	intel_pstate_set_pstate(cpu, target);
-}
-
-static inline void intel_pstate_pstate_decrease(struct cpudata *cpu, int steps)
-{
-	int target;
-	target = cpu->pstate.current_pstate - steps;
-	intel_pstate_set_pstate(cpu, target);
-}
-
 static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 {
 	cpu->pstate.min_pstate = pstate_funcs.get_min();
@@ -635,20 +620,15 @@ static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
 {
 	int32_t busy_scaled;
 	struct _pid *pid;
-	signed int ctl = 0;
-	int steps;
+	signed int ctl;
 
 	pid = &cpu->pid;
 	busy_scaled = intel_pstate_get_scaled_busy(cpu);
 
 	ctl = pid_calc(pid, busy_scaled);
 
-	steps = abs(ctl);
-
-	if (ctl < 0)
-		intel_pstate_pstate_increase(cpu, steps);
-	else
-		intel_pstate_pstate_decrease(cpu, steps);
+	/* Negative values of ctl increase the pstate and vice versa */
+	intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - ctl);
 }
 
 static void intel_pstate_timer_func(unsigned long __data)
-- 
1.9.3

