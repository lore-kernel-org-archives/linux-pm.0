From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 2/2] powercap: intel_rapl: PSys support
Date: Sun, 17 Apr 2016 15:03:01 -0700
Message-ID: <1460930581-29748-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1460930581-29748-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460930581-29748-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net
Cc: x86@kernel.org, peterz@infradead.org, bp@alien8.de, linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Skylake processor supports a new set of RAPL registers for controlling
entire SoC instead of just CPU package. This is useful for thermal
and power control when source of power/thermal is not just CPU/GPU.
This change adds a new platform domain (AKA PSys) to the current
power capping Intel RAPL driver.
PSys also supports PL1 (long term) and PL2 (short term) control like
package domain. This also follows same MSRs for energy and time
units as package domain.
Unlike package domain, PSys support requires more than just processor
level implementation. The other parts in the system need additional
implementation, which OEMs needs to support. So not all Skylake
systems will support PSys.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 69 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 8fad0a7..f2201d4 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -34,6 +34,9 @@
 #include <asm/processor.h>
 #include <asm/cpu_device_id.h>
 
+/* Local defines */
+#define MSR_PLATFORM_POWER_LIMIT	0x0000065C
+
 /* bitmasks for RAPL MSRs, used by primitive access functions */
 #define ENERGY_STATUS_MASK      0xffffffff
 
@@ -86,6 +89,7 @@ enum rapl_domain_type {
 	RAPL_DOMAIN_PP0, /* core power plane */
 	RAPL_DOMAIN_PP1, /* graphics uncore */
 	RAPL_DOMAIN_DRAM,/* DRAM control_type */
+	RAPL_DOMAIN_PLATFORM, /* PSys control_type */
 	RAPL_DOMAIN_MAX,
 };
 
@@ -251,9 +255,11 @@ static const char * const rapl_domain_names[] = {
 	"core",
 	"uncore",
 	"dram",
+	"psys",
 };
 
 static struct powercap_control_type *control_type; /* PowerCap Controller */
+static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
 
 /* caller to ensure CPU hotplug lock is held */
 static struct rapl_package *find_package_by_id(int id)
@@ -409,6 +415,14 @@ static const struct powercap_zone_ops zone_ops[] = {
 		.set_enable = set_domain_enable,
 		.get_enable = get_domain_enable,
 	},
+	/* RAPL_DOMAIN_PLATFORM */
+	{
+		.get_energy_uj = get_energy_counter,
+		.get_max_energy_range_uj = get_max_energy_counter,
+		.release = release_zone,
+		.set_enable = set_domain_enable,
+		.get_enable = get_domain_enable,
+	},
 };
 
 static int set_power_limit(struct powercap_zone *power_zone, int id,
@@ -1160,6 +1174,13 @@ static int rapl_unregister_powercap(void)
 			powercap_unregister_zone(control_type,
 						&rd_package->power_zone);
 	}
+
+	if (platform_rapl_domain) {
+		powercap_unregister_zone(control_type,
+					 &platform_rapl_domain->power_zone);
+		kfree(platform_rapl_domain);
+	}
+
 	powercap_unregister_control_type(control_type);
 
 	return 0;
@@ -1239,6 +1260,47 @@ err_cleanup:
 	return ret;
 }
 
+static int rapl_register_psys(void)
+{
+	struct rapl_domain *rd;
+	struct powercap_zone *power_zone;
+	u64 val;
+
+	if (rdmsrl_safe_on_cpu(0, MSR_PLATFORM_ENERGY_STATUS, &val) || !val)
+		return -ENODEV;
+
+	if (rdmsrl_safe_on_cpu(0, MSR_PLATFORM_POWER_LIMIT, &val) || !val)
+		return -ENODEV;
+
+	rd = kzalloc(sizeof(*rd), GFP_KERNEL);
+	if (!rd)
+		return -ENOMEM;
+
+	rd->name = rapl_domain_names[RAPL_DOMAIN_PLATFORM];
+	rd->id = RAPL_DOMAIN_PLATFORM;
+	rd->msrs[0] = MSR_PLATFORM_POWER_LIMIT;
+	rd->msrs[1] = MSR_PLATFORM_ENERGY_STATUS;
+	rd->rpl[0].prim_id = PL1_ENABLE;
+	rd->rpl[0].name = pl1_name;
+	rd->rpl[1].prim_id = PL2_ENABLE;
+	rd->rpl[1].name = pl2_name;
+	rd->rp = find_package_by_id(0);
+
+	power_zone = powercap_register_zone(&rd->power_zone, control_type,
+					    "psys", NULL,
+					    &zone_ops[RAPL_DOMAIN_PLATFORM],
+					    2, &constraint_ops);
+
+	if (IS_ERR(power_zone)) {
+		kfree(rd);
+		return PTR_ERR(power_zone);
+	}
+
+	platform_rapl_domain = rd;
+
+	return 0;
+}
+
 static int rapl_register_powercap(void)
 {
 	struct rapl_domain *rd;
@@ -1255,6 +1317,10 @@ static int rapl_register_powercap(void)
 	list_for_each_entry(rp, &rapl_packages, plist)
 		if (rapl_package_register_powercap(rp))
 			goto err_cleanup_package;
+
+	/* Don't bail out if PSys is not supported */
+	rapl_register_psys();
+
 	return ret;
 
 err_cleanup_package:
@@ -1289,6 +1355,9 @@ static int rapl_check_domain(int cpu, int domain)
 	case RAPL_DOMAIN_DRAM:
 		msr = MSR_DRAM_ENERGY_STATUS;
 		break;
+	case RAPL_DOMAIN_PLATFORM:
+		/* PSYS(PLATFORM) is not a CPU domain, so avoid printng error */
+		return -EINVAL;
 	default:
 		pr_err("invalid domain id %d\n", domain);
 		return -EINVAL;
-- 
1.9.1
