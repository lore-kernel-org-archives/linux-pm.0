Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651E53F210F;
	Thu, 26 Mar 2026 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525723; cv=fail; b=ZYeaPAa6C1c12PXYw6U1khp2zTJuoeQ2VoOkMiHj857EVb6Cyc/QzCyoiOxtJzCDKEvzC4uy544HlvF+zMAkRNbTOKoT+BUSTBIXGIXJGRc4vIgjpuExx23/tejZfxAaUELvYLoNKJKv69P6bxb6pFzEHoKL46WD3DJIHcF2uRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525723; c=relaxed/simple;
	bh=/cA91iDyZfLFWiNOnO3aOPVe8CGmvdamtWKHLaKDAPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oT7nYEqHpOETkHJBO5fWwWLu3Wa8ARjc5udznwRKgr7WyDSbIGX4Gs5IqleXcLmetb69fC7UVkZmOx4eovugmbvzuC1p4Bfwnig4tFYWHsv+UL44a7f83VJKsXjlOjIKFsA/Pp/HKoAkaoXASPsHExcnj33MgKr/oqWCqynkOFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dPch4nvm; arc=fail smtp.client-ip=52.101.62.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dPch4nvm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NigMewU71sailf98CpUmjpkRbLFwIUKxwBbjHq4nH8nMpq1oAT8pvZ1PDuhH7TUsfmbq/eplrMJMlbvPuyA+K1ajsaKZUIad93+91C84s5OiBaqg280kdU/PnFif6LIqBtHPqeH413l+rk97Ldz5UQp4Wu/YPXPM+dVmJnj/iZvthWVdhZu9qScAYYd3lxXdcvUX4cbIlj3l/flndCvdIWW0zK3BbzQHswkXkrh+2wpKfDJl2lM/1RRGjv3KfVW/hPk5Fkiyn6585R/Cr5yrUc7btZXZfg9LevQvD0HRTktpERxL1Oekf36ieufwCAw8yefSfyxKBeTUEwscxhexIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxCPStkbHqjm73kEpBcSBo/EeEwYezVKj2LaMOc7W4Q=;
 b=A0ueWBE00hKjRxfM3uh6rFAdozcEAuWGsU/HgRbq48jKBeyTjKFeJuob0hxCVr/bvUhD8TW0EceG563gnGjiAUAJphPn4om2yNFvZyqjnnInxy37ZykZ8ZGLqXpq6IkE6B2KSVNogDhkNCo5WASgm+clR/II9HP78O3VrIVGbnpo1wAnuhNNY3Nw+LLJeoFmceIJzPsvh+bgyHVrJB6LYbk2Pf4KkzJtgMqgCrpsYqbBNqp8FjdhBehY56htYaAXRBegAsr7xEshqgNU+RGtRmY2Rc/jmUaMY0kgs8+xEo/cg3qvVu++opTMJB82HzpW8HuikvTF3r49wz9Hp1JXzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxCPStkbHqjm73kEpBcSBo/EeEwYezVKj2LaMOc7W4Q=;
 b=dPch4nvmDixkig3Y86dfubW5+A6dh67x3N1vZx5t1MDLARtflaWAxzbmx4PH0nNh3GNeX6GA8acfau3uFZfUt8LQpcw4WibGmtPadI4LmCKtA/B4y8EHe72hABS13Hmanfh7Rm65WTPNXjc0foSCqrk3PsAbyK7YyoK1gso+i7E=
Received: from DM6PR17CA0024.namprd17.prod.outlook.com (2603:10b6:5:1b3::37)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 11:48:32 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::66) by DM6PR17CA0024.outlook.office365.com
 (2603:10b6:5:1b3::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 11:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:48:32 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 06:48:29 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v4 05/12] amd-pstate: Add support for CPPC_REQ2 and FLOOR_PERF
Date: Thu, 26 Mar 2026 17:17:49 +0530
Message-ID: <20260326114756.20374-6-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326114756.20374-1-gautham.shenoy@amd.com>
References: <20260326114756.20374-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 208b4ac1-873c-4f72-e20b-08de8b2d9ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9uSX6yYCzyPlLiI2r2Kfs5+l3TP2bS97SYHtstM2rCBReTJD9L3ZhZIU0durEgBZ8MuDcWjmOwsCvdXwrFkmZLKKO2L3PVClSY0mjViMgiNRD/H6yimHBXfcMUD2PDzAgtTcbvuI0ieh5IY5PyJ8vDC0SdCVZdq1t8z391MxM40QY0bDIfuDArPpj6Mcmc2ywH4GPbq6Cq+24X1N0bIKxSTibSkS8TpQzUl94XIRYOobR2PkyU9ooyZCrtd+okTgCNoFsl7hIkCmvnr2uIqeQjLuVIejpVDmcvmcJa/jt8o/dHEE6Nq735o93MK0/iNB0+YVTA3EwSZ5n0y13RcvgmFjwRZgYMkkh2mg5pOL8Eu/4nLDci7X5rcr/omCvSAlIDky35FNwTfdICwfOvGaFxiZLGnEywp1hhZMSTQonIQuzrzICKoBJIHGzHSznjIcT1POf7YhmiwLjNGt2DpeGguDnHWY6hT+1PYQVlPvsZfTnQzyl6Hqz59puastFA9INib+Qsi46+BmWypDnuGbcGcTPr+QMIg3r2naXWcmc6YV0gx/Wzrts0/hFpruBhRsBLwAV5DnFmjTwY4wz++/9JYKqN8DpCfFzzplsYW97hQhVrXLcL0ZnHnPgbBNMUIsGKNq7sGBo0eUZY5UiklNPsZQVNDUrnxb3CU5tSKgI7SXo3l0C0QWPKLuhy4KzXM/ApFm2JcxRe4dAIOWkPHCyizWy8itMf/3Rbz2nK9e0G3p6ZUMIKAVBuwcf3DeB1gq2IZEIk7jWw6/tT6CNtTVKg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(13003099007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7i9TTs/Px8aKSv/htY6qPS0uiraVmifdYvVnL3+11KcIYPGwNcy0D3xnSvdUrl2y+p0toRFvVROqraopVEc/jpRTI+fTjOpajHzPGw+aX/8VtpZv2UgD5ziyzQBHxR5SZZsyW3b+u5wEIzT6zZrJ8jLzw1EG8YcU7wgY0yYYG8gpFfIR8sHCYKtDRNR1aOo2+UOYbpcANdHplM7O1lKzC56rNnsdEhpM5v+62/auNXJLQk1mu5UpelRCgZdxg8yLN+wjk0cSGqg+2tsj2OK0ZAg+DtuVIRLWkAsK23yWU0C8MioEKjNpwSu2EdG5S7dcchR6R40es28uilinvaetCLtkNfCG0F0cJa95k+PnFPatT3KCeVkUiUQ7i0J3QluPO0ZXPtHehW1uhD/CULK7QrSTTs5GmocFth1lgk0A8JbHGSVvBWxLtKStbiDyZN+W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:48:32.0262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 208b4ac1-873c-4f72-e20b-08de8b2d9ada
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408

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
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 arch/x86/include/asm/msr-index.h |  5 ++
 drivers/cpufreq/amd-pstate.c     | 78 +++++++++++++++++++++++++++++++-
 drivers/cpufreq/amd-pstate.h     |  8 ++++
 3 files changed, 90 insertions(+), 1 deletion(-)

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
index cb45fdca27a6..303da70b0afa 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -62,9 +62,14 @@ struct amd_aperf_mperf {
  * @cpu: CPU number
  * @req: constraint request to apply
  * @cppc_req_cached: cached performance request hints
+ * @cppc_req2_cached: cached value of MSR_AMD_CPPC_REQ2
  * @perf: cached performance-related data
  * @prefcore_ranking: the preferred core ranking, the higher value indicates a higher
  * 		  priority.
+ * @floor_perf_cnt: Cached value of the number of distinct floor
+ *                  performance levels supported
+ * @bios_floor_perf: Cached value of the boot-time floor performance level from
+ *                   MSR_AMD_CPPC_REQ2
  * @min_limit_freq: Cached value of policy->min (in khz)
  * @max_limit_freq: Cached value of policy->max (in khz)
  * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
@@ -87,10 +92,13 @@ struct amd_cpudata {
 
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

