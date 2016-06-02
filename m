From: Dave Hansen <dave@sr71.net>
Subject: [PATCH 04/20] x86, intel_idle: use Intel family macros for intel_idle
Date: Wed, 01 Jun 2016 17:12:03 -0700
Message-ID: <20160602001203.177FD5D9@viggo.jf.intel.com>
References: <20160602001157.D8BE59D7@viggo.jf.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160602001157.D8BE59D7@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Dave Hansen <dave@sr71.net>, dave.hansen@linux.intel.com, lenb@kernel.org, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com
List-Id: linux-pm@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Use the new INTEL_FAM6_MODEL_* macros for intel_idle.c.  Also fix
up some of the macros to be consistent with how some of the
intel_idle code refers to the model.

There's on oddity here: model 0x1F is uniquely referred to here
and nowhere else that I could find.  0x1E/0x1F are just spelled
out as "Intel Core i7 and i5 Processors" in the SDM or as "Intel
processors based on the Nehalem, Westmere microarchitectures" in
the RDPMC section.  Comments between tables 19-19 and 19-20 in
the SDM seem to point to 0x1F being some kind of Westmere, so
let's call it "WESTMERE2".

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

 b/arch/x86/include/asm/intel-family.h |   10 +++-
 b/drivers/idle/intel_idle.c           |   71 +++++++++++++++++-----------------
 2 files changed, 43 insertions(+), 38 deletions(-)

diff -puN arch/x86/include/asm/intel-family.h~x86-intel-familites-intelidle arch/x86/include/asm/intel-family.h
--- a/arch/x86/include/asm/intel-family.h~x86-intel-familites-intelidle	2016-06-01 15:45:04.180944067 -0700
+++ b/arch/x86/include/asm/intel-family.h	2016-06-01 15:45:04.187944386 -0700
@@ -6,6 +6,9 @@
  *
  * The "_X" parts are generally the EP and EX Xeons, or the
  * "Extreme" ones, like Broadwell-E.
+ *
+ * Things ending in "2" are usually because we have no better
+ * name for them.  There's no processor called "WESTMERE2".
  */
 
 #define INTEL_FAM6_MODEL_CORE_YONAH		0x0E
@@ -17,12 +20,13 @@
 #define INTEL_FAM6_MODEL_NEHALEM_EP		0x1A
 #define INTEL_FAM6_MODEL_NEHALEM_EX		0x2E
 #define INTEL_FAM6_MODEL_WESTMERE		0x25
+#define INTEL_FAM6_MODEL_WESTMERE2		0x1F
 #define INTEL_FAM6_MODEL_WESTMERE_EP		0x2C
 #define INTEL_FAM6_MODEL_WESTMERE_EX		0x2F
 #define INTEL_FAM6_MODEL_SANDYBRIDGE		0x2A
 #define INTEL_FAM6_MODEL_SANDYBRIDGE_X		0x2D
 #define INTEL_FAM6_MODEL_IVYBRIDGE		0x3A
-#define INTEL_FAM6_MODEL_IVYBRIDGE_X		0x3E
+#define INTEL_FAM6_MODEL_IVYBRIDGE_X		0x3E /* aka. Ivy Town / IVT */
 #define INTEL_FAM6_MODEL_HASWELL_CORE		0x3C
 #define INTEL_FAM6_MODEL_HASWELL_X		0x3F
 #define INTEL_FAM6_MODEL_HASWELL_ULT		0x45
@@ -44,9 +48,9 @@
 #define INTEL_FAM6_MODEL_ATOM_PENWELL		0x27
 #define INTEL_FAM6_MODEL_ATOM_CLOVERVIEW	0x35
 #define INTEL_FAM6_MODEL_ATOM_CEDARVIEW		0x36
-#define INTEL_FAM6_MODEL_ATOM_SILVERMONT1	0x37
+#define INTEL_FAM6_MODEL_ATOM_SILVERMONT1	0x37 /* BayTrail/BYT */
 #define INTEL_FAM6_MODEL_ATOM_SILVERMONT2	0x4D /* Avaton/Rangely */
-#define INTEL_FAM6_MODEL_ATOM_AIRMONT		0x4C
+#define INTEL_FAM6_MODEL_ATOM_AIRMONT		0x4C /* CherryTrail */
 #define INTEL_FAM6_MODEL_ATOM_GOLDMONT		0x5C
 #define INTEL_FAM6_MODEL_ATOM_DENVERTON		0x5F /* Goldmont Microserver */
 
diff -puN drivers/idle/intel_idle.c~x86-intel-familites-intelidle drivers/idle/intel_idle.c
--- a/drivers/idle/intel_idle.c~x86-intel-familites-intelidle	2016-06-01 15:45:04.182944158 -0700
+++ b/drivers/idle/intel_idle.c	2016-06-01 15:45:04.189944477 -0700
@@ -62,6 +62,7 @@
 #include <linux/cpu.h>
 #include <linux/module.h>
 #include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
 #include <asm/mwait.h>
 #include <asm/msr.h>
 
@@ -1020,38 +1021,38 @@ static const struct idle_cpu idle_cpu_bx
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_MWAIT, (unsigned long)&cpu }
 
 static const struct x86_cpu_id intel_idle_ids[] __initconst = {
-	ICPU(0x1a, idle_cpu_nehalem),
-	ICPU(0x1e, idle_cpu_nehalem),
-	ICPU(0x1f, idle_cpu_nehalem),
-	ICPU(0x25, idle_cpu_nehalem),
-	ICPU(0x2c, idle_cpu_nehalem),
-	ICPU(0x2e, idle_cpu_nehalem),
-	ICPU(0x1c, idle_cpu_atom),
-	ICPU(0x26, idle_cpu_lincroft),
-	ICPU(0x2f, idle_cpu_nehalem),
-	ICPU(0x2a, idle_cpu_snb),
-	ICPU(0x2d, idle_cpu_snb),
-	ICPU(0x36, idle_cpu_atom),
-	ICPU(0x37, idle_cpu_byt),
-	ICPU(0x4c, idle_cpu_cht),
-	ICPU(0x3a, idle_cpu_ivb),
-	ICPU(0x3e, idle_cpu_ivt),
-	ICPU(0x3c, idle_cpu_hsw),
-	ICPU(0x3f, idle_cpu_hsw),
-	ICPU(0x45, idle_cpu_hsw),
-	ICPU(0x46, idle_cpu_hsw),
-	ICPU(0x4d, idle_cpu_avn),
-	ICPU(0x3d, idle_cpu_bdw),
-	ICPU(0x47, idle_cpu_bdw),
-	ICPU(0x4f, idle_cpu_bdw),
-	ICPU(0x56, idle_cpu_bdw),
-	ICPU(0x4e, idle_cpu_skl),
-	ICPU(0x5e, idle_cpu_skl),
-	ICPU(0x8e, idle_cpu_skl),
-	ICPU(0x9e, idle_cpu_skl),
-	ICPU(0x55, idle_cpu_skx),
-	ICPU(0x57, idle_cpu_knl),
-	ICPU(0x5c, idle_cpu_bxt),
+	ICPU(INTEL_FAM6_MODEL_NEHALEM_EP,	idle_cpu_nehalem),
+	ICPU(INTEL_FAM6_MODEL_NEHALEM,		idle_cpu_nehalem),
+	ICPU(INTEL_FAM6_MODEL_WESTMERE2,	idle_cpu_nehalem),
+	ICPU(INTEL_FAM6_MODEL_WESTMERE,		idle_cpu_nehalem),
+	ICPU(INTEL_FAM6_MODEL_WESTMERE_EP,	idle_cpu_nehalem),
+	ICPU(INTEL_FAM6_MODEL_NEHALEM_EX,	idle_cpu_nehalem),
+	ICPU(INTEL_FAM6_MODEL_ATOM_PINEVIEW,	idle_cpu_atom),
+	ICPU(INTEL_FAM6_MODEL_ATOM_LINCROFT,	idle_cpu_lincroft),
+	ICPU(INTEL_FAM6_MODEL_WESTMERE_EX,	idle_cpu_nehalem),
+	ICPU(INTEL_FAM6_MODEL_SANDYBRIDGE,	idle_cpu_snb),
+	ICPU(INTEL_FAM6_MODEL_SANDYBRIDGE_X,	idle_cpu_snb),
+	ICPU(INTEL_FAM6_MODEL_ATOM_CEDARVIEW,	idle_cpu_atom),
+	ICPU(INTEL_FAM6_MODEL_ATOM_SILVERMONT1,	idle_cpu_byt),
+	ICPU(INTEL_FAM6_MODEL_ATOM_AIRMONT,	idle_cpu_cht),
+	ICPU(INTEL_FAM6_MODEL_IVYBRIDGE,	idle_cpu_ivb),
+	ICPU(INTEL_FAM6_MODEL_IVYBRIDGE_X,	idle_cpu_ivt),
+	ICPU(INTEL_FAM6_MODEL_HASWELL_CORE,	idle_cpu_hsw),
+	ICPU(INTEL_FAM6_MODEL_HASWELL_X,	idle_cpu_hsw),
+	ICPU(INTEL_FAM6_MODEL_HASWELL_ULT,	idle_cpu_hsw),
+	ICPU(INTEL_FAM6_MODEL_HASWELL_GT3E,	idle_cpu_hsw),
+	ICPU(INTEL_FAM6_MODEL_ATOM_SILVERMONT2,	idle_cpu_avn),
+	ICPU(INTEL_FAM6_MODEL_BROADWELL_CORE_M,	idle_cpu_bdw),
+	ICPU(INTEL_FAM6_MODEL_BROADWELL_GT3E,	idle_cpu_bdw),
+	ICPU(INTEL_FAM6_MODEL_BROADWELL_X,	idle_cpu_bdw),
+	ICPU(INTEL_FAM6_MODEL_BROADWELL_XEON_D,	idle_cpu_bdw),
+	ICPU(INTEL_FAM6_MODEL_SKYLAKE_MOBILE,	idle_cpu_skl),
+	ICPU(INTEL_FAM6_MODEL_SKYLAKE_DESKTOP,	idle_cpu_skl),
+	ICPU(INTEL_FAM6_MODEL_KABYLAKE_MOBILE,	idle_cpu_skl),
+	ICPU(INTEL_FAM6_MODEL_KABYLAKE_DESKTOP,	idle_cpu_skl),
+	ICPU(INTEL_FAM6_MODEL_SKYLAKE_X,	idle_cpu_skx),
+	ICPU(INTEL_FAM6_MODEL_XEON_PHI_KNL,	idle_cpu_knl),
+	ICPU(INTEL_FAM6_MODEL_ATOM_GOLDMONT,	idle_cpu_bxt),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_idle_ids);
@@ -1261,13 +1262,13 @@ static void intel_idle_state_table_updat
 {
 	switch (boot_cpu_data.x86_model) {
 
-	case 0x3e: /* IVT */
+	case INTEL_FAM6_MODEL_IVYBRIDGE_X:
 		ivt_idle_state_table_update();
 		break;
-	case 0x5c: /* BXT */
+	case INTEL_FAM6_MODEL_ATOM_GOLDMONT:
 		bxt_idle_state_table_update();
 		break;
-	case 0x5e: /* SKL-H */
+	case INTEL_FAM6_MODEL_SKYLAKE_DESKTOP:
 		sklh_idle_state_table_update();
 		break;
 	}
_
