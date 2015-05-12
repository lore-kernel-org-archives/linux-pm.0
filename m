From: Joe Konno <joe.konno@linux.intel.com>
Subject: [PATCH] intel_pstate: set BYT MSR with wrmsrl_on_cpu()
Date: Tue, 12 May 2015 07:59:42 -0700
Message-ID: <1431442782-12061-1-git-send-email-joe.konno@linux.intel.com>
References: <1431017979-28349-1-git-send-email-joe.konno@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36305 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932998AbbELPA6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 May 2015 11:00:58 -0400
In-Reply-To: <1431017979-28349-1-git-send-email-joe.konno@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, viresh.kumar@linaro.org, kristen@linux.intel.com

From: Joe Konno <joe.konno@intel.com>

Commit 007bea098b86 (intel_pstate: Add setting voltage value for
baytrail P states.) introduced byt_set_pstate() with the assumption that
it would always be run by the CPU whose MSR is to be written by it.  It
turns out, however, that is not always the case in practice, so modify
byt_set_pstate() to enforce the MSR write done by it to always happen on
the right CPU.

v2: better commit message, remove For: tag

Fixes: 007bea098b86 ("intel_pstate: Add setting voltage value for
       baytrail P states.")
Signed-off-by: Joe Konno <joe.konno@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 6414661ac1c4..c45d274a75c8 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -535,7 +535,7 @@ static void byt_set_pstate(struct cpudata *cpudata, int pstate)
 
 	val |= vid;
 
-	wrmsrl(MSR_IA32_PERF_CTL, val);
+	wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
 }
 
 #define BYT_BCLK_FREQS 5
-- 
2.4.0

