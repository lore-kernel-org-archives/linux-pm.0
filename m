Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B14037EFFF;
	Mon, 31 Aug 2026 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205528; cv=fail; b=MD5mB160bX+iEOg+YT3Qlacm4SWGG6WarxB+peF7x5L4rl3k+PER8PFPs6cy+ZjjbJU3TsvdQauZayHRlLMfEDHCd6Aeggg+K7QPYzfkgyxzsxX3CJc5gjR+nGzVOJ6GYM8YGLBMi0ZZqdXcPCioR5OdyTvtMPlsCcqdpBE81aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205528; c=relaxed/simple;
	bh=4MzXrFmHGvQ9brGxAKdwRCg8IOkPWgAg0tQSXU/EPKw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5/PohwwV6aGood7ZnSRdQBMdS9rPVsdmnhz5Q9Q+6G9LNHWb2PuqLxwLrjaD2jkdO1r8QtL0hWjKa4Y7gBSFhU6qR+cB2MZJaeCdMdMrJfsu6qnEkglLcUdBqjvdLz3XYfOXaGqwKQTipE97YdBJiIcGuqJM9h4R4jljn9fqW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wXczdDif; arc=fail smtp.client-ip=52.101.46.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wXczdDif"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQVcbqTcq/IEVvbM2lSBg0wPaqYnHuHTq7iKGqPtg/VN0sPO/9EimUCt0Y+WoXQfChn5O7dLLU0fXLs7kw0SLIbXQW+te2SeVky+cWw2uFgeGtwSmpjKnIXOARZ1rVF2TvvM4ESWDU/NoCw95Idm02DFZOA7Qx9UvK9fZ6iBEFnztgpwDgWNMc6SiT++54vDCiYExW4mmiWBHnI4tZ5nKjgBxlO8FNKazrZK+R6opiojiBd6lpjdrnvxiFo2OZsGY42/5VmFXOFhyx/RTfmlJU892zNZSI815VkdrjUkewj+Xm02fjReOknYy7Fa92G5AYW/JHQlfEtwL8pvLb3VOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Rq4FVKvryYH9apzkoYSEEpVs9+Q3IcVxA0hfEpiT60=;
 b=B7/IyxSADVX+PiFtm+VW9h3j6Z9QZWT2IIHrg3EQ0Q+Hwoy/QO7UZjHvuIsVE12s0GBDzYzZXSG8LhkkDfFm8k60S4GxsvwJRH3bfyJP6HhaLUpDID+pPzpXB26FNBY/T06iJowQNwgUayzv7h2mhqDAL9fuOAuHSJkZw4095XfgDWVmzAgr9jar3flXLux7ETnpaxcV99JvTsW8q6ECdqOw9HEXKgyiffbuzNpT71nvIXp7d8E7Yda1pRR+jsIr7Q4pNiB5GLCeCV10eizAeM+0R6wNJErd3GOg1otsxPdEGtI//o5vKEOkiT+jcpBiY5UwEWoWm2m+h3v2e4o4Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Rq4FVKvryYH9apzkoYSEEpVs9+Q3IcVxA0hfEpiT60=;
 b=wXczdDif5rkLiDIoQkUY/2zxNlsGXuFW/RhbIfQ2NGTzJLohVF4WozKEkWgYHFeNnEczaXZimxEEtC7uJ3N6cUPIoHKp35CU0QiYjKF1DdkceLQkf0VOmZ7sNRnZrV1wmNBAGQ1Kh/BInz4g64gXF7e5YWxDu9205l6E+EuJOnY=
Received: from BY3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:254::27)
 by SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 19:45:17 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::a) by BY3PR05CA0022.outlook.office365.com
 (2603:10b6:a03:254::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 19:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 19:45:17 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 14:45:15 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<x86@kernel.org>, Vishal Badole <Vishal.Badole@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH 1/3] ACPI: CPPC: Refactor boost ratio handling
Date: Mon, 31 Aug 2026 14:44:26 -0500
Message-ID: <20260831194428.2287055-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831194428.2287055-1-mario.limonciello@amd.com>
References: <20260831194428.2287055-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|SN7PR12MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 652472e1-3c0f-45d1-cddb-08df0798623b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|10067099003|11063799006|56012099006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IAXdcqqXINAjcOjd/z28yaC+Dr5Z9Uw4KtCrEXMwhNpswJmcPxvdLjsFH8iFxcD1lqu5zxpk7nfluZ88UKqimZLAcG/ImoUgeFnbIowBB+KlO7H4tE88iHMtUaPfxulOyDa5hxNtMH7+H2GYSkoCSEosoMHt4mDxw7/OLcuyppa1KCGeT+fyf/hBll9fK49AKCjGfE6+S7KwUXbbVVu19KGGGsWc5x4m0LXCWP3BZumEoWM1ASkGE3KjX2baUvRCVg0NTx1OcU157EnnpYKy2ikBAOvMUc9rpVPcWgSSxLgagSRUCpnOuH1y8sv6OxFqFKnIDdkP/R+bGk9refvMXsvp5c1GWwzM5SFVlHF/xv8FSbEWMCZdcEPLEqcnTXWxI6oTzTp8Et7V8rLFNK1XlYVs+IYFvgMxGyhZGK7j2cwZ8oCDeUipd3gJHx8nI+CjPF2K1B9ZS08INyQfrhm/3Mrer1riUgfGC5zkIP9f72+zN8q/M4ysbj1hYZh1ny8vrhJaRyoiMbN7F8qz8F6zvoLnJtJ4FcwrkGc/qZihNkqW7wGgw+KEQ5EPXQJGTF1M9/huo/USXOQY0YOvy12bImbWiFFaqlezu7+9kLpxiUJjNNumBqmoiK4hlL1TibgPKFOWqmSSK+yP30lvCfkmTBr2e7k755NNszatdDFkAUWV1YnC8vth5uP9papYPJxWhNp/Aq/VoRpxyyWcyB68Rg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nTecr9sqqSvROgLujZrhf3Rsds/4+8YU5ZxxOvcptnjYYz1ZK3D36d2FHctbnAXaJWJSHJofav7nUsqljeK+Sy/ZkuauaRNPAHXJkN84TlUFSTQNXypjV7Pen0UXrXnOluVo8o1/ed/cpMpLpbXiC55yqmJ9Eai38DxcNlN+m4WtVNAXN9MqvepC/55eGBaGGAthgsaJ8m2K5kZBZVtof+yF6sIwlv/+Jg+L0YGtYTRdltoRzV5H9G+ePM8QZlbr14XhMSLpvbxxmtYDq2v7eW9X2EZOjmDTeqMyM769cHilpSsAVI+51oq+J8IaZ9Lf+Zk5jr5A9YAkrXf/QfD+MBnto8LkBUxyrGCX60udRrvn7SrMcdyniQ0NMYzZe83YwpE6++/JeElHN5vpt8Pb0cGxWPg2opj+am75x2czAXKcwEwRe2MJdD0SCZ6IC9cy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 19:45:17.3661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 652472e1-3c0f-45d1-cddb-08df0798623b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853

Rename amd_get_boost_ratio_numerator() to amd_get_effective_highest_perf()
to better reflect that it returns the effective highest performance value
for a CPU, accounting for preferred cores and heterogeneous topologies.

Add a new helper amd_get_boost_ratio() for doing both for boost
ratio calculations and update callers to use it.

This refactoring is needed because on some AMD systems (Zen6+),
the boost ratio should be calculated from frequency values rather than
performance values.

The frequency values will eventually come from the BIOS, but for now
use some hardcoded values for Zen6 platforms.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/acpi/cppc.c    | 174 ++++++++++++++++++++++-----------
 drivers/cpufreq/acpi-cpufreq.c |   5 +-
 drivers/cpufreq/amd-pstate.c   |  14 ++-
 include/acpi/cppc_acpi.h       |  14 ++-
 4 files changed, 142 insertions(+), 65 deletions(-)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index bbade0da5130f..78b32bc93e603 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -10,6 +10,7 @@
 #include <asm/msr.h>
 #include <asm/processor.h>
 #include <asm/topology.h>
+#include <asm/cpu_device_id.h>
 
 #define CPPC_HIGHEST_PERF_PERFORMANCE	196
 #define CPPC_HIGHEST_PERF_PREFCORE	166
@@ -81,31 +82,18 @@ int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 
 static void amd_set_max_freq_ratio(void)
 {
-	struct cppc_perf_caps perf_caps;
-	u64 numerator, nominal_perf;
+	u64 numerator, denominator;
 	u64 perf_ratio;
 	int rc;
 
-	rc = cppc_get_perf_caps(0, &perf_caps);
+	rc = amd_get_boost_ratio(0, &numerator, &denominator);
 	if (rc) {
-		pr_debug("Could not retrieve perf counters (%d)\n", rc);
-		return;
-	}
-
-	rc = amd_get_boost_ratio_numerator(0, &numerator);
-	if (rc) {
-		pr_debug("Could not retrieve highest performance (%d)\n", rc);
-		return;
-	}
-	nominal_perf = perf_caps.nominal_perf;
-
-	if (!nominal_perf) {
-		pr_debug("Could not retrieve nominal performance\n");
+		pr_debug("Could not retrieve boost ratio (%d)\n", rc);
 		return;
 	}
 
 	/* midpoint between max_boost and max_P */
-	perf_ratio = (div_u64(numerator * SCHED_CAPACITY_SCALE, nominal_perf) + SCHED_CAPACITY_SCALE) >> 1;
+	perf_ratio = (div_u64(numerator * SCHED_CAPACITY_SCALE, denominator) + SCHED_CAPACITY_SCALE) >> 1;
 
 	freq_invariance_set_perf_ratio(perf_ratio, false);
 }
@@ -225,35 +213,30 @@ int amd_detect_prefcore(bool *detected)
 EXPORT_SYMBOL_GPL(amd_detect_prefcore);
 
 /**
- * amd_get_boost_ratio_numerator: Get the numerator to use for boost ratio calculation
- * @cpu: CPU to get numerator for.
- * @numerator: Output variable for numerator.
+ * amd_get_effective_highest_perf: Get the effective highest performance value
+ * @cpu: CPU to get highest performance for.
  *
- * Determine the numerator to use for calculating the boost ratio on
- * a CPU. On systems that support preferred cores, this will be a hardcoded
- * value. On other systems this will the highest performance register value.
+ * Get the effective highest performance value for a CPU, accounting for
+ * preferred cores and heterogeneous topologies. On systems with preferred
+ * cores, this may be a hardcoded value. On heterogeneous systems, this
+ * may be a per-CPU value. On other systems, this is the shared highest
+ * performance value.
  *
- * If booting the system with amd-pstate enabled but preferred cores disabled then
- * the correct boost numerator will be returned to match hardware capabilities
- * even if the preferred cores scheduling hints are not enabled.
- *
- * Return: 0 for success, negative error code otherwise.
+ * Return: Effective highest performance value, or negative error code.
  */
-int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
+int amd_get_effective_highest_perf(unsigned int cpu)
 {
 	bool prefcore;
 	int ret;
 	u32 tmp;
 
 	ret = amd_detect_prefcore(&prefcore);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	/* without preferred cores, return the highest perf register value */
-	if (!prefcore) {
-		*numerator = boost_numerator;
-		return 0;
-	}
+	if (!prefcore)
+		return boost_numerator;
 
 	/*
 	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
@@ -263,8 +246,7 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 	if (cpu_feature_enabled(X86_FEATURE_ZEN4)) {
 		switch (boot_cpu_data.x86_model) {
 		case 0x70 ... 0x7f:
-			*numerator = CPPC_HIGHEST_PERF_PERFORMANCE;
-			return 0;
+			return CPPC_HIGHEST_PERF_PERFORMANCE;
 		default:
 			break;
 		}
@@ -272,28 +254,108 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 
 	/* detect if running on heterogeneous design */
 	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES)) {
-		switch (cpu_data(cpu).topo.cpu_type) {
-		case TOPO_CPU_TYPE_UNKNOWN:
-		case TOPO_CPU_TYPE_ANY:
-			pr_warn("Undefined core type found for cpu %d\n", cpu);
-			break;
-		case TOPO_CPU_TYPE_PERFORMANCE:
-			/* use the max scale for performance cores */
-			*numerator = CPPC_HIGHEST_PERF_PERFORMANCE;
-			return 0;
-		case TOPO_CPU_TYPE_LOW_POWER:
-		case TOPO_CPU_TYPE_EFFICIENCY:
-			/* use the highest perf value for efficiency and low-power cores */
-			ret = amd_get_highest_perf(cpu, &tmp);
-			if (ret)
-				return ret;
-			*numerator = tmp;
-			return 0;
-		}
+		if (cpu_feature_enabled(X86_FEATURE_ZEN5) &&
+		    cpu_data(cpu).topo.cpu_type == TOPO_CPU_TYPE_PERFORMANCE)
+			return CPPC_HIGHEST_PERF_PERFORMANCE;
+
+		/* Zen 5 efficiency, and Zen 6+ */
+		ret = amd_get_highest_perf(cpu, &tmp);
+		if (ret < 0)
+			return ret;
+
+		return tmp;
 	}
 
-	*numerator = CPPC_HIGHEST_PERF_PREFCORE;
+	return CPPC_HIGHEST_PERF_PREFCORE;
+}
+EXPORT_SYMBOL_GPL(amd_get_effective_highest_perf);
+
+struct amd_max_freq {
+	u32 performance;
+	u32 efficiency;
+	u32 low_power;
+};
+
+static const struct amd_max_freq max_freq_zen6_client __initconst = {
+	.performance = 5025,
+	.efficiency = 3524,
+	.low_power = 2399,
+};
+
+static const struct x86_cpu_id amd_zen6_client_ids[] __initconst = {
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0x80, &max_freq_zen6_client),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0x81, &max_freq_zen6_client),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0x84, &max_freq_zen6_client),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0x85, &max_freq_zen6_client),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0xe0, &max_freq_zen6_client),
+	{}
+};
+
+int amd_get_max_frequency(unsigned int cpu)
+{
+	enum x86_topology_cpu_type type = cpu_data(cpu).topo.cpu_type;
+	const struct x86_cpu_id *id = x86_match_cpu(amd_zen6_client_ids);
+	const struct amd_max_freq *max_freq;
+
+	if (!id)
+		return -ENODEV;
+
+	max_freq = (const struct amd_max_freq *)id->driver_data;
+
+	switch (type) {
+	case TOPO_CPU_TYPE_PERFORMANCE:
+		return max_freq->performance;
+	case TOPO_CPU_TYPE_EFFICIENCY:
+		return max_freq->efficiency;
+	case TOPO_CPU_TYPE_LOW_POWER:
+		return max_freq->low_power;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(amd_get_max_frequency);
+
+/**
+ * amd_get_boost_ratio: Get numerator and denominator for boost ratio
+ * @cpu: CPU to get the boost ratio for.
+ * @numerator: Output variable for numerator.
+ * @denominator: Output variable for denominator.
+ *
+ * Get the numerator and denominator for calculating the boost ratio.
+ *
+ * Return: 0 for success, negative error code otherwise.
+ */
+int amd_get_boost_ratio(unsigned int cpu, u64 *numerator, u64 *denominator)
+{
+	struct cppc_perf_caps perf_caps;
+	int max_frequency;
+	int ret;
+
+	ret = cppc_get_perf_caps(cpu, &perf_caps);
+	if (ret)
+		return ret;
+
+	max_frequency = amd_get_max_frequency(cpu);
+	/* Use frequency values if available */
+	if (max_frequency > 0 && perf_caps.nominal_freq) {
+		*numerator = max_frequency;
+		*denominator = perf_caps.nominal_freq;
+		return 0;
+	}
+
+	/* Fall back to performance values */
+	ret = amd_get_effective_highest_perf(cpu);
+	if (ret < 0)
+		return ret;
+
+	*numerator = ret;
+
+	*denominator = perf_caps.nominal_perf;
+	if (!*denominator)
+		return -EINVAL;
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(amd_get_boost_ratio_numerator);
+EXPORT_SYMBOL_GPL(amd_get_boost_ratio);
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 10ea6035f4ad6..523ee1a06ef8a 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -640,12 +640,13 @@ static u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
 	}
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
-		ret = amd_get_boost_ratio_numerator(cpu, &highest_perf);
-		if (ret) {
+		ret = amd_get_effective_highest_perf(cpu);
+		if (ret < 0) {
 			pr_debug("CPU%d: Unable to get boost ratio numerator (%d)\n",
 				 cpu, ret);
 			return 0;
 		}
+		highest_perf = ret;
 	} else {
 		highest_perf = perf_caps.highest_perf;
 	}
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d2b4a8eba3052..9fb1d7150c356 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -584,11 +584,13 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
-	if (ret)
+	ret = amd_get_effective_highest_perf(cpudata->cpu);
+	if (ret < 0)
 		return ret;
 
-	ret = rdmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req);
+	numerator = ret;
+
+	ret = rdmsrq_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req);
 	if (ret)
 		return ret;
 
@@ -619,10 +621,12 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
-	if (ret)
+	ret = amd_get_effective_highest_perf(cpudata->cpu);
+	if (ret < 0)
 		return ret;
 
+	numerator = ret;
+
 	perf.highest_perf = numerator;
 	perf.max_limit_perf = numerator;
 	perf.min_limit_perf = cppc_perf.lowest_perf;
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 94a6277edab27..4c0b11a718e38 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -192,7 +192,9 @@ extern int cppc_set_auto_sel(int cpu, bool enable);
 extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
 extern int cppc_set_perf_limited(int cpu, u64 bits_to_clear);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
-extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
+extern int amd_get_effective_highest_perf(unsigned int cpu);
+extern int amd_get_max_frequency(unsigned int cpu);
+extern int amd_get_boost_ratio(unsigned int cpu, u64 *numerator, u64 *denominator);
 extern int amd_detect_prefcore(bool *detected);
 #else /* !CONFIG_ACPI_CPPC_LIB */
 static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
@@ -305,7 +307,15 @@ static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
 {
 	return -ENODEV;
 }
-static inline int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
+static inline int amd_get_effective_highest_perf(unsigned int cpu)
+{
+	return -EOPNOTSUPP;
+}
+static inline int amd_get_max_frequency(unsigned int cpu)
+{
+	return 0;
+}
+static inline int amd_get_boost_ratio(unsigned int cpu, u64 *numerator, u64 *denominator)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.43.0

