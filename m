From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/3] cpufreq: intel_pstate: Don't use ACPI perf for HWP
Date: Mon,  9 Nov 2015 18:58:09 -0800
Message-ID: <1447124291-14059-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1447124291-14059-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:48368 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbbKJC7E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Nov 2015 21:59:04 -0500
In-Reply-To: <1447124291-14059-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, lenlenb@kernel.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When HWP is enabled, the information in _PSS and _PPC prevents entering
turbo states. The reason is HWP and legacy pstate are not compatible.
There is no processing of turbo activation ratio in HWP, but _PPC setting
still behaves as there is support. So we end up in a pstate, which is
below or equal to max non turbo ratio. Also the max turbo ratio is set to
wrong value in _PSS, so even if HWP is disabled to use acpi-cpufrq or
intel_pstate in legacy mode, this will still cause issue. This change will
not read any _PSS table or call acpi_processor_register_performance,
when the platform has HWP feature.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 93a3c63..a0b8180 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1557,8 +1557,11 @@ static int __init intel_pstate_init(void)
 	if (!all_cpu_data)
 		return -ENOMEM;
 
-	if (static_cpu_has_safe(X86_FEATURE_HWP) && !no_hwp)
-		hwp_active++;
+	if (static_cpu_has_safe(X86_FEATURE_HWP)) {
+		if (!no_hwp)
+			hwp_active++;
+		no_acpi_perf = 1;
+	}
 
 	if (!hwp_active && hwp_only)
 		goto out;
-- 
1.9.3

