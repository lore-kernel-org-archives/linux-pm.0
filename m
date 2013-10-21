From: dirk.brandewie@gmail.com
Subject: [PATCH 2/4] cpufreq/intel_pstate:  Correct calculation of min pstate value
Date: Mon, 21 Oct 2013 09:20:33 -0700
Message-ID: <1382372435-29778-3-git-send-email-dirk.j.brandewie@intel.com>
References: <1382372435-29778-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:38476 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab3JUQUq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2013 12:20:46 -0400
Received: by mail-pa0-f52.google.com with SMTP id kl14so8235740pab.25
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2013 09:20:46 -0700 (PDT)
In-Reply-To: <1382372435-29778-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rjw@rjwysocki.net
Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

The minimum pstate is supposed to be a percentage of the maximum P
state available.  Calculate min using max pstate and not the
current max which may have been limited by the user

Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 9f42b0a..67a87e0 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -366,12 +366,13 @@ static int intel_pstate_turbo_pstate(void)
 static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
 {
 	int max_perf = cpu->pstate.turbo_pstate;
+	int max_perf_adj;
 	int min_perf;
 	if (limits.no_turbo)
 		max_perf = cpu->pstate.max_pstate;
 
-	max_perf = fp_toint(mul_fp(int_tofp(max_perf), limits.max_perf));
-	*max = clamp_t(int, max_perf,
+	max_perf_adj = fp_toint(mul_fp(int_tofp(max_perf), limits.max_perf));
+	*max = clamp_t(int, max_perf_adj,
 			cpu->pstate.min_pstate, cpu->pstate.turbo_pstate);
 
 	min_perf = fp_toint(mul_fp(int_tofp(max_perf), limits.min_perf));
-- 
1.8.3.1

