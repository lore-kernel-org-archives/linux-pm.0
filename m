Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013006.outbound.protection.outlook.com [40.93.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D3432AAA0;
	Thu, 26 Mar 2026 19:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774553948; cv=fail; b=h73JJTLhCLDNOJ7QSwKCNLg07H3R42gqebVWEL2/iy/wu15J2HTmc8Mw5tgV6bfNeULRG2Z37OE+Uz/AdCBGxRTmNt9hmrBIsegAGAnCfqK/5R6/4oZL4vkmj7XdzfQ/vN+JjgJKaWl0IEFiGNi0wONJ0XxtGiaTyixsagBqHpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774553948; c=relaxed/simple;
	bh=BhYkMck4nm9DDexKf/kzN81BlFaH1k69T3KHKqogvPs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ts90BdC1h/K9bC3WH6iIHXwh9/ELW4lasXtu/FPnpR3EYhhwH0Z/UJX/7/fO0QLVyESoUh+oygJ2n5C9mGukvkGWsDliHtgM8RfC2J6OSVRj3gpgYZZCX0wFPpVwxmEBpI2S1rpKsi2vyvSQ6RHfu5ht6YYzb9TKBLnRNqTIc3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gbwzReH3; arc=fail smtp.client-ip=40.93.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gbwzReH3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCduKzaJOyhjtk7IX0N5f2RKQ0IRKhwFfVKZ/vGoxNaeJx2t0/AGw9CFpI05fBgT2fm58kcgrbnMdDMgTEex1u+373jI2TPUdzaXtBbvoT1U7D0DcwBBK8byyhQ9ATmyXxCYjjlUqkRP3RbX5gX7Dg6YS6msJFOX9hKDIPWGha45JCEhAaabzmR+iDGQOwLvPILdg9VgYq9+T9e6q9dKmZ3fXlCWwSf3PTrvElqhtRzbbDLHe5IWe16wM8cLkntyoDIrcXSa2ASfw2rlPNj2na5jcf1yRs44oSmjmUHgP478qpYAaplI0Ir2h/Z8gnS6mzXqpF6HZHU9nfOhcsihBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAh5Qi73PlJYt8MEbpCRWdbp6GIz7QDmLlX2bsQYWhw=;
 b=r0xgPK5ZHlbI9a3gpAKkJhnAnUN2FuvzhwWqFftBnwl75kCFggzP6HF4giPSZABl0N6CROatfeJUTXb5ucpQLiwym0yfi4cOrDo5Db6UrnlbAuvMGHKnO/tVMjMwB08JKmYNSbCf2q0KhsXFMnqnxm6kIByTGqxh6NXHmbH3xl74m4hvjOxsTuSCQHBNZpFDuMErZI2fQRkjFkulKh/W50+0B+h9hRf2qvZjJmilt8UxbQEm3Md0ZTwohzxq4qLEomcCz+alaCWHvBiTW18go6lzWjopcFvMaCFHGqstjL+th2OpGBWlpKPOHjqX9+urznLeXQIn/sEFSKYuWEXGnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAh5Qi73PlJYt8MEbpCRWdbp6GIz7QDmLlX2bsQYWhw=;
 b=gbwzReH3dM68WgRhwadW+S4ZFCfeeDFVNzZh+PEXuXLd55NULnFEF//uU1JhVmhHT+VJTicRg0D3Kjn2Y36xSAY7NdNdODw1bZCOqmz5i+LBbPJ/qL7nV+TKNGttZR7iLuAGJ9xVny5mKp1FzkiTReZ3JTntiBwb0r7GFnDdAdg=
Received: from CH0PR03CA0415.namprd03.prod.outlook.com (2603:10b6:610:11b::26)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 19:39:03 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::75) by CH0PR03CA0415.outlook.office365.com
 (2603:10b6:610:11b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 19:39:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 19:39:03 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 26 Mar 2026 14:39:03 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, "Mario Limonciello (AMD)"
	<superm1@kernel.org>
Subject: [PATCH v3] cpufreq/amd-pstate: Cache the max frequency in cpudata
Date: Thu, 26 Mar 2026 14:36:20 -0500
Message-ID: <20260326193620.649441-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: 9139ebc0-2b2b-479c-a0f7-08de8b6f562c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ut4FTNSK8+8omvdkI6y08FB7gVxlNpYqEEMCdEZ+Vs3RMi8hSRnw/Q597KO10zGfmpZDIW8QgNvS4+CyE43MuaopGj8IbWT9A0xtVnakCUOz7sJl3mMYvumlDhzfzwHr+7lTeDgNSXv56pPuJ2PggeTYE9tOZ/FyrEdsO9d1ILK2jP70hlqjniqVjHkt1d8RtSUEPk+mB78rOTP7SFJy57PiEpJVXKZnPR6wTqvi9etzAqo4OD9f1blqwlifaHzgZCzvisp/cZN5OOwo2a8j2eXOjlZEuMNB4HJRd4XYNFBIv+p8PJpBTOvl69rUMMNBQ1euGqS1LP5l0g6cvs6D6yYbC0YsVhU4anA9/tkkFZYAzeZ+Bz8DG6p++AR+o51hHhTc1sabLrCttuZSlN9uC0PXgSI8JTicfKcdam2luJ3bG5e2zydrlMiccjP8JcdFDYz+DWNVjzPPpPY8FkhxiFEiEXC1fVMwVW8lwyh9MQ9q6xK1y7uroxXeY/qqePuECin/3CNeR+CShvHhVpUJjcnq9FgviOAI5lKoPAFtLgndlWYkDZ0VxxxQZysWWJTK/UeVxieTKi5Gl4Z3aZd3Uw5ipdh8KaM0XrHwiPJi9t65hjphMx5lfTVRgUCRnkPVlBj0GcnFUSEBwyRVBn8q3Zu0hKlUzKAl0KhFua6qv2PsSX5P4fBdehF97p6j5nj1aHYNcfV2JMNK+VEGT0PcMn79giz9OQyIL/G70bbp3WjcH+ziWm8xtQ7MVWbGCp3lhHZdNtivF9IlR9P5uJGpCg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WQKA8cJ19HnLw2bu+FxK0fekkXROgfcOgsx6TD/nA/MAykCMHobuPLOqdb4cjmnwG6ikIp8AFdjauyVL7gGIJmlmIYH7lzGHBa9PUrD8OnnMghnQCEZnET30+LCkEvU8slzXPWuR1NX0oLT6qBi95VvcMxRNq+t6COUssPObo8AWedQCs4bduDIBvl0tC7+MkNT4wnjO0+6UrrDguGkeoWQ3cUQwazCtc+lqamiHMiwmRVVI0lfTKDSQ0E85GWjqwLEtlVhrKFyks/NIP7sxDjZLVyjJt6k5UBpbsSG+iXncc25Vkr6F3GM/wZ8v8sBr8d9VVs5gi5Yv9fCxJQQQ4OU2djTioOqEKj56U0Vg3r+SZKSaoS7sLo5q20PKUujulU7BsLuTZi+QyJSCJ3I/PR1j07nb7MxHn1N9c++a6RpJD6bCoo92Zvr7S0FgEE5R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 19:39:03.6320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9139ebc0-2b2b-479c-a0f7-08de8b6f562c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

The value of maximum frequency is fixed and never changes. Doing
calculations every time based off of perf is unnecessary.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v3:
 * rebase on Gautham's CPPC perf priority series
 * add kdoc
---
 drivers/cpufreq/amd-pstate.c | 27 +++++++++------------------
 drivers/cpufreq/amd-pstate.h |  2 ++
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ed9fd4155a256..f207252eb5f5f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -826,15 +826,13 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	union perf_cached perf = READ_ONCE(cpudata->perf);
-	u32 nominal_freq, max_freq;
+	u32 nominal_freq;
 	int ret = 0;
 
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
-	max_freq = perf_to_freq(perf, cpudata->nominal_freq, perf.highest_perf);
 
 	if (on)
-		policy->cpuinfo.max_freq = max_freq;
+		policy->cpuinfo.max_freq = cpudata->max_freq;
 	else if (policy->cpuinfo.max_freq > nominal_freq)
 		policy->cpuinfo.max_freq = nominal_freq;
 
@@ -1021,13 +1019,15 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
 
+	/* max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf */
 	max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
+	WRITE_ONCE(cpudata->max_freq, max_freq);
+
 	lowest_nonlinear_freq = perf_to_freq(perf, nominal_freq, perf.lowest_nonlinear_perf);
 	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
 
 	/**
 	 * Below values need to be initialized correctly, otherwise driver will fail to load
-	 * max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf
 	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
 	 * Check _CPC in ACPI table objects if any values are incorrect
 	 */
@@ -1090,9 +1090,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
 							      cpudata->nominal_freq,
 							      perf.lowest_perf);
-	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
-							      cpudata->nominal_freq,
-							      perf.highest_perf);
+	policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
 
 	policy->driver_data = cpudata;
 	ret = amd_pstate_cppc_enable(policy);
@@ -1167,14 +1165,9 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
 					char *buf)
 {
-	struct amd_cpudata *cpudata;
-	union perf_cached perf;
-
-	cpudata = policy->driver_data;
-	perf = READ_ONCE(cpudata->perf);
+	struct amd_cpudata *cpudata = policy->driver_data;
 
-	return sysfs_emit(buf, "%u\n",
-			  perf_to_freq(perf, cpudata->nominal_freq, perf.highest_perf));
+	return sysfs_emit(buf, "%u\n", cpudata->max_freq);
 }
 
 static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
@@ -1702,9 +1695,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
 							      cpudata->nominal_freq,
 							      perf.lowest_perf);
-	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
-							      cpudata->nominal_freq,
-							      perf.highest_perf);
+	policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
 	policy->driver_data = cpudata;
 
 	ret = amd_pstate_cppc_enable(policy);
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index faead0b19a8a4..32b8b26ce388f 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -73,6 +73,7 @@ struct amd_aperf_mperf {
  * @min_limit_freq: Cached value of policy->min (in khz)
  * @max_limit_freq: Cached value of policy->max (in khz)
  * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
+ * @max_freq: in ideal conditions the maximum frequency (in khz) possible frequency
  * @lowest_nonlinear_freq: the frequency (in khz) that mapped to lowest_nonlinear_perf
  * @floor_freq: Cached value of the user requested floor_freq
  * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
@@ -103,6 +104,7 @@ struct amd_cpudata {
 	u32	min_limit_freq;
 	u32	max_limit_freq;
 	u32	nominal_freq;
+	u32	max_freq;
 	u32	lowest_nonlinear_freq;
 	u32	floor_freq;
 
-- 
2.53.0

