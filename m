From: Piotr Luc <piotr.luc@intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Add Knights Mill CPUID
Date: Wed, 12 Oct 2016 20:25:50 +0200
Message-ID: <20161012182550.2102-1-piotr.luc@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3593 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755859AbcJLSeR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Oct 2016 14:34:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>

Add Knights Mill (KNM) to the list of CPUIDs supported by intel_pstate.

Signed-off-by: Piotr Luc <piotr.luc@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Depends-on: x86/cpu/intel: Add Knights Mill to Intel family
https://lkml.kernel.org/r/20161012180520.30976-1-piotr.luc () intel ! com

 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index be9eade..4240aff 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1367,6 +1367,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP,	core_params),
 	ICPU(INTEL_FAM6_BROADWELL_XEON_D,	core_params),
 	ICPU(INTEL_FAM6_XEON_PHI_KNL,		knl_params),
+	ICPU(INTEL_FAM6_XEON_PHI_KNM,		knl_params),
 	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		bxt_params),
 	{}
 };
-- 
2.10.1

