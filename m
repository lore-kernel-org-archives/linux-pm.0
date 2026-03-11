Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657C1373BE2;
	Wed, 11 Mar 2026 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237723; cv=fail; b=YAf+fiL7Xj5NFbZ7aQMx3DFRImoerYxpn/p9o16VLm8MDWLKBsGpUZ3V7ndpL5SQ+qNV2VfShO1nZMyxyMbE+N5WEFd6GKTPWGCHR+TaGdKfDdogkUt8q85dBywynvo3cY4EOugs7ol9SBwEsqyOwynWonGR5PzSU+L5qZOOw4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237723; c=relaxed/simple;
	bh=Cg63vYR3AFGnbyjvM8T8iAtjW80ivsKuDzbuRP/oHvA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCngznscgur9yGNCDwtMPu7LXBsvvuz17mOmoy8paJXEan/fqfkah9mVD+gCrcbmT9+uYTGYhBfTG/Lxsb9e5oZynMB0gONyD1LSlumD/nFefNelsYh1y7k7tO4XUC36JCbnEgkdWDTmSkcStnFSn9trALFLdp4c3ERHa0n/dGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OMOAxcIW; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OMOAxcIW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izZhAlaAnp9vThrRDNEhBGZ6k+P7xkWV0D3hU21J3oB2EmJGHxUz7zv9khpte0CWua/BayB+FAt0ZEWQyRLkMpWEjpBynTjihzABM3zT2CpMgYkDSmF+Jiyt5jWBljxoxhj0NJDUbPO8ZTIMR5jVuap+9m3cNkT47/ItZXRkS2zLkBkqtE8enufqbrXN3hH1dDZHG88dVQ2WGLlA8qOZfBBfXGdmOPUQWnZV6BKIzMjDb2/xTltO1CsJ7mIonY5pCfc81V8/Ahrj6WixZK2BfrzfAIsuadLl6/9GXR4nAoDwPmAfpyJSy6KsK2qHLrLuFTczmd4NlK8mEyvEtY+B1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wujOmyHpRdf6rdJ573nRhT4OOBNwo3Es00kWzGiV7kQ=;
 b=QFfPoMLc8cjk9/USia9C1Bz/YSzDLNwAMpaDpy/ik9hhRDGxNppVb2grzESlZfDVpBMzEb11okaF18JaRH2GSy9Sxm1nE/SQ8o9V94qeqhbVaj3aPhzuRt9O2prWvDS1NPEf6aPX+Pl8JPWe5Px1h5WAc4fj526EFaFnofzc3hE+LtR3bnU/CNLVVqKExk3wpHIlk+wHyq0DJYSO2pF3zgSWg/DV1DPrxA50GkB3fbnQ6yU/BQ41hmVRB2ZAG4eL9IhDII1/wT3cQ3AE+5yHl4uWhkHELg1TG/yrERH0GACHPGJw7DLFUkNpAb20nu1ZJv38H+c1vlXFcSfHJCdgfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wujOmyHpRdf6rdJ573nRhT4OOBNwo3Es00kWzGiV7kQ=;
 b=OMOAxcIWgxzYIUiV91VI8igpd3FY+x9KPqK+i/b/+ekCrnOVlxps8PQxRWsrIDwNq6hUsiPWNKdFvi7tsn48Kg08RjHBDm2bWYCmUjWnxxwD/wedWJ/kS29sCEOSjrzpA3zsXNXW9sVwjarT5CZdRrloO93lcWNVT5mOnXD+8C4=
Received: from SJ2PR07CA0013.namprd07.prod.outlook.com (2603:10b6:a03:505::15)
 by DS4PR12MB9769.namprd12.prod.outlook.com (2603:10b6:8:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 14:01:59 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::5c) by SJ2PR07CA0013.outlook.office365.com
 (2603:10b6:a03:505::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 14:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 14:01:59 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 09:01:56 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH v2 7/9] amd-pstate: Introduce a tracepoint trace_amd_pstate_cppc_req2()
Date: Wed, 11 Mar 2026 19:31:14 +0530
Message-ID: <20260311140116.19604-8-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|DS4PR12MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b88376-dd40-469b-3ccb-08de7f76c34f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	HW50lK4kAig9HyLE8sYFNxatOzs/VkP9jvXF9Dd5YVMdsgzyvYAH7YFGfVxZjmwLyLV0rH9WmVxIhqDiIU0JE7/KZf0oHNjsY96y2kpCi54W2w9KvHKgofu52dZUEOMYOgCS6BEtIyQhxlsFHxxV9JCUHSbIE3Eyu1pUkepl8mfWErg7EPmlIA2POhYRppGHvHO/6AvBUJQw41dI5RYD1DRDJyvrVeTrpIaLR59Z+bkz50BEgvf+shx5Kzfkeg1u2cOBm+5V2dh1cv2MijYrWvRd4staJ2UnCozErcbLYhZnLX9RgTZFGnEreXpS6NqqqDmhQRd20V4piM33Y6SS2d2ovN8lzpmKa43hx67JgHAYdOd2w/crBXAEuZYtBWJF8I+4H8jqNqFM6i5fKDPj//P99a9dcAP3qqRGuxdJt4wAQVf7MxlokGway1AJSUZJdQ5Rf/kwdKiX0dUukxE5hI3T4s/+2/DLoZzQ7rk57MzZWB4Brduk0ET9Lu3WdkkYUztzxtk4JQPV0gzHwGEP/i8XPAJnpk+hg93SYKqlCvZENa0QkOp8sXl06S3YJWTJdAg8JEw5vwnISkj3DTqmYfN1b2UM2Cr0GZNgLXZcSET7jltxf9jGPsVW3kZbUmIl82PFe3aZbzHfSnC97fEzFR+5JxjzQ4cfnph9YuaN6khyywea2dDzydv346KoGBd6iPuylPXL6HSXb0F+kq8TGLpUVOYYMSLeKIGkN2hY0XYdFEmqS+2RAqvDc62/7yKU6KN8bf8OUZ6k0RZ0vzUEhA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sxMKy6Y8Z8axfD2K+eU4meI2pTCSjblXde9uB4y+iwSBmFMskkWuYr53+Og43f152Ybew1BNKe2WBr3CGP82P7kzBtEgohbqydJe2IPYshIMTuNE9xIEtyL5G+Y3T1H1RA3zcG50/MG8ERs4Mx3gRzVQN6i7+7kk/493eyowD5ezmzytvKjI6O1GGd4abtSZ+y0JAUQNDmJN835qAc0cgFeJAxd8parTI/CaIxTc6LDuvVnwltIRnRMqRSWSL4KW5/mbGi9P5N1A1EnhAe37RRLlD2AZ+zhLSHuFbPIEj6E00zxkxeyJm14H5JjpX7J7mHk8sfjVFu+bXZuh9L0JYbj/Lgm+dbnVpdkggrgxIBm4WCeAdnYDYHc8gKNe7ZJ8hmUG1ManBdp0uYOd43M0gBeeaG8xzsb9YUcoNepNLQ6zqPeKzCO32TcaVZWWUaz1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 14:01:59.2016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b88376-dd40-469b-3ccb-08de7f76c34f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9769

Introduce a new tracepoint trace_amd_pstate_cppc_req2() to track
updates to MSR_AMD_CPPC_REQ2.

Invoke this while changing the Floor Perf.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate-trace.h | 35 ++++++++++++++++++++++++++++++
 drivers/cpufreq/amd-pstate.c       | 14 +++++++++---
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
index 32e1bdc588c52..91fa073b2be48 100644
--- a/drivers/cpufreq/amd-pstate-trace.h
+++ b/drivers/cpufreq/amd-pstate-trace.h
@@ -133,6 +133,41 @@ TRACE_EVENT(amd_pstate_epp_perf,
 		 )
 );
 
+TRACE_EVENT(amd_pstate_cppc_req2,
+
+	TP_PROTO(unsigned int cpu_id,
+		 u8 floor_perf,
+		 bool changed,
+		 int err_code
+		 ),
+
+	TP_ARGS(cpu_id,
+		floor_perf,
+		changed,
+		err_code),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, cpu_id)
+		__field(u8, floor_perf)
+		__field(bool, changed)
+		__field(int, err_code)
+		),
+
+	TP_fast_assign(
+		__entry->cpu_id = cpu_id;
+		__entry->floor_perf = floor_perf;
+		__entry->changed = changed;
+		__entry->err_code = err_code;
+		),
+
+	TP_printk("cpu%u: floor_perf=%u, changed=%u (error = %d)",
+		  __entry->cpu_id,
+		  __entry->floor_perf,
+		  __entry->changed,
+		  __entry->err_code
+		 )
+);
+
 #endif /* _AMD_PSTATE_TRACE_H */
 
 /* This part must be outside protection */
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 54b650f3b4e78..a79c6213a67e4 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -333,6 +333,7 @@ static int amd_pstate_set_floor_perf(struct cpufreq_policy *policy, u8 perf)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	u64 value, prev;
+	bool changed;
 	int ret;
 
 	if (!cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO))
@@ -341,17 +342,24 @@ static int amd_pstate_set_floor_perf(struct cpufreq_policy *policy, u8 perf)
 	value = prev = READ_ONCE(cpudata->cppc_req2_cached);
 	FIELD_MODIFY(AMD_CPPC_FLOOR_PERF_MASK, &value, perf);
 
-	if (value == prev)
-		return 0;
+	changed = value != prev;
+	if (!changed) {
+		ret = 0;
+		goto out_trace;
+	}
 
 	ret = wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ2, value);
 	if (ret) {
+		changed = false;
 		pr_err("failed to set CPPC REQ2 value. Error (%d)\n", ret);
-		return ret;
+		goto out_trace;
 	}
 
 	WRITE_ONCE(cpudata->cppc_req2_cached, value);
 
+out_trace:
+	if (trace_amd_pstate_cppc_req2_enabled())
+		trace_amd_pstate_cppc_req2(cpudata->cpu, perf, changed, ret);
 	return ret;
 }
 
-- 
2.34.1

