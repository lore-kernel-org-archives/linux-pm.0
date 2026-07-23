Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095EE381E88;
	Thu, 23 Jul 2026 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784837657; cv=fail; b=kU0cWIabliLhnIkk97Wgdi9B/Y9cEnQ0c4PKPUwhWPO8HEhSw58i/p3LLx10kYKhhOcWX8AxVEYappeUubJRTl8wwxgv66uNFJkcWE12Oy4VKxyreFPLk76ijMCmxrFT/HMgyUbDjhsmvxaQCgaaf+7tXlnA6CaXHdGDrsLhQmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784837657; c=relaxed/simple;
	bh=DjzzB9NAr7gT49ImlVa3f8PPnTV6Yh/TPVmZGee6G/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmLN7+Ybim16u89hcxdjtPGzuGisOQrt7gWyPJPGSn4MOwJS2JMUfKDWlbsukneRE8ZCdZj+DfVYQ1O8lSKAn/5ioF1cqDdc2Vy3jlfZNPMSjjPuGRQjpVRa1r5CKcKUCZVr0wMq32j0smck/Md7izffeIBAs+KaPaZnEIYgKMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NJmnkhPq; arc=fail smtp.client-ip=52.101.48.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NJmnkhPq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmRy8LDSUWQC6m/L3lgkI+7wzlpB89ODYNpMVbb3cDkMUBD3ZT74YH7rnMkjbPOqcKUvzBqFXhmXYWH4o7V0G7gcQTbHwDoZihOFlmWFKTxEmbQ2hfmLSPpmJT/lwjey9ulSK6H6agqsx8+7bMmKfBIVDgl7BPf5I/ReCuULtyb9muqgOcKZ1lBpmUNV9WR3Gyg1v0CC7cHKd7j3P3/KMFUaF6Ou2U9/PE2c6+Bsv204OeAPhoa2XH9c+8R1eFWkI8XKVfiBnr265rJSZpBCY80T76ml5atqtEKMV1i+t0CrQoeIecrh/Rh++QZsI+AmCAZ8/EOPcxlNbkSarGw2bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9iLYb2nzSe3+DL2tO/skpivOZZXFmPztAItWOFB86A=;
 b=BP5hacMtTTpNLfUYzrr6wmdQqtVaW+wRRZAhJqXY+EaVv0QodN/FUEj94aifDHcmQ97QrWfABVTyCuoal5C1//fRPEqxrqhX29TkbyFsmzGDJmyZd2G7UpGdZbWB91iOjjb7wemac1aLYNKkS/9zXAqqfX/+qCrrSkGKmG2AmCpYs4d/DD97EoWxP0qBWiGPb6/fsOaT23tBskV7S/8/sZr3z0wN5+PPNTf98m+0+Rbe0OgKIDDGr5FNMyxI3PoxvSG3eEaxKLmJWMJ4gczogh9SfE7IoLghHmWO1dIEmYMFmvG6bUx2Y10qD4eNmThp88N9nyWP9LGhoYvI6qm8dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9iLYb2nzSe3+DL2tO/skpivOZZXFmPztAItWOFB86A=;
 b=NJmnkhPq4XIi0wyIs1s+vG60cUqCyEvX4Hgbb4byFVKUG3LuoA/mDPVDyEWZJX7n2B9ncQK/Ywb6KU3fn6Su9gNoqqZGEYXFdXUZTvVuU1j5iM+NGuCytd/G5svsXuW0/ulIqGYsCy/vnYTgRBvYHmdRcxUo753h+Xdr/mvOUQI=
Received: from SJ0PR13CA0180.namprd13.prod.outlook.com (2603:10b6:a03:2c7::35)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:14:06 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::41) by SJ0PR13CA0180.outlook.office365.com
 (2603:10b6:a03:2c7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.4 via Frontend Transport; Thu, 23
 Jul 2026 20:14:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:14:05 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:13:59 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/9] cpufreq/amd-pstate: Add dynamic EPP as an "energy_performance_preference" mode
Date: Thu, 23 Jul 2026 20:12:23 +0000
Message-ID: <20260723201228.22584-5-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723201228.22584-1-kprateek.nayak@amd.com>
References: <20260723201228.22584-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9f0ee3-ceb2-481a-baf0-08dee8f6f23a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|11063799006|22082099003|5023799004|10067099003|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	RnzQ4tRR63qksK5ta5ZWkuCEm8j0qKZ7l3AL3np7WO7Oa0EqwciPP7yLcHhy9r1r2uA50Afk56xwMKLb9k7CP/HuiFw/SmJWslNOVKfiiThqGddK9JED4Soc4ArWUQ04tTKsuncnnCCgx3DxfjQKsutxhjxC0lFY7SCkKGA/reHCNzL8it1IfrOaGak6lGWUniv8oX6BScNtvHRruPiny53Qt4tsr9XTktvz5LChLZvMvX2o5qSbJp6RWdxpJy5WU8oqotGatK9relCq0P1GdzbnrFsZuHQHYIytaSVWGwy5X8G2i+GIgPOREj+JAMBtDdJxl61nZebAXzJ6VzPkuhnxaoDROGECKdoPs1W9AHdYGGxzH8cgv4wKKrAIVO1nVaDBz1zPCo0TV0opwPdwTt6+Rocbc2eXP7QTpESDHLTyFioDu8tYDkKVSdA7wmmbmlyhOXgsp5AHaNfuU7BBR4dCtfqX6abXSTHbiOMrlrJJ61rznjxSiFzQBhkmSvJ8PA9K2A5XX5D6q1NfUaqqRoUvJpRGuDZWJ5TZZx272CNrDS13HB6RAefhOC4H6B895HCEJdTXalhUoEIhv7r04rlduroDpfu07juP5gOL1tmcLH5O2JzTPT/vZT6KZEpiJMGgP13+dG3RZabgxfQKyAVt8y7itMDNcyMYfb9OJlQhBChT93MYJvq74k1x/orVta2hwY/PEzWwoQJ8ih9kwA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(11063799006)(22082099003)(5023799004)(10067099003)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nfSKvGhWwUwi6kPNT7FgqNvBEuS1GIsLsUYXYvLMs//u0uzfYWQXi3EENzxqAZYO5nKv8s6ffsvlzMW3dix5BJSBB14WHdJwI26QRUoyVyPpCfLurcyWNKblUmyIWYZvujmO+u0jUd68MFosXEWX78pCavfaJDO59zXY9NcfHmYHRxgxo41Yq1KccmDB2hWamzRjxi6s6VyMg9I/HQY9xuqKUuv72WAYXv0jNwE0uKY2MS171t20F+UYGxqXq9ltZGhOvsmDa5pM9ZiJPN+P1ZdVUmqDorKWNS2m2ZEmTScrnpZ44JgfWXuCLy24jlIwCfeXxMpXjcUSxwiA0c5Lb6BXKCRniAmu9DabDZguFDfjI6M2gZToS9Lhh6WsHhxRzQkD6laX0a0AKukQKabkBWv8Z1Pw5RNpj5hlEIxKJUtIcsdOD4j5n48+QgCL7pl4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:14:05.5449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9f0ee3-ceb2-481a-baf0-08dee8f6f23a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365

Conver the global "dynamic_epp" toggle into a per-CPU
"energy_performance_preference" mode "dynamic" that allows toggling the
functionality of "dynamic_epp" at a per-CPU level.

Instead of being a system-wide toggle, users can opt into the
functionality of dynamic EPP on a per-CPU basis by switching to the
powersave governor and selecting the "dynamic" mode from the available
performance preferences.

Unlike the previous implementation that had to check for driver mode
before toggling on the functionality, block writes to certain sysfs
files, potentially disallow policy change, etc. the per-CPU toggle fits
naturally into the intended design and provides more granular control to
the user.

The dynamic_epp file is now redundant as the option to toggle it on is
controlled via energy_performance_preference, and the dynamic_epp file
will be removed in the subsequent commit.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog rfc v1..v2:

o Removed "dynamic_epp" global control related changes since it will be
  removed in the subsequent commit.
---
 drivers/cpufreq/amd-pstate.c | 57 +++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 7d1feed0e11e..fc90e4108c22 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -106,6 +106,7 @@ static struct quirk_entry *quirks;
  *	3		balance_power
  *	4		power
  *	5		custom (for raw EPP values)
+ *	6		dynamic (platform profile driven selection)
  */
 enum energy_perf_value_index {
 	EPP_INDEX_DEFAULT = 0,
@@ -114,6 +115,7 @@ enum energy_perf_value_index {
 	EPP_INDEX_BALANCE_POWERSAVE,
 	EPP_INDEX_POWERSAVE,
 	EPP_INDEX_CUSTOM,
+	EPP_INDEX_DYNAMIC,
 	EPP_INDEX_MAX,
 };
 
@@ -124,6 +126,7 @@ static const char * const energy_perf_strings[] = {
 	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
 	[EPP_INDEX_POWERSAVE] = "power",
 	[EPP_INDEX_CUSTOM] = "custom",
+	[EPP_INDEX_DYNAMIC] = "dynamic",
 };
 static_assert(ARRAY_SIZE(energy_perf_strings) == EPP_INDEX_MAX);
 
@@ -134,7 +137,7 @@ static unsigned int epp_values[] = {
 	[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_BALANCE_POWERSAVE,
 	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
 };
-static_assert(ARRAY_SIZE(epp_values) == EPP_INDEX_MAX - 1);
+static_assert(ARRAY_SIZE(epp_values) == EPP_INDEX_MAX - 2);
 
 typedef int (*cppc_mode_transition_fn)(int);
 
@@ -1274,6 +1277,7 @@ EXPORT_SYMBOL_GPL(amd_pstate_clear_dynamic_epp);
 static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
+	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
 	int ret;
 	u8 epp;
 
@@ -1314,6 +1318,9 @@ static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
 cleanup:
 	amd_pstate_clear_dynamic_epp(policy);
 
+	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, prev);
+	/* Restore previous EPP if toggling Dynamic EPP failed. */
+	amd_pstate_set_epp(policy, epp);
 	return ret;
 }
 
@@ -1384,7 +1391,7 @@ static ssize_t show_amd_pstate_hw_prefcore(struct cpufreq_policy *policy,
 static ssize_t show_energy_performance_available_preferences(
 				struct cpufreq_policy *policy, char *buf)
 {
-	int offset = 0, i;
+	int i, offset = 0;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
@@ -1407,11 +1414,6 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 	bool raw_epp = false;
 	u8 epp;
 
-	if (cpudata->dynamic_epp) {
-		pr_debug("EPP cannot be set when dynamic EPP is enabled\n");
-		return -EBUSY;
-	}
-
 	/*
 	 * if the value matches a number, use that, otherwise see if
 	 * matches an index in the energy_perf_strings array
@@ -1422,6 +1424,23 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 		ret = sysfs_match_string(energy_perf_strings, buf);
 		if (ret < 0 || ret == EPP_INDEX_CUSTOM)
 			return -EINVAL;
+
+		if (ret == EPP_INDEX_DYNAMIC) {
+			/*
+			 * Dynamic EPP was already enabled for this CPU.
+			 * Nothing to do.
+			 */
+			if (cpudata->dynamic_epp)
+				return count;
+
+			cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
+			ret = amd_pstate_set_dynamic_epp(policy);
+			if (ret)
+				return ret;
+
+			return count;
+		}
+
 		if (ret)
 			epp = epp_values[ret];
 		else
@@ -1433,6 +1452,13 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 		return -EBUSY;
 	}
 
+	/*
+	 * Dynamic EPP was enabled previously!
+	 * Switch back to the static EPP mode.
+	 */
+	if (cpudata->dynamic_epp)
+		amd_pstate_clear_dynamic_epp(policy);
+
 	ret = amd_pstate_set_epp(policy, epp);
 	if (ret)
 		return ret;
@@ -1450,7 +1476,7 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 
 	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 
-	if (cpudata->raw_epp)
+	if (!cpudata->dynamic_epp && cpudata->raw_epp)
 		return sysfs_emit(buf, "%u\n", epp);
 
 	switch (epp) {
@@ -1470,6 +1496,9 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 		return -EINVAL;
 	}
 
+	if (cpudata->dynamic_epp)
+		return sysfs_emit(buf, "dynamic(profile:%s)\n", energy_perf_strings[preference]);
+
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
 }
 EXPORT_SYMBOL_GPL(show_energy_performance_preference);
@@ -2030,6 +2059,18 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
 
+	/* Must be a switch between PERFORMANCE and POWERSAVE */
+	if (cpudata->policy != policy->policy) {
+		/*
+		 * Disable dynamic_epp when switching
+		 * out of CPUFREQ_POLICY_POWERSAVE.
+		 */
+		if (cpudata->dynamic_epp) {
+			WARN_ON_ONCE(cpudata->policy != CPUFREQ_POLICY_POWERSAVE);
+			amd_pstate_clear_dynamic_epp(policy);
+		}
+	}
+
 	cpudata->policy = policy->policy;
 
 	ret = amd_pstate_epp_update_limit(policy, true);
-- 
2.34.1

