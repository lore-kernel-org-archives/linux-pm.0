Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013063.outbound.protection.outlook.com [40.93.196.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC394AC156;
	Mon, 12 Oct 2026 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838580; cv=fail; b=o1nnkftPkFk2+FN6TMJn8Gej+tFHgL0q1UwvNmbnL2JDgIcnispYLS8u+a+QchfpYygmGd8zMJglJuoeweShFIam85Qfq8k2MwuXk9oFEBvJdqnpZsF67XWKzTneWIWu1Yl048pTh3PJfJm7eAJgEy52xp7m5LQ9F9Ibo4Mb5g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838580; c=relaxed/simple;
	bh=a6GksICdd9ya6se0/sGzLbz6OjpZyeewQSUliW2mlLE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=en6hthp6P+XcCuUrgQ2q+LaHLe9cej++th1OrQjaP1HXh3yoeBDEtTLW2EUyiKuWuiMAQfEYh1JMYSPRNdM7JSMELs84JcWOXw9GDxdrbtvjG+DXtxYdu7P1rbFKAoWR0NQbz8/lVRHLUBDgq7D5RLbOTunbSTfGJAb1H06nHKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sWzAC8T6; arc=fail smtp.client-ip=40.93.196.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sWzAC8T6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbzT/+0cIASFECq7S/ApWhOVKsbOD1FmRs106nMP2RH2txpE5rsEuB1ZD2iGYgwGZgtOKVGBPdFvbZ6dhYuUcLV7FY5qOvt1mL4QdSlKSHDfzwMDoY1B0MrSKSQistTvI2zmA5BruxpPx7JLahhwI63T2mMFHgJuSPVgto+Rzm9Aeain/0xDbvuAR+DfuQ0amhKwcF5EhqWk6kj6aJE3hSgxdZipN5ibP2CWb2a6wcJhSAhskJ2suPUxP+3vc5PqwTJh0l0/k8u31MiHUfjCJMAqpC+G8cRHYAsho3bsoM6+wA+KXlIvqAZ6aOqqnov/G8G+wpvyur6lSRaKH3LbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d92RjNdVXzXesW9GGAsLmiG/V2fm0PhRAzdHtHK/MzU=;
 b=Y365Lh/x4qVvESSHzGQOXdq8Q6KfA+VkF27oJvbrlWEeCC+WbgFlhF3SmyboxSZ9+ffRrIYuuivOWg5TzSoSpLnYj6o+KenUydMa0xJ6fcSnXTPAwfSQYO/1GA/sWwFUi6w4dG1kcFg4zE07iku3vQ8CC74G+WrA9lcPRAWmjMY2W5tcnqrIo2yl8DZLIF9xFUli8OPGOzO09Vlhm/46EIXxAN9/ECfZGBx03XBm5DF7lXZ9hzZ74WgDLJBLm3dfJDIClJ77MZtGz9d07brsFdGUOfykuNSYmGZbnzD015YwUx9uUJAKeB4ssIA5ZPNoHi5+SznvBhLswLL0Pa5k9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d92RjNdVXzXesW9GGAsLmiG/V2fm0PhRAzdHtHK/MzU=;
 b=sWzAC8T6gytks/inhRUHIFKIaKaigC0THztBqjAsT3wd0AiOokerHJrlbz5QsU1iTsICBxXyXkP7mTM/2D66SKUinSJ0oRA3YEBpQFMO25Z5i1rJgvAyiB9N0duOhW9tcgLHJ+XAl378V6knuG66ztEHuRS22mVLJWIuiQJk5V0=
Received: from SJ0PR03CA0379.namprd03.prod.outlook.com (2603:10b6:a03:3a1::24)
 by DSWPR12MB999151.namprd12.prod.outlook.com (2603:10b6:8:36b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 20:56:09 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::85) by SJ0PR03CA0379.outlook.office365.com
 (2603:10b6:a03:3a1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 20:56:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 20:56:09 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 12 Oct 2026 15:56:02 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH] cpufreq: amd-pstate: Preserve names for aliased EPP values
Date: Mon, 12 Oct 2026 15:55:59 -0500
Message-ID: <20261012205559.3421297-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|DSWPR12MB999151:EE_
X-MS-Office365-Filtering-Correlation-Id: 683020be-246c-4beb-3f63-08df28a33dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|6133799003|10067099003|18002099003|11063799006|261009223027099003|261009221227099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jOBZMtibRkS7JhAidWkKpK/OZUQTRjk51KzAC3A9Ln8Se6s4YQQtulI2ctj8pRlO/+qQkq7Buatq2Y4Yym6Ae5Zmf51cVI2DdpPOotQaG5x5/aVLK8P0Y9Coj1poHu2WB2j6zR4WLthYN7VOqQEzBeWKS6Ir+s592fdOpGFFoeRbDyfhn0dMl/fuq2XxeMjGzuiLWOUBWxoEEFpsT7WZPk89Vv7Hp6T9mwuCYRG9WvYMTIUyIV+r7DCCZMff01CVvu+/75Jvzu6o668UizN0afSIVS2vRn+pnY9SxH89AVcea7uEOxmwR6LaoW+qYG2Kvn/YtGdX6FPxdqJ0326D1gdb0XenPOR0NOsMz1aOOl9Wrl55BJOE6xq/dqCeGA5nhHc+drn/sNEWmGpjwvQIFfvQdS2QcdDZpMz5/1G84Q0LbPdqA5Tv/bm6yyDlQwvY6Qgf7xA00lIbyM3uiGk3v/XaSIPOJo+biSkk/FDN/agmpG7QZey1nmIRGgTrqi46j8W/Opos6/Oomxttg5UdG/5/alp2/+dIgzTpf+qb5vbKXt4FdoiPG+pPJufpe4VxUi69AlRTWSmpPqQrR1FLaj9KKl6n38LatqRe2g6tL/sK2oBLIZIKDAQMaVq1MMhXcFQeGNBZDCPuJefyXpaOznEhbGu+UKWYfActkrExxI8ncxAR7QI/8upOhnkUNynRA1OvYWX0M+CqH0ruw+TIRg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(6133799003)(10067099003)(18002099003)(11063799006)(261009223027099003)(261009221227099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2AzEDKc+2J7SqyxiS6Fv/Jxqnmi8HF2n1nZGCY2hty09nxl6R3VUBfwofuDtKjESD34L/s+quP7p4rVj0wajoAqBmjH+9IVQon4Sg/LfE8/Z0x2/F+1w2kqPMa3HBS4hm2bfdZriXQXa6gvIgdEAxNz8FRrLKwwnz0GgibNWXKGDYEbqeqz6rm4A5xFcnlprIkRcuu2mBRKw6A4ET3es+eRIM3Ah2wA0unCzFkFYtCGPOacOzVkYRET/7j24Xiu8kSq/qzfATAPQm3BS4tl72Wbe3yQ/0tLDOIqQV795CzbkiJUlCLR5/dvzEWNl2WE23VUq1Xve8NaoqLBpAIhR5R17pH+55EFTXojet8oklyNg9g8+SsrHjT2kXzUfNbr1HBYDlNZwueLYmIR5JIVEd2qzdLdbhka+Gq1Um0pBbQD69snd4GFrJJdSO7IfGK1q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 20:56:09.0494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 683020be-246c-4beb-3f63-08df28a33dd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999151

Zen6 low-power cores use the same numeric EPP value for the
balance_performance, balance_power, and power preferences. The show
callback currently scans the numeric values and returns the first matching
name, so writing balance_power or power reads back as
balance_performance.

Cache the index of the last successfully written static named preference.
Return that name while the cached numeric EPP still agrees, retaining the
numeric lookup as a fallback for boot, firmware, default, and dynamic
states.

Make the unit test require exact string round-tripping again.

Fixes: 52763c00945a ("cpufreq: amd-pstate: Update Zen6 client EPP tuning values")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 17 +----------------
 drivers/cpufreq/amd-pstate.c    | 20 ++++++++++++++++----
 drivers/cpufreq/amd-pstate.h    |  4 ++--
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 506d7bb2e6609..21313b724945d 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -392,26 +392,11 @@ static int amd_pstate_ut_epp(u32 index)
 		strreplace(buf, '\n', '\0');
 		/*
 		 * "dynamic" mode reports the EPP as "dynamic(profile:X)"
-		 * Trim at "(" and just compare tie the epp string.
+		 * Trim at "(" and just compare the EPP string.
 		 */
 		strreplace(buf, '(', '\0');
 
 		if (strcmp(buf, energy_perf_strings[epp_modes[i]])) {
-			u8 epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
-
-			/*
-			 * The preference read back may legitimately differ from the one
-			 * written: some platforms (e.g. Zen6) program the same raw EPP
-			 * value for more than one named preference, so show() reports the
-			 * first name that matches that value.
-			 *
-			 * If strings mismatch, confirm the CPU is programmed with the correct
-			 * EPP value for the mode. This verifies hardware programming while
-			 * tolerating such aliasing in driver.
-			 */
-			if (epp == amd_pstate_cpu_epp_values(cpudata->cpu_type)[epp_modes[i]])
-				continue;
-
 			pr_err("String EPP value mismatch: %s != %s\n",
 			       buf, energy_perf_strings[epp_modes[i]]);
 			ret = -EINVAL;
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4bedfbfc18b66..318365585b4e0 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -118,7 +118,7 @@ static_assert(ARRAY_SIZE(epp_values) == TOPO_CPU_TYPE_LOW_POWER + 1,
  * Non-hybrid systems use TOPO_CPU_TYPE_ANY; hybrid systems use the CPU's
  * actual type (PERFORMANCE/EFFICIENCY/LOW_POWER).
  */
-u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type)
+static inline u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type)
 {
 	switch (cpu_type) {
 	case TOPO_CPU_TYPE_PERFORMANCE:
@@ -129,7 +129,6 @@ u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type)
 		return epp_values[TOPO_CPU_TYPE_ANY];
 	}
 }
-EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_cpu_epp_values);
 
 /**
  * struct amd_pstate_epp_values - EPP values for the four named preferences
@@ -1474,6 +1473,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	u8 *values = amd_pstate_cpu_epp_values(cpudata->cpu_type);
+	u8 epp_index = EPP_INDEX_MAX;
 	ssize_t ret;
 	bool raw_epp = false;
 	u8 epp;
@@ -1507,10 +1507,12 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 			return count;
 		}
 
-		if (ret)
+		if (ret) {
 			epp = values[ret];
-		else
+			epp_index = ret;
+		} else {
 			epp = cpudata->epp_default_dc;
+		}
 	}
 
 	if (epp > 0 && epp != values[EPP_INDEX_PERFORMANCE] &&
@@ -1531,6 +1533,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 		return ret;
 
 	cpudata->raw_epp = raw_epp;
+	cpudata->epp_index = epp_index;
 
 	return count;
 }
@@ -1548,6 +1551,14 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 	if (!cpudata->dynamic_epp && cpudata->raw_epp)
 		return sysfs_emit(buf, "%u\n", epp);
 
+	/* Several named preferences may share the same numeric EPP value. */
+	if (!cpudata->dynamic_epp &&
+	    cpudata->epp_index >= EPP_INDEX_PERFORMANCE &&
+	    cpudata->epp_index <= EPP_INDEX_POWERSAVE &&
+	    epp == values[cpudata->epp_index])
+		return sysfs_emit(buf, "%s\n",
+				  energy_perf_strings[cpudata->epp_index]);
+
 	/*
 	 * Map the cached EPP value back to a named preference. Skip the
 	 * "default" slot (index 0) so an EPP of 0 reports as "performance".
@@ -1980,6 +1991,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	cpudata->cpu = policy->cpu;
 	cpudata->cpu_type = cpu_data(policy->cpu).topo.cpu_type;
+	cpudata->epp_index = EPP_INDEX_MAX;
 
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 422188c639b1e..e42ea811d581e 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -101,6 +101,7 @@ struct amd_aperf_mperf {
  * @dynamic_epp: Whether dynamic EPP is enabled
  * @raw_epp: Whether the last EPP write was a raw numeric value rather than a
  *	     named preference
+ * @epp_index: Index of the last static named EPP preference
  * @power_nb: Notifier block for power events
  * @current_profile: Currently selected platform profile option
  * @ppdev: Device registered with the platform profile handler
@@ -142,6 +143,7 @@ struct amd_cpudata {
 	u8	epp_default_dc;
 	bool	dynamic_epp;
 	bool	raw_epp;
+	u8	epp_index;
 	struct notifier_block power_nb;
 
 	/* platform profile */
@@ -204,8 +206,6 @@ static const char * const energy_perf_strings[] = {
 };
 static_assert(ARRAY_SIZE(energy_perf_strings) == EPP_INDEX_MAX);
 
-u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type);
-
 static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_freq, unsigned int freq_val)
 {
 	u32 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, nominal_freq);

base-commit: 19c2ab5ae8aa9fe92c396a089f67baca85b5f117
-- 
2.43.0

