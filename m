From: Dave Hansen <dave@sr71.net>
Subject: [PATCH 08/20] x86, rapl: reorder cpu detection table
Date: Thu, 02 Jun 2016 17:19:37 -0700
Message-ID: <20160603001937.B53A383A@viggo.jf.intel.com>
References: <20160603001927.F2A7D828@viggo.jf.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160603001927.F2A7D828@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, jacob.jun.pan@intel.com, Dave Hansen <dave@sr71.net>, dave.hansen@linux.intel.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Let's make an effort to group these things by microarchitecture
name.  It makes it easier to see if something got missed.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
---

 b/drivers/powercap/intel_rapl.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff -puN drivers/powercap/intel_rapl.c~x86-intel-familites-powercap-rapl-reorder drivers/powercap/intel_rapl.c
--- a/drivers/powercap/intel_rapl.c~x86-intel-familites-powercap-rapl-reorder	2016-06-02 15:19:19.006249411 -0700
+++ b/drivers/powercap/intel_rapl.c	2016-06-02 15:19:19.011249639 -0700
@@ -1099,25 +1099,31 @@ static const struct rapl_defaults rapl_d
 static const struct x86_cpu_id rapl_ids[] __initconst = {
 	RAPL_CPU(INTEL_FAM6_SANDYBRIDGE,	rapl_defaults_core),
 	RAPL_CPU(INTEL_FAM6_SANDYBRIDGE_X,	rapl_defaults_core),
-	RAPL_CPU(INTEL_FAM6_ATOM_SILVERMONT1,	rapl_defaults_byt),
+
 	RAPL_CPU(INTEL_FAM6_IVYBRIDGE,		rapl_defaults_core),
+
 	RAPL_CPU(INTEL_FAM6_HASWELL_CORE,	rapl_defaults_core),
-	RAPL_CPU(INTEL_FAM6_BROADWELL_CORE,	rapl_defaults_core),
-	RAPL_CPU(INTEL_FAM6_HASWELL_X,		rapl_defaults_hsw_server),
-	RAPL_CPU(INTEL_FAM6_BROADWELL_X,	rapl_defaults_hsw_server),
 	RAPL_CPU(INTEL_FAM6_HASWELL_ULT,	rapl_defaults_core),
 	RAPL_CPU(INTEL_FAM6_HASWELL_GT3E,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_HASWELL_X,		rapl_defaults_hsw_server),
+
+	RAPL_CPU(INTEL_FAM6_BROADWELL_CORE,	rapl_defaults_core),
 	RAPL_CPU(INTEL_FAM6_BROADWELL_GT3E,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_BROADWELL_XEON_D,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_BROADWELL_X,	rapl_defaults_hsw_server),
+
+	RAPL_CPU(INTEL_FAM6_SKYLAKE_DESKTOP,	rapl_defaults_core),
 	RAPL_CPU(INTEL_FAM6_SKYLAKE_MOBILE,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_KABYLAKE_MOBILE,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_KABYLAKE_DESKTOP,	rapl_defaults_core),
+
+	RAPL_CPU(INTEL_FAM6_ATOM_SILVERMONT1,	rapl_defaults_byt),
 	RAPL_CPU(INTEL_FAM6_ATOM_AIRMONT,	rapl_defaults_cht),
 	RAPL_CPU(INTEL_FAM6_ATOM_MERRIFIELD1,	rapl_defaults_tng),
-	RAPL_CPU(INTEL_FAM6_BROADWELL_XEON_D,	rapl_defaults_core),
 	RAPL_CPU(INTEL_FAM6_ATOM_MERRIFIELD2,	rapl_defaults_ann),
 	RAPL_CPU(INTEL_FAM6_ATOM_GOLDMONT,	rapl_defaults_core),
-	RAPL_CPU(INTEL_FAM6_SKYLAKE_DESKTOP,	rapl_defaults_core),
+
 	RAPL_CPU(INTEL_FAM6_XEON_PHI_KNL,	rapl_defaults_hsw_server),
-	RAPL_CPU(INTEL_FAM6_KABYLAKE_MOBILE,	rapl_defaults_core),
-	RAPL_CPU(INTEL_FAM6_KABYLAKE_DESKTOP,	rapl_defaults_core),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
_
