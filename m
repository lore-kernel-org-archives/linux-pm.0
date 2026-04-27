Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4652222A9;
	Mon, 27 Apr 2026 05:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777267136; cv=fail; b=nWT85Qjs7Az0X4F5/dXi7aWdrxqm9GJxc1O+mhtUsgOF+yPUVDhw/UvmZ7T7BsZ3enqOUW3zRfzzdecijbVv/+60+EkrRDgI/0+0x13m9vBWzAdj1niOi94xlMxrGadcZCkVdFzJGTdsp3ZQiRYzT2iD7UNgKDez+QSC++WeqZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777267136; c=relaxed/simple;
	bh=CD7VU4G1lhYTE0KH5m1HLoCL8xHihFfntZFytgCV54Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mChfBbWBcrqeFz++6przKz0s3RYmGBZ89y95qkeoDBTuR/IvFfipOhY1tiNraRwi6XyvgG7UVZG7NzdCc32jqZEhD2aOv5QROH1MwLW8fBM8ZpdmYvy7KzOqy4AZBcGSdLZY0LRYZiUUv6HmX7CwTAEHIBYqQDtHVN/Wa68HNW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rpmqehzs; arc=fail smtp.client-ip=52.101.48.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rpmqehzs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlUc317ZWJ1vac/aiQtTPbx0550fQ4vTLCCd13eueHzX1MnaUgFMFpIh1NhWZMNNaK+pO279I/tTCEbnHtAtRIReP0RbrMtiKUp/pMWtnuy4ZF6hG8KSAwDeqdgwQspJvbVgnljJFPxqSs23+JMBw/lDGpeoyD8NAbEiGXBGOIJHdvLAhEould2doTBpukaahgmJrhRoaT5WKdd+Oejyn38+ipTwM8Kc8oCxxCs1Lwv1Tzyl1FLSEfakMJD5guLHnBnU6K3fdB3F3yJuWOd1z148zD0bnqzD7hja79rwgbbJUX4hKzLP7PbiGp1IPcWkzOfpH5dgw2idhHuYCXd+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9t5bhzSULqT7rEcGl4ctRXIu59TojIXli35Nkzq2nNk=;
 b=pVSFb2zMG6tf5RF+9CCPb1hmv5TpfE6FBGMs6bFIlsPy1lYLWJY4Noufvwa6IWLMxXSA8c416NnYObx8siWbhRVH38Fj104q2W6n8i8NEMVZ8fNPYCp9OcFDgh8QxSrMtGRZRCP0IeCQgyFQcebE1C3eH3xFwEP+HC5l7UwvusDz9UlYXpLVGO+9ZTQZLq7tjKuT3v7Y4XWOhAKBHILbe7d6T2pLUaj6rSKDT1G2365reJiiV/SqMaREdW9zgqRosLhsXIloFQgYCBpMFtbP9CxzHQgVIoRQWaM1yyd4loyTnJA9kfZtjjeEHEVBzr4je14XNikN1ps8lZj71eNSgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t5bhzSULqT7rEcGl4ctRXIu59TojIXli35Nkzq2nNk=;
 b=rpmqehzsJaxpYZKcJ+5XY/lYMetmgw/i10smHK17fJEqpn3wB2ZNe3HPvAuIKnUzQ9xTtJsA/gARpGmun7jEsrRzgDrnqitzi6kwJegoaC+xuntt4G/C+wBm01I18sywHmexzunNwPgWj00eJUwSQuZzvpehqIzrYQ5t6PohYgoXljM3q9eyjdIhvoJ8Dc8ZKlu5oIvb41e0KOFv1DU6Otkfj9/koCvSgTIOs9fJatGR4y/k9WtEqst9f1jDoCCQtHhpJCsQA4hMzTf/l4BdMZegdVxE8oGpVnaObyY+lBSbs3Qz0taSa69pB8QoqXj6s1XPqRlAZu5QuWh7DXtafQ==
Received: from BY5PR13CA0035.namprd13.prod.outlook.com (2603:10b6:a03:180::48)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 05:18:48 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::40) by BY5PR13CA0035.outlook.office365.com
 (2603:10b6:a03:180::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 05:18:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 05:18:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 22:18:38 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 22:18:37 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 26 Apr 2026 22:18:32 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<pierre.gondois@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <mario.limonciello@amd.com>,
	<saket.dumbre@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH 1/2] ACPI: CPPC: Add support for CPPC v4
Date: Mon, 27 Apr 2026 10:48:22 +0530
Message-ID: <20260427051823.280419-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427051823.280419-1-sumitg@nvidia.com>
References: <20260427051823.280419-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: da2c4081-a5d2-4e07-ae1e-08dea41c7670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700016|376014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rtlDadOKiOlj01UTvHWclbi730GiwTSIej1PZnZCQDEV4iCdZaY5DP3OiDkVjlIvMyC0HwpmU5g0UHat/CfcC1Pf1lD10B2DBSBQO78F/Wze/+YvPLeIJJavKiiwE2nnzLeZM73QgnE3gN7i91KnagOoCkBdlAWxAcf8QkargfQudRSXO2EzYI4fGWACn8NTqq2Uzsp4Y9KPZ8MTiOYnXpsSp9Mtr0J/sMF/U7+EvrRbOUVkANmjBj5HXQbX6lgxtSjg3GvaTVOt7GMYhjYAASMJ61yY0vFsLJtc+T13NzcaA2uCe2fFeBuDzCmzAAcgAB4zWSgJGxuM2ydLNjcZA07Ekj2HyIQ2x5qYPmC0AMLsB4G1wwKyVvpynZxHsms4GQzYa3VYAw0t+Ac0Zx8vSbwRQFjWUH9jEEju1XcN36ZPIrMdvBVAvfkDu6pXu4hdtK0BqOM+RXHy3Xtn62yvcWQI2Npjzz2HnRSTVW4XKHHBqE1uzh430sATPodjnzVuRqtZSsjmgQVMKECk/yCxk3agRv632O1sVf034sCtMH7sHpkYb4nEtLlLNpXLlWL7R+/AOLojpMeJxmok25A4G9BPBOpZKrA0ON6At813ZQ5Zu2sHOldq+SsOYLcHzSJxwxAsCJ5KXarAw3WgirPxwIWoqLQsKhYbLIbQ2jA79NShhkXiBmH2C6Vt/vn+NsdjUfzTSfA1m1bwUQnM8p0Vxg99bLiQmn0vXvfaXmRoMMmBZV/bUjnni99fluHdCmEKTmxNoaD0HSZsz8EAwNtPw7aYBmyo+3LjkZ04WnvjY/1MVpE6kzYBal6raHbPylZe
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700016)(376014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kglHQXwzsy423CkdWyh+uJipl5QthNAQRLWGYhOfzPk2jwKsgMkFYlmxTcdf32zEUZKKAMaDRUBBm21y2XZGQHflWAjng57zMjEjkHtj4JeskcrttOGJ+/QrZgZKUyKr78hpWfLFjf9yVBtCektEGs9TQgNkohLQZpn9T9mLjMgDLXjJ+RPAe91RR6GHxzEDoZuAFfY1w+74bMrZYLXGmVDLC2JgGEuroIEzmwWZtYPJLBp0B3rMhPUApNH3QzOsyLPeCNS1VhXgAbtDP98u6dc2FFytmL2KPXpCbu5nwwCllM1VS9U0SP41Dscm9xFm968Tp2OwTxFpWtav2Sar2hHPhXSRhcUP/GtBWtgGrnuY2kkeym6H6BncXcjmUfODPpEkNjWd2WopJrwZRLNExHpRhwIuHYGnumbxYp0hJNVUTho/Fr+2w8sh6bZm9sa6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 05:18:48.5091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da2c4081-a5d2-4e07-ae1e-08dea41c7670
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877

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

