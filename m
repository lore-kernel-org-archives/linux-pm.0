From: Dave Hansen <dave@sr71.net>
Subject: [PATCH 07/20] x86, intel: use Intel model macros intead of open-coding
Date: Thu, 02 Jun 2016 17:19:36 -0700
Message-ID: <20160603001936.F474F9D8@viggo.jf.intel.com>
References: <20160603001927.F2A7D828@viggo.jf.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160603001927.F2A7D828@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, jacob.jun.pan@intel.com, Dave Hansen <dave@sr71.net>, dave.hansen@linux.intel.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Use the new macros to remove another large set of open-coded values.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
---

 b/arch/x86/include/asm/intel-family.h |    2 +
 b/drivers/powercap/intel_rapl.c       |   43 +++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff -puN drivers/powercap/intel_rapl.c~x86-intel-familites-powercap-rapl drivers/powercap/intel_rapl.c
--- a/drivers/powercap/intel_rapl.c~x86-intel-familites-powercap-rapl	2016-06-02 15:25:59.902487254 -0700
+++ b/drivers/powercap/intel_rapl.c	2016-06-02 15:26:40.170305768 -0700
@@ -33,6 +33,7 @@
 
 #include <asm/processor.h>
 #include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
 
 /* Local defines */
 #define MSR_PLATFORM_POWER_LIMIT	0x0000065C
@@ -1096,27 +1097,27 @@ static const struct rapl_defaults rapl_d
 		}
 
 static const struct x86_cpu_id rapl_ids[] __initconst = {
-	RAPL_CPU(0x2a, rapl_defaults_core),/* Sandy Bridge */
-	RAPL_CPU(0x2d, rapl_defaults_core),/* Sandy Bridge EP */
-	RAPL_CPU(0x37, rapl_defaults_byt),/* Valleyview */
-	RAPL_CPU(0x3a, rapl_defaults_core),/* Ivy Bridge */
-	RAPL_CPU(0x3c, rapl_defaults_core),/* Haswell */
-	RAPL_CPU(0x3d, rapl_defaults_core),/* Broadwell */
-	RAPL_CPU(0x3f, rapl_defaults_hsw_server),/* Haswell servers */
-	RAPL_CPU(0x4f, rapl_defaults_hsw_server),/* Broadwell servers */
-	RAPL_CPU(0x45, rapl_defaults_core),/* Haswell ULT */
-	RAPL_CPU(0x46, rapl_defaults_core),/* Haswell */
-	RAPL_CPU(0x47, rapl_defaults_core),/* Broadwell-H */
-	RAPL_CPU(0x4E, rapl_defaults_core),/* Skylake */
-	RAPL_CPU(0x4C, rapl_defaults_cht),/* Braswell/Cherryview */
-	RAPL_CPU(0x4A, rapl_defaults_tng),/* Tangier */
-	RAPL_CPU(0x56, rapl_defaults_core),/* Future Xeon */
-	RAPL_CPU(0x5A, rapl_defaults_ann),/* Annidale */
-	RAPL_CPU(0X5C, rapl_defaults_core),/* Broxton */
-	RAPL_CPU(0x5E, rapl_defaults_core),/* Skylake-H/S */
-	RAPL_CPU(0x57, rapl_defaults_hsw_server),/* Knights Landing */
-	RAPL_CPU(0x8E, rapl_defaults_core),/* Kabylake */
-	RAPL_CPU(0x9E, rapl_defaults_core),/* Kabylake */
+	RAPL_CPU(INTEL_FAM6_SANDYBRIDGE,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_SANDYBRIDGE_X,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_ATOM_SILVERMONT1,	rapl_defaults_byt),
+	RAPL_CPU(INTEL_FAM6_IVYBRIDGE,		rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_HASWELL_CORE,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_BROADWELL_CORE,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_HASWELL_X,		rapl_defaults_hsw_server),
+	RAPL_CPU(INTEL_FAM6_BROADWELL_X,	rapl_defaults_hsw_server),
+	RAPL_CPU(INTEL_FAM6_HASWELL_ULT,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_HASWELL_GT3E,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_BROADWELL_GT3E,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_SKYLAKE_MOBILE,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_ATOM_AIRMONT,	rapl_defaults_cht),
+	RAPL_CPU(INTEL_FAM6_ATOM_MERRIFIELD1,	rapl_defaults_tng),
+	RAPL_CPU(INTEL_FAM6_BROADWELL_XEON_D,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_ATOM_MERRIFIELD2,	rapl_defaults_ann),
+	RAPL_CPU(INTEL_FAM6_ATOM_GOLDMONT,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_SKYLAKE_DESKTOP,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_XEON_PHI_KNL,	rapl_defaults_hsw_server),
+	RAPL_CPU(INTEL_FAM6_KABYLAKE_MOBILE,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_KABYLAKE_DESKTOP,	rapl_defaults_core),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
diff -puN arch/x86/include/asm/intel-family.h~x86-intel-familites-powercap-rapl arch/x86/include/asm/intel-family.h
--- a/arch/x86/include/asm/intel-family.h~x86-intel-familites-powercap-rapl	2016-06-02 15:26:52.676870602 -0700
+++ b/arch/x86/include/asm/intel-family.h	2016-06-02 15:28:49.234135388 -0700
@@ -56,6 +56,8 @@
 #define INTEL_FAM6_ATOM_SILVERMONT1	0x37 /* BayTrail/BYT */
 #define INTEL_FAM6_ATOM_SILVERMONT2	0x4D /* Avaton/Rangely */
 #define INTEL_FAM6_ATOM_AIRMONT		0x4C /* CherryTrail */
+#define INTEL_FAM6_ATOM_MERRIFIELD1	0x4A /* Tangier */
+#define INTEL_FAM6_ATOM_MERRIFIELD2	0x5A /* Annidale */
 #define INTEL_FAM6_ATOM_GOLDMONT	0x5C
 #define INTEL_FAM6_ATOM_DENVERTON	0x5F /* Goldmont Microserver */
 
_
