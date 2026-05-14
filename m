Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CD03D16F4;
	Thu, 14 May 2026 21:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795819; cv=fail; b=I5fPDgtDz4o2PpuJblsKMcDCQhoIYP0+5vforGWSDCJ1hmDJfTuKZoz5IO26ETK2J08hKhkZSGtRndUVVR9nikH7IWTPKscrtafH6F/0SvE9qx8N7UsJKKEmqGyfbDqK6NTWftej03YVbpeGJQH4W1rqsTzWEPdJr/RB9Q9CAbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795819; c=relaxed/simple;
	bh=//GmgP13M6QTUZpfMgWk7gG/bnHtPeJFTloKKDMzYB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CuLQvINkDrVIOcqg5MdEUHDF7VGPqaQy7Olfn9Xj7tzZOR/pUKlaWE569Q8MtY84uPxodBhSLvatDqa/8yr58es0+ODlMN9iU73NAG84HKt/dO59CALYom/s5VHVxWUbitKIBv9tkD3pevDMWawjoiazXR+eV6gGaTxAOaS5G3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NiVmP488; arc=fail smtp.client-ip=52.101.53.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NiVmP488"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ibnhdx0ZEJLSXCewcIarLP/5wuRV86qAmRN28HWALt8T0I4v6knIKrNpFIP6gUz5zsC9Nx6NAxlr1RxbRRmmcfqcZRgF0Ag2tdjqQNbQm4H98WuhENnguhVlnh9JTBd55zJLZ4UH0OA3T13psEqxGpKgCf7dGbkJGu07fbR4V3VxQmcZAwYgiUUBy/v6wBdWREh2XugSLQNBH1bXctvqdaOGgEmw6KXS0w0NIk+zQzONvonEjS7ltOu1cBvmlgRvXjBtLoOhsS7Jh4nzSrl0/43UZ6BGHqHC54vTNCg7G8QWQWLl1CqhKxYcrJ+IENHcHauUUQ6MhE9fS+QYQqqDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21dPsFUFTJS3lGet6JPWH4cDz76nGpKqyzrhD3V1gUk=;
 b=vbUTIrZHSgdRvU1+UNjhQIL6eY50ogiTL0jL5klivHn2F2wdyQtH0W0vWVnhUFur5CQ9jSEmdRKXbKiX4qBAc7CZh/FUaVLnxWVMDimzUUN3HGCJwTcPvhqzHaGKyMN7sxvSOhEsGUsTgdeWjfbiYHo+2b5c7VheFIVZerjqsx1i7TgVDYZVrqK29KOX/5RkgDREGGSCuBJmVlGYMCQXlfpOu/Z4ZBMLjSZwPE6q/OsfWzuM5xkkZENvzLZpuqeiimO/TjKD5bRCMnS1NwGb5EZmNGh2sAdLMR1qnx2t40cvtGW7rTun66+1178SPJbEWA52vlpaXVkb4HcLwExDjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21dPsFUFTJS3lGet6JPWH4cDz76nGpKqyzrhD3V1gUk=;
 b=NiVmP488AjeSGwhoNADOU47bX2p2grl2jw0DuTeVKcP1g8NF9mJt6lZF9GAWMNW1fSHOPiYaZgE9Vpa14IyUcBjokwfjAFZC2gfoADUrbIzDDEremBKrm2T/wXq2cdzn6S6/1e8jTtdt9+VjEGax3wSdqsSY1Pt0dKu6ycc4hsg=
Received: from SJ0PR03CA0203.namprd03.prod.outlook.com (2603:10b6:a03:2ef::28)
 by DS0PR12MB7947.namprd12.prod.outlook.com (2603:10b6:8:150::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 21:56:52 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::9) by SJ0PR03CA0203.outlook.office365.com
 (2603:10b6:a03:2ef::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 21:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 21:56:52 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 16:56:49 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<x86@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 2/4] ACPI: CPPC: Refactor boost ratio handling
Date: Thu, 14 May 2026 16:56:24 -0500
Message-ID: <20260514215626.35327-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514215626.35327-1-mario.limonciello@amd.com>
References: <20260514215626.35327-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|DS0PR12MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4c3aec-b8b3-40d0-2d38-08deb203b4d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|11063799003|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BjBPmD0ip3oKjj+DK7IqsAqsi2kSPjBo8D3iaPmxrfrvZV13A4QtEG0JJGq/Vljqn1zvj1HoK6pDmEG2vzBOk5olK1l0QxVqqPBd2MdaEEm9hvs5bKfsIY7yUznsj5UGn5MZUBm80pjLJJ6aaLS547R2JZjl+cClqrmwpSjFBr6Laz2yYUJ1mudMTrMSl6fty8I2g/x52UJk6f02gD5dlJXPwGm6gHa9FazlqrBFoNBNsoboCsSdxzCf0Yrl52CN+a40maYj/eAvXfeZ8hLQRDnXGnFtTB+Ve5l+bDr+UHZZB4BJq45QiyNY63sai8PuBN7Wy0QZEN10e61ZsHS+4chFV+uhaebRAYF50Rar94idzAhVyUdqX3KFCvdiWNIRUAOM2oneDo6FNrF3a91kXV0xBYeOUiMGLy5T9eHQQJZGjHuXTSxXE5tirT6AQrO6VH61GIAFd/pv/s1ZNLiqSLo2jEUQL4yJreRSyWD0ZFUsXZXWwyWIC9lL+qHY+YMIQNexoze0rith2PVeqgYdjhxgcfgqZt3bf2T3v7X3chB3wHd0eczkUcz6DOwZ4Yf0qyi7UKVfXighTb65/GNQfoum9tnnrWd/V0AxZWGARyJr5oVrYZAW4xGz7ZabipexR7QtGKL1YKTruf630jYCQ5u8FGzVWx1SnUeF93VbW6c1SikHwPISxWfsLZf82xD3pLjtnVrFGmrWoEENLysCgC7SFz5AEmy2pPJ7LCP2JHw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(11063799003)(3023799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NzxZZ+9dHV4B2gnWgyGDe+OuRXoqi1gBsbICV4KySyadDnx85atTPN3ZKDv1LTA+qxorJ4heTWaVjk/L6uRy1t4uhk2BrWFu5OkcyZdfBLh2S242/95vS6AzG0wfOJpsABYImNe2XtFL0P53lNvvHwGf8YyFEZ4aiXWWHN6aO57SeG75n9ReWwg18TDcVNurJphuUM97G71peQZNZW41+WPV4tGWM2oim1qI50uP7aYmNI6YMUyyERTsQY/MHuK+sWDuU5FSUDYzmPAHgzcCgijWybB/LI4dSqNDfZNWAqF1Cxfyby9XjO2n3RXMN8NepXhOBu3nPeLc1GZnU85jrlYfB/0FyCVYD6jrQwTJhY8UiNPIG/EtZSVNyMugQ6e7SKD0T0gTOztX8R65h5cuBc2oMAqzKYaOPAvvjNreiMfH9PLZphqXSQPWXjXEmBD1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 21:56:52.0233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4c3aec-b8b3-40d0-2d38-08deb203b4d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7947

Rename amd_get_boost_ratio_numerator() to amd_get_effective_highest_perf()
to better reflect that it returns the effective highest performance value
for a CPU, accounting for preferred cores and heterogeneous topologies.

Add a new helper amd_get_boost_ratio() for doing both for boost
ratio calculations and update callers to use it.

This refactoring is needed because on some AMD systems (Zen6+),
the boost ratio should be calculated from frequency values rather than
performance values.

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/acpi/cppc.c    | 122 ++++++++++++++++++---------------
 drivers/cpufreq/acpi-cpufreq.c |   5 +-
 drivers/cpufreq/amd-pstate.c   |  12 ++--
 include/acpi/cppc_acpi.h       |   9 ++-
 4 files changed, 86 insertions(+), 62 deletions(-)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index be4c5e9e5ff6f..b581447711079 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -81,31 +81,18 @@ int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 
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
@@ -225,21 +212,18 @@ int amd_detect_prefcore(bool *detected)
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
 	enum x86_topology_cpu_type core_type = get_topology_cpu_type(&cpu_data(cpu));
 	bool prefcore;
@@ -247,14 +231,12 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
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
@@ -264,8 +246,7 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 	if (cpu_feature_enabled(X86_FEATURE_ZEN4)) {
 		switch (boot_cpu_data.x86_model) {
 		case 0x70 ... 0x7f:
-			*numerator = CPPC_HIGHEST_PERF_PERFORMANCE;
-			return 0;
+			return CPPC_HIGHEST_PERF_PERFORMANCE;
 		default:
 			break;
 		}
@@ -273,26 +254,59 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 
 	/* detect if running on heterogeneous design */
 	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES)) {
-		switch (core_type) {
-		case TOPO_CPU_TYPE_UNKNOWN:
-			pr_warn("Undefined core type found for cpu %d\n", cpu);
-			break;
-		case TOPO_CPU_TYPE_PERFORMANCE:
-			/* use the max scale for performance cores */
-			*numerator = CPPC_HIGHEST_PERF_PERFORMANCE;
-			return 0;
-		case TOPO_CPU_TYPE_EFFICIENCY:
-			/* use the highest perf value for efficiency cores */
-			ret = amd_get_highest_perf(cpu, &tmp);
-			if (ret)
-				return ret;
-			*numerator = tmp;
-			return 0;
-		}
+		if (cpu_feature_enabled(X86_FEATURE_ZEN5) &&
+		    core_type == TOPO_CPU_TYPE_PERFORMANCE)
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
+	int ret;
+
+	ret = cppc_get_perf_caps(cpu, &perf_caps);
+	if (ret)
+		return ret;
+
+	/* Use frequency values if available */
+	if (perf_caps.highest_freq && perf_caps.nominal_freq) {
+		*numerator = perf_caps.highest_freq;
+		*denominator = perf_caps.nominal_freq;
+		return 0;
 	}
 
-	*numerator = CPPC_HIGHEST_PERF_PREFCORE;
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
index 21639d9ac753b..a1a005b29daba 100644
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
index 62b5d995281d2..ae8d67fb374bd 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -472,10 +472,12 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
-	if (ret)
+	ret = amd_get_effective_highest_perf(cpudata->cpu);
+	if (ret < 0)
 		return ret;
 
+	numerator = ret;
+
 	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req);
 	if (ret)
 		return ret;
@@ -516,10 +518,12 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
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
index eb1eb40c6cb8d..492ebacfe05b4 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -195,7 +195,8 @@ extern int cppc_set_auto_sel(int cpu, bool enable);
 extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
 extern int cppc_set_perf_limited(int cpu, u64 bits_to_clear);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
-extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
+extern int amd_get_effective_highest_perf(unsigned int cpu);
+extern int amd_get_boost_ratio(unsigned int cpu, u64 *numerator, u64 *denominator);
 extern int amd_detect_prefcore(bool *detected);
 #else /* !CONFIG_ACPI_CPPC_LIB */
 static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
@@ -306,7 +307,11 @@ static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
 {
 	return -ENODEV;
 }
-static inline int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
+static inline int amd_get_effective_highest_perf(unsigned int cpu)
+{
+	return -EOPNOTSUPP;
+}
+static inline int amd_get_boost_ratio(unsigned int cpu, u64 *numerator, u64 *denominator)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.54.0

