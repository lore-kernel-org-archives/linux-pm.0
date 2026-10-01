Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986CF3D0BEC;
	Thu,  1 Oct 2026 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873540; cv=fail; b=TjWNEMJOoBUw5/and7R3/qEOVwZ+UUN7bizcu0tAnQ9ixGk2wblj86BY+hmJxIDPU+/z8tFOkIzsYiiW5OQyJCizMO4EGldrHtdqbS2fBEv9Ye9L2cBWPhbrAYj3x58rtR2R3W6mYjxKXk+yhaT7s3BHe4pPY2v3Ecjdmr3dOdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873540; c=relaxed/simple;
	bh=BXMCinyiRic5dDgYluGenLaZ69dP0l0oJ+2hFPRvl4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DBLrZsV6GXnYN7A6jni+12RtuoOl4kzWjZ0LfS/1tF2yisNLom5jixw5P7q86TdGl3ABkVjbT9/yhSLQtkStSqXKJ4wVo145nIHDWc6WL2365DsXEb6gjsNKeT+hq+9zV/hz3SRVngsNmO3EhHTp7/z7cKFcEIgZXb3fx6cTBd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3LKNtHGS; arc=fail smtp.client-ip=52.101.46.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3LKNtHGS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThICoG92p9FKI8TDWBgpz99czdQLEF6niV5AWFl9xs/LiRGVQ7m/YTXM3CJqV7ZZ3QznNt3hSLruCe31N1Xfvlwawc+agGo7dYzHbiZ0SbcHvbg7mx7LosD1zDl8kQ9b2qqp7+xYMVfo/a2z+adnhfOOwJMoYykVP3UQ+jImc+FJM00pl8sQxpYt47tN//7rlc4qheeuLD8ceZh9y9DxfnjmiBRYHQi6KYEoqlljK9F+wcs1Ggofv+ZQ8MEeDXTme2/m3k5PvuaG0qMoZfqcIQTSobgOcla5rl0Q2YMtt7OV6DvJMcCfm03pSeXJRzewIfX6yZ0PZtFHiyN9VeUQTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nxqh6RnqDZyaLmH1JU4Pp+hfICIkIlQwQjXnrLVFeck=;
 b=yHHdlFpjpHJsNq4fNDE+uGLbrVqGLWAPLGRS7QFKLFrOHpDQ9v3OKcrwpyqqXcIDEf5Zo4QwC1wXnyDObTPCuWO+HZ/L4Mla8f0r+SFS3rExTQdVZkomdpqHjlcd/bWhUvjAWAYtNaZ4KLKws4a6Yfr+obLY5DIObYp47c7pCSTYIfdgliRrSpVBJkdILzPZajzvPMYr3CcfVvyx/xNlvg+J/AVG1bUEjrdow+5/nFtwm7jghT6+bA94lzWBN9mshitCnWmHXWpoTapPAGqwJ9snA+q53Ou7i8B2hNNwMeDlE5d5Eku4vEJPEni1MyVUmttZJZUbsKt2ow4BiRUT9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nxqh6RnqDZyaLmH1JU4Pp+hfICIkIlQwQjXnrLVFeck=;
 b=3LKNtHGSs29qedi+g1gQZZHkMT6zkoDljJYIR9sU59sggxDg0tKalIL5TT8cDEx3f8vgctwMknjHuLhaF9zDcYfCJxhlSOBJyoYWtavOUJt1QgUbuGA0BR2pAS07fkI+iwZU4L6tly0BInlSPZeEdG7Z41k6fy9STHcuPnqejIM=
Received: from PH8PR05CA0006.namprd05.prod.outlook.com (2603:10b6:510:2cc::6)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Thu, 1 Oct
 2026 16:52:09 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::65) by PH8PR05CA0006.outlook.office365.com
 (2603:10b6:510:2cc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 16:52:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 16:52:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 11:52:03 -0500
Received: from [192.168.0.226] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 1 Oct 2026 11:52:02 -0500
Message-ID: <b3ed027f-8c7b-4ac5-aac6-95d47ac0c41d@amd.com>
Date: Thu, 1 Oct 2026 22:22:00 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cpufreq: amd-pstate-ut: Tolerate aliased EPP
 preferences in the EPP test
To: Mario Limonciello <mario.limonciello@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20260921190235.3651688-1-mario.limonciello@amd.com>
 <20260921190235.3651688-3-mario.limonciello@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260921190235.3651688-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1e37d2-956a-4aa0-fe26-08df1fdc555e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|22082099003|4143699003|18002099003|6133799003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	tgsM69Noe2Tsr9iGkcFcqvHjXMSPX1erWFC80YuaeK7yikObV9USfBxTdrD96P36rVkxGe0BcOYXso0eRnJP4ce3qds2rI1tDNKsWArPJvYTHWcTWrsYIn3o81Z4GyPNN3y4GSDj+edst1bzN5Ajxe5uiZTpz3ojmy0pA//8fG3W79C0LZ2mkon9U8TC/Xjjvks3rXzc32tr5tiXxii7NMREEF0q5zfrt5S2Knq0NN2x7NnT781ebn+WVLYst+WWFJeDhFeOkXVThNyPGoR70/Ot549czb8fS7j+1Fy4HH0RUwSC/N0QJpyiHLQKz+z3hYIKrnZPREYfwGj8BrPooSZqCbAXAPmI8/7bY3Xx4KeSGU3KklNsAaiilhCm79CebWNe3bmZ3wBYwgn5GvNxh78nWh55wfzqHw2u4UEWdhTNLLLdtGyJNl8vMpWTciHPrPE3moLxrRHc5DdhY1hwnIVSi7O8hjqJl0PvVSZ9b6cCSiEGDb+DUL59hgdeoZBdzihGNWrIs/RnRczByzb2lC0o4OF/Bq2nBL1fZ5wMAxTv2ANt/0EVMp19987Dlj8CuyOR+pju3MMtUFCDYrckH0N6mXajYh8gMg+KWd/kja2EXkYc18jAX0vnCQdi9sy0qooaRzbMuKlzsIw+Dof8GqWM61S91smCQB1ZVx192zNtNbTTwyCcMuREnNPSc935eQIRtvHtpV2gMzRCd9GPKg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(22082099003)(4143699003)(18002099003)(6133799003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kMhwgOTHcp64dSJsOlUSLDIu8WNs0+xTpDVb6mwaHgoS6bBlr+4Tkeyh7vFnMNWAOhtmggeKA1/rFKcG/hvRJp103mnRNZ6GDyaPo5m+Ff0aQjdTk6h3qWXc+S3Pekake9209o33btY7Gkt31SjjX7PDQN1O9+NwmryTdq/oNZiVq0HXC56Pa/xi0yOp9XgWel5/pXOlS2HmDxiW6SZqtd1LEI/o4jtAP1nBgFCiTitiY+89oaW+q05O+9qDnxK66QSDoQ1jZNdvAI1IIfzNrnfvVrBbQGu4SmiWOipP+u9Q8xdhJN2T+ikTCqpR1qnNvQS1eLFspteWch7obZwaqf7I2k0tXeruDlToAa4dE+t3cNxs487j1kZ+JiCdwBis87jwLBOOTP9MUHpmvOAyijH/0ARvnP3+oqbiWn0+GITeFmJPst/EDwO7SSHkiSMN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 16:52:09.4819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1e37d2-956a-4aa0-fe26-08df1fdc555e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108

Hello Mario,

On 9/22/2026 12:32 AM, Mario Limonciello wrote:
> @@ -385,12 +388,27 @@ static int amd_pstate_ut_epp(u32 index)
>  		strreplace(buf, '\n', '\0');
>  		/*
>  		 * "dynamic" mode reports the EPP as "dynamic(profile:X)"
> -		 * Trim at "(" and just compare tie the epp string.
> +		 * Trim at "(" and just keep the preference name.
>  		 */
>  		strreplace(buf, '(', '\0');
>  
> -		if (strcmp(buf, epp_strings[i])) {
> -			pr_err("String EPP value mismatch: %s != %s\n", buf, epp_strings[i]);
> +		/*
> +		 * The preference read back may legitimately differ from the one
> +		 * written: some platforms (e.g. Zen6) program the same raw EPP
> +		 * value for more than one named preference, so show() reports the
> +		 * first name that matches that value. Rather than compare the
> +		 * strings, re-write whatever name was reported and confirm it
> +		 * programs the same raw EPP value. This verifies the show()/store()
> +		 * mapping stays consistent while tolerating such aliasing.
> +		 */
> +		ret = store_energy_performance_preference(policy, buf, strlen(buf));
> +		if (ret < 0)
> +			goto out;
> +		got_epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
> +
> +		if (want_epp != got_epp) {


So this feels a bit hacky since it may be possible an epp
may be programmed incorrectly in hardware and as a result
it aliases with a different string.

Can we use amd_pstate_cpu_epp_values() as a source of truth
to double verify?

Something like below:

  (Only build tested on bleeding-edge with this patch reverted)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index be10ab90b820..506d7bb2e660 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -304,12 +304,12 @@ static int amd_pstate_set_mode(enum amd_pstate_mode mode)
 
 static int amd_pstate_ut_epp(u32 index)
 {
-	static const char * const epp_strings[] = {
-		"dynamic",
-		"power",
-		"balance_power",
-		"balance_performance",
-		"performance",
+	enum energy_perf_value_index epp_modes[] = {
+		EPP_INDEX_DYNAMIC,
+		EPP_INDEX_POWERSAVE,
+		EPP_INDEX_BALANCE_POWERSAVE,
+		EPP_INDEX_BALANCE_PERFORMANCE,
+		EPP_INDEX_PERFORMANCE,
 	};
 	char *buf __free(cleanup_page) = NULL;
 	struct cpufreq_policy *policy = NULL;
@@ -378,9 +378,9 @@ static int amd_pstate_ut_epp(u32 index)
 		}
 	}
 
-	for (i = 0; i < ARRAY_SIZE(epp_strings); i++) {
+	for (i = 0; i < ARRAY_SIZE(epp_modes); i++) {
 		memset(buf, 0, PAGE_SIZE);
-		snprintf(buf, PAGE_SIZE, "%s", epp_strings[i]);
+		snprintf(buf, PAGE_SIZE, "%s", energy_perf_strings[epp_modes[i]]);
 		ret = store_energy_performance_preference(policy, buf, strlen(buf));
 		if (ret < 0)
 			goto out;
@@ -396,8 +396,24 @@ static int amd_pstate_ut_epp(u32 index)
 		 */
 		strreplace(buf, '(', '\0');
 
-		if (strcmp(buf, epp_strings[i])) {
-			pr_err("String EPP value mismatch: %s != %s\n", buf, epp_strings[i]);
+		if (strcmp(buf, energy_perf_strings[epp_modes[i]])) {
+			u8 epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
+
+			/*
+			 * The preference read back may legitimately differ from the one
+			 * written: some platforms (e.g. Zen6) program the same raw EPP
+			 * value for more than one named preference, so show() reports the
+			 * first name that matches that value.
+			 *
+			 * If strings mismatch, confirm the CPU is programmed with the correct
+			 * EPP value for the mode. This verifies hardware programming while
+			 * tolerating such aliasing in driver.
+			 */
+			if (epp == amd_pstate_cpu_epp_values(cpudata->cpu_type)[epp_modes[i]])
+				continue;
+
+			pr_err("String EPP value mismatch: %s != %s\n",
+			       buf, energy_perf_strings[epp_modes[i]]);
 			ret = -EINVAL;
 			goto out;
 		}
@@ -413,11 +429,12 @@ static int amd_pstate_ut_epp(u32 index)
 		 * restore it here before dropping policy reference.
 		 */
 		if (orig_dynamic_epp) {
+			const char * const dynamic_string = energy_perf_strings[epp_modes[0]];
 			int ret2;
 
 			ret2 = store_energy_performance_preference(policy,
-								  epp_strings[0],
-								  strlen(epp_strings[0]));
+								  dynamic_string,
+								  strlen(dynamic_string));
 			if (!ret && (ret2 < 0))
 				ret = ret2;
 		}
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f27676e8e9ef..89f911d378ae 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -44,7 +44,6 @@
 #include <acpi/cppc_acpi.h>
 
 #include <asm/msr.h>
-#include <asm/processor.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_device_id.h>
 
@@ -89,46 +88,6 @@ static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool amd_pstate_prefcore = true;
 static struct quirk_entry *quirks;
 
-/*
- * AMD Energy Preference Performance (EPP)
- * The EPP is used in the CCLK DPM controller to drive
- * the frequency that a core is going to operate during
- * short periods of activity. EPP values will be utilized for
- * different OS profiles (balanced, performance, power savings)
- * display strings corresponding to EPP index in the
- * energy_perf_strings[]
- *	index		String
- *-------------------------------------
- *	0		default
- *	1		performance
- *	2		balance_performance
- *	3		balance_power
- *	4		power
- *	5		custom (for raw EPP values)
- *	6		dynamic (platform profile driven selection)
- */
-enum energy_perf_value_index {
-	EPP_INDEX_DEFAULT = 0,
-	EPP_INDEX_PERFORMANCE,
-	EPP_INDEX_BALANCE_PERFORMANCE,
-	EPP_INDEX_BALANCE_POWERSAVE,
-	EPP_INDEX_POWERSAVE,
-	EPP_INDEX_CUSTOM,
-	EPP_INDEX_DYNAMIC,
-	EPP_INDEX_MAX,
-};
-
-static const char * const energy_perf_strings[] = {
-	[EPP_INDEX_DEFAULT] = "default",
-	[EPP_INDEX_PERFORMANCE] = "performance",
-	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
-	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
-	[EPP_INDEX_POWERSAVE] = "power",
-	[EPP_INDEX_CUSTOM] = "custom",
-	[EPP_INDEX_DYNAMIC] = "dynamic",
-};
-static_assert(ARRAY_SIZE(energy_perf_strings) == EPP_INDEX_MAX);
-
 /*
  * The numeric EPP value programmed for each named preference. First dimension
  * is CPU type (TOPO_CPU_TYPE_ANY for non-hybrid, TOPO_CPU_TYPE_PERFORMANCE/
@@ -159,7 +118,7 @@ static_assert(ARRAY_SIZE(epp_values) == TOPO_CPU_TYPE_LOW_POWER + 1,
  * Non-hybrid systems use TOPO_CPU_TYPE_ANY; hybrid systems use the CPU's
  * actual type (PERFORMANCE/EFFICIENCY/LOW_POWER).
  */
-static inline u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type)
+u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type)
 {
 	switch (cpu_type) {
 	case TOPO_CPU_TYPE_PERFORMANCE:
@@ -170,6 +129,7 @@ static inline u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type)
 		return epp_values[TOPO_CPU_TYPE_ANY];
 	}
 }
+EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_cpu_epp_values);
 
 /**
  * struct amd_pstate_epp_values - EPP values for the four named preferences
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index c7189d177b81..422188c639b1 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -11,6 +11,8 @@
 #include <linux/pm_qos.h>
 #include <linux/platform_profile.h>
 
+#include <asm/processor.h>
+
 #if IS_MODULE(CONFIG_X86_AMD_PSTATE_UT)
 #define EXPORT_SYMBOL_FOR_PSTATE_UT(symbol) \
 	EXPORT_SYMBOL_FOR_MODULES(symbol, "amd-pstate-ut")
@@ -162,6 +164,48 @@ enum amd_pstate_mode {
 	AMD_PSTATE_MAX,
 };
 
+/*
+ * AMD Energy Preference Performance (EPP)
+ * The EPP is used in the CCLK DPM controller to drive
+ * the frequency that a core is going to operate during
+ * short periods of activity. EPP values will be utilized for
+ * different OS profiles (balanced, performance, power savings)
+ * display strings corresponding to EPP index in the
+ * energy_perf_strings[]
+ *	index		String
+ *-------------------------------------
+ *	0		default
+ *	1		performance
+ *	2		balance_performance
+ *	3		balance_power
+ *	4		power
+ *	5		custom (for raw EPP values)
+ *	6		dynamic (platform profile driven selection)
+ */
+enum energy_perf_value_index {
+	EPP_INDEX_DEFAULT = 0,
+	EPP_INDEX_PERFORMANCE,
+	EPP_INDEX_BALANCE_PERFORMANCE,
+	EPP_INDEX_BALANCE_POWERSAVE,
+	EPP_INDEX_POWERSAVE,
+	EPP_INDEX_CUSTOM,
+	EPP_INDEX_DYNAMIC,
+	EPP_INDEX_MAX,
+};
+
+static const char * const energy_perf_strings[] = {
+	[EPP_INDEX_DEFAULT] = "default",
+	[EPP_INDEX_PERFORMANCE] = "performance",
+	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
+	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
+	[EPP_INDEX_POWERSAVE] = "power",
+	[EPP_INDEX_CUSTOM] = "custom",
+	[EPP_INDEX_DYNAMIC] = "dynamic",
+};
+static_assert(ARRAY_SIZE(energy_perf_strings) == EPP_INDEX_MAX);
+
+u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type);
+
 static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_freq, unsigned int freq_val)
 {
 	u32 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, nominal_freq);
---

Thoughts?

> +			pr_err("EPP mapping inconsistent: %s programmed %u but %s programmed %u\n",
> +			       epp_strings[i], want_epp, buf, got_epp);
>  			ret = -EINVAL;
>  			goto out;
>  		}

-- 
Thanks and Regards,
Prateek

