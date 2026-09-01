Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9322BE034;
	Tue,  1 Sep 2026 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299975; cv=fail; b=SLhoYHgUQoitnTe48tykUXnUfEslxbUgtsTwRni7n0da6b6GWk9JpsSqgtJczkWWkAvFjmJG5WMMdLKJcdwtpAYxGE8JB7MDqjYGUtKOdabgZc0He3fkLPHTNwb7OjvQWOosGUap84+UVHI9KvQCZZ+CP1POdzWj4MRbsktPF5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299975; c=relaxed/simple;
	bh=gs44WxlMye0uFck9/h5OW/KXgGwSf1jGBBmyd5UX7fQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtzJ2YxH5C4sptQgec+JvKTlQb5S+DcJKpKsKZ+cAphGpsICOoo6hSV7FEsOv4UH9nN6Dp6uoepnPRD7bGnZFmva6P4TSV5QpMVaxLYKNwKhlrbsFSuck00qDkUp/jv2dJGuTXcOKVGnOpstjJyrhz45mB0PDznZUMWZM4/hzoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ChBw3LWC; arc=fail smtp.client-ip=52.101.57.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ChBw3LWC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cruDnoCEROkvVqy6JVD6s8HXXN5riJo5WjpdpiPRlKBZb8kPhzOCNEzZ0mQ0ian7PNSAbEY4kqdqHTaJ1JkN17kkoUxGMxBNxrgOAwFtWhvCB+PPYnh3aBhOhe2j0xnVHoHaxRWoqby+KojfvwuA0Oc/FMvmpI5AF05L8sBeEhVuupHsInO6PmeFWyCNs0g2SABl8y/lBQ0BEzX7Ps2On9qIjB/5jMb58pYa725AcGf9hNFhJzqCQNAUNAsOm0r0WYhg3nhio4LR2P71PNwVYNW9r0fO76rX+Bm9uHO5tsZkVWTQOurzf2AsJXBzt63v+r8M6odP6+MKq5MKIcghTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prSlFJ1UDgSAh1QIMwnkUDTXa/b99L+1WAtrFZr8tjo=;
 b=TKqO4qJ0oLrrZaD/8OUtWlcgUPDwI4VajbLB3clPLIjR9eIrki/Psw+iQSc5dHs4Pff997thLa7sGvvbf5y9+YGYwzThh4NFHw7qDK86T96Jq8nRU76pI9qCQPc+lBcxwRDSBAXY3Rb2hYnhBuPUBSye+uaEN2dqzhBLeMnzUhRfkNfbCgg/WaLLil3ZfDbZWVQli5ryhIxARqVPbyiNqsz+kojq2KlMkUe74s4N5OHyU+/LeiIv/mjyeNwetMNkFBK5r6Wx4lOBHO1NTVefYFobU2fJ2YYo3+NmU+ruxFwBJxutWQg80y2FsBISze+hdKXt5ptsw8DSJgWRtm55aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prSlFJ1UDgSAh1QIMwnkUDTXa/b99L+1WAtrFZr8tjo=;
 b=ChBw3LWCc/UOLAmexuQLTPGA/gk7FLpYcTyi0x2w31Oe2evNKyc5doRzcmMhQH4xrVRgfi99Lv4STJ2LNi5IrvNcXWYEAIn9B3pA63gpSZZSaGSf1/XVyEXOfXMILJneDXOp+CEX0V1gMz1vPh+zxBrUWEKGp49EglGxRAFkWMs=
Received: from SJ2P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::7)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 1 Sep 2026
 21:59:27 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:5da:cafe::81) by SJ2P220CA0010.outlook.office365.com
 (2603:10b6:a03:5da::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 21:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 21:59:26 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 16:59:24 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<x86@kernel.org>, Vishal Badole <Vishal.Badole@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v2 1/3] ACPI: CPPC: Refactor boost ratio handling
Date: Tue, 1 Sep 2026 16:59:10 -0500
Message-ID: <20260901215913.3042182-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901215913.3042182-1-mario.limonciello@amd.com>
References: <20260901215913.3042182-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b73365d-f1a9-4085-7283-08df08744a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	IApxtjkEsgJr5zez59fAhw3KCyWNPzCotWvUmXmSyYzQcs5tPugJDx4r7LF+mcZG0UOa9P1SHtNt7aoCkPNYoriLZ+1WKmQ+vMgLz2ad288ieH/2CLcW0QyylGweerdVydYWFCm/uHPrHkEnBlAdNahJOG0+hiz/YAQp7eNkGNnCRnTbWhWQr3lSCYbWiWi+vqgzT0k6F5XA3VJXn4M75nZ5v5ncG1Ouzov9duu3FIXxSTQkKAs8xeJR3ssfMRMMFRHcYWP9KiUe32smH1AFM6OwLW6L3+AqO2hhmFTAyZXkMjn7aDImLH6aCsIhKtWrt2KvAuvBWcY1KGtYZYqwl+go7lMhAZqkxeY6nuTbUSQ1nBKWYaQXxoWqkmcMThyIHKuXurjw8fbn0UUGRxcEi3FpNkj7MAyevU18agp+nY7wuSCQ/X/W66d6bIpVpqUGF+jjfrBZdt62xrqDGxOB+CgFy3ggd8A//J9J2O0uLphFNeA+TmMr60NZJsZrpeSOqCqGKe1aYWZ9s+xalJHe+fMMQ9CY+ELaqrUfajAeqtsqm8uITcGzYmQ9i691QlkeU1xuNVXJ/mM8fTQt6bTBZbD8UMIWWLoXMiJ5dqvwMrnBfZIi51nUIaFYRcE5PXEX7XaAcpiZwXreDwjhvmQmu419rqGNjn919/+RBCh4s6mcJdCDadv1DpuDPjSxX1v32ChPqa9C2X9ttXD127mKHw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kAvzuwrcrRpxoXYeqFs31xGn4Sz2Yu316o6bKmpHm6L/MbgtU94GIMKGQKO83WPvKEChHa+CNqmci4r+mMs3G/8F2dytOORwtul5DTjx3JrZaKJRLi8+UPs/m+qOnSxzP8qup0tBwTFC4AFAlNfHgWeAhdgEhkBGlmgtKamAm24UNIRK56kXShgUy5fdsdNMkBUTYV/+VeBjCqHAeHTEnO8jJFdJwF0zYukY81pLvp9mULtVlPhiU/SX+MbrGRqtmgeYf6AkQxWp9pRoBeI1+LBq1FvOFTa1bL1ntcmAh92NyqyS2rcbxWtNdyCSfTLEgM4wOWOi1frog0kiDvrtj14jrBJVVkOo38rgZIOXZFWiOJRXwSOmeKYBJj3K8dBOSb206zh7wr4kx6IoCGimzMqTcVKN1k0mjdtyYQYclr/atfrQZFeNEzrBCzr1vKIG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 21:59:26.7707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b73365d-f1a9-4085-7283-08df08744a80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744

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

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Drop __initconst from amd_zen6_client_ids and max_freq_zen6_client
 * Add T-b tag
 * Switch X86_FEATURE_ZEN6 and X86_FEATURE_AMD_HTR_CORES to cover more
   platforms
---
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
index b565843e41d35..cf2d67f09fead 100644
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
index be22504eddce7..edad712e3330f 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -201,7 +201,9 @@ extern int cppc_set_auto_sel(int cpu, bool enable);
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
@@ -314,7 +316,15 @@ static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
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

