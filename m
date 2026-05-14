Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E217D3CFF75;
	Thu, 14 May 2026 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795818; cv=fail; b=Kf7VzluSZyq8hOllHAA7dOJ8iMOa1ffvKyNBtoyGv3W9tvuQHDvLSmjLrcF9rHYV0wXUaKH+CbmaTHRM7BBQ4OMghP84OWePuGQcPMkmAVDiBWY4UTQ380o06+W86sLJF3k96ZhHEJsZ+7u5FJpic4lAZ4R6LPMvIo1hCd+asZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795818; c=relaxed/simple;
	bh=zbamKeOKSMgAcoYm6qDK2tLUZCLbcWUrpTUUJwISA3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEexJ0gdSUEoOuDbf3kny8jaxmEy/jxby6X0h+ZkiyjW9cTD0K1fJLRQP+JFIAQAwKR8uC1BhelbVNw76iuPqedaDT0rIpW1BTV6a/8pH9N0E34iJ/QTlwqTVC2BaFccS5H8SWVhdm+R5Xz7XWzBxDw9VsRpK3EWv64iJRodB5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ohnIpMth; arc=fail smtp.client-ip=52.101.46.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ohnIpMth"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuxTf9k2yp3a5fwu7bQHOTAGBLBKJWZ1BWx0u8aWug0ZwGiBp0fYJJFHXJ4Y5Kj1EWqviKYM6PkV8w9bZifU8c6rE1dI1ahzjSbgMcSZ6dtLsS1Gn7kV4ysJs7ZKLmE7MRtqLqw7/fjwauPEgPauoD7KPkFdN/mxbuKAjDS+N0IfeJUlbKx8aVCknIER0GYXiz7Lwgvmrh+k8KDZ9OcLEoEYV/M9F4qMbLchHDXcatkIVnT/wiQSn+VxN/0zLpMADoqsVKn8MCsztV9gTMaWjhx9fvF3w6aL16u/2r/Cfou0M2EkCw46S3RUNrtHlD8FqDvQBW4vLTb7dk/WGKIxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIn0DdGD+iz/INFdkv0amtRpN8Rv5do3IeKwO2rH4aY=;
 b=ScifATzGkj6oFdfkPi5/oVq8zb4q2N+e9qtjPZekwMFsmCqZ20o3TgVEZWeT8CT5HsxLQh/zVAE96jJzppPyHgNIIymazu4CImOXktZuSbEDF+tj2GyA8VGlAYAFDzfJu6Lr63eTKEvH59cQIBSx6E+tLWgua5a4XlQaN7R0ifayrQI7ZegF7Y0ks7rV5YK6TrlmaN2YRmob5XsDKB6SNbRFSfgS/iwAzNLWpVrJnthObGhzPyxtLVMDBA7Mxek1LSC/1EyF3UtmcmDeTqvOqmz2y1t70QfrvhI7X/wecjW/HtZdS//Jr3N//Pkx8oe7WjAJHV+etC8/MWvJMF4LuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIn0DdGD+iz/INFdkv0amtRpN8Rv5do3IeKwO2rH4aY=;
 b=ohnIpMthesYjTSAbr1oPFDiQMhkVdCFh46pkES6l1QJVr1wft0PeLbkHkqa03LH8g7FzdujUIjGY+dBHDaWuCT4LPWgKmS8OY2VguSylU45GvVSCH1oaWOFN1njTVgqWr6b5JOaIAjt7ew9FlwMvy3oEyZAoFvtQC2izPC03Wiw=
Received: from SJ0PR03CA0186.namprd03.prod.outlook.com (2603:10b6:a03:2ef::11)
 by CH3PR12MB9124.namprd12.prod.outlook.com (2603:10b6:610:1a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 21:56:51 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::be) by SJ0PR03CA0186.outlook.office365.com
 (2603:10b6:a03:2ef::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 21:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 21:56:51 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 16:56:48 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<x86@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 1/4] ACPI: CPPC: Add support for reading HighestFreq
Date: Thu, 14 May 2026 16:56:23 -0500
Message-ID: <20260514215626.35327-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514215626.35327-1-mario.limonciello@amd.com>
References: <20260514215626.35327-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|CH3PR12MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: 47239016-99c5-4c13-a550-08deb203b469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|3023799003|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	gm1stNtuw5OYyZOg7vSbPLG2UUEiEMIdOYqPgIT/2wAkMUL6oABIkK+noZKTQrv3VPUUo0LouRvYHWBYQx7yc3zlCa9ZDPaFRSW96bRV7c+k20dsqae0YF9WJ05U1ixeawygoXugw0cf054Za559WfjY7vNWoBMDhoaLQfYtAwN82ZgvYXorGj+ZjGe8TRiYMiAA6tnewBEw7eMRPVsi1imPKxYO9O19Y71N+TXKafV+gSGYGk8/NX9BOGLzN2rKOhk5JNAM3/wWEFL+eBD8NgFcdA/SjUjGJ/rckh6fJxYkCcx0dZZcQdmSTtuibr4eTMBdChtRQz/FpHHn8be6YIYPjjr54tE7pGwy9OMmv9yCy8toROq50ePhbzYbNAc4XIyVQ/k9Wa1+TsuvVWxMX0zHAiC2tMRoBpHuSSOSichJyUPWvY+YNTpdB9AQXOltxG9emG8luME7a8uOFZ78PVtqydXXzMElO9mkgEGqabOaud7E+W97a/9AyLk+OUkLEUFXbqH6ZzBNK7BQO1Tr0A59GHAh9TUfOG4Iu4EziIpRxUImXIVWIqByD5hyjekkpDVTVZ9jspf/4auaXZYzhZmVd4KQ5yS3nOjgLarmHyCQ+UAZh9FonkNHBLRVhiFU53q5uoinnFwQXa8NNU55kghL9CCYEpORNuMLxp5M2iR2Z6Y/yfhXGRAs78QztzS2vuO6oHEMT3yCJAeHv5kPJIdK8m/jXXw6s0WshyR6fbQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(3023799003)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y6+mmKuOppQTH1dbSGJB8xqGJoufYBR+60Q4zlYC9G2wNdeKN/qaObO6LWOJ3kIESO1HddE9wfQaXo6Ixl3OPqSBYRx4kWmF4BCrCRQhx9sHKnWV40PwBRTk5lQdq3e/VD+IslUJlLqi+sgjyCPqCqkJNQtAzy5A3KQS1xYdIvzwS2H/H1mqp4o8tHouIfMxN6zYF4BsCzbZrr3T+7uO0NNoWs7kKicjmqdYDwzp0+/8OmPrrNW42hFsB0TX5geGAxA8MdLOPhqzsXTcgeYfM+V2/MW5D2rlWUCP5Di5Xx4yJaLX9PieJ0xwkMrECd46NYK3qr7+iB+sw5mLkEY6ipxq+NdVNV/keFZdDBm0RGQ33BHToMJVXSvUle4hcj8FavzLpHOqaPS6ckYGqQ8NG+Uw7o1Sdn18gdgancLbCAE5ffLuBEFiEzNk3j9aaRJd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 21:56:51.3313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47239016-99c5-4c13-a550-08deb203b469
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9124

A future revision of the ACPI specification will be including
a definition for HighestFreq.  Add support for reading it.

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/cppc_acpi.c | 31 +++++++++++++++++++++----------
 include/acpi/cppc_acpi.h |  7 ++++++-
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index ad6ece16c30df..befe3e3136a6a 100644
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
@@ -182,6 +182,7 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_nonlinear_perf);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, guaranteed_perf);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_freq);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
+show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, highest_freq);
 
 show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 
@@ -222,6 +223,7 @@ static struct attribute *cppc_attrs[] = {
 	&nominal_perf.attr,
 	&nominal_freq.attr,
 	&lowest_freq.attr,
+	&highest_freq.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(cppc);
@@ -756,14 +758,15 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
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
@@ -1364,9 +1367,10 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
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
@@ -1383,6 +1387,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	reference_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
 	low_freq_reg = &cpc_desc->cpc_regs[LOWEST_FREQ];
 	nom_freq_reg = &cpc_desc->cpc_regs[NOMINAL_FREQ];
+	highest_freq_reg = &cpc_desc->cpc_regs[HIGHEST_FREQ];
 	guaranteed_reg = &cpc_desc->cpc_regs[GUARANTEED_PERF];
 
 	/* Are any of the regs PCC ?*/
@@ -1390,7 +1395,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 		CPC_IN_PCC(lowest_non_linear_reg) || CPC_IN_PCC(nominal_reg) ||
 		(CPC_SUPPORTED(reference_reg) && CPC_IN_PCC(reference_reg)) ||
 		CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg) ||
-		CPC_IN_PCC(guaranteed_reg)) {
+		CPC_IN_PCC(guaranteed_reg) || CPC_IN_PCC(highest_freq_reg)) {
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id\n");
 			return -ENODEV;
@@ -1453,7 +1458,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 		goto out_err;
 	}
 
-	/* Read optional lowest and nominal frequencies if present */
+	/* Read optional lowest, highest and nominal frequencies if present */
 	if (CPC_SUPPORTED(low_freq_reg)) {
 		ret = cpc_read(cpunum, low_freq_reg, &low_f);
 		if (ret)
@@ -1466,9 +1471,15 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
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
index 0b1dcdbea10a2..eb1eb40c6cb8d 100644
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
@@ -113,6 +115,8 @@ enum cppc_regs {
 	NOMINAL_FREQ,
 	OSPM_NOMINAL_PERF,
 	RESOURCE_PRIORITY,
+	HIGHEST_FREQ,
+	CURRENT_FREQ,
 };
 
 /*
@@ -130,6 +134,7 @@ struct cppc_perf_caps {
 	u32 lowest_nonlinear_perf;
 	u32 lowest_freq;
 	u32 nominal_freq;
+	u32 highest_freq;
 };
 
 struct cppc_perf_ctrls {
-- 
2.54.0

