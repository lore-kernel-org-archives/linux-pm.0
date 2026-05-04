Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012027.outbound.protection.outlook.com [52.101.53.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E34438CFF8;
	Mon,  4 May 2026 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935718; cv=fail; b=baoskAcfPniEbHABY2gOR+9Fyp1Zh4Ogf7/vNCdm3P/dZhIfqRV40ytiClbLTcxUinrWPFsPS46P6XmKN8zj0TkaEmeBAL6ChN38hHvzgDk9a03CImg7GgkuthjKBGZtCwRfDeIrE7ya6DEji1YG4xRU5c4487nockai11SkUr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935718; c=relaxed/simple;
	bh=ujWfsM+K8Hvja/lclvZjnHfPXyI1EFAgPlbaSo5ZRtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bka3ADIWqp1RD8cMXneW3IZL8lcif9rBZq48WNATse01iBokW7RV+iqaMkDKNNxeoiVMAZ//SQY7xXwpn0E9SJgwkWb3iAgt5XGg8gRK93oAJb8HSmdrRfLNWq2nf0VhCHjJ6vYmlSlEHOManaLU9nUASkHoMwTfeyYg6m5m/jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OPEYKXgI; arc=fail smtp.client-ip=52.101.53.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OPEYKXgI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqoTyTBdMOnA9u2HTi6M2kZ9GIOYiuTY3lMkSG0njxJLnkjqYYIs4OHYYoml6aoqfW0BDPp/XLy2Rm8R1BARwP23eC+bKA/RWr0U2YL6STGFXEYzpRrMzB6kUrAPl9jg2m5iz7SY60oKtPaZiEtzw2UGbQeykE7mLU42r1VeM/yEgnm0eNXnZkAKbBM7VclGa+HcYJmhnmyoHXnbCMrCokW6Ix4CM/MnzOxn24sH8kZJWgQ7yA2TQRGWxpGWcS54G1ICHGcPAN7CTGfiHqxGnzX4i1bVDVQVTx/aJCIfXm5aimqOxWAZ2/QSftJYtLnpglUOhV9WSzcE/BAqF5hBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVpP6QNaEaJUtoqMeTEGf47znfpbWBm7v7T1b/rphUU=;
 b=ZrQTz5UMzbtyqfl9W5nCZmGi1iVDa21LBui88BSIXmtyqOE9SE+lAo+PgN2fkCjU1gZq3bsPcW7V8TmIXezlhk8Igi5K2LHMGY/XtkGJFal62PTykJNcfLEWi0JLN+6r2ZJq02vNai9Q9t4Ai57vI3boSlpjGIf2TO7uoozTwMuWZFO2NoBaaxOpKk2otZpd90jhb06yTLWBWXn3XTa0aMkitbx3QctDzSFXdOaTvGjDmChrC2qiAXjawBQeIHzmdalsdhecRn1ZGKoeCbFCHQ0J2WlPOFHEUzd7xeppGhNIVytHIzQE3aS/HLjJXt2V06szPluXroH7sFQIcviSRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVpP6QNaEaJUtoqMeTEGf47znfpbWBm7v7T1b/rphUU=;
 b=OPEYKXgISTMJ6D/rpyFkaxZd1EN63++qNI3nUPe6tRLl/11oR8Asx5yx7NPZQ0WkZRNmoDLlasTbVWSqEf+M7OBxD0BwKzi/P3iG8oW6f7MFJIWuBQf+mBLFHgd2Lhr5e9/jiJNCpRlQWCZXnZsg0y9cR4BYO+ChUEsCozcGiqg=
Received: from BL1PR13CA0448.namprd13.prod.outlook.com (2603:10b6:208:2c3::33)
 by LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 23:01:53 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::92) by BL1PR13CA0448.outlook.office365.com
 (2603:10b6:208:2c3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.14 via Frontend Transport; Mon,
 4 May 2026 23:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 23:01:53 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 4 May
 2026 18:01:52 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<x86@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 3/5] ACPI: CPPC: Refactor boost ratio handling
Date: Mon, 4 May 2026 18:01:39 -0500
Message-ID: <20260504230141.484743-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504230141.484743-1-mario.limonciello@amd.com>
References: <20260504230141.484743-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|LV3PR12MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 610b3712-bc7c-4d1a-a1b0-08deaa312214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wRN08QLgVtAziimdiclXAGy04i13Ys0CEfWROx+X3LiXa/WTwAQSH4F1FrOirjiXdMm/xVhXvrI8xQXuiZtbDXxNJTfuvyzoepRYzfZUmJi0p90DuQpYN82Y/HI+32JtCgsdr17IMp86K/Uwx3YxTnV70Fm6HxVmUTbklrLRAoslRtXWza3cKVmhX2kkZYZR4/8p8kH5jG4Qbp2oVHBfpgF3pBYwb92sqgv+o8oupAMX8vx8zceHdl1eQS1PlT381a93P/dzLoG9eLYPPRwz1AO73D39p2mQmI2OZIwE5rPyGpF+OVI30bJB6R54ecSSk/2jaL6Z6/m1gtwZ/x4WbS5AJkFklTQuLO8ZPS0oRLbYaXF2R4p0ClZa+9zJBVXNl4eThlXus3yeO94b/J0boYdcvopEmlExs1CdcsorQslqm3kFk7Mtrs+2j6Zw+7TlVIX83+6eUOfH9pCQCG/7GHfgGHnXl6gX9dVHu9UmnlZmeMioELiRAvJnHM+H6HVMpHtcxBc03DBZQVwQIg9NSWWnmAH8mL3ba6X4Mc08cxRmpjej7USk2QZWfwbhl1xg43EZmk20lEmONzl3KQsaQHre+7q+xaG3qWeScIjvh/erItXPa6QkYitlbeXnyKrgHbaC80ZaLLWPdb0LpyVr0hwhrde4b++1gxpGgg1DdsOgIViR2Dc3nqZ+kAuWKIJs0e1t+M3W8rp/8rTT6VMkF+abiB4IkZU2L2ku90rKnhQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e3L3vkgMrV/bcKQADpCc0cABw5mLU4flFvRQquvjafGRffAnQVL8UqKI2ENVjmqeHGpFrowCw0/4PEbI1u2syGf2pBporzAH9OyccY7himTEO5l3uy6agSZmY92PiPY6gx6yY4QBP8CoGJko1PDsj6NWwc8DR42Q1Gw31OuFaVaSxMNfBV7I1bEqttJ82DvrO85rNrpagdHEWY15mKgn43T1vygxKWe3ihoiXMO9wnk9Eh2YiyGEdLOLINy7pMN/xrQC13ZPCdtgj85PuNqDjPEww/MeT0Pwx2P5oTWXzH5nKJcNUxphAWjy0pBTdKPxZsMRVhN6kZj255wNERkjhKun0gGxRfb8D+SEv1MhSHVMsOEHezsESPcUZaznSpxAl+OC1NpfpASRAaBQ++8DZYEfCCg27nxpKHj7jAUpLYQE0/Q9r1nStcEdS+kQRYKT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 23:01:53.4609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 610b3712-bc7c-4d1a-a1b0-08deaa312214
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185

Rename amd_get_boost_ratio_numerator() to amd_get_effective_highest_perf()
to better reflect that it returns the effective highest performance value
for a CPU, accounting for preferred cores and heterogeneous topologies.

Add a new helper amd_get_boost_ratio() for doing both for boost
ratio calculations and update callers to use it.

This refactoring is needed because on some AMD systems (Zen6+),
the boost ratio should be calculated from frequency values rather than
performance values.

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
index 453084c67327f..f5c7cc05220c4 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -476,10 +476,12 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
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
@@ -520,10 +522,12 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
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
index 053ea67f767ff..0d7b047cb1efd 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -194,7 +194,8 @@ extern int cppc_set_auto_sel(int cpu, bool enable);
 extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
 extern int cppc_set_perf_limited(int cpu, u64 bits_to_clear);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
-extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
+extern int amd_get_effective_highest_perf(unsigned int cpu);
+extern int amd_get_boost_ratio(unsigned int cpu, u64 *numerator, u64 *denominator);
 extern int amd_detect_prefcore(bool *detected);
 #else /* !CONFIG_ACPI_CPPC_LIB */
 static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
@@ -305,7 +306,11 @@ static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
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
2.43.0

