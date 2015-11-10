From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/3] cpufreq: intel_pstate: Fix the scaling of _PSS entry[0]
Date: Mon,  9 Nov 2015 18:58:11 -0800
Message-ID: <1447124291-14059-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1447124291-14059-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:43581 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbbKJC7F (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Nov 2015 21:59:05 -0500
In-Reply-To: <1447124291-14059-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, lenlenb@kernel.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Since even non core platforms like Atom SoC has _PSS table, we can't
hardcode scaling. Instead we can use cpu->pstate.scaling. We need to
convert to MHz as the scaling values are in KHz.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 69dc9b5..50d3cff 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -312,7 +312,7 @@ static int intel_pstate_init_perf_limits(struct cpufreq_policy *policy)
 		 * Also need to convert to MHz as _PSS freq is in MHz.
 		 */
 		cpu->acpi_perf_data.states[0].core_frequency =
-						turbo_pss_ctl * 100;
+				turbo_pss_ctl * cpu->pstate.scaling / 1000;
 	}
 
 	pr_debug("intel_pstate: Updated limits using _PSS 0x%x 0x%x 0x%x\n",
-- 
1.9.3

