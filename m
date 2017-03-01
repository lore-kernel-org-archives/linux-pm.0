From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/44] intel_pstate: use MSR_ATOM_RATIOS definitions from msr-index.h
Date: Wed,  1 Mar 2017 00:27:19 -0500
Message-ID: <92134bdbc6272da6e98e9242cc6f1576cedc0735.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35095 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbdCAFkR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 00:40:17 -0500
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Originally, these MSRs were locally defined in this driver.
Now the definitions are in msr-index.h -- use them.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 50bd6d987fc3..6e68b556305a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -39,11 +39,6 @@
 
 #define INTEL_CPUFREQ_TRANSITION_LATENCY	20000
 
-#define ATOM_RATIOS		0x66a
-#define ATOM_VIDS		0x66b
-#define ATOM_TURBO_RATIOS	0x66c
-#define ATOM_TURBO_VIDS		0x66d
-
 #ifdef CONFIG_ACPI
 #include <acpi/processor.h>
 #include <acpi/cppc_acpi.h>
@@ -1258,7 +1253,7 @@ static int atom_get_min_pstate(void)
 {
 	u64 value;
 
-	rdmsrl(ATOM_RATIOS, value);
+	rdmsrl(MSR_ATOM_CORE_RATIOS, value);
 	return (value >> 8) & 0x7F;
 }
 
@@ -1266,7 +1261,7 @@ static int atom_get_max_pstate(void)
 {
 	u64 value;
 
-	rdmsrl(ATOM_RATIOS, value);
+	rdmsrl(MSR_ATOM_CORE_RATIOS, value);
 	return (value >> 16) & 0x7F;
 }
 
@@ -1274,7 +1269,7 @@ static int atom_get_turbo_pstate(void)
 {
 	u64 value;
 
-	rdmsrl(ATOM_TURBO_RATIOS, value);
+	rdmsrl(MSR_ATOM_CORE_TURBO_RATIOS, value);
 	return value & 0x7F;
 }
 
@@ -1336,7 +1331,7 @@ static void atom_get_vid(struct cpudata *cpudata)
 {
 	u64 value;
 
-	rdmsrl(ATOM_VIDS, value);
+	rdmsrl(MSR_ATOM_CORE_VIDS, value);
 	cpudata->vid.min = int_tofp((value >> 8) & 0x7f);
 	cpudata->vid.max = int_tofp((value >> 16) & 0x7f);
 	cpudata->vid.ratio = div_fp(
@@ -1344,7 +1339,7 @@ static void atom_get_vid(struct cpudata *cpudata)
 		int_tofp(cpudata->pstate.max_pstate -
 			cpudata->pstate.min_pstate));
 
-	rdmsrl(ATOM_TURBO_VIDS, value);
+	rdmsrl(MSR_ATOM_CORE_TURBO_VIDS, value);
 	cpudata->vid.turbo = value & 0x7f;
 }
 
-- 
2.11.0.161.g6610af872
