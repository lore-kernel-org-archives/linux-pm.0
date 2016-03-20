From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 1/2] perf/x86/intel/rapl: support Skylake RAPL domains
Date: Sun, 20 Mar 2016 16:26:31 -0700
Message-ID: <1458516392-2130-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1458516392-2130-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:12878 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211AbcCTX0Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 20 Mar 2016 19:26:25 -0400
In-Reply-To: <1458516392-2130-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net
Cc: bp@alien8.de, ak@linux.intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jacob.jun.pan@linux.intel.com, x86@kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Added Skylake support for RAPL domains. In addition to RAPL domains in
Broadwell clients, it has support for platform domain (aka PSys).

Also fixed error in comment for gpu counter, which previously was dram
counter.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 arch/x86/events/intel/rapl.c     | 50 ++++++++++++++++++++++++++++++++++++++--
 arch/x86/include/asm/msr-index.h |  2 ++
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index b834a3f..69904e7 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -27,10 +27,14 @@
  *	  event: rapl_energy_dram
  *    perf code: 0x3
  *
- * dram counter: consumption of the builtin-gpu domain (client only)
+ * gpu counter: consumption of the builtin-gpu domain (client only)
  *	  event: rapl_energy_gpu
  *    perf code: 0x4
  *
+ *  psys counter: consumption of the builtin-psys domain (client only)
+ *	  event: rapl_energy_psys
+ *    perf code: 0x5
+ *
  * We manage those counters as free running (read-only). They may be
  * use simultaneously by other tools, such as turbostat.
  *
@@ -64,13 +68,16 @@
 #define INTEL_RAPL_RAM		0x3	/* pseudo-encoding */
 #define RAPL_IDX_PP1_NRG_STAT	3	/* gpu */
 #define INTEL_RAPL_PP1		0x4	/* pseudo-encoding */
+#define RAPL_IDX_PSYS_NRG_STAT	4	/* psys */
+#define INTEL_RAPL_PSYS		0x5	/* pseudo-encoding */
 
-#define NR_RAPL_DOMAINS         0x4
+#define NR_RAPL_DOMAINS         0x5
 static const char *const rapl_domain_names[NR_RAPL_DOMAINS] __initconst = {
 	"pp0-core",
 	"package",
 	"dram",
 	"pp1-gpu",
+	"psys",
 };
 
 /* Clients have PP0, PKG */
@@ -89,6 +96,13 @@ static const char *const rapl_domain_names[NR_RAPL_DOMAINS] __initconst = {
 			 1<<RAPL_IDX_RAM_NRG_STAT|\
 			 1<<RAPL_IDX_PP1_NRG_STAT)
 
+/* SKL clients have PP0, PKG, RAM, PP1, PSYS */
+#define RAPL_IDX_SKL	(1<<RAPL_IDX_PP0_NRG_STAT|\
+			 1<<RAPL_IDX_PKG_NRG_STAT|\
+			 1<<RAPL_IDX_RAM_NRG_STAT|\
+			 1<<RAPL_IDX_PP1_NRG_STAT|\
+			 1<<RAPL_IDX_PSYS_NRG_STAT)
+
 /* Knights Landing has PKG, RAM */
 #define RAPL_IDX_KNL	(1<<RAPL_IDX_PKG_NRG_STAT|\
 			 1<<RAPL_IDX_RAM_NRG_STAT)
@@ -360,6 +374,10 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		bit = RAPL_IDX_PP1_NRG_STAT;
 		msr = MSR_PP1_ENERGY_STATUS;
 		break;
+	case INTEL_RAPL_PSYS:
+		bit = RAPL_IDX_PSYS_NRG_STAT;
+		msr = MSR_PLATFORM_ENERGY_STATUS;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -414,11 +432,13 @@ RAPL_EVENT_ATTR_STR(energy-cores, rapl_cores, "event=0x01");
 RAPL_EVENT_ATTR_STR(energy-pkg  ,   rapl_pkg, "event=0x02");
 RAPL_EVENT_ATTR_STR(energy-ram  ,   rapl_ram, "event=0x03");
 RAPL_EVENT_ATTR_STR(energy-gpu  ,   rapl_gpu, "event=0x04");
+RAPL_EVENT_ATTR_STR(energy-psys,   rapl_psys, "event=0x05");
 
 RAPL_EVENT_ATTR_STR(energy-cores.unit, rapl_cores_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-pkg.unit  ,   rapl_pkg_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-ram.unit  ,   rapl_ram_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-gpu.unit  ,   rapl_gpu_unit, "Joules");
+RAPL_EVENT_ATTR_STR(energy-psys.unit,   rapl_psys_unit, "Joules");
 
 /*
  * we compute in 0.23 nJ increments regardless of MSR
@@ -427,6 +447,7 @@ RAPL_EVENT_ATTR_STR(energy-cores.scale, rapl_cores_scale, "2.3283064365386962890
 RAPL_EVENT_ATTR_STR(energy-pkg.scale,     rapl_pkg_scale, "2.3283064365386962890625e-10");
 RAPL_EVENT_ATTR_STR(energy-ram.scale,     rapl_ram_scale, "2.3283064365386962890625e-10");
 RAPL_EVENT_ATTR_STR(energy-gpu.scale,     rapl_gpu_scale, "2.3283064365386962890625e-10");
+RAPL_EVENT_ATTR_STR(energy-psys.scale,   rapl_psys_scale, "2.3283064365386962890625e-10");
 
 static struct attribute *rapl_events_srv_attr[] = {
 	EVENT_PTR(rapl_cores),
@@ -476,6 +497,27 @@ static struct attribute *rapl_events_hsw_attr[] = {
 	NULL,
 };
 
+static struct attribute *rapl_events_skl_attr[] = {
+	EVENT_PTR(rapl_cores),
+	EVENT_PTR(rapl_pkg),
+	EVENT_PTR(rapl_gpu),
+	EVENT_PTR(rapl_ram),
+	EVENT_PTR(rapl_psys),
+
+	EVENT_PTR(rapl_cores_unit),
+	EVENT_PTR(rapl_pkg_unit),
+	EVENT_PTR(rapl_gpu_unit),
+	EVENT_PTR(rapl_ram_unit),
+	EVENT_PTR(rapl_psys_unit),
+
+	EVENT_PTR(rapl_cores_scale),
+	EVENT_PTR(rapl_pkg_scale),
+	EVENT_PTR(rapl_gpu_scale),
+	EVENT_PTR(rapl_ram_scale),
+	EVENT_PTR(rapl_psys_scale),
+	NULL,
+};
+
 static struct attribute *rapl_events_knl_attr[] = {
 	EVENT_PTR(rapl_pkg),
 	EVENT_PTR(rapl_ram),
@@ -726,6 +768,10 @@ static int __init rapl_pmu_init(void)
 		rapl_cntr_mask = RAPL_IDX_SRV;
 		rapl_pmu_events_group.attrs = rapl_events_srv_attr;
 		break;
+	case 78: /* Skylake client */
+		rapl_cntr_mask = RAPL_IDX_SKL;
+		rapl_pmu_events_group.attrs = rapl_events_skl_attr;
+		break;
 	case 87: /* Knights Landing */
 		apply_quirk = true;
 		rapl_cntr_mask = RAPL_IDX_KNL;
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 2da46ac..cfb1587 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -190,6 +190,8 @@
 #define MSR_PP1_ENERGY_STATUS		0x00000641
 #define MSR_PP1_POLICY			0x00000642
 
+#define MSR_PLATFORM_ENERGY_STATUS	0x0000064d
+
 #define MSR_CONFIG_TDP_NOMINAL		0x00000648
 #define MSR_CONFIG_TDP_LEVEL_1		0x00000649
 #define MSR_CONFIG_TDP_LEVEL_2		0x0000064A
-- 
2.5.0

