Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010036.outbound.protection.outlook.com [40.93.198.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA448428495;
	Thu, 30 Apr 2026 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777559143; cv=fail; b=bg7NEzqMVdzZWKECMd4XgyR+jz26Q1zAKfT84+1kqDDvsVJv4T1MlTVY3CeOc5OuHAKId3DVEep+flMn6EOZAZj1KoLlb7BBb+cXSyGCluJGN7KJsBgPhoyFkI1OWAi/MBBLQdCGbQIDP6F7gCJD55/ZdsdkRED5i7nZbgMennY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777559143; c=relaxed/simple;
	bh=GQLmu6kBx6MgVwyeyLGaJOSZZPglCqjV/kJ+t3zrENs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=freUxxnTJTaZ4onTcnsRjS/wvQShUrUl9W3oYMYWRTXbsozeJef9fc4ev/n5Zn30i0AMxb+/WhvwEss8tAY8t5pQtDxwxxQHLF25NmSGKj2IV5duoLKl6YTBpfLM8mDToj18/JEZHT+RUDMUaBSXJfWR3/UBLtQDJatno7j6qPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L/h9z/L5; arc=fail smtp.client-ip=40.93.198.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L/h9z/L5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzUtb4uJl4YCTnvAh1EknEOWFc4htNz1rxVM3w/dwgiLVIISCsGwXgWePa0pr7aor7pJ4rPEw6eXasKUja7U8S7Fz/Nq89Ii/w0vlwtUdkDwJndlsaOz2+rzMo08yOBkOe0dxwR/V9Zgis9tZo8CM33ASV9B/MI31rbmHEBzLzz4m5ZF0hBCW+mmrrGS+V6ulx+mcfDiAuLUGAIFARWQr64hHhY8nj+g/KbAr7DAs3VC7VZzi9cdmU9GSYGC6KUoPJEiua2XomPGHSRRY8XN8q93pBaR8nf3UMnGfVy/AjqKzihySSb0/1+MuDJIqUyQM565HE1gVLV3ORtQ6YhR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9P7UVqocdTWxE4EaCWAJFSFppLsyG6muG63Wo2hUmc=;
 b=KS8iAduRBb1zTaKdyuHle6qBRfRGR+VZI8NAZNggHjb7jRWe7goooQtpRZ5AlkKVEK7Bn/vqSe7xVccLl9n1ihpMlrrmzP6CmS1GOyOnYUJB5GNn3AsG5LlQfVVXjeOsX9I9kz3vW0nDoYXWQ/rnBrblavfKEscCnmWI9OOXZT3h8Ok3Y7o5lbyBbjTo63uRikaHC9q61b7mG28HTGtCk2C9qtopxEEenADamvx3yhA+9TRKE3wPy++cGQpzZhNPTWxuhgYA3xtEh8Dc6ceHUAAa3rJ2mf/6QzdflE/pPCNzgm4/vQ600nsLWIrNGHzDKy9bJv8sGzP2mhBsO++0TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9P7UVqocdTWxE4EaCWAJFSFppLsyG6muG63Wo2hUmc=;
 b=L/h9z/L5FirG4unEVfZTWMJLZfTASRGCJ1he1NrIT2ORG5dJza/7cULhWuKcHoqsZXvO2C3Eh4DhCKodPOAkiZCTaExLES2K4KheO1NWR/V6M/lkrYt6ZJS/TQQS1XWDC9MJu6EEuy25Xm6eXeBBSh4r7BmLkzzCs4SqZsvP9zH2CP+meiRHwG7TLyd6xVwoFZWaTq/nT/Ry/wHFG1TEZK+SQaFXoXRiaydsiSvoZ0edM7I4NMZ/by2nKr9SIscPNSr52reL92/gw/NjNJJc6j2uaYvoAeDeZS32N/7rnDnweSaDyxwB6ZTFt9DLfo7C5MmBPuulad4IgwSuihMDuA==
Received: from BY3PR04CA0004.namprd04.prod.outlook.com (2603:10b6:a03:217::9)
 by DM4PR12MB6206.namprd12.prod.outlook.com (2603:10b6:8:a7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.20; Thu, 30 Apr 2026 14:25:33 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::d1) by BY3PR04CA0004.outlook.office365.com
 (2603:10b6:a03:217::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 14:25:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 14:25:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 07:25:06 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 07:25:05 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Apr 2026 07:25:00 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<pierre.gondois@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <mario.limonciello@amd.com>,
	<saket.dumbre@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v2 1/2] ACPI: CPPC: Add support for CPPC v4
Date: Thu, 30 Apr 2026 19:54:29 +0530
Message-ID: <20260430142430.755437-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430142430.755437-1-sumitg@nvidia.com>
References: <20260430142430.755437-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|DM4PR12MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b74573f-b946-4225-82e6-08dea6c45650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	OufsI079VM/YcIcZYCwL02ZfxxqGipJTbg3wweJcSbSobFlEb1khBSodaC7o3tEKZQf3bivm/ZpHt93eOOnV8kt7NPiOELS62AURqlxnUXM8WQUKA1j9nBkfyN2klBPnj+P9iUtDj+fcVpnvGMWjtFh0+Qg++psHOrFSyv7BOy/8HWNMDH1vn61142CqCRm8HDgjwcPo8YTupQJWuKBUWL5xtFFGhkK8DtSyJ4IrXii0CBRVcltW80cvnwSqAScMofbkJ+wp3q7aHr55MfY5wakIseFbM/QhQkGuy6oe2SLAW9GUw5KL+rhxu2IHKPT8vrBeXD4uQHPYMi0hgk7SVV0CNTQ/L+GcxYRSzNFYHjW6hcxwE5Fc0KCdbA6R6bA+lA3hjNNibuMIFgQq2nJj0qPMUHxyKNppkFi3myenpOof70r1ITsju++rcifcII3k54j5CNRq5LdmzFVvjLaIX9oX2ra8WsqR2F9f2aB1rZs54SRrRMLhiTi7W0dGEwOVhAWc08rh9L5IKExubT5eieghVCusJuZHQBSTFvQY/si7IG0tH0Bw9Ct5yaxcF8wocBzOCydCKwBrACBB1+sdFBd4AC7bxSTzaZX2EgOzRmuk94RtfbmUxIJHQ7jCFZfNL+7kMpPVGK4UwCr9Lsyy/A3bFvzBVaAZmg12FEJphcdcBVoymSJ7sNf8pRfFPG96dIVwaKgtmZyyEAND+EIIrSxKEuvu1F9bcg6enTU1KJ4qsuSVSlvu1ro6ocv8AFJwqUxSxuH3rGs3X8FwRra//zsKpOff0971Fl/bnSgKr7H0M8PQYjTB3o+Q/t/oOY+L
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LLbCW+zg0DcLrYJoXe5FnMJe95FEjrB8N7XKEQarUd2cgsaGNLRDLN5P2gr049zRP95IVF7ZlrN0UE5EHWa4EnhUCDEhiT7ouqLuzV7ZyLb8Po5GJWAaE7plEVzU9Y2gEQC+N/Q1ZPNkwBNtZ0rtjOiWbC3534eDSOsfoICURoTSeld9zxd9P5tFqoU4Z+3aIRSchMsdwdTWRDudvvG3IOtZiwpsYfuLQFc4jzpDyiMk5p0T6hdRbad5beklwMOFcUERjJdX4r+AGuDzP9ilU0DIRZ7IyicMsubE33fE/Em0bvHy3Yz4I44wuldMoJkQCs0pRc5X+Ub6Fy0E/89SryXZNr4Fk8SJztZyk2EH5jeDco5xUpIuz0VqUvk5wc3J/xjAV/yGZdtKSD4VJVnO+sjml2XIsJg/08eeuk1Yq+Za4Ja1Fu2PRu6imlb/cKdO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 14:25:32.3559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b74573f-b946-4225-82e6-08dea6c45650
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6206

CPPC v4 (ACPI 6.6, Section 8.4.6) adds two optional entries to the
_CPC package:

1. OSPM Nominal Performance (8.4.6.1.2.6): A write-only register that
   lets OSPM inform the platform what it considers nominal performance.
   The platform classifies performance above this level as boost and
   below as throttle for its power/thermal decisions.

2. Resource Priority (8.4.6.1.2.7): A Package of Resource Priority
   Register Descriptor sub-packages that allow OSPM to set relative
   priority among processors for shared resources (boost, throttle,
   L2/L3 cache, memory bandwidth). Parsing the full structure is not
   yet supported; such entries are marked as unsupported.

Add v4 _CPC table parsing (25 entries) and update REG_OPTIONAL to
mark the two new registers as optional.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/acpi/cppc_acpi.c | 24 ++++++++++++++++++------
 include/acpi/cppc_acpi.h |  8 ++++++--
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 2e91c5a97761..a1c91ce20cc8 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -134,7 +134,7 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
  * cpc_regs[] with the corresponding index. 0 means mandatory and 1
  * means optional.
  */
-#define REG_OPTIONAL (0x1FC7D0)
+#define REG_OPTIONAL (0x7FC7D0)
 
 /*
  * Use the index of the register in per-cpu cpc_regs[] to check if
@@ -751,18 +751,19 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	/*
 	 * Disregard _CPC if the number of entries in the return package is not
 	 * as expected, but support future revisions being proper supersets of
-	 * the v3 and only causing more entries to be returned by _CPC.
+	 * the v4 and only causing more entries to be returned by _CPC.
 	 */
 	if ((cpc_rev == CPPC_V2_REV && num_ent != CPPC_V2_NUM_ENT) ||
 	    (cpc_rev == CPPC_V3_REV && num_ent != CPPC_V3_NUM_ENT) ||
-	    (cpc_rev > CPPC_V3_REV && num_ent <= CPPC_V3_NUM_ENT)) {
+	    (cpc_rev == CPPC_V4_REV && num_ent != CPPC_V4_NUM_ENT) ||
+	    (cpc_rev > CPPC_V4_REV && num_ent <= CPPC_V4_NUM_ENT)) {
 		pr_debug("Unexpected number of _CPC return package entries (%d) for CPU:%d\n",
 			 num_ent, pr->id);
 		goto out_free;
 	}
-	if (cpc_rev > CPPC_V3_REV) {
-		num_ent = CPPC_V3_NUM_ENT;
-		cpc_rev = CPPC_V3_REV;
+	if (cpc_rev > CPPC_V4_REV) {
+		num_ent = CPPC_V4_NUM_ENT;
+		cpc_rev = CPPC_V4_REV;
 	}
 
 	cpc_ptr->num_entries = num_ent;
@@ -845,6 +846,17 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_BUFFER;
 			memcpy(&cpc_ptr->cpc_regs[i-2].cpc_entry.reg, gas_t, sizeof(*gas_t));
+		} else if (cpc_obj->type == ACPI_TYPE_PACKAGE) {
+			/*
+			 * ACPI 6.6, s8.4.6.1.2.7 defines Resource Priority
+			 * as a Package of Resource Priority Register Descriptor
+			 * sub-packages.  Parsing the full structure is not yet
+			 * supported; mark the register as unsupported for now.
+			 */
+			pr_debug("CPU:%d entry %d: package type not supported\n",
+				 pr->id, i);
+			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_INTEGER;
+			cpc_ptr->cpc_regs[i-2].cpc_entry.int_value = 0;
 		} else {
 			pr_debug("Invalid entry type (%d) in _CPC for CPU:%d\n",
 				 i, pr->id);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index d1f02ceec4f9..8693890a7275 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -17,16 +17,18 @@
 #include <acpi/pcc.h>
 #include <acpi/processor.h>
 
-/* CPPCv2 and CPPCv3 support */
+/* CPPCv2, CPPCv3 and CPPCv4 support */
 #define CPPC_V2_REV	2
 #define CPPC_V3_REV	3
+#define CPPC_V4_REV	4
 #define CPPC_V2_NUM_ENT	21
 #define CPPC_V3_NUM_ENT	23
+#define CPPC_V4_NUM_ENT	25
 
 #define PCC_CMD_COMPLETE_MASK	(1 << 0)
 #define PCC_ERROR_MASK		(1 << 2)
 
-#define MAX_CPC_REG_ENT 21
+#define MAX_CPC_REG_ENT 23
 
 /* CPPC specific PCC commands. */
 #define	CMD_READ 0
@@ -109,6 +111,8 @@ enum cppc_regs {
 	REFERENCE_PERF,
 	LOWEST_FREQ,
 	NOMINAL_FREQ,
+	OSPM_NOMINAL_PERF,
+	RESOURCE_PRIORITY,
 };
 
 /*
-- 
2.34.1

