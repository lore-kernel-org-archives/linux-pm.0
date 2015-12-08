From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 3/4] Documentation: cpu-freq: update setpolicy documentation
Date: Tue,  8 Dec 2015 14:31:29 -0800
Message-ID: <1449613890-10403-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1449613890-10403-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60772 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815AbbLHWco (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Dec 2015 17:32:44 -0500
In-Reply-To: <1449613890-10403-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, prarit@redhat.com, trenn@suse.de, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Updated documentation for usage of setpolicy interface.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/cpu-freq/cpu-drivers.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/cpu-freq/cpu-drivers.txt b/Documentation/cpu-freq/cpu-drivers.txt
index 14f4e63..144e0ad 100644
--- a/Documentation/cpu-freq/cpu-drivers.txt
+++ b/Documentation/cpu-freq/cpu-drivers.txt
@@ -195,8 +195,13 @@ argument. You need to set the lower limit of the in-processor or
 in-chipset dynamic frequency switching to policy->min, the upper limit
 to policy->max, and -if supported- select a performance-oriented
 setting when policy->policy is CPUFREQ_POLICY_PERFORMANCE, and a
-powersaving-oriented setting when CPUFREQ_POLICY_POWERSAVE. Also check
-the reference implementation in drivers/cpufreq/longrun.c
+powersaving-oriented setting when CPUFREQ_POLICY_POWERSAVE, and a
+optional on demand frequency scaling setting when
+CPUFREQ_POLICY_ONDEMAND. The default supported policies are
+CPUFREQ_POLICY_PERFORMANCE and CPUFREQ_POLICY_POWERSAVE. To change or
+add supported policies set policy->available_policies with a mask of
+supported policies. Also check the reference implementation in
+drivers/cpufreq/longrun.c and intel_pstate.c.
 
 1.7 get_intermediate and target_intermediate
 --------------------------------------------
-- 
2.4.3

