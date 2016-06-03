From: Dave Hansen <dave@sr71.net>
Subject: [PATCH 13/20] x86, cpufreq: use Intel family name macros for intel_pstate cpufreq driver
Date: Thu, 02 Jun 2016 17:19:45 -0700
Message-ID: <20160603001945.0F5D02AA@viggo.jf.intel.com>
References: <20160603001927.F2A7D828@viggo.jf.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62841 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753093AbcFCATq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 2 Jun 2016 20:19:46 -0400
In-Reply-To: <20160603001927.F2A7D828@viggo.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, jacob.jun.pan@intel.com, Dave Hansen <dave@sr71.net>, dave.hansen@linux.intel.com, rjw@rjwysocki.net, srinivas.pandruvada@linux.intel.com, lenb@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Another straightforward replacement of magic numbers.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
---

 b/drivers/cpufreq/intel_pstate.c |   37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff -puN drivers/cpufreq/intel_pstate.c~x86-intel-families-cpufreq-pstate drivers/cpufreq/intel_pstate.c
--- a/drivers/cpufreq/intel_pstate.c~x86-intel-families-cpufreq-pstate	2016-06-02 15:19:21.152347090 -0700
+++ b/drivers/cpufreq/intel_pstate.c	2016-06-02 15:19:21.157347317 -0700
@@ -35,6 +35,7 @@
 #include <asm/msr.h>
 #include <asm/cpu_device_id.h>
 #include <asm/cpufeature.h>
+#include <asm/intel-family.h>
 
 #define ATOM_RATIOS		0x66a
 #define ATOM_VIDS		0x66b
@@ -1352,29 +1353,29 @@ static void intel_pstate_update_util(str
 			(unsigned long)&policy }
 
 static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
-	ICPU(0x2a, core_params),
-	ICPU(0x2d, core_params),
-	ICPU(0x37, silvermont_params),
-	ICPU(0x3a, core_params),
-	ICPU(0x3c, core_params),
-	ICPU(0x3d, core_params),
-	ICPU(0x3e, core_params),
-	ICPU(0x3f, core_params),
-	ICPU(0x45, core_params),
-	ICPU(0x46, core_params),
-	ICPU(0x47, core_params),
-	ICPU(0x4c, airmont_params),
-	ICPU(0x4e, core_params),
-	ICPU(0x4f, core_params),
-	ICPU(0x5e, core_params),
-	ICPU(0x56, core_params),
-	ICPU(0x57, knl_params),
+	ICPU(INTEL_FAM6_SANDYBRIDGE, 		core_params),
+	ICPU(INTEL_FAM6_SANDYBRIDGE_X,		core_params),
+	ICPU(INTEL_FAM6_ATOM_SILVERMONT1,	silvermont_params),
+	ICPU(INTEL_FAM6_IVYBRIDGE,		core_params),
+	ICPU(INTEL_FAM6_HASWELL_CORE,		core_params),
+	ICPU(INTEL_FAM6_BROADWELL_CORE,		core_params),
+	ICPU(INTEL_FAM6_IVYBRIDGE_X,		core_params),
+	ICPU(INTEL_FAM6_HASWELL_X,		core_params),
+	ICPU(INTEL_FAM6_HASWELL_ULT,		core_params),
+	ICPU(INTEL_FAM6_HASWELL_GT3E,		core_params),
+	ICPU(INTEL_FAM6_BROADWELL_GT3E,		core_params),
+	ICPU(INTEL_FAM6_ATOM_AIRMONT,		airmont_params),
+	ICPU(INTEL_FAM6_SKYLAKE_MOBILE,		core_params),
+	ICPU(INTEL_FAM6_BROADWELL_X,		core_params),
+	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP,	core_params),
+	ICPU(INTEL_FAM6_BROADWELL_XEON_D,	core_params),
+	ICPU(INTEL_FAM6_XEON_PHI_KNL,		knl_params),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
 
 static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] = {
-	ICPU(0x56, core_params),
+	ICPU(INTEL_FAM6_BROADWELL_XEON_D, core_params),
 	{}
 };
 
_
