From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Ignore _PPC processing under HWP
Date: Wed,  4 May 2016 15:07:34 -0700
Message-ID: <1462399654-15005-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13420 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754191AbcEDWGj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 4 May 2016 18:06:39 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When HWP (hardware P states) feature is active, the ACPI _PSS and _PPC
is not used. So ignore processing for _PPC limits.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 97a8278..0620fa6 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -378,6 +378,9 @@ static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 	int ret;
 	int i;
 
+	if (hwp_active)
+		return;
+
 	if (!intel_pstate_get_ppc_enable_status())
 		return;
 
-- 
2.5.5

