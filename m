From: Joe Konno <joe.konno@linux.intel.com>
Subject: [PATCH] intel_pstate: set BYT MSR with wrmsrl_on_cpu()
Date: Thu,  7 May 2015 09:59:39 -0700
Message-ID: <1431017979-28349-1-git-send-email-joe.konno@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:19723 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459AbbEGQ7j (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 7 May 2015 12:59:39 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, kristen@linux.intel.com

From: Joe Konno <joe.konno@intel.com>

In instances where the default cpufreq governor is Performance, reading
from MSR 0x199 on an applicable multi-core Atom system saw boot-to-boot
variability in the P-State value set to each logical core.  Sometimes
only one logical core would be set properly, other times two or three.
There was an assumption in the code that only a thread on the intended
logical core would be calling the wrmsrl() function. That was disproven
during debug, as cpufreq, at init, was not always calling from the same
as the logical core it targeted. Thus, use wrmsrl_on_cpu() instead, as
done in the core_set_pstate() function.

For: LCK-1822
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

