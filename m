Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010009.outbound.protection.outlook.com [40.93.198.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C94234753C;
	Thu, 12 Mar 2026 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773339915; cv=fail; b=upWE4jn+/wbhWhH4TlBTVtn9bxlWfsCUt8fPUi2sPgTOZ00wIQjob5Hi489zvAOTsN/scxCQOJA1Aj+mW16TcXiffJ1MOznqQcMTX422q/vXkQ4NHygbVLsNarE/kFEpDcXndoEk7fRHqTJb8hSj6zfx/7W+hA3haSrr4rrue30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773339915; c=relaxed/simple;
	bh=xK2AAs5D+6nFe96Nf3V+1qjGL5OnxpIvCqs6zvmUeEg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W+esBSLFWPCH5g564voJwnIRAEn5KiOb39T+zCUBjVWMLr99I3ssRjSPP2qJWmDlnRL8RQt+wcI7JbuWyk1LDnVy8Ui20uKtywCLK/3A9x65Nys2cfocezDPBTwL3XAIsZbfXE8McnuuPGvyuZNPUPgZ4IdrKpRMRGcjRcSmvvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BWuMjHIO; arc=fail smtp.client-ip=40.93.198.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BWuMjHIO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvloYaxO13VkOe4/TxgSpD+aQIx2XCpjumygD0ZQFq0LQKedWhOF1ox7fhBSZTCCFZzASdggRn56EfY8bhOHQe+hqxuGhBkPn/O1DXb8UNAPEB1UuENyf8O1hztL7SLEiMNYWgSaD8VDA/8ljJlmWy5abptbD4BT7qLPq0ly5sUQOvAhloi7ne5vzrTfWbBBHlmn9QCjlP3Y8v7HJNOhuZkXkCw2amfNeIpAP3+3YROcs9SRmXwat7pFy7dgeBN65/FdBciVarEX5hreDmkSQXdE46tZBIHaQfdPfecH/iunwTTwim7u951zavP8ZoR8fm12fEm0cNUrOA2y2wcvCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3F0lisDMQ8ZIENSDt01/oN1/h6LhjC42S4JXHwy3/Ns=;
 b=K8Pp7XCYGi+cS24Bdc8S4cjUWO4/TPxr7QqCwIvAaQJKQJKVT0QOFw5eSOHtFHIqkX9KYFT1ZpQHeBKOwAHUnxQK2svXUBuHApPZw80vi5epurWndXTpi+cvmc7vf35vPH2PCDjaGJMHxuHIkGB2k/ly9OJ2v1O/uQjoyJ9Pg+AKGoTRmAY8JVNUFgHHS+5JH0F676WoA3BlZLuaqJ5R3JxKGqhvLJyoogg/wSx0h8TgAE701HOGsvh4pzW5jaCt25eLg/qbfZq+M3k0a1NafQ/c4Md8HhWEA0ATGOaFuM+ld3Uj+JMtkcaUMnBL1/GVFxedHAdZG9Y7fu2IjNwASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3F0lisDMQ8ZIENSDt01/oN1/h6LhjC42S4JXHwy3/Ns=;
 b=BWuMjHIOej+eEzFNGqd63cB0vv1397gtxWomQ3t6CBSO+OIbr2rCvl0uZH9YqE3GY9M2mP5E5BrwTmxavoHBvAttF5dGYGXnb6e/5sRKsV7I5wDRkzPVX0Y4GOu0WxlH2T2Ntfk9Wy1plZZ/zRE6r4q6udjeY2wGXPn+Gi7hw5c=
Received: from SJ0PR03CA0363.namprd03.prod.outlook.com (2603:10b6:a03:3a1::8)
 by PH7PR12MB8777.namprd12.prod.outlook.com (2603:10b6:510:26b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 18:25:10 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::7c) by SJ0PR03CA0363.outlook.office365.com
 (2603:10b6:a03:3a1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 18:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 18:25:10 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 12 Mar 2026 13:25:08 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH] cpufreq/amd-pstate: Cache the max frequency in cpudata
Date: Thu, 12 Mar 2026 13:24:42 -0500
Message-ID: <20260312182442.3236386-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|PH7PR12MB8777:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7eccac-6a20-4588-f3cf-08de8064b207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	cZgW8YmGn7t1WXIbtSjWmVVrBfoGKBPjERLFZ0sNWK1O671cA5J/XNTMHQ2g5wmFVrsZIR9sxPPaUBKVbnvllkpSfHYEbGIBnnlpaKVqR7s/wv4wgVcqfC5dgbphEaH9V5GU39dTJ9XDsIGs9Lg/Grj7ngeqgCFyb0r6vePQe9xmVWsN3Hl72J11GdMRrzKYIZD0TsaMZw948xoo1KrlpUPdKDs3b7oQw/e0ATNJ9yFvZ0t9Fvbev4c5ivV57gZvMopos6qNxUCdGmGTu96p6WgAhmVdercmjM30gN6KY4KfxDcYZkHUiPM9EEm2BYZHd+BTE8oZS3K50nqZ7blDH2E8tLvFhus94ynqWYEd34cSjxXeK0rfu6wESPLqXd4t+ySRz8FXQ0c65xhmKV+FqtUO/n0Ikhc2uc63Hvbo45Q7IGWtSZ816rJzWZLemBTqZV/sdvECm2EeIh089h2ns0ev8+EyOjAlb27KQCVtBi7qSFiaD9rnlZDHjgt3kyBKtwicCF9bgwcMCOyj2X8l1GNV7LdyNpmUlcorh75kXUkNA0Fz+3UgQk1CpuwTFOP/I9CRaV6e9lI8rXm23ZfoVrXJVoP9JiCZJkn/VPTl+ynB3cFbzKRNxIIXZotmal/JdAJh31mm05CH6xKxu4nRzX1S5oCTg+CXvGSFkGjCn6uNxg4XOXa3NEmxCnjesdr7DP1+MLJ8FM7WQJStfyhgnPWh1nmzIPVBvM9R5Gr8Bcc/tHmzwtQBl9mvwlHRg5UclFrRoNaKe3ZhURkbf0OhFQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l4FMGLGXfzVm92+QKt5zrwPmybmd1HIPFIwmaRykEFLeLhAtKyvKWocxe7QafmOWAtbM7bkQR0xKFbA0L++HJQurvRBBRWcnt+/dtl5TkuIFe1eZblEsPj7PoH2nh4FxgcSZJ+eQqVvnh6BWspPuKGMV05M8VwApag4W0xPyH0nCdeLt5+Q/nSUfmKsyRkXgyUZw7SbTxLE3x9wxiFHcxOL+KnMwd5wdVBRyIUZNpMG++syJtlgFvQQPD0c8HqoQHC34QpJR82+TE7qls8akIpMOa7z9CbqfLIlZ0bJY+6deBZP8mU6Qtjpm7nD4HSqU/Mv1MYnkMo3Aqz8HvqADGPJisgmABdoVdLHHnrVDW2ldOMF/PuwG5qRr8DWNGEc7tLk5tWP4ldM/Ofe8UTn94Get8aPscpqGCWq4iSrvuEYGHKyIJiLihJuItGjUBu13
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 18:25:10.4335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7eccac-6a20-4588-f3cf-08de8064b207
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8777

The value of maximum frequency is fixed and never changes. Doing
calculations every time based off of perf is unnecessary.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 21 ++++++++-------------
 drivers/cpufreq/amd-pstate.h |  1 +
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5aa9fcd80cf51..787aa3ba87b33 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -757,15 +757,13 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
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
 
@@ -952,13 +950,15 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
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
@@ -1021,9 +1021,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
 							      cpudata->nominal_freq,
 							      perf.lowest_perf);
-	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
-							      cpudata->nominal_freq,
-							      perf.highest_perf);
+	policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
 
 	ret = amd_pstate_cppc_enable(policy);
 	if (ret)
@@ -1096,8 +1094,7 @@ static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
 	cpudata = policy->driver_data;
 	perf = READ_ONCE(cpudata->perf);
 
-	return sysfs_emit(buf, "%u\n",
-			  perf_to_freq(perf, cpudata->nominal_freq, perf.highest_perf));
+	return sysfs_emit(buf, "%u\n", cpudata->max_freq);
 }
 
 static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
@@ -1503,9 +1500,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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
index cb45fdca27a6c..485ee023d79c5 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -94,6 +94,7 @@ struct amd_cpudata {
 	u32	min_limit_freq;
 	u32	max_limit_freq;
 	u32	nominal_freq;
+	u32	max_freq;
 	u32	lowest_nonlinear_freq;
 
 	struct amd_aperf_mperf cur;
-- 
2.53.0

