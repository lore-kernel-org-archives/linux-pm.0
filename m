From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/3] cpufreq: intel_pstate: Replace MSR_NHM_TURBO_RATIO_LIMIT
Date: Wed,  6 Jul 2016 16:07:55 -0700
Message-ID: <1467846477-13659-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1467846477-13659-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2758 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932711AbcGFXIM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 Jul 2016 19:08:12 -0400
In-Reply-To: <1467846477-13659-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Replace MSR_NHM_TURBO_RATIO_LIMIT with MSR_TURBO_RATIO_LIMIT.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f6dd072..facf05c 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -973,7 +973,7 @@ static int core_get_turbo_pstate(void)
 	u64 value;
 	int nont, ret;
 
-	rdmsrl(MSR_NHM_TURBO_RATIO_LIMIT, value);
+	rdmsrl(MSR_TURBO_RATIO_LIMIT, value);
 	nont = core_get_max_pstate();
 	ret = (value) & 255;
 	if (ret <= nont)
@@ -1002,7 +1002,7 @@ static int knl_get_turbo_pstate(void)
 	u64 value;
 	int nont, ret;
 
-	rdmsrl(MSR_NHM_TURBO_RATIO_LIMIT, value);
+	rdmsrl(MSR_TURBO_RATIO_LIMIT, value);
 	nont = core_get_max_pstate();
 	ret = (((value) >> 8) & 0xFF);
 	if (ret <= nont)
-- 
2.5.5

