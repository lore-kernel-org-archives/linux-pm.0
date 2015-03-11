From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] powercap/rapl: handle domain energy unit
Date: Wed, 11 Mar 2015 05:55:09 -0700
Message-ID: <1426078509-3767-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39221 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251AbbCKM4V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 11 Mar 2015 08:56:21 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

The current driver assumes all RAPL domains within a CPU package
have the same energy unit. This is no longer true for HSW server
CPUs since DRAM domain has is own fixed energy unit which can be
different than the package energy unit enumerated by package
power MSR. In fact, the default HSW EP package power unit is 61uJ
whereas DRAM domain unit is 15.3uJ. The result is that DRAM power
consumption is counted 4x more than real power reported by energy
counters.

This patch adds domain specific energy unit per cpu type, it allows
domain energy unit to override package energy unit if non zero.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 97b5e4e..af4c61e 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -158,6 +158,7 @@ struct rapl_domain {
 	struct rapl_power_limit rpl[NR_POWER_LIMITS];
 	u64 attr_map; /* track capabilities */
 	unsigned int state;
+	unsigned int domain_energy_unit;
 	int package_id;
 };
 #define power_zone_to_rapl_domain(_zone) \
@@ -190,6 +191,7 @@ struct rapl_defaults {
 	void (*set_floor_freq)(struct rapl_domain *rd, bool mode);
 	u64 (*compute_time_window)(struct rapl_package *rp, u64 val,
 				bool to_raw);
+	unsigned int dram_domain_energy_unit;
 };
 static struct rapl_defaults *rapl_defaults;
 
@@ -227,7 +229,8 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 static int rapl_write_data_raw(struct rapl_domain *rd,
 			enum rapl_primitives prim,
 			unsigned long long value);
-static u64 rapl_unit_xlate(int package, enum unit_type type, u64 value,
+static u64 rapl_unit_xlate(struct rapl_domain *rd, int package,
+			enum unit_type type, u64 value,
 			int to_raw);
 static void package_power_limit_irq_save(int package_id);
 
@@ -305,7 +308,8 @@ static int get_energy_counter(struct powercap_zone *power_zone, u64 *energy_raw)
 
 static int get_max_energy_counter(struct powercap_zone *pcd_dev, u64 *energy)
 {
-	*energy = rapl_unit_xlate(0, ENERGY_UNIT, ENERGY_STATUS_MASK, 0);
+	/* package domain is the largest */
+	*energy = rapl_unit_xlate(NULL, 0, ENERGY_UNIT, ENERGY_STATUS_MASK, 0);
 	return 0;
 }
 
@@ -639,6 +643,11 @@ static void rapl_init_domains(struct rapl_package *rp)
 			rd->msrs[4] = MSR_DRAM_POWER_INFO;
 			rd->rpl[0].prim_id = PL1_ENABLE;
 			rd->rpl[0].name = pl1_name;
+			rd->domain_energy_unit =
+				rapl_defaults->dram_domain_energy_unit;
+			if (rd->domain_energy_unit)
+				pr_info("DRAM domain energy unit %duj\n",
+					rd->domain_energy_unit);
 			break;
 		}
 		if (mask) {
@@ -648,7 +657,8 @@ static void rapl_init_domains(struct rapl_package *rp)
 	}
 }
 
-static u64 rapl_unit_xlate(int package, enum unit_type type, u64 value,
+static u64 rapl_unit_xlate(struct rapl_domain *rd, int package,
+			enum unit_type type, u64 value,
 			int to_raw)
 {
 	u64 units = 1;
@@ -663,7 +673,11 @@ static u64 rapl_unit_xlate(int package, enum unit_type type, u64 value,
 		units = rp->power_unit;
 		break;
 	case ENERGY_UNIT:
-		units = rp->energy_unit;
+		/* per domain unit takes precedence */
+		if (rd && rd->domain_energy_unit)
+			units = rd->domain_energy_unit;
+		else
+			units = rp->energy_unit;
 		break;
 	case TIME_UNIT:
 		return rapl_defaults->compute_time_window(rp, value, to_raw);
@@ -773,7 +787,7 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 	final = value & rp->mask;
 	final = final >> rp->shift;
 	if (xlate)
-		*data = rapl_unit_xlate(rd->package_id, rp->unit, final, 0);
+		*data = rapl_unit_xlate(rd, rd->package_id, rp->unit, final, 0);
 	else
 		*data = final;
 
@@ -799,7 +813,7 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
 			"failed to read msr 0x%x on cpu %d\n", msr, cpu);
 		return -EIO;
 	}
-	value = rapl_unit_xlate(rd->package_id, rp->unit, value, 1);
+	value = rapl_unit_xlate(rd, rd->package_id, rp->unit, value, 1);
 	msr_val &= ~rp->mask;
 	msr_val |= value << rp->shift;
 	if (wrmsrl_safe_on_cpu(cpu, msr, msr_val)) {
@@ -1017,6 +1031,13 @@ static const struct rapl_defaults rapl_defaults_core = {
 	.compute_time_window = rapl_compute_time_window_core,
 };
 
+static const struct rapl_defaults rapl_defaults_hsw_server = {
+	.check_unit = rapl_check_unit_core,
+	.set_floor_freq = set_floor_freq_default,
+	.compute_time_window = rapl_compute_time_window_core,
+	.dram_domain_energy_unit = 15,
+};
+
 static const struct rapl_defaults rapl_defaults_atom = {
 	.check_unit = rapl_check_unit_atom,
 	.set_floor_freq = set_floor_freq_atom,
@@ -1037,7 +1058,7 @@ static const struct x86_cpu_id rapl_ids[] = {
 	RAPL_CPU(0x3a, rapl_defaults_core),/* Ivy Bridge */
 	RAPL_CPU(0x3c, rapl_defaults_core),/* Haswell */
 	RAPL_CPU(0x3d, rapl_defaults_core),/* Broadwell */
-	RAPL_CPU(0x3f, rapl_defaults_core),/* Haswell */
+	RAPL_CPU(0x3f, rapl_defaults_hsw_server),/* Haswell servers */
 	RAPL_CPU(0x45, rapl_defaults_core),/* Haswell ULT */
 	RAPL_CPU(0x4C, rapl_defaults_atom),/* Braswell */
 	RAPL_CPU(0x4A, rapl_defaults_atom),/* Tangier */
-- 
1.9.1

