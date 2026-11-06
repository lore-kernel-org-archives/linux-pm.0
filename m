Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993672;
	b=Savppp2FsW59dklJ6k6Iul8+ejoVD2HjxJ45aj9nne9cBriBVnSh/Tjqz8+47Y9e4+yY
	 axNlqb+qHLN2kLlexdfcO9RwNFxH99bmyc4V87p6uhpBCcI/nwULKEbK4R4aldClpPARA
	 Ga+g8TTJ89NImussAHPB72BPBnwIGL0++ul0PcGXkXtXiDti0OLRrMXMgCHTCxoFzeG+j
	 bNn9584yEpRq1BLURquMT0InJAuRUZb0Rt+r0xcPGvN5NkrJbzSoPlf4EuQ/ZVOzftB8m
	 YGOKu9mxDn2z4qLRC2Ti0mYAwepHheox3xrVy3yCed7tV914InR9CMZoLPm2yAQwpWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993672;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
	 Content-Transfer-Encoding:Content-Type:X-NV-OnPremToCloud:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=QpjGU/2sze6YDHHHuLGzC0v+aKkWGJ5XQ/zgM/akByw=;
	b=hNFeYAlPqipQmcSMissEhv4VHNwb2qFrFjmdzsU0K5/KVEOw3nLdRWKG+U1az3AwYNwG
	 4RaV7HFeXDpPxGuarco0iErPHbwEJEWrrkmiR0uvJEjJQ8n6eRXfHPvUgyNDu4geu7Ngw
	 +qsYEZm1MhhAdfl0xbsGeYAXNivM8DMvtTLrPi2+3mEsk68yahliiZipOBSp7m55ZhQoi
	 5mgyOtAGc1DxuTIBFn8GkT912gE+MmiV9gyXvppSYfWg9g0Mn4w3HeUeNXv82V58KXTxN
	 jQxFPxtum7TGsypEfmNSPzHkYtL1zL/ZNFMtMDnMPa2bHvEd5LZa+TgIb58gtrhMIWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=o2krKo24;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.59
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19029606A32D;
	Fri,  6 Nov 2026 19:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19029606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=o2krKo24
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPmNr0/noSAE/Q/ykcTe6XUUOvNJ4P0rhxbnnmIvcGx7oiSK4JHndafCo+zS5EE6xHfLYgguCagT6lFoAUjnRVAFnBzW7voXYX3dgd5p/307LZt2wWBrpDl3HCsh5p+ONnfmrEZL+suKGOqMVJ61qOYkHsU0uXpyWBO4QwJ+rui2Ge2zXiWLnHzIDCGHkER0x7AFNJLgUSLacwoqzThMtS3CHB5Nnu4VBLXcPOJVYgP1rIYWsUxeiz7Xe9oRqmLwqQYKuNqr2+Zopc0iazfaaMVUBC/TmclS9tFS23T/qGZNEqaoqOj//eu/RqUMjFVayEt1SPzGsZox/R7Y8ehPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpjGU/2sze6YDHHHuLGzC0v+aKkWGJ5XQ/zgM/akByw=;
 b=RfIe47Ezonb9uWqZwxuMBnm57/slgyqodUppJLytEsBhi6mJ8+uezZzab/hJLVNbF/N6yOOSjOZGYXo2H8rdE0gbxugppWqffZkY+qsYXmDAU6/9Zb9mELghdYlX5oUwa9i6kZaIg3fR1xoUrsTvFa+mZ9LTWBqdRn83PrkbopOLrze1hcQlGPYzhbi2XDFryQP9RAno1u3WH0f84GSBKoCm5VOtSWbqi1jenh4moFY+gZqq0Q9pSPACjK0LWdOfgaxTg8k7qjuHome0TiMFM7+7hmP0SfYFkWYjqB/caNl7U7NtJR9i1PGcMnC6lNg23HBep6djlNikr4bKAEGTUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpjGU/2sze6YDHHHuLGzC0v+aKkWGJ5XQ/zgM/akByw=;
 b=o2krKo24gA/rd9bG1kbaz0AxXItnaVJT1LolEbUGPQWppq52iM0K3Lzyf+t5rEAjfF6fJwPC3vWOmunk8XqUCCUjAsMigisDgsD80XCTW96B6X4Qvda5REr8/V2FTocQW0yk5dGBc76IG+jPiVUhTWL4j/YdZOCzho10w9zWDr2maeholtgEHOXUEhTMeyl+s4fGxNvIELycsKt//Nwazb3amXVP17LRTBWF2M0RNbaza9pr8nNwybiqVZVFKH0RMJiSE1S4oUouycIRKsR30PTbVnkQWa+0cKTXQcrVf9LfbV+altxsIadkYsxkYo34C54WBmgO3KHZoojX6hvNKQ==
Received: from CH3P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::23)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.11; Fri, 6 Nov 2026 19:34:24 +0000
Received: from CH3PEPF0002457B.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::7b) by CH3P221CA0023.outlook.office365.com
 (2603:10b6:610:1e7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 19:34:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF0002457B.mail.protection.outlook.com (10.167.252.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 19:34:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 6 Nov
 2026 11:34:09 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 11:34:08 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 6 Nov 2026 11:34:02 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v9 4/8] cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
Date: Sat, 7 Nov 2026 01:03:00 +0530
Message-ID: <20261106193304.3347374-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106193304.3347374-1-sumitg@nvidia.com>
References: <20261106193304.3347374-1-sumitg@nvidia.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457B:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: de3cb00c-406d-46d3-9ade-08df3c3cf59f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|7416014|1800799024|18002099003|22082099003|10067099003|921020|5023799004|11063799006|261102123227099003|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261022105027099003|261022113327099003|261022075727099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	BWyT4ffZxFMGRv+UF4ETyaNqirLjrqFaCySLKD5n3A0gMNAvICe7IJAbr8dVehm6ftuBWuXdgDFH2Y3/dM63vlV6c++f1+Ow0QWlXAjkv4V6n559xFKoOqnkTkOLV8Q+ZtCxZ/sKGHPSxLnam8s1PehFgr763xyVX+zirsBxyxV/BfDi6f1fmXilmuiBXl5FPngtcECHKfBW4XD+I4kwErTBg2FuS61xpVghKA4wIkX9jUHZ2Up/iRNH6pfZBuRrtBEhPPo4PPnfv13wHAJPs8029J3Mt7GDZdJ92GHYxlDJ2DRTtLcwWAlRfJYXPUrp7NdogXAOB+IPJIBnmSLU69+flssjGkWbDY9Ixbp7HS/iMWAdbUPSBky8LU6a3q7tArnCFtlFuzcpWHCwmdifeaDK/oUy9d92alxCa4eMnjBFxtTaHNvlxhKp2ITaVRCJwPO2t4TnZKZWWU7fkr7Ldfp8xtFlBoO9++vz+0M0a9aguaJ7ryGcfBf0Q+RL6gZJ69S4xUSv+N5/rA3O2vVoPIUpVUNxE8TrrKsr+ZjrS3LOMOXXyzjoXg8tOIm7U9pBxGH8zKvj2YqaLkOA5HY0WBVq2f76RKV0lBpNiwkEjxQVqv0rXGoL4D4NK+5PBElHcsC/4aJNoZJ7bHa9cadnms5p3ZSDT/TTUkMPbHWT4ggVd5L4a+4s2Wce0mJKYFRnRG8to4Iqc0u7HzQNNKxvH4MTq0wz/Hdzchz8/B2hQI8RB3z5P87xBpXhC7ct4xAQ
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(10067099003)(921020)(5023799004)(11063799006)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261022113327099003)(261022075727099003)(261021121427099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ae8gvLqcwQRZaaWWAO2zcIEfYyGaIrk75m5O8D6LyPTpc40RYHHbTPbffok6nkAxsJgdQGqZedxzXezQaG9VLB1Q45FpeJdAKG2AAPsz07faqqt0Urgk9Xi0XIrAsNSysqbLq6IyWrotrD8TZMyV+la0AmErGPsdLm4VHIDLifn84162yiNa2RnyRvpReit8e7zo1Yo8/cJBCbeotxF1+GDY2KAaOzTYZ9m82YvclP39hrV7EHILkHWkxmtHrT5D2XPHVwrici1ysYe3XnbQ9Gh/cmB76rw3bPIfYlCxNuJfg5DSSu2ACarZbjtHFj1tM4XphdkMcJJFftp1O4CBWU3gzvI/W5wZRoENB1cZ1LCsJPX+aJCVLxddF7FQ1SevuaYKFBAhnsUoIBqCdd0tge0jYyTuhGEfOaAbZNk41UqIfc44XhtKH9sZhuKwoccQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 19:34:22.4963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de3cb00c-406d-46d3-9ade-08df3c3cf59f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0002457B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285

Values written to OSPM-set CPPC registers via sysfs are not handled in
two cases:

  - Across CPU hotplug: the platform may reset a CPU's registers while it
    is offline, and the value is lost.
  - On driver unload: the value stays in the register instead of
    returning to its pre-driver state.

Handle both by saving a firmware value and a requested value for each
register:

  - On init(), save each register's firmware value before the driver
    programs anything. Also use it as the requested value. If the OS
    never writes a register and the platform resets it while the CPU is
    offline, online() then restores the firmware value.
  - Save each successful sysfs write as the requested value.
  - On offline(), restore the firmware values.
  - On online(), reapply the requested values after reprogramming the
    performance controls.
  - On exit(), nothing is needed, as the core calls offline() first, which
    already restored the firmware values.

The value reapplied at online() is the last one the OS wrote, and it stays
in effect until userspace changes it. The performance controls are not
reapplied this way. online() recomputes them from the current policy
limits.

Also split the auto_act_window store out of the handler it shared with
perf_limited, so that it can save the requested value. perf_limited is
not tracked, as writing it only clears status bits.

Cover the Autonomous Selection (auto_sel), Energy Performance Preference
(EPP) and Autonomous Activity Window (auto_act_window) registers. Writes
to EPP and auto_act_window only have meaning while auto_sel is enabled,
so write auto_sel before them when enabling it and after them when
disabling it. While autonomous selection stays disabled, the platform may
ignore those writes.

Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
Link: https://lore.kernel.org/all/86780f97-29ee-4a72-b311-38c89434b707@arm.com/
Tested-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 227 ++++++++++++++++++++++++++++++++-
 1 file changed, 222 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 3f7d740e04af..27ef1ea41a3e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -29,6 +29,185 @@
 
 static struct cpufreq_driver cppc_cpufreq_driver;
 
+/*
+ * OSPM-set CPPC registers tracked for save/restore. A value the OS wrote is
+ * reapplied from online() across CPU hotplug, and the firmware value is
+ * restored from offline().
+ *
+ * Autonomous Selection (auto_sel) is kept first, as the registers after it
+ * only have meaning while it is enabled.
+ */
+enum cppc_saved_reg_id {
+	CPPC_SAVED_AUTO_SEL,
+	CPPC_SAVED_EPP,
+	CPPC_SAVED_AUTO_ACT_WINDOW,
+	CPPC_NR_SAVED_REGS,
+};
+
+struct cppc_saved_reg {
+	const char *name;
+	int (*get)(int cpu, u64 *val);
+	int (*set)(int cpu, u64 val);
+};
+
+static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
+	[CPPC_SAVED_AUTO_SEL] = {
+		.name = "auto_sel",
+		.get = cppc_get_auto_sel,
+		.set = cppc_set_auto_sel,
+	},
+	[CPPC_SAVED_EPP] = {
+		.name = "epp",
+		.get = cppc_get_epp_perf,
+		.set = cppc_set_epp,
+	},
+	[CPPC_SAVED_AUTO_ACT_WINDOW] = {
+		.name = "auto_act_window",
+		.get = cppc_get_auto_act_window,
+		.set = cppc_set_auto_act_window,
+	},
+};
+
+enum cppc_saved_type {
+	CPPC_SAVED_FIRMWARE,
+	CPPC_SAVED_REQUESTED,
+	CPPC_NR_SAVED_TYPES,
+};
+
+/*
+ * Per-policy values saved for each register in cppc_saved_regs[], U64_MAX
+ * if the register is not implemented or not readable:
+ *   CPPC_SAVED_FIRMWARE  - value before the driver touched it, saved at
+ *                          init() and written back when the policy goes
+ *                          offline
+ *   CPPC_SAVED_REQUESTED - value the OS asked for, reapplied at online().
+ *                          It starts as the firmware value and changes only
+ *                          when a write from the OS succeeds.
+ */
+struct cppc_policy_state {
+	u64 regs[CPPC_NR_SAVED_REGS][CPPC_NR_SAVED_TYPES];
+};
+
+static DEFINE_PER_CPU(struct cppc_policy_state, cppc_policy_state);
+
+/*
+ * Per-policy state is kept in the per-CPU variable of the first CPU the policy
+ * manages. related_cpus (the policy's full set of CPUs) never changes while the
+ * policy exists, so this CPU (unlike policy->cpu) stays the same across CPU
+ * hotplug, and every callback reaches the same copy.
+ */
+static struct cppc_policy_state *
+cppc_cpufreq_policy_state(struct cpufreq_policy *policy)
+{
+	const struct cpumask *policy_cpus = policy->related_cpus;
+
+	/*
+	 * related_cpus is empty during init(), as the core fills it in only
+	 * after init() returns. Use policy->cpus then, which has the same
+	 * first CPU.
+	 */
+	if (cpumask_empty(policy_cpus))
+		policy_cpus = policy->cpus;
+
+	return &per_cpu(cppc_policy_state, cpumask_first(policy_cpus));
+}
+
+/*
+ * Save each tracked register's firmware value before the driver programs
+ * anything. Also start the requested value from it. If the OS never writes a
+ * register and the platform resets it while the CPU is offline, online() then
+ * writes the firmware value back.
+ *
+ * Skip a register that is not implemented or not readable. Fail on any other
+ * read error, as the firmware value is needed to put the register back later.
+ */
+static int cppc_cpufreq_save_firmware_regs(struct cpufreq_policy *policy)
+{
+	struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
+	unsigned int cpu = policy->cpu;
+	u64 val;
+	int i, ret;
+
+	for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
+		ret = cppc_saved_regs[i].get(cpu, &val);
+		if (ret == -EOPNOTSUPP)
+			val = U64_MAX;
+		else if (ret)
+			return ret;
+
+		st->regs[i][CPPC_SAVED_FIRMWARE] = val;
+		st->regs[i][CPPC_SAVED_REQUESTED] = val;
+	}
+
+	return 0;
+}
+
+/*
+ * After a successful write to a tracked register, save the value so that
+ * online() can reapply it.
+ */
+static void cppc_cpufreq_save_requested(struct cpufreq_policy *policy,
+					enum cppc_saved_reg_id reg, u64 val)
+{
+	cppc_cpufreq_policy_state(policy)->regs[reg][CPPC_SAVED_REQUESTED] = val;
+}
+
+/*
+ * Write one tracked register, skipping it when there is no saved value.
+ * A register the platform does not allow writing is not an error.
+ */
+static void cppc_cpufreq_write_saved_reg(unsigned int cpu,
+					 enum cppc_saved_reg_id reg, u64 val,
+					 enum cppc_saved_type saved_type)
+{
+	const char *op = (saved_type == CPPC_SAVED_FIRMWARE) ?
+			 "restore firmware" : "reapply requested";
+	int ret;
+
+	if (val == U64_MAX)
+		return;
+
+	ret = cppc_saved_regs[reg].set(cpu, val);
+	if (ret == -EOPNOTSUPP)
+		return;
+	if (ret)
+		pr_debug("Failed to %s %s=%llu on CPU%u (%d)\n", op,
+			 cppc_saved_regs[reg].name, val, cpu, ret);
+}
+
+/*
+ * Apply the saved firmware or requested value to each tracked register.
+ *
+ * Write auto_sel first when the value being applied enables autonomous
+ * selection and last when it disables it, so the writes to the dependent
+ * registers can still take effect. While autonomous selection stays disabled,
+ * the platform may ignore those writes. Do not enable it temporarily to force
+ * them through.
+ */
+static void cppc_cpufreq_apply_saved_regs(struct cpufreq_policy *policy,
+					  enum cppc_saved_type saved_type)
+{
+	const struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
+	unsigned int cpu = policy->cpu;
+	u64 auto_sel, val;
+	int i;
+
+	auto_sel = st->regs[CPPC_SAVED_AUTO_SEL][saved_type];
+
+	if (auto_sel)
+		cppc_cpufreq_write_saved_reg(cpu, CPPC_SAVED_AUTO_SEL, auto_sel,
+					     saved_type);
+
+	for (i = CPPC_SAVED_AUTO_SEL + 1; i < CPPC_NR_SAVED_REGS; i++) {
+		val = st->regs[i][saved_type];
+		cppc_cpufreq_write_saved_reg(cpu, i, val, saved_type);
+	}
+
+	if (!auto_sel)
+		cppc_cpufreq_write_saved_reg(cpu, CPPC_SAVED_AUTO_SEL, auto_sel,
+					     saved_type);
+}
+
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
 static enum {
 	FIE_UNSET = -1,
@@ -790,6 +969,12 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = cppc_perf_to_khz(caps, desired_perf);
 	cpu_data->perf_ctrls.desired_perf = desired_perf;
 
+	ret = cppc_cpufreq_save_firmware_regs(policy);
+	if (ret) {
+		pr_debug("Err reading CPU%d firmware values: ret:%d\n", cpu, ret);
+		goto out;
+	}
+
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	if (ret) {
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
@@ -821,12 +1006,14 @@ static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
  *
  * The platform may have disabled CPPC and reset the performance controls
  * (desired, min and max performance) while the CPU was offline. Re-enable
- * CPPC and reprogram the controls.
+ * CPPC, reprogram the controls and reapply the requested values of the
+ * OSPM-set registers, which offline() reset to firmware values.
  *
  * Log failures but do not return them, as the core would free the policy.
  * Continue after a failure to enable CPPC, as the writes that follow fail
- * on their own if the platform does not take them. A failed controls write
- * is not fatal, as the next frequency change writes the controls again.
+ * on their own if the platform does not take them. If the controls write
+ * fails, still reapply the OSPM-set registers, as frequency changes rewrite
+ * only the controls.
  */
 static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
 {
@@ -872,6 +1059,8 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
 		WRITE_ONCE(cpu_data->perf_limits_valid, true);
 	}
 
+	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_REQUESTED);
+
 	/* Restart what offline() stopped, with a new counter snapshot. */
 	cppc_cpufreq_cpu_fie_init(policy);
 
@@ -889,6 +1078,9 @@ static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	int ret;
 
+	/* Leave the platform in its pre-driver state. */
+	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
+
 	/*
 	 * Stop the frequency invariance updates and cancel the pending work, so
 	 * that no sample spans the offline window. online() restarts them with
@@ -1097,6 +1289,8 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 		WRITE_ONCE(cpu_data->perf_limits_valid, true);
 	}
 
+	cppc_cpufreq_save_requested(policy, CPPC_SAVED_AUTO_SEL, val);
+
 	return count;
 }
 
@@ -1144,8 +1338,30 @@ static ssize_t store_##_name(struct cpufreq_policy *policy,		\
 					    buf, count);		\
 }
 
-CPPC_CPUFREQ_ATTR_RW_U64(auto_act_window, cppc_get_auto_act_window,
-			 cppc_set_auto_act_window)
+static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
+{
+	return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_auto_act_window,
+					   buf);
+}
+
+static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
+				     const char *buf, size_t count)
+{
+	u64 val;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = cppc_set_auto_act_window(policy->cpu, val);
+	if (ret)
+		return ret;
+
+	cppc_cpufreq_save_requested(policy, CPPC_SAVED_AUTO_ACT_WINDOW, val);
+
+	return count;
+}
 
 static ssize_t
 show_energy_performance_preference_val(struct cpufreq_policy *policy, char *buf)
@@ -1170,6 +1386,7 @@ store_energy_performance_preference_val(struct cpufreq_policy *policy,
 		return ret;
 
 	cpu_data->perf_ctrls.energy_perf = val;
+	cppc_cpufreq_save_requested(policy, CPPC_SAVED_EPP, val);
 
 	return count;
 }
-- 
2.34.1

