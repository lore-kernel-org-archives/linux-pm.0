From: Dave Hansen <dave@sr71.net>
Subject: [PATCH 13/20] x86, cpufreq: use Intel family name macros for intel_pstate cpufreq driver
Date: Wed, 01 Jun 2016 17:12:15 -0700
Message-ID: <20160602001215.771A0149@viggo.jf.intel.com>
References: <20160602001157.D8BE59D7@viggo.jf.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160602001157.D8BE59D7@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Dave Hansen <dave@sr71.net>, dave.hansen@linux.intel.com, srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Another straightforward replacement of magic numbers.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
---

 b/drivers/cpufreq/intel_pstate.c |   37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff -puN drivers/cpufreq/intel_pstate.c~x86-intel-families-cpufreq-pstate drivers/cpufreq/intel_pstate.c
--- a/drivers/cpufreq/intel_pstate.c~x86-intel-families-cpufreq-pstate	2016-06-01 15:45:08.102122880 -0700
+++ b/drivers/cpufreq/intel_pstate.c	2016-06-01 15:45:08.106123062 -0700
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
+	ICPU(INTEL_FAM6_MODEL_SANDYBRIDGE, core_params),
+	ICPU(INTEL_FAM6_MODEL_SANDYBRIDGE_X, core_params),
+	ICPU(INTEL_FAM6_MODEL_ATOM_SILVERMONT1, silvermont_params),
+	ICPU(INTEL_FAM6_MODEL_IVYBRIDGE, core_params),
+	ICPU(INTEL_FAM6_MODEL_HASWELL_CORE, core_params),
+	ICPU(INTEL_FAM6_MODEL_BROADWELL_CORE_M, core_params),
+	ICPU(INTEL_FAM6_MODEL_IVYBRIDGE_X, core_params),
+	ICPU(INTEL_FAM6_MODEL_HASWELL_X, core_params),
+	ICPU(INTEL_FAM6_MODEL_HASWELL_ULT, core_params),
+	ICPU(INTEL_FAM6_MODEL_HASWELL_GT3E, core_params),
+	ICPU(INTEL_FAM6_MODEL_BROADWELL_GT3E, core_params),
+	ICPU(INTEL_FAM6_MODEL_ATOM_AIRMONT, airmont_params),
+	ICPU(INTEL_FAM6_MODEL_SKYLAKE_MOBILE, core_params),
+	ICPU(INTEL_FAM6_MODEL_BROADWELL_X, core_params),
+	ICPU(INTEL_FAM6_MODEL_SKYLAKE_DESKTOP, core_params),
+	ICPU(INTEL_FAM6_MODEL_BROADWELL_XEON_D, core_params),
+	ICPU(INTEL_FAM6_MODEL_XEON_PHI_KNL, knl_params),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
 
 static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] = {
-	ICPU(0x56, core_params),
+	ICPU(INTEL_FAM6_MODEL_BROADWELL_XEON_D, core_params),
 	{}
 };
 
_
