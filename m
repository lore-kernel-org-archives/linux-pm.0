Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85573C5DBD;
	Fri, 20 Mar 2026 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017857; cv=fail; b=WTdsIKqEWyuo44NDYsgc8hhk9Kgu/18aHEv1AyIDlvJK7JvaaUwUuQn9/CfYdpn097JmSfDQcv6G9zJ8qoTKRNuHvpk9EhY2o9fJQnrzBBWwcbRHRE4QSRu0oHwex4VWBMDaqH2SfeKZgbZnn8ydc7RUt+XnUH7bDOsV/etUQKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017857; c=relaxed/simple;
	bh=41InMdOXhJ/3OZJ/XlV/WGLZfaBqmEyb5XHWsjBZ/Rg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TE9UZGm9yFO7ebVHkJP40KZl0o/CVETCw6VngW7/DezSLXcsU0npuQW5nxTS78dSPWS++J2gykw36Ftf89gisqLHOxodsmhfOhxaYPl1WjMt5i61weSPHV8e+PI79YCde0w5nkWPtXwsxNpJ2blNGuBDNE8vLafzQY8Pn+grQXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jjfc41dj; arc=fail smtp.client-ip=52.101.43.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jjfc41dj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bn+ugbLswqwHZsNAF1R+sTuasIw9+p+TbQPmfZW5Pb7tH8MlPgpEWEilHC9lQmBS+sdtVAhNjtFxY1SDYaKnJVUyl4UjjezELV8giTH4lWaA69hH4BEvWB63LK+hrgHpIJ66MUMjhc+2i8UIyNBKEPmagcDFUxxjAOiWs4/QnR2iAGlVKQPt7tOu5g0QDryt395isYJawoMX6foc0J8vSc4vo1VCgExQP1xmh2xFI0ffvCMi6xUnMXgckdyz0lxn8NSxzF62Pcff5Co4HvFPJ9hOE5C8s1X9LG5uEiPShLxbFeiZIzCq2oOvLPifBtyunu90n8luN/OjrCl45yNixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VEyOtwYDHhIL0/dwAHuMzYhTNbGbLvuXPKLlMGwK8w=;
 b=d5PomY2RoEGfLKjjMBkJ7PGpJjllT4AGTJwEnEZDU8Lhl3KufHn2bkUkrJhN1wn0Nk6gml6R5YCHwnFf3Ih06lHz8HSY9rOV+TAi+Nj/uDLERM/H2RA+M9UEnVXZ5Le8aieb5PibYMMZzg+5LmWQ9vnnHwzIyQwrHu1AfOwWiXFiJx3m9SnGn9gdpSoOXP5ZO9X24KOnphgVzC/032UCEjH0bTQbmQWZMU04rWpoYUg6RvTI+Dk55tm7lwiuivx0AX3+IWYY554xfW9pli+skg7h0ySrByDQGtiocI1rWmYKrfatfrUw2UvmNSBGxEgObzIbiZazbQWtjKgMHQnJuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VEyOtwYDHhIL0/dwAHuMzYhTNbGbLvuXPKLlMGwK8w=;
 b=Jjfc41djlQqcNH1OeXOFoiVrsAsnVmKMEP1x2G+1Qib/GGd/fYnfyRavNLGQqez2F8YEDgSVFmpeJ49GkuCOTwafr4TNZVkz4lqIgoIym/URBp3U30QksNa8ld1jhNETW9cSSHrLzj806r9ZsVBQD8xdrI9scCprYxKU0MYb6UY=
Received: from MN2PR03CA0013.namprd03.prod.outlook.com (2603:10b6:208:23a::18)
 by PH8PR12MB7025.namprd12.prod.outlook.com (2603:10b6:510:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 14:44:10 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::5a) by MN2PR03CA0013.outlook.office365.com
 (2603:10b6:208:23a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 14:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 14:44:10 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 09:44:06 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH v3 05/12] amd-pstate: Add support for CPPC_REQ2 and FLOOR_PERF
Date: Fri, 20 Mar 2026 20:13:14 +0530
Message-ID: <20260320144321.18543-6-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320144321.18543-1-gautham.shenoy@amd.com>
References: <20260320144321.18543-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|PH8PR12MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d33201e-5dc7-414b-2858-08de868f25b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	1CRJl8TYJLYURpj8y7AqpRbKPvh/ywdMW59MuwJodkKUBe/CwBZL7Cc7hqCxNjYZhxbgDrqhmX/rodxwj6fMlIs0OCxirqYpkNQRIqzLyDgOFvPIw2iovavPJNE2wMM2mcCRkOIADLGB43iKAHuPxc8oHy8IYo1WW57tS0mIaecMKMqQ2WDU0fO0QIZv1cxiGmVocdbjkhkibqXz4D/FjrCRhoK+3OFSzIWbr2/Nu1VMXsHv4zXB2m2BqTcpyRU8exxcohyvs8ijv32akLcyLiwJHcalo5Lmur3t86QT7XN9fKB2JaRDCyhpgpqXbr2LX36GtnXRxXa3jGfac7ll6+c9Ka2uz5iuzIVpCS1D3xSSThhV1BDYNO9FE/HTxmDdxSAcOJA5k9Zd+ddyMCGvRIh6NGOEzQ3yGwiRbMpCAbiU+EL6I//ljDzCcMxnpBzLcYSPdbVL8TMoRDj/6YB42gUg/YUNr3mRxLEU94iOTX3QA3yplyd0S6MuJQjgZIAR3g0fw8d3A4NE6lVE2n7L8yU/sUn0l02lZTyIh//UF9pbVMPfDNHBtFBAPXFQ9N71/HSIUjmMPA15A6TSDuY3/lrsQWJVLyCia9bWPtfJUXXtTdC1eCNwS6t+62xjINJYYo1fDfY4luHD30cQxFaNAOPZ0V1uqLAOB4sv9/UPxLIiULQ01Ej/muH44pdSdVsNDNIgHi1LzCJ6HT/Ayk04wUkJoK0Jz+MIAIshx0FNq7oNJY1MpE7z5/8zQH7vyq5xb1PpI8hMwL3AYW+3GUtHXw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2oGqqwbyLtF9ziAXKq5jvzwasXUiDGMytd4mmIxKw1XjjhlAKnJYIaS+xtLLEcO1WG4JdDAIQ2QC3JZxLBhbZIw3ho3JdRkUMhl1IIrP2WnJBX1SruQoSOqciUA1BO5p3kmPEWJCW8ySZadZZsc+uVwANa4nHrjUrkIYOAgaT9xEFobfqzdP8WcjUXv7pAit4KpUyezC2+909mRIHxdswLMeNNOCMPkV4SwTtrletp7rAo+hhhJz+FxF4abA8RxWR+WvqeHjI54xE32qfPZG3ovcMB0+0bCfg0m7I10nW/zQ8e0+KY0Pt/6SJ2g2vuxR0mSxJ1dDWpksaLcgzsX6UYJcEDn3FaKelOELq2GfjoePUhF7OJsMIEXgzxObTgd7venkuLtM2GYAF0N+Wid1MPScrcskymzpBqwSxWnzF47EQPDFYQKYO1O2m9iZD3u8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:44:10.3554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d33201e-5dc7-414b-2858-08de868f25b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7025

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

Save the boot-time floor_perf during amd_pstate_init_floor_perf(). In
a subsequent patch it will be restored in the suspend, offline, and
exit paths, mirroring how bios_min_perf is handled for
MSR_AMD_CPPC_REQ.

Link: https://docs.amd.com/v/u/en-US/69206_1.10_AMD64_CPPC_PUB
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 arch/x86/include/asm/msr-index.h |  5 ++
 drivers/cpufreq/amd-pstate.c     | 78 +++++++++++++++++++++++++++++++-
 drivers/cpufreq/amd-pstate.h     |  6 +++
 3 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6673601246b3..e126c7fb69cf 100644
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
index 4de2037a414c..53b8173ff183 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -329,6 +329,65 @@ static inline int amd_pstate_set_epp(struct cpufreq_policy *policy, u8 epp)
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
+	cpudata->bios_floor_perf = floor_perf;
+
+	return 0;
+}
+
 static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
@@ -426,6 +485,7 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 	perf.lowest_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
 	WRITE_ONCE(cpudata->perf, perf);
 	WRITE_ONCE(cpudata->prefcore_ranking, FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1));
+	WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
 
 	return 0;
 }
@@ -1024,6 +1084,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 							      cpudata->nominal_freq,
 							      perf.highest_perf);
 
+	policy->driver_data = cpudata;
 	ret = amd_pstate_cppc_enable(policy);
 	if (ret)
 		goto free_cpudata1;
@@ -1036,6 +1097,12 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
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
@@ -1050,7 +1117,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 		goto free_cpudata2;
 	}
 
-	policy->driver_data = cpudata;
 
 	if (!current_pstate_driver->adjust_perf)
 		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
@@ -1062,6 +1128,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 free_cpudata1:
 	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
 	kfree(cpudata);
+	policy->driver_data = NULL;
 	return ret;
 }
 
@@ -1072,6 +1139,7 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 
 	/* Reset CPPC_REQ MSR to the BIOS value */
 	amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
+	amd_pstate_set_floor_perf(policy, cpudata->bios_floor_perf);
 
 	freq_qos_remove_request(&cpudata->req[1]);
 	freq_qos_remove_request(&cpudata->req[0]);
@@ -1598,6 +1666,12 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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
@@ -1605,6 +1679,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 free_cpudata1:
 	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
 	kfree(cpudata);
+	policy->driver_data = NULL;
 	return ret;
 }
 
@@ -1617,6 +1692,7 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 
 		/* Reset CPPC_REQ MSR to the BIOS value */
 		amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
+		amd_pstate_set_floor_perf(policy, cpudata->bios_floor_perf);
 
 		kfree(cpudata);
 		policy->driver_data = NULL;
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index cb45fdca27a6..f04561da4518 100644
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
@@ -87,10 +90,13 @@ struct amd_cpudata {
 
 	struct	freq_qos_request req[2];
 	u64	cppc_req_cached;
+	u64	cppc_req2_cached;
 
 	union perf_cached perf;
 
 	u8	prefcore_ranking;
+	u8	floor_perf_cnt;
+	u8	bios_floor_perf;
 	u32	min_limit_freq;
 	u32	max_limit_freq;
 	u32	nominal_freq;
-- 
2.34.1

