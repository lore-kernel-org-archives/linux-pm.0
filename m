Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011061.outbound.protection.outlook.com [40.93.194.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA185190473;
	Thu, 14 May 2026 19:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778788160; cv=fail; b=dreKeiM9f54+XhLjJ+aL+eMJrTjbcjeNDANc/xwmretAmGYm2FDlcSU07Y0+/2JBi7wqX06HdrqA4o2TOiYT2UiETBP2Bkj15N06dRJ41lh0veGInbhHXOgqSJvhFqPZbfVIEvf4iKTchEka4oXdgyPGL0gh5tCIgNblrf8QWks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778788160; c=relaxed/simple;
	bh=UDjT0sYslkljTX+bvfUoxBA/7IRCCMLnJxqzUOUSwCE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXZcSwfJJ1UDR/uytmMIJEwnhNkl13mK5YtgwwBYtpRSzgUTGycqEL41PW/Dlc0S3t1rDD7a14Pzn2JjeOxuyU2v24uxPPrloamLMi6fTpSzJvRyixHuAIXwQ3vYP0pbc+wulVnFENv6XDh046vDA+qVDz5GV3vi44hbnfhilS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZVrdjsmw; arc=fail smtp.client-ip=40.93.194.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZVrdjsmw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyCfppCCUthkXMqASDBctL5cgLNAN6IaQg/piUQfBejkXrJfu8FNEc+QUBfxRwjFS91ZiU84fT0JAbIJ4bazdAnVdH95bpRLzej5w79TDV2e9cDYgjH4y4viobn3ZK0BIGH7VUjftlPm5cNXvP5yN1s+GGsQAAtQsilqxaRpwN1SN05pVv+LL+mmeP4h3Ecoulm5IMBbGR2l5FEscxffc/WDsFBT36ke6XdLgCfFMpjKwT6l8ROzFQLqY4wUgDcvRD7TI+fN8PWteiGuvVP3pUR6nFXwfUSPN52B7ugexYj/vqfrgmoYQ+63zoFd1TE4PXQaJHDgfBvGzZjNbejS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyNXfqRBdM9q0HbNnPCSzvP4YZs6gm+n2GSuH9dY7d8=;
 b=Dw18oFNByNNv6cdHWeUuG9NXR0fHri/FYhHDK4jbJg8vW7WmsPECRnRlqktpUi0tmxgZj5N0P0mwUHPI1YLONWNhAZX1b07H6TQ6zsqPfSQ7gAyuEps+Sss+gY40olsjK2pouYGAlsIx6myHAOu3pBDXtikzxY9BgqxbSG/Hn732faKq9lAn1O8VMDv3FJoA8LV1N3gy9VtjWTikKUDiG1Yh8eNHpOBecKIhCn8dvz0ctoaSs+abmeWm/lQTrN4ki1i5XJV5cGO8XQ80aXN3PuWEfoaazu+kT5wAT1M8oHayGpSrwhpXZHAiBP7bI00TMFBM1We5zbV2eKyO4CszuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyNXfqRBdM9q0HbNnPCSzvP4YZs6gm+n2GSuH9dY7d8=;
 b=ZVrdjsmwSxr3z/mmExBE1kR35Im1bXKach7cBdd619sJhdrRUEDY0zbFXTOlsZPbOduTvWx6awYDqdebx7TFfD1P/Q/Sx9BhoVTeC/9p4UgocOyoiALDiPmvNNLIdySr2qKKN25XTUY23doHbvGe3f0rVW79xPWTyhoyowxCiPaMXCUTW4+PmPnT8a/58JXIywCMJyueEeHCJEQB4NiAfrB8VCtvK0wx+c5y7Raxohe4CleAkNKr9m7yhsoNJWvmWB2P8sYCMacrKuXtYVMKE2aiVoVEgM2aGmtwFbyvk8tCEuEghWyILoglVdzWV0uwrz9ZZIXuE+3OE17cXq7o8w==
Received: from IA1P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::13)
 by DM4PR12MB8498.namprd12.prod.outlook.com (2603:10b6:8:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 19:49:13 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:208:461:cafe::b0) by IA1P220CA0005.outlook.office365.com
 (2603:10b6:208:461::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.19 via Frontend Transport; Thu, 14
 May 2026 19:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Thu, 14 May 2026 19:49:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 14 May
 2026 12:48:48 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 14 May 2026 12:48:48 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 14 May 2026 12:48:43 -0700
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
Subject: [PATCH v3 1/2] ACPI: CPPC: Add support for CPPC v4
Date: Fri, 15 May 2026 01:18:21 +0530
Message-ID: <20260514194822.1841748-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514194822.1841748-1-sumitg@nvidia.com>
References: <20260514194822.1841748-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|DM4PR12MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d4478f-3c68-4df6-d8b1-08deb1f1dfc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|921020|3023799003|56012099003|18002099003|11063799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GsAuAmrgUh/G1d69DIXTzQ4QBOft0QiAxaCYq4MvRgBHBVrSeU2g51IjvWlOApZxTm/wYMNIUF6eeKzVnqNLLkFRiNqe/TcNYkZUZdCdDnLmxh28wTEW0KXTkM27qPugnAeI/IykW2E8+fS4I7mWVwpZj4EBQIS35FXoFiL5PaQfE0ITNb6DknGJylCJzUZFDDLtDCW/75U2LtAgAmlgm6jI1X5dCXafqG7nIvgyLOZei84gnWPmw9nPg4w1MDdKYAFpBCFFVzIPVFrkPWXXl+X7F0aRtcNENckOQeoymNH6hG9QytNZjUXAsnN4cb+n1F5tmR4PGOA5dYbseVWYVUh4i3xxkLP5drt/sbNuOnEScJcDkuTcmvTBXyU/N1KvJ3Tf2caMTnx3DEFtc7o9w/R1ORAujy3VVbxmmUQegAWe5Q/XgMXTICnbGuB4zo/XM6LM6ung9QraRejAuBKZoOHEeXBXskm0Zkbp8iQ/CapPNJ+/S7mDPVH3qJbBCdJe5vVJKlaNaVZMv/uJ3BlX83graPJX9lyE2ZqqmKEISf9PdnQ2v0gn60fRDJxX+Nto4rVh4zuTcIUBE8vBcOTUInRHndfK4eyeHxeP4GqP8LY+oo5XvrFwSWxVEO+jcmWjOK0PJgXAedMFhiduWk0oLghiNxR+/nwmyAWwkHdIwJAzuwC8Z6Xh0itRmF2drzBsrpOUKWvfcnNAQPPgC1Yc8UiLuF2OB+kr+LVnxa/AnJqfUVL9N/5ohOlIwRIK3KFU
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(921020)(3023799003)(56012099003)(18002099003)(11063799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zpv4N5Gmd8jp6gXxeZPOqbD2m59EgqA1KC8ers2pACQ9BUK+/LpozIFSm8I8sOjnk5Se3+nP302qT1VrMQkQvI8HQTg1PXAIkDW7YEHZwmI5SJAQfIs68TJjvXEZHuM1F/Jpqv3CuTDrrGMqo0bKh3YJYAfaW1boS9oujQsoFuflZwHktxo8fQHsKEvH5HE7BIPOBl4rlxiCV3F9PdgGBq9aSqQ+CTlIl7ckEgQ+ho+uxB2T1H08KobnzyiNT19a871/026ZaB2fuUxGC9KPCKrhFwIPDPSTqeRx5hDjA6L2BFkH7gWY+MvpOskxwLPIzSd3HHodVo9nd4UkWhzDC0+wg7GNwHeFQo7VaNkzHS3W9CmCpXUl0Rd/SwWrxM1hdIIoQFxabIDfVZZuklf47IKNunXR1m85aJidXZtHGEcp7g3sO3bXiQ9NrrNLUVJC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 19:49:13.0808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d4478f-3c68-4df6-d8b1-08deb1f1dfc6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8498

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
Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/cppc_acpi.c | 23 +++++++++++++++++------
 include/acpi/cppc_acpi.h |  8 ++++++--
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index f370be8715ae..c76cfafa3589 100644
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
@@ -845,6 +846,16 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_BUFFER;
 			memcpy(&cpc_ptr->cpc_regs[i-2].cpc_entry.reg, gas_t, sizeof(*gas_t));
+		} else if (cpc_obj->type == ACPI_TYPE_PACKAGE && (i - 2) == RESOURCE_PRIORITY) {
+			/*
+			 * ACPI 6.6, s8.4.6.1.2.7 defines Resource Priority as a
+			 * Package of Resource Priority Register Descriptor sub-packages.
+			 * Parsing the full structure is not yet supported.
+			 * Mark the register as unsupported for now.
+			 */
+			pr_debug("CPU:%d Resource Priority not supported\n", pr->id);
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

