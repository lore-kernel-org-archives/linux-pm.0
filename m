Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73051C04F;
	Thu,  1 Oct 2026 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864644; cv=fail; b=oHZERmsojmPV8oRB3D25qsl2PTXYzH8WmykDCaKcS6+EASd+lyyBTO5QHj6iuC8qgWQDhCtHX31rcwqAwexc/mN0AUeYrJtFUJ+S3kiRnmtffTkPglr484PFosJYYyble0VE4hkNhmMFE0N+EGKTe9XD9qwwKoGnYReS/CtnAVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864644; c=relaxed/simple;
	bh=tcpnvroqv/DqJXagH3d00yCvw30V2ZsrodfbHMISYJ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTEpFfJm0OQSDxj8oi3f1cwoMejIGhoEYTEp3bxWX5G/IwSfyoBYvap/b6rqBJhetAZcLB1wmz2b07U8Zcg03MMfdIr5nVRRxY95uzYvzeq0gmM38AB02ZMNi5y4m3JBpN6ZSVtiQFW+IdDTACNJY2iwYp+d5f4jX17WkofAj9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R1urqerD; arc=fail smtp.client-ip=40.93.194.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R1urqerD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecJYfQo5reTUkY77OhHdxQ6odjDE8OIEnfv2mVRcpjczgK0V2odPSL2QqTd3Lg9957OsTw4AsJSh47Hb6PhyqHwfpYwjCBUpt9ejWX7/ub5L9Rtu5wXK3vTa07mF0BVrKB+5tKplAchX6pG2/hQN5xDaI9h0rmiFaU8POlcBhjzDuE7FDTNBZpW9Y1y+vYk0Zaihrs8IOB5OACfEj1aijhnu2YFJ5rVtiArVqJxt+wjcigXyTJTQHlafjOcNMYiwnO6MuVU71qWjUv7uV2w9GHGeBBFi+bLTStT0iT0o+K4V9t9ZfkuCtSeu02dAYB72edJVnOKS32V4gcevQ7WqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbNxXU8Km9JfOpd/QVwVhhoNnxdwF+YWzRYFm5ieFOY=;
 b=AOgmPQ5RRyUvLTmPje6nQi4fSPq+H/OdISeYnQHLGCQUkHcA7YEWhvofmrZga5crDo+LnQeL2mbCvtxeHbqce1DN0voFXKtlk+cXhgewxvUIdITOvmr4SG3TSWqqmCtFyKHQKOzyHWRaTF1Fuj1mjkUerWPIpyo/AaLPW708e6VwOm2N7QuKsAAn/RlsC5AVyl51f0F9Q1406VVm3Qc/eA5MeQuXECgb8tqI9PNuxcI0kt693QyWM2ME+d12sf+YnnGYvRvn5GpyXemsETlgh61VmSa6GoMqjxw4F0IhmsRWESL/o4ngEIiaxF9WtWugRcsp4hM+gW0fIZ4Lug6eZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbNxXU8Km9JfOpd/QVwVhhoNnxdwF+YWzRYFm5ieFOY=;
 b=R1urqerDVIW4Yvg5p7Gia+5bCNrEQVwaQpBO7wGDa/AtI7Hn8zO1X8rKCe5sqUELgXm26fIh4uMdFyAejKjFygXOvPkmykSJOrQFahOCVdGSWvjRRb+2kmUEb5/X8Boogj7WzPqk3vHvZds996nm8qOdX68GYBokVQ0sAGJDDyA=
Received: from MW4PR04CA0352.namprd04.prod.outlook.com (2603:10b6:303:8a::27)
 by MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Thu, 1 Oct
 2026 14:23:52 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:8a:cafe::5a) by MW4PR04CA0352.outlook.office365.com
 (2603:10b6:303:8a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 14:23:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 14:23:52 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 09:23:50 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Prateek Nayak <KPrateek.Nayak@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Subject: [PATCH v4 1/3] ACPI: CPPC: Refactor boost ratio handling
Date: Thu, 1 Oct 2026 09:23:39 -0500
Message-ID: <20261001142341.2934582-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001142341.2934582-1-mario.limonciello@amd.com>
References: <20261001142341.2934582-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|MW3PR12MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: d99fca95-f8b3-4a11-0cf5-08df1fc79e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|3023799007|11063799006|10067099003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WuP1tLyHUu0q0xHrPqAJO1Qk63GgovJkA0DM+PkcES4CPPbUjXbOQwU+haJwqhB0PLJgOdiG8w/a74fmNqwXQ298BXa3hZQj41cTy4OTai8Imo7E2JrmjFGR4GJ83RQHapbuHsE4iGp1MhGSV9NoPw4JcJuxCcH/SMWsXZkC3+2iloKt33ZUuxdsf1zUE9rLs1jWuS7h/NnaDqRSK97HvJdmu9KQsgUenc1NtHl7ZqFf/fvEH0miy5UrYFGazPkHrPWB66e1zsPoBC7OynHbs/7IbiY1Fj1m1q2pqBVPd+D/Dtm1Ul/A3rm8M9NGFlHr5EZhRvWZhTvJx+PJCvPjeC6lxOIN4WQqmf3kxp19I+Yo9OFiANtOLm07fkwXnKTJDx7RwfPJv7XHk+0uRrlavTadmiLC8fMLTiP7FSDZZ7Aq/56cObLAw0BJs60R/sX9yxxcS6+bSdYCd8ld49d2Qrsv04WKZ+yewKd68P1kWbOki5JvD4TU1e1114NCHc8tkLZ3rKPmL2hHn4vSu2prcDC2EpU9nm/TlGbgxBqnjGUrxjdKG01aKV4rqaguij8wUlUeo9vXr1FyZhoC6ia9jqDL0o32r9VCwQ99SckSi8E9J0f9jvmit9q0yXvsvLBZvFDBjrA2iCzYqJeG1+hzfzn7m4xR5+Ivqbukb3eyAZ3sgPv3xQJmHWE2ED3OOgk1MKftaVWrWslSfFy3/1J5Vw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(3023799007)(11063799006)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qI+ZKLOtLsu1Pcy0EMyE6RIk6CQU3nrHNKwT9X8ZdcfZpDVL9J6z4EsYQtivjhhUY2rbNRiq3Fg05bb7ijt0HUcEn4Ot+Yq5lUdajAlnBRlGAH8E20wEMfq5oydABYDKCljLYMrj1xoESEkh0hfoAZBYVOylLl/oZP5KqYnDN2ajH9kmvns+bEOYvlXi8m4UaGSUaG5qtxjZ8xp+aMHMEv10aHls6u0YpqvOuy87FyJppuBZxe0R0Y0b4GHZWWNUlKEQh5LvnNOTvlaiiRwabiPpPFiawaSkjJDHHmW+GAkqGvHmxV6CATBaZbOwCNILBVIVaEICZj1CjD5p3ulU5J5A8NAMYt1ru8U8HuCjSklBa5hNu+UpP7ZjKmJARznyRKSF/v8XK7bQxF+e029aWqxPgwm5ZbQYG7F1/BtFECLQoufDItS954VWWpK55rLA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:23:52.5626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d99fca95-f8b3-4a11-0cf5-08df1fc79e70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459

Rename amd_get_boost_ratio_numerator() to amd_get_effective_highest_perf()
to better reflect that it returns the effective highest performance value
for a CPU, accounting for preferred cores and heterogeneous topologies.

Add a new helper amd_get_boost_ratio() for doing both for boost
ratio calculations and update callers to use it.

This refactoring is needed because on some AMD systems (Zen6+),
the boost ratio should be calculated from frequency values rather than
performance values.

Newer versions of the ACPI will introduce a proper interface
for getting this information, but for now hardcode values so that
these systems perform as intended and to unblock future scheduler
work while we continue to wait.

For now use some temporary hardcoded values for Zen6 platforms.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4:
 * Add Rafael's tag
 * Update commit message

 arch/x86/kernel/acpi/cppc.c    | 166 ++++++++++++++++++++++-----------
 drivers/cpufreq/acpi-cpufreq.c |   5 +-
 drivers/cpufreq/amd-pstate.c   |  14 ++-
 include/acpi/cppc_acpi.h       |  14 ++-
 4 files changed, 134 insertions(+), 65 deletions(-)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index bbade0da5130f..f230e9323187d 100644
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
-	if (rc) {
-		pr_debug("Could not retrieve perf counters (%d)\n", rc);
-		return;
-	}
-
-	rc = amd_get_boost_ratio_numerator(0, &numerator);
+	rc = amd_get_boost_ratio(0, &numerator, &denominator);
 	if (rc) {
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
- *
- * Determine the numerator to use for calculating the boost ratio on
- * a CPU. On systems that support preferred cores, this will be a hardcoded
- * value. On other systems this will the highest performance register value.
+ * amd_get_effective_highest_perf: Get the effective highest performance value
+ * @cpu: CPU to get highest performance for.
  *
- * If booting the system with amd-pstate enabled but preferred cores disabled then
- * the correct boost numerator will be returned to match hardware capabilities
- * even if the preferred cores scheduling hints are not enabled.
+ * Get the effective highest performance value for a CPU, accounting for
+ * preferred cores and heterogeneous topologies. On systems with preferred
+ * cores, this may be a hardcoded value. On heterogeneous systems, this
+ * may be a per-CPU value. On other systems, this is the shared highest
+ * performance value.
  *
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
@@ -272,28 +254,100 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 
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
+	}
+
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
+static const struct amd_max_freq max_freq_zen6_client = {
+	.performance = 5025,
+	.efficiency = 3524,
+	.low_power = 2399,
+};
+
+int amd_get_max_frequency(unsigned int cpu)
+{
+	enum x86_topology_cpu_type type = cpu_data(cpu).topo.cpu_type;
+	const struct amd_max_freq *max_freq = NULL;
+
+	if (cpu_feature_enabled(X86_FEATURE_ZEN6) &&
+	    cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
+		max_freq = &max_freq_zen6_client;
+
+	if (!max_freq)
+		return 0;
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
 	}
 
-	*numerator = CPPC_HIGHEST_PERF_PREFCORE;
+	return 0;
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
+	if (max_frequency && perf_caps.nominal_freq) {
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
index 93e3a60f1b121..9e8ef5548894c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -555,11 +555,13 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
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
 
@@ -590,10 +592,12 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
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
2.55.0

