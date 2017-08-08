From: Doug Smythies <doug.smythies@gmail.com>
Subject: [PATCH] cpufreq: intel_pstate: report correct CPU frequencies during trace.
Date: Tue,  8 Aug 2017 14:05:12 -0700
Message-ID: <1502226312-5451-1-git-send-email-dsmythies@telus.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37190 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbdHHVFf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Aug 2017 17:05:35 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com, rafael@kernel.org, len.brown@intel.com
Cc: dsmythies@telus.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

The intel_pstate cpu frequency scaling driver has always
calculated CPU frequency incorrectly. Recent changes have
eliminted most of the issues, however the frequency reported
in the trace buffer, if used, is incorrect.

It remains desireable that cpu->pstate.scaling still be a nice
round number for things such as when setting max and min frequencies.
So the proposal is to just fix the reported frequency in the trace data.

Fixes what remains of: https://bugzilla.kernel.org/show_bug.cgi?id=96521

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 drivers/cpufreq/intel_pstate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 0566455..65ee4fc 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1613,8 +1613,7 @@ static inline bool intel_pstate_sample(struct cpudata *cpu, u64 time)
 
 static inline int32_t get_avg_frequency(struct cpudata *cpu)
 {
-	return mul_ext_fp(cpu->sample.core_avg_perf,
-			  cpu->pstate.max_pstate_physical * cpu->pstate.scaling);
+	return mul_ext_fp(cpu->sample.core_avg_perf, cpu_khz);
 }
 
 static inline int32_t get_avg_pstate(struct cpudata *cpu)
-- 
2.7.4
