Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2E43630BF;
	Wed, 11 Mar 2026 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237724; cv=fail; b=olG0Sfer+W1+/TNkWYZT+AWxhdlwLNXxaY1+Yv/qJdXoS7hj2nO42O6RO/JyxEN9cv5+g6qFBfwjbn41nYWERyLLL2wEV14aqOQw20wNlothyK60JKm1J2zELjoEeg8phy6K+jxI8BkYU8M/KOrex0o3KQmf9lcWqXbs3xKoSnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237724; c=relaxed/simple;
	bh=n1Tl38Sn6lxI0OmhSE5nm83xT1r+US2/yBIpGuqLFIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+L6WZejUmr67e/z+XJAH5d3CCpdnqBghKk6goOvI1NJCD2vKq/N7Jsx4giryLi1nk/k+JQeZVSp63TDcZx7sXX9eEDeUSQxnFibXPryVlM3/dMUPnJEhFtFcR0AeAcFl5kw+ZM95QV39cz8XQ/mILXDZBfkLjVxnWpdl4A4QUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Uq7xvWbO; arc=fail smtp.client-ip=40.93.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Uq7xvWbO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mra2fP7o/Vc3VCXquldfCrqVl0AU11M1C+drR2MTdz93DN2YZuxvYR+35hdEBrxHxu4+2TG7rQxLxNMu/zyjmYK0MMgtN32dUFlfc2pE3441VMxxSmG3XPRY+WsnQ7gnXxj2YfrcJPp/oGhC4m9k49KVkXoDZ5DIhvFfrjN+Q5aQ32WLKmui/M8OP8ZjyUYwTyq40VVnfRvYidN/BlDdn0gFD2Nq7GK8gKSnQvQqpn7a9SLaBZbK3+uBxg7bg5vmHTusFIak7UlnoioE6BkHvo1bGQp9yTn+S1TpB4yjmo5tEOBZB03sn4ZHcZuwKm/VW0WoLegT8UAPZF6ezObyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfZxwt5XGXotEdEgKtkjcXWUiYeMwfAWNtQCMY9WUWc=;
 b=NFU3Xy6BgdNPs2KnZse9dpYuNdoLdT4NJk0jeS0DpJiikD/3sgGwrYpVlkf1oa3HP4Y5ubsnzAyZi8FFnRTkZ2P/v819h3vfTGE0VIrbfgIoJl4XWjQYQaziJGbUH16R8CoFxm4LDoSRif1dQrXd2tToZYHJ+qs6/HSkMMMhfh0HgpybuqTi2yEZ8eulwWeohBeASjmbd3md5KSu+ortKoZRRVg7YlFehPK7K3TADYv/W9r+DuKtC6ck+Qt9exlT5u2NMjS4ao29rIR0vI0LMZGOWMsYMqXprvvlz0VyFU5pNsJoJgKr1g4spRxyj6Gy+PgBqxXLf32LZuJ/K3TxsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfZxwt5XGXotEdEgKtkjcXWUiYeMwfAWNtQCMY9WUWc=;
 b=Uq7xvWbOVmjUH9HD391EPwZFbx/2djhy4jYwjYjCwHDp9Rw2TKBGM3lI3ItdjKQDwG2zsSDVr7Ah8++CkdzbUWXUAgN/TOucqfi4lSmq7lZGY9t/IS5okPO2u7j8K8s74JYTpw392oghgK6fGxTx/5BJ3JA6fRxpb4bpwRna/rw=
Received: from SJ2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:a03:505::10)
 by IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 14:01:56 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::85) by SJ2PR07CA0004.outlook.office365.com
 (2603:10b6:a03:505::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 14:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 14:01:56 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 09:01:54 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH v2 6/9] amd-pstate: Add sysfs support for floor_freq and floor_count
Date: Wed, 11 Mar 2026 19:31:13 +0530
Message-ID: <20260311140116.19604-7-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311140116.19604-1-gautham.shenoy@amd.com>
References: <20260311140116.19604-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|IA1PR12MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 0abb3697-900f-4d0b-b563-08de7f76c1be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DixFlcteZ0jSB994bKmkscYNq/664PoNqZAffT2R7EIbidAoiRwMtAWe+jT78AR6y4NyLfVo1i/lW3vAAIWIgU3HoGnRlLNpLHpJUGkzLyawhSM/ZkexR3iZV4tUXCP5N0jgGuM2sP6VcWbAYuLZfiMd/gIXcbTfVUGlSqgHNzJjyl6o0DiBxpgOhEJXy53nRoI+FSnvpwW8tqTgjzumBvJeopAU9u3cUSQqnsHwG/YFHVEHnScxtLcDsLxUx5v8XoCmyPee1hz+i7bufw7fQoQL6MwzoAKiIP6SeZd+PJLGuVDifqB0j1bKkuN90djKvW7J246pPelUXhLdHvtgc9N4gHCXQ09hs6DMhJFyclXA1/WxwOzytlJO9Fy0UNES7WnitZeunhHu1y/8rOAFCTwhm6CbnO5SOm8h7sdK7sDYc5S4YsKyznOi2JOE44X9J3WWHrZdJGVZQ+917Bgmea/UWAUA98WugpIIFOHvqNwz8urAiNPAbzks50ss07PYjjIN+TrEAtoUWSqw+A6+f4T5QbneSBY26jTAKKCU5CNeqf50mrKXAKHOI23UU2l741iNlPdt/qsYWHlmhlAuNN9QBOXeux9q925A28O7dvmyUjMuiYXxyo1jkygfJ//8Hmi/FisP9Lcslzg4sH8hCaLFELAA7N06iBy6FIhB0eSRQbAf4OkYi9VGjiX+edfiUk1QMZTiXZ+UxtJmeHToyODqQcmDMIOYAWIGn4+NqjLzeP/KhLkU9Mwa0xrzVtg3AikLAy0QcflYyF5k3nEE0g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xzc8jGB2AYRKzcjzVfuZdpIKTUWT5/2D+oQZgimJZ+/A+LY5tRNcf4Ec8V/RalV/RqIS9z/fjdik7dztWMic144PlF9RI/EWtww9XK0Z5PHVW2yAIQtOZRsCLTrIAfNvf2ywYFxZDhe+/qGbdP/EafMTjJHFWKGQ0DezKdXmEfrWy00aUG2CebntRxKwbGFD8KBtiZbpm4urhSn1hA4JBJiNvs8PyRqGSFKejPYJaMz84+Pas2ZJANt7RbgceCRe2GLFNLCmvZP6gWzWwXm33T7BsZholPRVRSbMk5w57liFL4JkwiIg+1mfyIZKMsJV17y9zqF9NJ3Pk4nL4adavWlrR9QBxP+4fKW9wM7dE8V9SoaJguJo809go981mCTyqnQhdwciAo7FVpiS0HduSOwNZfys0w6dU5UFbMpecKsia2oLssBIpJUsn/Mg1Roc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 14:01:56.5827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abb3697-900f-4d0b-b563-08de7f76c1be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494

When Floor Performance feature is supported by the platform, expose
two sysfs files:

   * amd_pstate_floor_freq to allow userspace to request the floor
     frequency for each CPU.

   * amd_pstate_floor_count which advertises the number of distinct
     levels of floor frequencies supported on this platform.

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 50 ++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/amd-pstate.h |  2 ++
 2 files changed, 52 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3122ad5af6f47..54b650f3b4e78 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -383,6 +383,8 @@ static int amd_pstate_init_floor_perf(struct cpufreq_policy *policy)
 			return ret;
 	}
 
+	cpudata->floor_freq = perf_to_freq(cpudata->perf, cpudata->nominal_freq,
+					   floor_perf);
 	return 0;
 }
 
@@ -1284,6 +1286,44 @@ static ssize_t show_energy_performance_preference(
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
 }
 
+static ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy,
+					   const char *buf, size_t count)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	union perf_cached perf = READ_ONCE(cpudata->perf);
+	unsigned int freq;
+	u8 floor_perf;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &freq);
+	if (ret)
+		return ret;
+
+	floor_perf = freq_to_perf(perf, cpudata->nominal_freq, freq);
+	ret = amd_pstate_set_floor_perf(policy, floor_perf);
+
+	if (!ret)
+		cpudata->floor_freq = freq;
+
+	return ret ?: count;
+}
+
+static ssize_t show_amd_pstate_floor_freq(struct cpufreq_policy *policy, char *buf)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	return sysfs_emit(buf, "%u\n", cpudata->floor_freq);
+}
+
+
+static ssize_t show_amd_pstate_floor_count(struct cpufreq_policy *policy, char *buf)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	u8 count = cpudata->floor_perf_cnt;
+
+	return sysfs_emit(buf, "%u\n", count);
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
@@ -1292,6 +1332,8 @@ cpufreq_freq_attr_ro(amd_pstate_prefcore_ranking);
 cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
+cpufreq_freq_attr_rw(amd_pstate_floor_freq);
+cpufreq_freq_attr_ro(amd_pstate_floor_count);
 
 struct freq_attr_visibility {
 	struct freq_attr *attr;
@@ -1316,6 +1358,12 @@ static bool epp_visibility(void)
 	return cppc_state == AMD_PSTATE_ACTIVE;
 }
 
+/* Determines whether amd_pstate_floor_freq related attributes should be visible */
+static bool floor_freq_visibility(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO);
+}
+
 static struct freq_attr_visibility amd_pstate_attr_visibility[] = {
 	{&amd_pstate_max_freq, always_visible},
 	{&amd_pstate_lowest_nonlinear_freq, always_visible},
@@ -1324,6 +1372,8 @@ static struct freq_attr_visibility amd_pstate_attr_visibility[] = {
 	{&amd_pstate_hw_prefcore, prefcore_visibility},
 	{&energy_performance_preference, epp_visibility},
 	{&energy_performance_available_preferences, epp_visibility},
+	{&amd_pstate_floor_freq, floor_freq_visibility},
+	{&amd_pstate_floor_count, floor_freq_visibility},
 };
 
 static struct freq_attr **get_freq_attrs(void)
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 0c587ca200199..ab4caea39f0e8 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -72,6 +72,7 @@ struct amd_aperf_mperf {
  * @max_limit_freq: Cached value of policy->max (in khz)
  * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
  * @lowest_nonlinear_freq: the frequency (in khz) that mapped to lowest_nonlinear_perf
+ * @floor_freq: Cached value of the user requested floor_freq
  * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
  * @prev: Last Aperf/Mperf/tsc count value read from register
  * @freq: current cpu frequency value (in khz)
@@ -100,6 +101,7 @@ struct amd_cpudata {
 	u32	max_limit_freq;
 	u32	nominal_freq;
 	u32	lowest_nonlinear_freq;
+	u32	floor_freq;
 
 	struct amd_aperf_mperf cur;
 	struct amd_aperf_mperf prev;
-- 
2.34.1

