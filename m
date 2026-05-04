Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D2D38F934;
	Mon,  4 May 2026 23:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935722; cv=fail; b=sfllhMSphoyQxuysZ40eHQWO6rhkk2rWB+BM/cCAHXoTksUGPD/Y2gRbBNhkZmD/t7KhXtkd7CsU/0RokPY9Wz7UVeNEeFNocaNY5gg6wwuiqcirLg3dNzTyOzojD+SVcNI4EN8jHJzwzvI1eKl4+WWptk4ZqMz50aa3+gLYl1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935722; c=relaxed/simple;
	bh=nPBEEZTPOv3WynOxeYpY1MkrATCBomPUZLPqzdjCYxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+EsyJj0FanXx9t1xtp0FUmrZ9sWhvgyCXMHrKLdbPH57CbtJhI7/pjDVkrdkkwJ9fK5WajN6OKBHZcOu0Q0Y9vCudCyZd1VYsHOIWXffM1+lHDEpZeOf1oYLwaCvf221iAYxKFGZFvez3159Ruj2+sQmJC3vDHE/zOpbfS9fKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nn5tVfOS; arc=fail smtp.client-ip=40.107.208.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nn5tVfOS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVmpafgd2ZztutmM2BEWtTS/uIVVBGYyf+20eH0S5juwQu9vv2y3FFObRkFK44kk9l/kHfmFNywdzobgT1rTuoG9pbEoptGTVkp/H6qgYSdchriiN8tijgn4SoRNx3zxVcxW9aUUTdcUGrayAErKG83rCvWr82m1qeql7ETwWUojVBkeiS+ncq3CqoxFT3JjPtkJK/P6+WU+kK7rCAexBD+dq9V2JeOsCDlH6J19MyCpzKQKLzd3SW/N+6gAZRW83BsWnupXdKja2O4l1O4uoO1PkEpQovrh4B3V034iezHSkK9kij/XJ8i85edh00od6+lCzlkhz+zy1FY5KwS6HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyrvObeUSRIQLXRlYKPn+8bDiJE7UsgiK6XHN0T7g1g=;
 b=ZWqx3Un8/9WjRejaF+t3fTT4miKsllmm35RO4yWjkW4gb+ZxJEAxGIs+j8DWNWjqCSzTjst/IoUMc9JW0jr0uQvt7bbJoPGhGW19mbX4p8+iOHonN3xVBqjVnDVKYqVp2nccUulgOJ/YKdsJRIm873KlEVYuPB5NVurnWKZkZEVoIs/A6Tw3PXxPfao+GIA1ZzBu3jf9DYEYewPeBPMHnZs83lk2jEq6GvrXdq0xQ1oA31yL5BpyiDfDJC4hzXfM1UreOa/teiT0dIs9RvnEZcizu0SmAjTWHuHE6+UepS0s24umqdRSVEdXC4lWGxkKS1G9m20cH44yuPNQsdBtNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyrvObeUSRIQLXRlYKPn+8bDiJE7UsgiK6XHN0T7g1g=;
 b=Nn5tVfOSwxTAVPJCCCBUt1JMNeNxujV+mA6FlwCfDDtiaSplrrPoqMQdJ3iqSeU70hnescxEplM7h+Ohobdg+MqM8RLTjNIOpQCG0wiKPcV4l+TtpctHU2UwjZWR/FQwKV8oi04GOz+Z4XuxGgDWPg+Bu5lwCAkzihmfeydNqqg=
Received: from MN2PR22CA0008.namprd22.prod.outlook.com (2603:10b6:208:238::13)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 23:01:53 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::3d) by MN2PR22CA0008.outlook.office365.com
 (2603:10b6:208:238::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 23:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 23:01:52 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 4 May
 2026 18:01:52 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<x86@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 2/5] ACPI: CPPC: Add support for reading HighestFreq
Date: Mon, 4 May 2026 18:01:38 -0500
Message-ID: <20260504230141.484743-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504230141.484743-1-mario.limonciello@amd.com>
References: <20260504230141.484743-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea33ac4-078c-4b1f-d962-08deaa3121ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PU3JDYYwgpqG6NDqoNqoCyWNYNAJh/LOSz0wyZKLi2otjzLtPMYVzSKuWd5lxa9od2NTahAVXVWRawNxepBSCCc5pqwmZqe5x1iDP+YiciSxZUnNFJBJ9Ku2Cah0eu95xtg/FhUhTCgZ9hNfsbOuLpZOIRUfkuQ5AxWclEfdzP+PZmn+yTzFahmDQ3YZkAPe/x1lEqScrSewaWlorRES16E3+fqdXVgvAWeVw/WBGCUq7owJGLhx6ICWOX333C9qKSV1OcEh6XwDgtHiWRM9+hAZU/F9yV+TMTaRhR2M9BG+dGOXDEAxa5SeNJSuJdrnxCOwb2N3BPP5ApuQM+BEC5lLh/D6bsuOqQlZcjaY6lxbJBQrdMp9JudhAnaj/iEF6VZrQCze4Y3ylvyDXh5K48dtMYgnFtsD6Irl7ATeOXYujKSPfqgtNi8FjkPqB4N4JPwse/VGEG8/Yz4PnK8IpW7aYxGEdsUL/eQ9yAB8iO1Oph8/3M6WN8aEI0gZsbxkHWY27Q1Sls7ltiE8iAJXKWDyCBXcjZ3Ui3cTgdDnl/BgcPrQWb6UY8oa6CVEtcPzQ219kdhuJhtPkdOkBqfkmLVXgudeAIOJ5D6LRa/ApAkzzNJ+zUA5ICaaqEj7W32ItEMegexzWjWsF2o0vp00vVWYBs/sRFQboZvEooEkwyVVAMPV8kAxyemX003FFkcuNpYBvt3NzvsHoV16aU/8aV6Ex8nh4fySyW0mv89M8cM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RDl8LviSh58AdjDBlKwniQP8zPltyOPr95u2FqopgdH1EmCbboN5F4zfcz8+ztVR9UE/W+1lttbvpSoVRlVKXETgFJlwTrMROWTbBIeUqFBugXZWEMnccOVLgy1n8zcMyDSNa/T2kuQAzJ58K4HR2T0Gcw4pBiLLH7SmAgLHP5NfZLsPozCUfFoJLKJ1Rm+mewGKWS9jhyj879yikAGvQVhjwcBCkJoj9B+Q8RQ21HyQlpm6yXBGvB7/a63FUtAMp8oFQWJP7q8Z9lCtNt5BEH/pW/AdThm54k/6G8bJljJGB96g9zYB9EpxnCgirtcvt2Mf6TuvDciqgrskwgfEE70u3iCDzaS/HNHO3DNmI4GQbQHEabyRbwcE1z+xRYgIHrDrv7Jl7xUoZ6rnTxV0qtRrb2pWOXEYKRbwWxyJAKE+LLNyiE2/e7GpKS2teZAf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 23:01:52.8790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea33ac4-078c-4b1f-d962-08deaa3121ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440

A future revision of the ACPI specification will be including
a definition for HighestFreq.  Add support for reading it.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Fix optional register mask
---
 drivers/acpi/cppc_acpi.c | 31 +++++++++++++++++++++----------
 include/acpi/cppc_acpi.h |  7 ++++++-
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index fbc620adafad7..f96a83b58072b 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -134,7 +134,7 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
  * cpc_regs[] with the corresponding index. 0 means mandatory and 1
  * means optional.
  */
-#define REG_OPTIONAL (0x7FC7D0)
+#define REG_OPTIONAL (0x1FFC7D0)
 
 /*
  * Use the index of the register in per-cpu cpc_regs[] to check if
@@ -186,6 +186,7 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_nonlinear_perf);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, guaranteed_perf);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_freq);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
+show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, highest_freq);
 
 show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 
@@ -259,6 +260,7 @@ static struct attribute *cppc_attrs[] = {
 	&nominal_freq.attr,
 	&lowest_freq.attr,
 	&ospm_nominal_perf.attr,
+	&highest_freq.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(cppc);
@@ -793,14 +795,15 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	if ((cpc_rev == CPPC_V2_REV && num_ent != CPPC_V2_NUM_ENT) ||
 	    (cpc_rev == CPPC_V3_REV && num_ent != CPPC_V3_NUM_ENT) ||
 	    (cpc_rev == CPPC_V4_REV && num_ent != CPPC_V4_NUM_ENT) ||
-	    (cpc_rev > CPPC_V4_REV && num_ent <= CPPC_V4_NUM_ENT)) {
+	    (cpc_rev == CPPC_V5_REV && num_ent != CPPC_V5_NUM_ENT) ||
+	    (cpc_rev > CPPC_V5_REV && num_ent <= CPPC_V5_NUM_ENT)) {
 		pr_debug("Unexpected number of _CPC return package entries (%d) for CPU:%d\n",
 			 num_ent, pr->id);
 		goto out_free;
 	}
-	if (cpc_rev > CPPC_V4_REV) {
-		num_ent = CPPC_V4_NUM_ENT;
-		cpc_rev = CPPC_V4_REV;
+	if (cpc_rev > CPPC_V5_REV) {
+		num_ent = CPPC_V5_NUM_ENT;
+		cpc_rev = CPPC_V5_REV;
 	}
 
 	cpc_ptr->num_entries = num_ent;
@@ -1402,9 +1405,10 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
 	struct cpc_register_resource *highest_reg, *lowest_reg,
 		*lowest_non_linear_reg, *nominal_reg, *reference_reg,
-		*guaranteed_reg, *low_freq_reg = NULL, *nom_freq_reg = NULL;
+		*guaranteed_reg, *low_freq_reg = NULL, *nom_freq_reg = NULL,
+		*highest_freq_reg = NULL;
 	u64 high, low, guaranteed, nom, ref, min_nonlinear,
-	    low_f = 0, nom_f = 0;
+	    low_f = 0, nom_f = 0, high_f = 0;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
 	int ret = 0, regs_in_pcc = 0;
@@ -1421,6 +1425,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	reference_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
 	low_freq_reg = &cpc_desc->cpc_regs[LOWEST_FREQ];
 	nom_freq_reg = &cpc_desc->cpc_regs[NOMINAL_FREQ];
+	highest_freq_reg = &cpc_desc->cpc_regs[HIGHEST_FREQ];
 	guaranteed_reg = &cpc_desc->cpc_regs[GUARANTEED_PERF];
 
 	/* Are any of the regs PCC ?*/
@@ -1428,7 +1433,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 		CPC_IN_PCC(lowest_non_linear_reg) || CPC_IN_PCC(nominal_reg) ||
 		(CPC_SUPPORTED(reference_reg) && CPC_IN_PCC(reference_reg)) ||
 		CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg) ||
-		CPC_IN_PCC(guaranteed_reg)) {
+		CPC_IN_PCC(guaranteed_reg) || CPC_IN_PCC(highest_freq_reg)) {
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id\n");
 			return -ENODEV;
@@ -1491,7 +1496,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 		goto out_err;
 	}
 
-	/* Read optional lowest and nominal frequencies if present */
+	/* Read optional lowest, highest and nominal frequencies if present */
 	if (CPC_SUPPORTED(low_freq_reg)) {
 		ret = cpc_read(cpunum, low_freq_reg, &low_f);
 		if (ret)
@@ -1504,9 +1509,15 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 			goto out_err;
 	}
 
+	if (CPC_SUPPORTED(highest_freq_reg)) {
+		ret = cpc_read(cpunum, highest_freq_reg, &high_f);
+		if (ret)
+			goto out_err;
+	}
+
 	perf_caps->lowest_freq = low_f;
 	perf_caps->nominal_freq = nom_f;
-
+	perf_caps->highest_freq = high_f;
 
 out_err:
 	if (regs_in_pcc)
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 3771e2ed507de..053ea67f767ff 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -21,14 +21,16 @@
 #define CPPC_V2_REV	2
 #define CPPC_V3_REV	3
 #define CPPC_V4_REV	4
+#define CPPC_V5_REV	5
 #define CPPC_V2_NUM_ENT	21
 #define CPPC_V3_NUM_ENT	23
 #define CPPC_V4_NUM_ENT	25
+#define CPPC_V5_NUM_ENT	27
 
 #define PCC_CMD_COMPLETE_MASK	(1 << 0)
 #define PCC_ERROR_MASK		(1 << 2)
 
-#define MAX_CPC_REG_ENT 23
+#define MAX_CPC_REG_ENT 25
 
 /* CPPC specific PCC commands. */
 #define	CMD_READ 0
@@ -114,6 +116,8 @@ enum cppc_regs {
 	NOMINAL_FREQ,
 	OSPM_NOMINAL_PERF,
 	RESOURCE_PRIORITY,
+	HIGHEST_FREQ,
+	CURRENT_FREQ,
 };
 
 /*
@@ -131,6 +135,7 @@ struct cppc_perf_caps {
 	u32 lowest_nonlinear_perf;
 	u32 lowest_freq;
 	u32 nominal_freq;
+	u32 highest_freq;
 };
 
 struct cppc_perf_ctrls {
-- 
2.43.0

