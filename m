Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60237283FC5;
	Wed, 11 Mar 2026 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237720; cv=fail; b=JVJDGUdLGlgTvgQtd13VGLDggOAv7SOH7Kka9dj7hMRz51Mf2bfPJEJPNWxSM2s5L+WngYEQt2VmN5Sy4h1yIeIEy/ZL4vhi3gDdLgdpAoN3NMLBeO9JPsAEx9xptydtDkSX0i3dSPGvtFdId2ug7vxb3TmNfWOlzE6SNJWUDcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237720; c=relaxed/simple;
	bh=+vrgG7jLvK4AJDGuFdzJQ1y+oGg1i/b0DTTvmowfUyk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcHWBFm7vjNOGQDJ3e6l6g8CzKTi/RW/Uyp0MDe24LzBteFem0qsKd4D+jNqwZXYhANpOEmBXqUO7vHyURBze4tEhurb9dzSP4gEDJJmVMSFiv23HjvPwAFmlf8xj6PGLRiRnw5PSREbIsCPQvWBvfK6Iqmq2FkcqGwEBXgx+Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=riJtbky5; arc=fail smtp.client-ip=52.101.57.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="riJtbky5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m56ceGkx51bCMlPjLDspNvNymhjop6EQI0W5VABxKZCYNHKVrrqHnLRTV7LE+SMRneQnOPiuLvREOxOyDPRqtpqBwPS+KjD/vGOx0PrQfgLZUjWoKn3C0Ehq7qW7XHgiqZR8+szh30CokTG9WozRTrSf9O+zrRRsU2zfhjIRd0CJQpzDdpKx5oRl0OpdXgnjE1Yv0aL4yaHsAHOMe3NHnJsibl0fu7JZ07vLeyyg6bscZuuSB25yfJPYViT2YTp97zmZLWcarnCnlek4xXcYUMSyM2LA5Cja3W5J+2DHLzSNNHqyGsA9eqeDH5wWFz2HFt2NBos96qKERw201/apqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIs5JjfGtEtwSgGlgXMffYi2vpyIrXwSsq/ya221OiE=;
 b=TMhqQ6VtwtwlrzvNzxo1k4GfxhLxJZ2sLq1zyqKzwy6g0stAhORKLWGlZe/fGWGfCDIgUh8PtCjAINCXUfKXoYMyWuhZDx5eCMOA1kH8A5y6tR0h+bmRnbZXY82V4enhZqj+NEtY0/u+/USdZhN/ksKrZQQTcLrhWZpXLGqt6E33Q0MYY9ZnUcp9ShBX+e7vLnmHZIp0EiHFl16Q9uqvBZUVLI6kiyboi0pc35f1fSDzBtSq2qaczgMSD14tkj0mrSD2iXozYf0hQkvNn3bHZzmHR8uskWJ3QdzNEQCBRyde3Okq9/b8XQpExQHcCEjqbnDz6NvwDef8EQQ5X6NzmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIs5JjfGtEtwSgGlgXMffYi2vpyIrXwSsq/ya221OiE=;
 b=riJtbky5+XRo+vgOzXc+Oj+q+EZVYKTm4alYFEQ0MF9NoEYJnPHrSs4K0b87Sol+C9+LQm2dpnGFLqbSNCkvBHJhtvpHBL65fcRF5Yv2uW4ODKa2rnKGPjxcMcdGuIXnBmXLIMd4klgOHKUBOhesgwx4rTZIi3h8Q/w2GKgLBqM=
Received: from BYAPR05CA0012.namprd05.prod.outlook.com (2603:10b6:a03:c0::25)
 by PH7PR12MB8594.namprd12.prod.outlook.com (2603:10b6:510:1b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 14:01:54 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:c0:cafe::a7) by BYAPR05CA0012.outlook.office365.com
 (2603:10b6:a03:c0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Wed,
 11 Mar 2026 14:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 14:01:54 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 09:01:51 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH v2 5/9] amd-pstate: Add support for CPPC_REQ2 and FLOOR_PERF
Date: Wed, 11 Mar 2026 19:31:12 +0530
Message-ID: <20260311140116.19604-6-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|PH7PR12MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d60c395-48f0-4e23-e3fa-08de7f76c043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sM7DVWJYAahy0otlgft9VYSvovUL17ceZ5M3ES7puUo255C/oFppd8t0XiXldgpcchOWjcLdOeZtSmwRwQcmMEuq78e06WweJooO99UTT+q3kC5woFVwSpKwyUqjyG6u/5kJ08MkiGfi6hDJU5n82Kfkp+oWG6VDJgGWqdqLxc1QErNTaYHiQqTLC14uAhjl0SUjnfGEslrgBuJd4Q3hwU89dT/KbQujeorxVdaOtODfNiwos9H1Lrs7s190mFFvu2p1pdxHjxvQDpoNSRJbBhbAyxURxcoYYKM/a4fjix+SE2+RVK+bZQzkYmWdwhroSFUqaocVIgX3GO55kfzxBqnAMjoqO0Atkm3JIehLKs7G/gvkZGSX+Sr5aHolf3v6R+RWRLnjrL1NDTMCD/lg2UIQgH6LuusA0CePMWPoM60oJ+zFeXKyCYBwcBMoTnG4OZnYx0oJcB+aoQvmJ1SnMx0isdZu1atKJtljjXJe6G9nHNLegQkzvtzEhI4oKwVgi5W0aAhPFU3f88s4Tpi/7U3HQn5An0HKtQoQ3Z/NMNb+O7nGydAl2F6Rq85ZQsn2h7Q6yKPXoiWq/ZbxRuhpP4O9BULc4ISpfMeNWC0ZEAxtQPA7RMYk0CB/0ihDkM+wQgjyLFmrc5pVRrU3DB4AL3UYHbyDD4m/M2dsR6jOGuGlmz2gH1tCVEs59kfgkWr86BSnH1U3CY0bLAa61KFshB7BK1O6bR7d3AjpQg4Y9+w+dG8JOvHA7sh8SmYdPv+f1LES4/Rm27D0Xmb/OwJbwQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ufoHNeS7yKAJl8M9Tymbo/44R2x+gKwT00XhNiSPvXPPh669XfE0F0XKirQrA/8xBaAO1+1mlbhjlNzcVXa258bSCbciZFrBoyJN16HyFLunfzOm8ko+dAXXgTSN0gEy6KbSqwuQljhKuwsW9zs8qL4WQQMoAt5ZDP/GVEzqyUGHuaizzBHmzCdU/pIp2gZFakVmXzKNm0HgbFcLoRMoVX2b02CIG6cHz9ucfbmVp1FfUP1w+pUCv05n2qOUEdwvLU5KQDi1Bc/AC5+LYewb7NRqx1ZWTtVHDuxoULsYDVsfjVHqq3FOJgvm7HHbRwINPQoQs9FppoLxqe2vsa5mYvOgAjZWgJFtL7LIodzmzVXDdXtHlHOMX4Anse4GAEo3DtINGSWMJVxg79+ca4ZznrCDW+3L0zYxunW7uQadtY8L1OUsi4K+rdLmiQ2NY6SB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 14:01:54.0950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d60c395-48f0-4e23-e3fa-08de7f76c043
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8594

Some future AMD processors have feature named "CPPC Performance
Priority" which lets userspace specify different floor performance
levels for different CPUs. The platform firmware takes these different
floor performance levels into consideration while throttling the CPUs
under power/thermal constraints. The presence of this feature is
indicated by bit 16 of the EDX register for CPUID leaf
0x80000007. More details can be found in AMD Publication titled "AMD64
Collaborative Processor Performance Control (CPPC) Performance
Priority" Revision 1.10.

The number of distinct floor performance levels supported on the
platform will be advertised through the bits 32:39 of the
MSR_AMD_CPPC_CAP1. Bits 0:7 of a new MSR MSR_AMD_CPPC_REQ2
(0xc00102b5) will be used to specify the desired floor performance
level for that CPU.

Add support for the aforementioned MSR_AMD_CPPC_REQ2, and macros for
parsing and updating the relevant bits from MSR_AMD_CPPC_CAP1 and
MSR_AMD_CPPC_REQ2.

On boot if the default value of the MSR_AMD_CPPC_REQ2[7:0] (Floor
Perf) is lower than CPPC.lowest_perf, and thus invalid, initialize it
to MSR_AMD_CPPC_CAP1.nominal_perf which is a sane default value.

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
Link to AMD publication describing this feature: https://docs.amd.com/v/u/en-US/69206_1.10_AMD64_CPPC_PUB

 arch/x86/include/asm/msr-index.h |  5 +++
 drivers/cpufreq/amd-pstate.c     | 70 ++++++++++++++++++++++++++++++++
 drivers/cpufreq/amd-pstate.h     |  5 +++
 3 files changed, 80 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6673601246b38..e126c7fb69cf6 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -765,12 +765,14 @@
 #define MSR_AMD_CPPC_CAP2		0xc00102b2
 #define MSR_AMD_CPPC_REQ		0xc00102b3
 #define MSR_AMD_CPPC_STATUS		0xc00102b4
+#define MSR_AMD_CPPC_REQ2		0xc00102b5
 
 /* Masks for use with MSR_AMD_CPPC_CAP1 */
 #define AMD_CPPC_LOWEST_PERF_MASK	GENMASK(7, 0)
 #define AMD_CPPC_LOWNONLIN_PERF_MASK	GENMASK(15, 8)
 #define AMD_CPPC_NOMINAL_PERF_MASK	GENMASK(23, 16)
 #define AMD_CPPC_HIGHEST_PERF_MASK	GENMASK(31, 24)
+#define AMD_CPPC_FLOOR_PERF_CNT_MASK	GENMASK_ULL(39, 32)
 
 /* Masks for use with MSR_AMD_CPPC_REQ */
 #define AMD_CPPC_MAX_PERF_MASK		GENMASK(7, 0)
@@ -778,6 +780,9 @@
 #define AMD_CPPC_DES_PERF_MASK		GENMASK(23, 16)
 #define AMD_CPPC_EPP_PERF_MASK		GENMASK(31, 24)
 
+/* Masks for use with MSR_AMD_CPPC_REQ2 */
+#define AMD_CPPC_FLOOR_PERF_MASK	GENMASK(7, 0)
+
 /* AMD Performance Counter Global Status and Control MSRs */
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fb5d7bb320c15..3122ad5af6f47 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -329,6 +329,63 @@ static inline int amd_pstate_set_epp(struct cpufreq_policy *policy, u8 epp)
 	return static_call(amd_pstate_set_epp)(policy, epp);
 }
 
+static int amd_pstate_set_floor_perf(struct cpufreq_policy *policy, u8 perf)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	u64 value, prev;
+	int ret;
+
+	if (!cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO))
+		return 0;
+
+	value = prev = READ_ONCE(cpudata->cppc_req2_cached);
+	FIELD_MODIFY(AMD_CPPC_FLOOR_PERF_MASK, &value, perf);
+
+	if (value == prev)
+		return 0;
+
+	ret = wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ2, value);
+	if (ret) {
+		pr_err("failed to set CPPC REQ2 value. Error (%d)\n", ret);
+		return ret;
+	}
+
+	WRITE_ONCE(cpudata->cppc_req2_cached, value);
+
+	return ret;
+}
+
+static int amd_pstate_init_floor_perf(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	u8 floor_perf;
+	u64 value;
+	int ret;
+
+	if (!cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO))
+		return 0;
+
+	ret = rdmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ2, &value);
+	if (ret) {
+		pr_err("failed to read CPPC REQ2 value. Error (%d)\n", ret);
+		return ret;
+	}
+
+	WRITE_ONCE(cpudata->cppc_req2_cached, value);
+	floor_perf = FIELD_GET(AMD_CPPC_FLOOR_PERF_MASK,
+			       cpudata->cppc_req2_cached);
+
+	/* Set a sane value for floor_perf if the default value is invalid */
+	if (floor_perf < cpudata->perf.lowest_perf) {
+		floor_perf = cpudata->perf.nominal_perf;
+		ret = amd_pstate_set_floor_perf(policy, floor_perf);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
@@ -426,6 +483,7 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 	perf.lowest_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
 	WRITE_ONCE(cpudata->perf, perf);
 	WRITE_ONCE(cpudata->prefcore_ranking, FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1));
+	WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
 
 	return 0;
 }
@@ -1036,6 +1094,12 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	if (cpu_feature_enabled(X86_FEATURE_CPPC))
 		policy->fast_switch_possible = true;
 
+	ret = amd_pstate_init_floor_perf(policy);
+	if (ret) {
+		dev_err(dev, "Failed to initialize Floor Perf (%d)\n", ret);
+		goto free_cpudata1;
+	}
+
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
 				   FREQ_QOS_MIN, FREQ_QOS_MIN_DEFAULT_VALUE);
 	if (ret < 0) {
@@ -1597,6 +1661,12 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
+	ret = amd_pstate_init_floor_perf(policy);
+	if (ret) {
+		dev_err(dev, "Failed to initialize Floor Perf (%d)\n", ret);
+		goto free_cpudata1;
+	}
+
 	current_pstate_driver->adjust_perf = NULL;
 
 	return 0;
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index cb45fdca27a6c..0c587ca200199 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -62,9 +62,12 @@ struct amd_aperf_mperf {
  * @cpu: CPU number
  * @req: constraint request to apply
  * @cppc_req_cached: cached performance request hints
+ * @cppc_req2_cached: cached value of MSR_AMD_CPPC_REQ2
  * @perf: cached performance-related data
  * @prefcore_ranking: the preferred core ranking, the higher value indicates a higher
  * 		  priority.
+ * @floor_perf_cnt: Cached value of the number of distinct floor
+ *                  performance levels supported
  * @min_limit_freq: Cached value of policy->min (in khz)
  * @max_limit_freq: Cached value of policy->max (in khz)
  * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
@@ -87,10 +90,12 @@ struct amd_cpudata {
 
 	struct	freq_qos_request req[2];
 	u64	cppc_req_cached;
+	u64	cppc_req2_cached;
 
 	union perf_cached perf;
 
 	u8	prefcore_ranking;
+	u8	floor_perf_cnt;
 	u32	min_limit_freq;
 	u32	max_limit_freq;
 	u32	nominal_freq;
-- 
2.34.1

