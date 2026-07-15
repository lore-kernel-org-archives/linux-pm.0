Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010043.outbound.protection.outlook.com [40.93.198.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F6231717D;
	Wed, 15 Jul 2026 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101766; cv=fail; b=nbJwYyldJQkl96XosYeiPWrzabnPREGKE8T2oxAykN31dpXb1TOj1mbRL/ddmRlCUrZ99qAZc3pECPGOWx2DKbncys46Jiz0uARrmBKLgXyt4BmQBOnZL4TnULngP8mPMEZOwIf2iN//mHgwDhnaSngZFcZ3UK1EvgB3EEFK5hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101766; c=relaxed/simple;
	bh=enOqMNIYFWx3lCapoZ2iSe5zI0LXkPFQLbZYJOAd80M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRfZJ1SCYnkbGZhUcjiB3mNVAQpCyGmrLe/J8v4xzFzaUwM0cutXWgS4RAIJNENvsUYXkKCvXVjip1KsPBCFvMkn00Ln6kt0Waq5eWBp8h/KMT6qpNp776EXfbLegnxm2szrKaiUqyAzlxP46dOPwKwplh1+7rqwVrIenw6xL/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hEHXIjXK; arc=fail smtp.client-ip=40.93.198.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hEHXIjXK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ii7PabUvvDCxkKB7KFsgcmoV62jErbKqJGXjZ8WCTMMy/C1uJh+hX7P1lxZNi9T95/gZW6Mt62eJjHajrgY7SdDEs34IaPvvyhK7ai7+yX8qL7xHlhyevvtlPzIp2jHdyJie+CIibKoOLRIm6HjEoNLpXKk1kh1FaJJ4BmChYv4PxzH6YZ9azSt3QIN1ogQ02TEWLANQ9+BWxuv4mCfK2wIfw4nt+KvIku8qqgcksbOUFyYDZhNwXDJyRKIAHtH9E1viU55s2yLJqSsi+W3mj1TANLO/ukGgH6QESe405FnfP3dMg+cItTz3NQQcSyDX9mSHU/YSxq8n/YTuUX067w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0entI+OBsCubrxUJS8qgh25qn2Mx3gm6t4foFQaQwQ=;
 b=jTdRfRFo6qeb5e0f6UI57WZ/BTGgMIiWsCYWY4r7T2imLNZ72rTIUAEqZwEyffQqczpo3yCUEE4GddBUCRp2RKJ36i6sQ3/2ULs9DIRaketUXK/Mzl2Qu6NoP1a3SbJRcf6hSDOcg5lUaj1DmjY9dqIGccciRAOD/nyQFNv1PFSVKwFE+SSqc4KaoyawLrLYU1Q7pN+3OFN/zNg02xjNhzV/xgYCU5peCsRxLiZskgSOlqv9DoVkuorp6Sr2nNDjTM16/5nFY4zZVhUzTiZ5Fsy3xgkpUj83bu9TC5/QgWfBlsf6N58fli6vXw8/7IAzGhTASvzFg9xzc5s19MOsJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0entI+OBsCubrxUJS8qgh25qn2Mx3gm6t4foFQaQwQ=;
 b=hEHXIjXK8HxV57HxU8uj2RB1teke8JVvvUQ9NM/drydmRShjN391NQgbae+wcmvoKPiQGe6andcT7mE+lC9e86HB6dORofbkMy9wJkPrVk67Oyy6e3rXWnAVCKAMeaDZ+9J+d8Rih2qwaR/9g/7juTrd3VV6/8jcHcYu912+hCw=
Received: from BN0PR04CA0082.namprd04.prod.outlook.com (2603:10b6:408:ea::27)
 by PH7PR12MB6587.namprd12.prod.outlook.com (2603:10b6:510:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 07:49:16 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:ea:cafe::30) by BN0PR04CA0082.outlook.office365.com
 (2603:10b6:408:ea::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 07:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 07:49:16 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 02:49:12 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Huang Rui <ray.huang@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh
 Kumar" <viresh.kumar@linaro.org>
CC: "Mario Limonciello (AMD)" <superm1@kernel.org>, Perry Yuan
	<perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 2/2] cpufreq/amd-pstate: Correctly reset bios_min_perf during suspend and offlining
Date: Wed, 15 Jul 2026 07:48:22 +0000
Message-ID: <20260715074822.16324-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715074822.16324-1-kprateek.nayak@amd.com>
References: <20260715074822.16324-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|PH7PR12MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: 4939afc7-4b52-4653-e33a-08dee24591e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cNgWQIa2yPWsMS3vjFc8PxU8dzm2fLIR8nlA08RzPMHbatejxxCjwYDT6/tGGLvPF5nGwqCH+zSC440TFs/JmYEyZ55sGbA51jKAord7IZ43k9qerKSkwZOJzx8p6sCfEkEBJuAeuqDPRVkch5xsJcjTkA83TsxPVFxTKoKUry45P5ImPc5WVUaUVtNcsXGp32XoGs3QvYBvwOvCGCGqhOJv24uMeNeWa445mFx/L8XrZ5y82d4pwJcXOw5H6KBUagEhg4Ym410HEQV0EfNu3OOdaXOVYSq/DrvzO6rgI1dUOmMj4lmeKooXmo/0pSeFbY2LH6wmxRZAPOR0/UMhsQFf+EYeotS8Xs5LvEHBCN4oo1LxdD0IrDtE28QEqInhDNQzhm3dI5Vhp/H9T/Dyz7AMIAHS6ZMRtlA2wmAsRBwemSAxJsIygLLq1aQ+FsZMLa3+dop2CwldCxgLI3sMJ2oIKpbNP6nBaX0B5dTXorasrQsTKtFsIMeo3qKQsUOz07I3DR+2m3ihVKV+hOyc50Se+vFFEWllAs96wNVvJ5kOFlbWyhpDIzWsm+4gkUGEmVmK2XIdEzlwUP77xmu6jrQlh+ZXRTLnItPvqesZIr92SGJI37cSP95yQc8u3qizo6KYXaBQXYmnXaBVN+VwRw4HKcxz7Y9Ze1JWiJwYqMETRlZQJgrK4t23RgBbk7tiGYhii9ylu1fda5j9ce1zuw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	45Ar0GH3lqTyd2mGyc84FNF+m7RJ/Mbkt+3PhXA395tRlD253+9z+wbEncpgZw7wGpV5/2UmG1wanxiuKcnsW6nP0SzfowPS5C9+uAKgSUsSVFBUMFgrtQTJ0FoVpVw93VghwHz2KPSc93eIaA5QBr7+OOAr0IuNN+kcoBktqBSDY0RSlsnGquPk9qNDVx5PTaJG6dnGuW4UmgfuW9IK+yzokmVhjLKI8cbwL/lXrEhwdDvAXU7NblTeS0lQhjp4o2J195Y5eE8BnVPxH6ai/aRztC3q58+2wya126v7zCbpgkEo/jX+EAHn5jIxKqpHA5Tzw2cljhUv0ngkiT6pXQCJlmppK8nTeBSBnj8NdVl8Jw5awWQGxuHoGZk3i9URG97x5W+mHF4W7xOTxd/CjXrM8/BsSJ9ltp35gN5LQ2Mf+WKhYcXsbBVygmCFsdfJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:49:16.0970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4939afc7-4b52-4653-e33a-08dee24591e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6587

msr_init_perf() accepts the configured bios_min_perf in CPPC_REQ MSR
only if it finds the other fields (bits[63:16] + bits[7:0]) to be 0.

This is intentional: a kernel unaware of bios_min_perf can leave the
last perf request programmed in the CPPC_REQ MSR before kexec and the
newer kernel, which is aware of bios_min_perf, should avoid incorrectly
interpreting this stale value form last CPPC_REQ as the bios_min_perf.

A kernel aware of bios_min_perf is expected to reprogram the CPPC_REQ as
seen at the time of reset during suspend / onlining. This allows for
kexeced kernel to pick the bios_min_freq during boot without needing
complex mechanisms like KHO.

Although suspend / offline callbacks correctly restore min_perf back to
bios_min_perf, they fail to set other fields to 0s which causes the
kexeced kernel to think the CPPC_REQ is configured with a stale value
from the last boot.

Restore the CPPC_REQ seen at the time of the boot during suspend /
offline.

The "cpudata->cppc_req_cached" is temporarily clobbered when the CPU is
suspended / offlined to reflect the perf state at that time. A
subsequent resume / onlining will use this clobbered data to reconstruct
the CPPC request and force a reprogramming of hardware to restore the
state back.

Since cpufreq is suspended at the time of clobbering, the state will
persist, undisturbed, until the CPU resumes activity.

Fixes: 85d7dda5a9f6 ("cpufreq/amd-pstate: Fix a regression leading to EPP 0 after hibernate")
Fixes: ba3319e59057 ("cpufreq/amd-pstate: Fix a regression leading to EPP 0 after resume")
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 61 +++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a6e43db6efefe..6ab769d4bd2da 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -2044,6 +2044,8 @@ static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	union perf_cached perf = READ_ONCE(cpudata->perf);
+	u64 cppc_req_cached = cpudata->cppc_req_cached;
+	u8 min_perf, max_perf, des_perf, epp;
 	u8 cached_floor_perf;
 	int ret;
 
@@ -2051,6 +2053,22 @@ static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
 	if (ret)
 		return ret;
 
+
+	max_perf = FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cppc_req_cached);
+	des_perf = FIELD_GET(AMD_CPPC_DES_PERF_MASK, cppc_req_cached);
+	min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req_cached);
+	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cppc_req_cached);
+
+	/*
+	 * During offline, cppc_req_cached is clobbered with the state at the time of
+	 * hotplug. Retrieve the relevant fields and then force a mismatch for the H/W
+	 * to update with the correct values.
+	 */
+	cpudata->cppc_req_cached++;
+	ret = amd_pstate_update_perf(policy, min_perf, des_perf, max_perf, epp, false);
+	if (ret)
+		return ret;
+
 	cached_floor_perf = freq_to_perf(perf, cpudata->nominal_freq, cpudata->floor_freq);
 	return amd_pstate_set_floor_perf(policy, cached_floor_perf);
 }
@@ -2059,6 +2077,7 @@ static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	union perf_cached perf = READ_ONCE(cpudata->perf);
+	u64 cppc_req_cached = cpudata->cppc_req_cached;
 	int ret;
 
 	/*
@@ -2066,14 +2085,13 @@ static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
 	 * min_perf value across kexec reboots. If this CPU is just onlined normally after this, the
 	 * limits, epp and desired perf will get reset to the cached values in cpudata struct
 	 */
-	ret = amd_pstate_update_perf(policy, perf.bios_min_perf,
-				     FIELD_GET(AMD_CPPC_DES_PERF_MASK, cpudata->cppc_req_cached),
-				     FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
-				     FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached),
-				     false);
+	ret = amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
 	if (ret)
 		return ret;
 
+	/* HACK: See the comment in amd_pstate_suspend() below. */
+	cpudata->cppc_req_cached = cppc_req_cached;
+
 	return amd_pstate_set_floor_perf(policy, cpudata->bios_floor_perf);
 }
 
@@ -2081,6 +2099,7 @@ static int amd_pstate_suspend(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	union perf_cached perf = READ_ONCE(cpudata->perf);
+	u64 cppc_req_cached = cpudata->cppc_req_cached;
 	int ret;
 
 	/*
@@ -2088,14 +2107,17 @@ static int amd_pstate_suspend(struct cpufreq_policy *policy)
 	 * min_perf value across kexec reboots. If this CPU is just resumed back without kexec,
 	 * the limits, epp and desired perf will get reset to the cached values in cpudata struct
 	 */
-	ret = amd_pstate_update_perf(policy, perf.bios_min_perf,
-				     FIELD_GET(AMD_CPPC_DES_PERF_MASK, cpudata->cppc_req_cached),
-				     FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
-				     FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached),
-				     false);
+	ret = amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
 	if (ret)
 		return ret;
 
+	/*
+	 * HACK: Restore the cppc_req_cached at the time of suspend. This is
+	 * used during amd_pstate_epp_resume() to restore the correct EPP value
+	 * when this CPU resumes.
+	 */
+	cpudata->cppc_req_cached = cppc_req_cached;
+
 	ret = amd_pstate_set_floor_perf(policy, cpudata->bios_floor_perf);
 	if (ret)
 		return ret;
@@ -2131,9 +2153,26 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
 	u8 cached_floor_perf;
 
 	if (cpudata->suspended) {
+		u64 cppc_req_cached = cpudata->cppc_req_cached;
+		u8 min_perf, max_perf, des_perf, epp;
 		int ret;
 
-		/* enable amd pstate from suspend state*/
+		max_perf = FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cppc_req_cached);
+		des_perf = FIELD_GET(AMD_CPPC_DES_PERF_MASK, cppc_req_cached);
+		min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req_cached);
+		epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cppc_req_cached);
+
+		/*
+		 * Enable amd-pstate from suspend state. During suspend, cppc_req_cached
+		 * is clobbered with the state at the time of suspend. Retrieve the
+		 * relevant fields and then force a mismatch for the H/W to update with
+		 * the correct values.
+		 */
+		cpudata->cppc_req_cached++;
+		ret = amd_pstate_update_perf(policy, min_perf, des_perf, max_perf, epp, false);
+		if (ret)
+			return ret;
+
 		ret = amd_pstate_epp_update_limit(policy, false);
 		if (ret)
 			return ret;
-- 
2.34.1

