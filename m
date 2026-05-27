Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33873B1008;
	Wed, 27 May 2026 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911242; cv=fail; b=q/UjbshpsHa8W4V3pjF7A0DfjA3T1H6l9FoBeBEB4CkUqU6pNM2e2vZVzl3YLJRBXH4xbjoM5iLwZ6dK++VIvP9nl2Bz9zL2+uWsSc630CZpSV0g+oKvi9I+pCS2AHTtV8YWvibzMNRk+Onk83G2Pu7KoG0rB0MIX61P9lSpIJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911242; c=relaxed/simple;
	bh=W+c3i2/g9/cqenS9QelXR74Vj95J6iBqOfZhNR54Xug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+PYwe/kSvHdLEaByEPW0YKCELj744g4sCPaYm044LNXd8D30JQjZLU2hXV0BduqUAbGkYAl2qew0BncNmAjFAgU9CZAtBglYK0m9QrpC0LLS5HvYSh/jsBB+937uArQWh/Ab5uvxn6LEuPs4+ke4Iwd2VmJM6P4h7FcpE9K3PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D9vS8n/b; arc=fail smtp.client-ip=52.101.52.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D9vS8n/b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOF2amU377tTxIQrD3soOUzb8GPdAMgot3TwYqrgOAwYhHm39XlYkgzw0gz4Z1qqoXG/wU7YsvBQJIHqhKAKigT2u/92FMw9zqQyfRcioM73XwrXKXbB5X/Xq1fpfyVxprYQdk+l8hzHOzlN7/j/lztW07lLuaZ1fWjlq+v5dKFVZBySHXhB+KCzj/Uz+Pv7xAsnBaxXuHFajfBzCJNuwVbIfihodmkDa+uGEVjLAheQHynFwPCGBCnkJF9sFHXlAiFFsiOD3t5UCtjd1CYceeFnfPuwPELz1hJojbkHlXXXcijtG1xqAllwh0TuU8851FVuY5ankkMMRTpIl6l54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLhxSfgBWH+NyJrqa3vKY0PKmMCJmOpPEiLkvMSQIkI=;
 b=bnOnGrfOoxgSs7vBuhcs1+1bmDcC4yF/4x0pnpnAP60EgrpQ27n2uq3GSbDNZYyMX0nxHP0D6uE2S+mNo9kbAf60HbmCk77Nn3o6TTmAgYrmo4GGybbe4A8guXrFSZ/qBYdJk1ayFDYJlVtYWCQ46I2dIW0pRjH+17uQN8GYmXtCyZnxJhaxBISAW3SlnFwiO58vcAIZc2HqNKr+pYT+dSfxoKr6UVSjkA8bW/vTvBkBKKpY2rWSpz6YKxR+fVbCaUtz8L67SVd9mc7qPub5LOBwgbrQPXyEu6cPYXMD9kVgf57VrzrM2EqwymnoSDJ3l0GDetXBp8jOqIQDvG8oUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLhxSfgBWH+NyJrqa3vKY0PKmMCJmOpPEiLkvMSQIkI=;
 b=D9vS8n/bWOvzZTBsPS5yzx3u1i2EBk5ZS8Y16As8uWePyfQ1qsSffC8JIX0A1R4fF7geTBB1roHgK1l08Zvab2NXimNTWsbkUQIjIRBASaXN4V+JU9Wr6BZBP7EHhsT7e1prjaj8i2cifAxlIkBftUA5anezWlE96ycSiWDZKW2xeEIcrEhbTZ22dd/Y2QH8FKJblQsdCR8fYuwh/etbTArQ0SGgtF/RJIoO49Mv/6aNflO5YDZzrUM1u1R/hbj6WK3zqL35aonCpHGdkgM3Lwj2v1bwY3dNeEV2uZnfVmDCHcyE969tr8UMnQSBLSmmGZUw4LrEpgtQSpQMLE7siw==
Received: from SJ0PR03CA0235.namprd03.prod.outlook.com (2603:10b6:a03:39f::30)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 27 May
 2026 19:47:09 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::a3) by SJ0PR03CA0235.outlook.office365.com
 (2603:10b6:a03:39f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 19:47:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 19:47:09 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 12:46:41 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 12:46:41 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 27 May 2026 12:46:35 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<pierre.gondois@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <mario.limonciello@amd.com>,
	<saket.dumbre@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>, Mario Limonciello
	<superm1@kernel.org>
Subject: [PATCH v4 1/2] ACPI: CPPC: Add support for CPPC v4
Date: Thu, 28 May 2026 01:16:25 +0530
Message-ID: <20260527194626.185286-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527194626.185286-1-sumitg@nvidia.com>
References: <20260527194626.185286-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 447c991d-da8f-4d0f-320c-08debc28bd31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|11063799006|3023799007|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	u9PXr9kxpJuqFL1+tuD9F1KDsUZr/GTiy/FiuAo39363fYTM4GelM5qUBcQTO9+E+ZFd4oXAHgNCI/EiecZNuC/rAAdEAbaplPHZ+PU9kTsXH+ldL/Z0aSO8mv6D9Z5O89O4NwA2RCr4FbD03z56tzmJGNxhA3bR53TG3O+Dp7L9hpa9Cfy5ITA2+x5zhwaK0xJidAQtWmw+owj39Zne6baxjxGbuAtTZ1aicyXU17nzm3w3XmUw4Rhw2NQhcaKTXOhN4eJPuJSi1cHyYd1sGscFehMdrMqLBKQ8vMtlZB0b+1jbjislCqrKSNUaYO6k/dMwryn/1b2L5vcW2+TCXPu6tvLhaogkMuNTGQTetHakdXSvY1ZQAUsSkMx1R0nR6GuHRJ21F7lbkXLrEdZ1Pc8Bdx0rLseqxfstAN8iGCN0NCf17LnrqHjJjAjjOsWCDyvqSo9prHVm7WYqB5cr37VQHO/HNccG2W2mrJmHYpDMNFIDZCo0VyknJs0z0Zr2vR314xsg1cG9jGRh7OFjmWwhgiEycv204/Fjij9Nbwwjilx2/vxgrdgePqwAyQeNRxL8WJaB2gV7MU4FmJnlbAsLcKW/4CGMCI9EYX9NHSkY0/EfAA4MWmHXNCi9eoOJNxN5NSc71Sn+TUJQNkFoa+Xhfpv2zGFcrbbLXVVmnd/k0UhhkI4LFkzD9VHhY1UABpGRe2mXg0QO1L4pOTHeWkG9zlBKm4S9IP87xXfLemKXVNiLfZ5koJh2Yg+Y1nV0VuhOTWe7X9glxjyrwav6FA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(11063799006)(3023799007)(22082099003)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	li+xUz/GK4/Q5sE6uXFPI+jP1snpUrF4jxShVMa1lYf+81Vdk7lL5sCNWj3UCOOzIA4xaloB9FxF9soWgGXHdDrE9LD6hAHHH0qkQ8AO7n7ILfUBprKFCZQpss/x2WfEHDYe0au/W/Tq7vvJqvYbQF9A/F/PqKcQINUxLD63e74ZHiQw367Sn9Qun+Igl86xNKHesy1WQsd+Y+fiVAj0a1PEfp8FK2tzeQOY0BHK43LzDTy7/6pLusLTUHRewc1CPi5hRgXF84wq7FSwQlV6O+GmuKyoSxNR4+rYJl7uNjkOTUHclTxkUUEQsjpmqh/f5RzV6jJHoMw2jCNI/2uONkWxvI/80LcV5iZYAWEDZWqNrvZAllUL0260dkyjIp2Wu6rrPNttAIemUXzqGXeEBJ1vj0Cagv6iNxqIovHsbOm71GRVfB+bx84qvPtCh77+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 19:47:09.0630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 447c991d-da8f-4d0f-320c-08debc28bd31
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

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
index ee8352830c32..9b18fb9aab7c 100644
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
@@ -110,6 +112,8 @@ enum cppc_regs {
 	REFERENCE_PERF,
 	LOWEST_FREQ,
 	NOMINAL_FREQ,
+	OSPM_NOMINAL_PERF,
+	RESOURCE_PRIORITY,
 };
 
 /*
-- 
2.34.1

