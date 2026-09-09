Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010019.outbound.protection.outlook.com [40.93.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4582B33D4E4;
	Wed,  9 Sep 2026 03:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788925015; cv=fail; b=C3h5eujgX7iP/YcokE9vyaeaMjw6ZNI/P32Nqk5rrOcfOKJGaSDnmHE4pyrJp2W4cHUMN93/SrKXJS1v+C9vSE7WCjkN4oD3BnyDeyNiBjE5iIor8bx93+WFu3axwdCtCRVTIWrGLBS/LuGb3+n96In2ziP6hpocVTg8s/n2I/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788925015; c=relaxed/simple;
	bh=+3gT9NLz8z6QOVgg1j0rCZVzsTuvTPSSR6dZjAn5ehc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBKzydIUJabgBRAqWXgz8FVoMRJOan1lAt1KVDw98bJMKpJEAE00kkNyMpiYUjmEeMHYvEybFjq2lg/xSl8b+1iTYPeExizfKdrWV5WAuAVhiQtqjfWPJcSh6IG+hVTsByQPlHDeisYFh8Og7YqW9JdJ4+8yljuvI8/FpuJI9dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FgjunHkB; arc=fail smtp.client-ip=40.93.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FgjunHkB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHb7eNa0T634eYfHtTKx7nKCchgB4LhvF7fRD2q26cuEz+dmO0i4XvIqMf2n+ZevKgGS3motyW5qbAR6rBqeSKPp57avrsM0ByUywqbFFiTm/jwzEd7nberqGM0hcru8b+lMqzqT5gvZggAyLJwq4LBUUqxGZlMyQKoxSJpFvzGfxTo96Y2u58EHlg5O1vowjcHKHi8Ir9llwyUAwvKByrX8lK5HYbgvgnYJOlCDpQGKG6XABx/55g4VLE+GXMAa/KsfgAMRYNGevcSxqa06YHoSDUl8wHGpc4mQAOk1IcDcuzWFvfsLzuJ+cRg1aaP34gviOYU8YPRY7ffzHisBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPC5NJlIzLMS78hnwz2lXJeC9gBlA7bh4LILz9JKdKY=;
 b=JfbWWn3gx/Dj5hXYTgvSK2slZgG/T+fJIDWeHpOOJdlnRE6txyV/jVjOzIrDfLf7d3eORI1nlWqI6G32hGhcoeWIoqp4zpI/ngZfrgTkMWadmoyVEue9kTR9Fh8CJKhTZfTUINGvS0vbEZCIgxRNYcSYsp+Qw2UfmGmPa6/h27hYRpY7AxGIvWrzvNFDhCWYfpCm7q3xN3M/urlh1kTJfFq/7O4pS9SqdYnuBMMPU8LBdlf+vIRgEfgutQO19xdZvwUVcOOOKxgPCwZepP8/lGG9Pxgs2IigLd4j9iLGfevdA+oh/LJW4iyNzW766x1TWBQ4MkBBHuJNPHBbOAqy8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPC5NJlIzLMS78hnwz2lXJeC9gBlA7bh4LILz9JKdKY=;
 b=FgjunHkBtZFAdo/wLB5ZkW1l0G4jGLKpB91+2MVrwtDp1zhxAB4N5gT2ccNdnPwzO7Ejvm2y778r3zod82ZW1Y/bc0orWo0CjiFtsCX48K6fyvhbaRWlCCX58NQ8wNcVnmBOSzhA6nXOUWvRmfUbux0QKnyLJ6qttEfBqlV1tl4=
Received: from PH8P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::17)
 by CY5PR12MB6276.namprd12.prod.outlook.com (2603:10b6:930:f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Wed, 9 Sep
 2026 03:36:47 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::f) by PH8P223CA0012.outlook.office365.com
 (2603:10b6:510:2db::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 03:36:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 03:36:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 22:36:44 -0500
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 22:36:43 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, "Mario Limonciello (AMD)"
	<superm1@kernel.org>
Subject: [PATCH v3 1/3] cpufreq/amd-pstate: Add per SoC and per core type EPP tuning values
Date: Tue, 8 Sep 2026 22:36:21 -0500
Message-ID: <20260909033623.454449-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909033623.454449-1-mario.limonciello@amd.com>
References: <20260909033623.454449-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|CY5PR12MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a8a64f-d570-4653-c986-08df0e239345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|10067099003|3023799007|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	7jz5gmjGRRpqk73BSJW6i7s+6KG1rSKKLo8dWRiWIwKgfCybg9S7fstkuDSk+TXrGzHvy/PgC+FACdekgx+e3i8L15graVV4xUw0BrYPj9achsxk0KDdX+Rx0cCHBpR8mCmx2z2qM1a87UvVvSLygpSibKwYUwxFrJw13VCZYlML7NMdS7JmlNlPR5EmEU4dPJm+a4wYT4HNt5z3d9LN53SVA3Ka5ZnT8982rbIpJv6LBgY+Np5hopCT9g5B+WwugwtaPZg8Vl+8+RxeogBhcdWpqGCSKFVKpbZ610ES5lgtolTMFcrGBc9MpEEfUvTmlLhpBWc9fn6cHVEuJt2enDy2WxOvME/4G82CaX7gmYKLBK+fQe724DkMdh5vzyFGQmpGK2Ra9LanOdDxnhWLr5cGCQEUoZLma81MmMhl7jmeYWqIMUpha3R2pwDIR1suRlfow4wM6QtTVFAIZeu7PmkuRwfbnOntRpmv7r1lQSMrLVc7Mws3/NzdDQ+Qq7X45LJ8J1yrYxdtqt6NrlniTjWUhFQNIrXOG/e4v7b0GfK/54gaQT5+mx579v3dcVm/oCdYsPLI7JEgfUSLNQjluz49Sq14J657m4NOjOWwyFU+yMA9nFznKIszXrvyad4vkdWFfZcFGL9Sy3EdsUdF8EQ6kEjshRhv19I/J0XsdzIKqpWMH8kMUKzwUXUBPo/VpCivw5TfqLYq4WkvSHwsuQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(10067099003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8S3oaDUUtq7yHrrKgmxniNeKwOK58dEemrHcXx3mU685DmHJ0g6LCLmdYrZCS30HGIlQ3ltQXGGEujz43E10Yt7KwTn1U2w0pvoDrBE2sCPrmtg8He4JVyARh29uiAtox90yLvYz5C1DgNvKcjENmhIH5cumX8af/mp2bNWICiQqQNkuhima1Lb41kX9LcYL/Cf/nRaE0yr4vKu9SW//60kY6/3kxkPXm40jEP9b9ldyj5iHo3VM+fmLM5kqoOkCuwDzvgXIlg90kIDIKjhkRfcQuuPRdygODCNeu1TKKx6Ha3n7khdci5ihaDCtR7rEJJ+7wzHQjza+PPmOiUVNnmyuZvGF0o2VPTzWpy7oBpkEbKB4RYp0FtygNuiYPk1tzDX24yc3R9lB2l7hfjDRxtZzWoIbaM2ki0IL4UFJMgkAqPT1lfdVTb5hQLwHadtu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 03:36:46.6745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a8a64f-d570-4653-c986-08df0e239345
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6276

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

On newer SoCs the behavior of the platform has changed, and using
the same EPP values for everything will yield worse results than expected.

Add a x86_cpu_id match table that allows setting policies on a
per-SoC/per-core type basis.  If a SoC is missing, fallback to legacy
values that are used.

Changes also:
- Change epp_values array and amd_pstate_cpu_epp_values() from unsigned int
  to u8
- Add static_assert to ensure epp_values has rows for all CPU types
- Fix show_energy_performance_preference() loop to exclude uninitialized
  EPP_INDEX_CUSTOM and EPP_INDEX_DYNAMIC slots
- Add debug print statements
- Remove amd_pstate_get_epp_from_platform_profile and inline the logic
- Fix cleanup path in amd_pstate_set_dynamic_epp
- Change show_energy_performance_preference to use for loop with preference
  tracking
- Add debug prints in amd_pstate_init_epp_values

Behavioral change: show_energy_performance_preference() now returns a
numeric EPP value via sysfs when the cached EPP does not match any named
preference, instead of returning -EINVAL as before. This provides
visibility into custom EPP values set by hardware or BIOS.

No new platforms are added in this commit.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v3:
 * Use switch/case
 * Cache cpu type
 * Use ... for legacy EPP initializer
---
 drivers/cpufreq/amd-pstate.c | 183 ++++++++++++++++++++++++++++-------
 drivers/cpufreq/amd-pstate.h |   2 +
 2 files changed, 148 insertions(+), 37 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9325c657d2d49..60a8b8f220437 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -55,10 +55,10 @@
 #define AMD_PSTATE_TRANSITION_DELAY	1000
 #define AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY 600
 
-#define AMD_CPPC_EPP_PERFORMANCE		0x00
-#define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
-#define AMD_CPPC_EPP_BALANCE_POWERSAVE		0xBF
-#define AMD_CPPC_EPP_POWERSAVE			0xFF
+#define AMD_CPPC_EPP_LEGACY_PERFORMANCE			0x00
+#define AMD_CPPC_EPP_LEGACY_BALANCE_PERFORMANCE		0x80
+#define AMD_CPPC_EPP_LEGACY_BALANCE_POWERSAVE		0xBF
+#define AMD_CPPC_EPP_LEGACY_POWERSAVE			0xFF
 
 static const char * const amd_pstate_mode_string[] = {
 	[AMD_PSTATE_UNDEFINED]   = "undefined",
@@ -129,14 +129,86 @@ static const char * const energy_perf_strings[] = {
 };
 static_assert(ARRAY_SIZE(energy_perf_strings) == EPP_INDEX_MAX);
 
-static unsigned int epp_values[] = {
-	[EPP_INDEX_DEFAULT] = 0,
-	[EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_PERFORMANCE,
-	[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_BALANCE_PERFORMANCE,
-	[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_BALANCE_POWERSAVE,
-	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
+/*
+ * The numeric EPP value programmed for each named preference. First dimension
+ * is CPU type (TOPO_CPU_TYPE_ANY for non-hybrid, TOPO_CPU_TYPE_PERFORMANCE/
+ * EFFICIENCY/LOW_POWER for hybrid). The initializer holds the legacy values
+ * used as the fallback on any platform not listed in amd_pstate_epp_soc_ids[];
+ * amd_pstate_init_epp_values() overwrites slots at boot when the running SoC
+ * has a per-SoC (and potentially per-CPU-type) override.
+ */
+static u8 epp_values[][EPP_INDEX_MAX] = {
+	/*
+	 * Initialize all CPU types to legacy defaults.
+	 * amd_pstate_init_epp_values() will fix these up
+	 * based on the platform during boot.
+	 */
+	[TOPO_CPU_TYPE_ANY ... TOPO_CPU_TYPE_LOW_POWER] = {
+		[EPP_INDEX_DEFAULT] = 0,
+		[EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_PERFORMANCE,
+		[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_BALANCE_PERFORMANCE,
+		[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_LEGACY_BALANCE_POWERSAVE,
+		[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_LEGACY_POWERSAVE,
+	},
+};
+static_assert(ARRAY_SIZE(epp_values) == TOPO_CPU_TYPE_LOW_POWER + 1,
+	      "epp_values must have entries for all CPU types up to TOPO_CPU_TYPE_LOW_POWER");
+
+/*
+ * Get the EPP value row for a given CPU, accounting for hybrid CPU types.
+ * Non-hybrid systems use TOPO_CPU_TYPE_ANY; hybrid systems use the CPU's
+ * actual type (PERFORMANCE/EFFICIENCY/LOW_POWER).
+ */
+static inline u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type)
+{
+	switch (cpu_type) {
+	case TOPO_CPU_TYPE_PERFORMANCE:
+	case TOPO_CPU_TYPE_EFFICIENCY:
+	case TOPO_CPU_TYPE_LOW_POWER:
+		return epp_values[cpu_type];
+	default:
+		return epp_values[TOPO_CPU_TYPE_ANY];
+	}
+}
+
+/**
+ * struct amd_pstate_epp_values - EPP values for the four named preferences
+ * @performance:	value for the "performance" preference
+ * @balance_performance: value for the "balance_performance" preference
+ * @balance_power:	value for the "balance_power" preference
+ * @power:		value for the "power" preference
+ */
+struct amd_pstate_epp_values {
+	u8 performance;
+	u8 balance_performance;
+	u8 balance_power;
+	u8 power;
+};
+
+/**
+ * struct amd_pstate_epp_soc - per-CPU-type EPP overrides for hybrid systems
+ * @performance_core:	values for TOPO_CPU_TYPE_PERFORMANCE cores
+ * @efficiency_core:	values for TOPO_CPU_TYPE_EFFICIENCY cores
+ * @low_power_core:	values for TOPO_CPU_TYPE_LOW_POWER cores
+ *
+ * Referenced from amd_pstate_epp_soc_ids[] to give a hybrid platform its own
+ * numeric EPP values for the four named preferences, with distinct values per
+ * CPU type. Non-hybrid systems are not listed in the table and always use the
+ * legacy defaults.
+ */
+struct amd_pstate_epp_soc {
+	struct amd_pstate_epp_values performance_core;
+	struct amd_pstate_epp_values efficiency_core;
+	struct amd_pstate_epp_values low_power_core;
+};
+
+/*
+ * Per-CPU-type EPP overrides for hybrid systems. Only hybrid SoCs should be
+ * listed here; non-hybrid systems always use the legacy defaults.
+ */
+static const struct x86_cpu_id amd_pstate_epp_soc_ids[] __initconst = {
+	{}
 };
-static_assert(ARRAY_SIZE(epp_values) == EPP_INDEX_MAX - 2);
 
 typedef int (*cppc_mode_transition_fn)(int);
 
@@ -1077,6 +1149,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 		return -ENOMEM;
 
 	cpudata->cpu = policy->cpu;
+	cpudata->cpu_type = cpu_data(policy->cpu).topo.cpu_type;
 
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
@@ -1204,13 +1277,16 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
 static int amd_pstate_get_epp_from_platform_profile(struct cpufreq_policy *policy,
 						    enum platform_profile_option profile)
 {
+	struct amd_cpudata *cpudata = policy->driver_data;
+	u8 *values = amd_pstate_cpu_epp_values(cpudata->cpu_type);
+
 	switch (profile) {
 	case PLATFORM_PROFILE_PERFORMANCE:
-		return AMD_CPPC_EPP_PERFORMANCE;
+		return values[EPP_INDEX_PERFORMANCE];
 	case PLATFORM_PROFILE_BALANCED:
 		return amd_pstate_get_balanced_epp(policy);
 	case PLATFORM_PROFILE_LOW_POWER:
-		return AMD_CPPC_EPP_POWERSAVE;
+		return values[EPP_INDEX_POWERSAVE];
 	default:
 		break;
 	}
@@ -1420,6 +1496,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 				    const char *buf, size_t count)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
+	u8 *values = amd_pstate_cpu_epp_values(cpudata->cpu_type);
 	ssize_t ret;
 	bool raw_epp = false;
 	u8 epp;
@@ -1454,12 +1531,13 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 		}
 
 		if (ret)
-			epp = epp_values[ret];
+			epp = values[ret];
 		else
 			epp = cpudata->epp_default_dc;
 	}
 
-	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
+	if (epp > 0 && epp != values[EPP_INDEX_PERFORMANCE] &&
+	    cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		pr_debug("EPP cannot be set under performance policy\n");
 		return -EBUSY;
 	}
@@ -1484,34 +1562,31 @@ EXPORT_SYMBOL_FOR_PSTATE_UT(store_energy_performance_preference);
 ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u8 preference, epp;
+	u8 *values = amd_pstate_cpu_epp_values(policy->cpu);
+	u8 epp;
+	int i;
 
 	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 
 	if (!cpudata->dynamic_epp && cpudata->raw_epp)
 		return sysfs_emit(buf, "%u\n", epp);
 
-	switch (epp) {
-	case AMD_CPPC_EPP_PERFORMANCE:
-		preference = EPP_INDEX_PERFORMANCE;
-		break;
-	case AMD_CPPC_EPP_BALANCE_PERFORMANCE:
-		preference = EPP_INDEX_BALANCE_PERFORMANCE;
-		break;
-	case AMD_CPPC_EPP_BALANCE_POWERSAVE:
-		preference = EPP_INDEX_BALANCE_POWERSAVE;
-		break;
-	case AMD_CPPC_EPP_POWERSAVE:
-		preference = EPP_INDEX_POWERSAVE;
-		break;
-	default:
-		return -EINVAL;
-	}
+	/*
+	 * Map the cached EPP value back to a named preference. Skip the
+	 * "default" slot (index 0) so an EPP of 0 reports as "performance".
+	 * Stop at POWERSAVE; CUSTOM and DYNAMIC are not initialized in epp_values.
+	 */
+	for (i = EPP_INDEX_PERFORMANCE; i <= EPP_INDEX_POWERSAVE; i++) {
+		const char *name = energy_perf_strings[i];
 
-	if (cpudata->dynamic_epp)
-		return sysfs_emit(buf, "dynamic(profile:%s)\n", energy_perf_strings[preference]);
+		if (epp == values[i]) {
+			if (cpudata->dynamic_epp)
+				return sysfs_emit(buf, "dynamic(profile:%s)\n", name);
+			return sysfs_emit(buf, "%s\n", name);
+		}
+	}
 
-	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
+	return sysfs_emit(buf, "%u\n", epp);
 }
 EXPORT_SYMBOL_FOR_PSTATE_UT(show_energy_performance_preference);
 
@@ -1903,6 +1978,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		return -ENOMEM;
 
 	cpudata->cpu = policy->cpu;
+	cpudata->cpu_type = cpu_data(policy->cpu).topo.cpu_type;
 
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
@@ -1953,9 +2029,11 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		cpudata->epp_default_ac = cpudata->epp_default_dc = default_epp;
 		cpudata->current_profile = PLATFORM_PROFILE_PERFORMANCE;
 	} else {
+		u8 *values = amd_pstate_cpu_epp_values(cpudata->cpu_type);
+
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
-		cpudata->epp_default_ac = AMD_CPPC_EPP_PERFORMANCE;
-		cpudata->epp_default_dc = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
+		cpudata->epp_default_ac = values[EPP_INDEX_PERFORMANCE];
+		cpudata->epp_default_dc = values[EPP_INDEX_BALANCE_PERFORMANCE];
 		cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
 	}
 
@@ -2254,6 +2332,34 @@ static bool amd_cppc_supported(void)
 	return true;
 }
 
+/*
+ * Resolve the numeric EPP values for hybrid systems. Only hybrid SoCs are listed
+ * in amd_pstate_epp_soc_ids[]; non-hybrid systems always use the legacy defaults.
+ */
+static inline void __init amd_pstate_set_epp_values(enum x86_topology_cpu_type type,
+						    const struct amd_pstate_epp_values *core)
+{
+	epp_values[type][EPP_INDEX_PERFORMANCE] = core->performance;
+	epp_values[type][EPP_INDEX_BALANCE_PERFORMANCE] = core->balance_performance;
+	epp_values[type][EPP_INDEX_BALANCE_POWERSAVE] = core->balance_power;
+	epp_values[type][EPP_INDEX_POWERSAVE] = core->power;
+}
+
+static void __init amd_pstate_init_epp_values(void)
+{
+	const struct x86_cpu_id *id = x86_match_cpu(amd_pstate_epp_soc_ids);
+	const struct amd_pstate_epp_soc *soc;
+
+	if (!id || !id->driver_data)
+		return;
+
+	soc = (const struct amd_pstate_epp_soc *)id->driver_data;
+
+	amd_pstate_set_epp_values(TOPO_CPU_TYPE_PERFORMANCE, &soc->performance_core);
+	amd_pstate_set_epp_values(TOPO_CPU_TYPE_EFFICIENCY, &soc->efficiency_core);
+	amd_pstate_set_epp_values(TOPO_CPU_TYPE_LOW_POWER, &soc->low_power_core);
+}
+
 static int __init amd_pstate_init(void)
 {
 	struct device *dev_root;
@@ -2281,6 +2387,9 @@ static int __init amd_pstate_init(void)
 	/* check if this machine need CPPC quirks */
 	dmi_check_system(amd_pstate_quirks_table);
 
+	/* resolve per-SoC EPP values for the named preferences */
+	amd_pstate_init_epp_values();
+
 	/*
 	* determine the driver mode from the command line or kernel config.
 	* If no command line input is provided, cppc_state will be AMD_PSTATE_UNDEFINED.
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 9f5a81976eae0..c9a1dfd3d6752 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -146,6 +146,8 @@ struct amd_cpudata {
 	enum platform_profile_option current_profile;
 	struct device *ppdev;
 	char *profile_name;
+
+	enum x86_topology_cpu_type cpu_type;
 };
 
 /*
-- 
2.43.0

