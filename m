Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794434934;
	b=WdwuORoxsVmgWZDVxudjJFXDqgqPif+6sGf7snIB31hgO8QC3HiZzOUTmnb87TnOGbZk
	 70r5Il78hs1OhzsUEXNCZtQNpMKgB2HXlTEbSNUTkOhwte+MNtK3U543b68t+QoH70buU
	 lnfNxbQxjM14zaK6XyEIMR8f1b80B297k1kVoRNN0Dfb8o390klnObjjH1emOayhJTDPR
	 kh8sEUnualCda1mSB72dTMFrw3cCzW9iFtuqpwZUl5cn/B14DIViCEkc5nh51Gxf0ajVQ
	 F4cz/Ti40Gf6jsLd6NaK8Jwx9dABCeoF+K+3NS/Xc4Dxtj++Yi9zdDWXJZCpC32Worw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434934;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=DZrDaT88E7rxQE6CFTvx0rUumxlFGk0WC20F/8OkLFQ=;
	b=BqsuEiOpdAxAIKKnApZBPzFXiExfIP4gSjD4fzzSbwFliYeZ0Mbr+/UQvL5DdPK7x4/a
	 ngjzKJveUEorwJSJBZMoUT3lIrjD/jn6FPAlyCTk03GHtAjLlE85BOxJGUYEQ6YgmOSlQ
	 ysd9Kr677eMtqtDI04QflACp+YmpbKr1xKi51binUfVhdcppAzfpWb5zR4/hIiLVnALXB
	 hiZ1VhJ9isq+TqKX6t5EBbmx3CHmRM1v3KBKgLeGu2dgSvWdGNEf/cj2FIhi2EvnQ4sCV
	 t8a9n1JPxBuGJrfFEXCjlPq+k+3eTaC84dvoy3a9OPxiyWcfXRdpnM2OSFrXq6cUn7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gy0G6FeT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.11
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C0D606A31C;
	Wed, 11 Nov 2026 22:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0C0D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gy0G6FeT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWe3sRhPg59fqFCUSzz9TH9RbVNfWJ5t/OPa3IN9qJ5pLDXEzmPr82eNP6p9YjS48r1bZ8GbgvsPDc36KgZZLOkggU5jJkXWLpbqfZZl9+HsFrUDdRDndpsGvsJs2Z42TXd11K4d4OzPBwV7fevKec3pCss9s1sK3xVzpLP2sOuEVC9Zq+E7iZ0wGzUvquDjqsj8iLXfG/inJFJ6uCkOYxZeh1vVs9hGCQvAcJ5Kb0lpEDALPEI7th0LANGsSSQyXLZifGIEWeBxqsQaJhtpdaYsVoQc5qdHSOy90V2OEnFCIeHTSZieWzlVtD7BJ3+TGVrVTKC+buWvn0RcXl660w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZrDaT88E7rxQE6CFTvx0rUumxlFGk0WC20F/8OkLFQ=;
 b=iYQwQk/MCqZOgpOmtWN/yjW2NtSZNdB0fRt72uuFIPfoD7gY4xILoxBKchBxK5gN8oK5clHs1Ccho2lvu7l2wfDnTYWv6H1YkvXXsIUCQK+rb4/NvfBhUh3of/geMOIm42Bs26XecceL6mHWtax8AiCt6FyKBw5DgsOCRgveEy0yYIeG2QO+ixDtusRUB4jvtQy7WzABBRv5OdjXXOIMGLdwGpjCFO093sZ2A2XNacBRTVHx2fbjtFHyk6aE5E2Pf8AsbKi+losS8fK2yBEKstjlzx7peu7HQRlR1aAHbHY+4B8XatEKiclzHC4x6jUrKEsSCJzL0ZhsfhtLS5hULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZrDaT88E7rxQE6CFTvx0rUumxlFGk0WC20F/8OkLFQ=;
 b=gy0G6FeTMsyemL0A36ULsD/7UDVMhOwPz3EGtbc2o/y4GMUHNh012fAplPdbNTrvaCJPnOICRPka7zhb87slAm5lq9KBqYd8WaGjVHeol9xBuG8I57JjFlsdW05eDmnFVd+EAUcayrNcG5zGX170q7LWCJ4/A/yj8G/1Vg3LXKDAEGqtdG4CUuzL05aacp2zu497z9AOqbqIpd3KjMJBQ78QJ5dRpdBKnF+zqikB6WlvMOd3XzwHiW7N9kUag6r04x3n487B+L8V0nTlYiDMzLB7rg4pJnivhV8jJx/u9QExUW+ym0bwdkqk7HmZ3X19bXc/Rxu6WvdJS5OO1WSE9A==
Received: from CH0PR03CA0199.namprd03.prod.outlook.com (2603:10b6:610:e4::24)
 by SA3PR12MB7877.namprd12.prod.outlook.com (2603:10b6:806:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 22:08:46 +0000
Received: from DM3PEPF000265BA.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::36) by CH0PR03CA0199.outlook.office365.com
 (2603:10b6:610:e4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 22:08:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM3PEPF000265BA.mail.protection.outlook.com (10.167.23.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 22:08:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 14:08:34 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 14:08:34 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Wed, 11 Nov 2026 14:08:27 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <christian.loehle@arm.com>,
	<maciej.wieczor-retman@intel.com>, <pawel.chmielewski@intel.com>,
	<lenb@kernel.org>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<rdunlap@infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v6] cpufreq: CPPC: Add autonomous mode boot parameter support
Date: Thu, 12 Nov 2026 03:38:03 +0530
Message-ID: <20261111220803.3953790-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BA:EE_|SA3PR12MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: fea823f7-335f-458a-61a2-08df40405b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|1800799024|23010399003|82310400026|921020|11063799006|261026121527099003|261022113327099003|261022105027099003|261026140227099003|261022075727099003|261028144727099003|261021121427099003|56012099006|261102123227099003|10067099003|261009223027099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	RfeTXsHYqaBS9OE5LAGtQpSXAK3APu7inG6HYEnvW8sWmEFgtkJ+bMKoHCC9uYlGga20hDvar90aSgkecSa5S06O8N3r+mhJlBBJHLOrLk6T//8eLjiEpr5laBSsuNhZUHiTji9CwI+8qh+0kf0srrxjHRncmuj4+YeCIzWYlf9QtfPYM9Fos3JxFB/woTTXKF3wHzZPzbckIlUHqfFtHHKTeqPclrXXCNouFRDVHS2Eoq8lZRQzjMGchN2vrOcWtUBajphUA5MkIRvIUxOjPsf9pjVO5E7EpSf64YduX4YwHK6CcMC/pSALLaNF3p4tjxpdnEbFKk7vkZ1zrAQwpXagSsr+P7y7B0Gdep9ADBqCJ9VViEsz6xzgi9YAxHftCRYJ6TMSZvY4jk6BvY6DjXKQKaE4kHKESmlmTl1vRALGklpuuTQ8ICekPSU9UDlE+T939g7As0OG4GMkyveh9XrUpTmAY3008P1qomYTFMB5pEMldzG1N5TR439nKZi1OhOcY0971X7lAUbjcg7oWWA5DrO0cb/QMnY1T4ZApvxbRC0R4dHpDlkhiVXwrmoQnNZA8jqyEyDPU8/Lg7LWKzg6h1Gk16D3lM6qsyxgaTmhj45U5MHGXVw22bmMGh2LHDJpKfgGQfFht+NKlDyYxgNyuvwFdTnsVmSuLXXF9fwnzAbSfOH+vz08XOXNxshZkt7rzUaZ0c8fURiAhQq9mC0QzAz4M15HTGSo9YEFSXMdhCzwJ67haq1xzoAvqvj9
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(1800799024)(23010399003)(82310400026)(921020)(11063799006)(261026121527099003)(261022113327099003)(261022105027099003)(261026140227099003)(261022075727099003)(261028144727099003)(261021121427099003)(56012099006)(261102123227099003)(10067099003)(261009223027099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w0zAKeuN2j7syc6ErX5oEeRDH3piNpQEw539AS7q6oeZmsyLM9aRowyXUvg0v9K51APtkj/0amY6QRf3S1+1gSAoPQVQkClqUDH+0i5pVWfxleORP49+GYuzAv2aFJiIUyrdZMK/tuL8yOxUJWF2yfOaLlDeODiQh687Ur2A3o3KEwpL8vBFgBmme8q8EtweOH+L4kB0Gto0Vc5hePGM0pm+Ss4fqDKyTuK9IjtR2hAiGCnWVHHaq8xdmaQDLthmw34Pyc3tpgHQ9yBXvuidBwMhog2TkBhjzIygAX50ERTI6EWDzHsEEbXJpqzS/D5QRG6bEBvk3FljYwRBHK4yYJ0TZsKk35Fkp8yR6spDJiL9xeYTtWqRQ6NknK0wZz6m7L7At1O0C8kj0gLYkjYaBGoCyCsjhNzADsS6hrerQL0XPx4uHDh7dxAt6nwho+XY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 22:08:46.2752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fea823f7-335f-458a-61a2-08df40405b51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7877

Configuring autonomous selection and Energy Performance Preference (EPP)
at every boot currently requires per-policy sysfs writes.

Add the 'cppc_cpufreq.auto_sel_mode' boot parameter to enable autonomous
selection during policy initialization and optionally set EPP. In
autonomous mode, the platform selects the performance level within the
MIN and MAX limits, which the driver sets from the policy limits. The EPP
hint guides that selection.

The parameter accepts:
- performance: enable autonomous selection and set EPP to 0x00
- balance_performance: enable it and set EPP to 0x80
- balance_power: enable it and set EPP to 0xc0
- power: enable it and set EPP to 0xff
- default_epp: enable it and preserve firmware EPP
- disabled: preserve the firmware configuration (default)

Warn about unrecognized values and ignore them.

Skip policies without autonomous-selection support. The driver enables
autonomous selection before writing EPP, as the platform may ignore EPP
while autonomous selection is disabled.

Record successful writes so the existing online and resume paths reapply
the requested values. The offline and suspend paths restore the saved
firmware values, including during driver unload.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
This is based on the "Preserve OSPM-set registers" [1] and
"ospm_nominal_perf" [2] series, which are applied for 7.5.

v5 -> v6:
- Split "Set CPPC Enable register in cpu_init" into a separate fix [3].
- Accept strings only (Pierre [4]).
- Move the setup into cppc_cpufreq_setup_auto_sel_mode() and check
  autonomous selection support first (Pierre [4]).
- Drop the last_governor check, as init() now runs only for a new
  policy (Pierre [4]).
- Drop the MIN/MAX seeding, Desired hint and policy->min/max override,
  as init() and the governor already set valid values (Pierre [4]).
- Apply the parameter at the end of init(), after the usual
  performance controls write.
- Save auto_sel and EPP through the saved-register code from [1]
  (Sashiko [5]).
- Drop the cppc_cpufreq_exit() loop that cleared auto_sel on all
  present CPUs (Pierre [4], Sashiko [5]).
- Enable autonomous selection before writing EPP.
- Set EPP also when firmware has already enabled autonomous selection.
- Add the balance_power (0xc0) and power (0xff) modes.
- Ignore an unrecognized value instead of treating it as disabled.

v5: https://lore.kernel.org/lkml/20260623080652.3353386-1-sumitg@nvidia.com/
[1] https://lore.kernel.org/lkml/20261106193304.3347374-1-sumitg@nvidia.com/
[2] https://lore.kernel.org/lkml/20261109195400.3600561-1-sumitg@nvidia.com/
[3] https://lore.kernel.org/lkml/20261110101246.3665797-1-sumitg@nvidia.com/
[4] https://lore.kernel.org/lkml/f61f592a-bc9c-4a83-bde1-e999c8101c36@nvidia.com/
[5] https://sashiko.dev/#/patchset/20260623080652.3353386-1-sumitg@nvidia.com

 .../admin-guide/kernel-parameters.txt         |  26 ++++
 drivers/cpufreq/cppc_cpufreq.c                | 120 ++++++++++++++++++
 include/acpi/cppc_acpi.h                      |   2 +
 3 files changed, 148 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..5714c0d30fce 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1015,6 +1015,32 @@ Kernel parameters
 			Format:
 			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
 
+	cppc_cpufreq.auto_sel_mode=
+			[ACPI,CPU_FREQ] Enable ACPI CPPC autonomous performance
+			selection on all CPUs at boot. In autonomous mode, the
+			platform selects the performance level within the CPPC
+			Minimum and Maximum Performance limits. The driver sets
+			these limits from scaling_min_freq and scaling_max_freq.
+			The Energy Performance Preference (EPP) hint guides the
+			platform toward performance (0x00) or energy efficiency
+			(0xff).
+			Requires the ACPI CPPC Autonomous Selection Enable
+			register. EPP is set only if the platform implements it.
+			Format: <string>
+			  performance:
+				  enable autonomous selection, set EPP to 0x00
+			  balance_performance:
+				  enable autonomous selection, set EPP to 0x80
+			  balance_power:
+				  enable autonomous selection, set EPP to 0xc0
+			  power:
+				  enable autonomous selection, set EPP to 0xff
+			  default_epp:
+				  enable autonomous selection, keep firmware EPP
+			  disabled:
+				  keep the firmware configuration (default)
+			An unrecognized value is ignored with a warning.
+
 	cpuidle.off=1	[CPU_IDLE]
 			disable the cpuidle sub-system
 
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index a62589c0674f..c9bed93cf0c9 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -238,6 +238,58 @@ static void cppc_cpufreq_apply_saved_regs(struct cpufreq_policy *policy,
 					     saved_type);
 }
 
+/* Autonomous Selection boot parameter modes */
+enum {
+	AUTO_SEL_MODE_DISABLED,
+	AUTO_SEL_MODE_PERFORMANCE,
+	AUTO_SEL_MODE_BALANCE_PERFORMANCE,
+	AUTO_SEL_MODE_BALANCE_POWER,
+	AUTO_SEL_MODE_POWER,
+	AUTO_SEL_MODE_DEFAULT_EPP,
+};
+
+static const char * const auto_sel_mode_names[] = {
+	[AUTO_SEL_MODE_DISABLED]		= "disabled",
+	[AUTO_SEL_MODE_PERFORMANCE]		= "performance",
+	[AUTO_SEL_MODE_BALANCE_PERFORMANCE]	= "balance_performance",
+	[AUTO_SEL_MODE_BALANCE_POWER]		= "balance_power",
+	[AUTO_SEL_MODE_POWER]			= "power",
+	[AUTO_SEL_MODE_DEFAULT_EPP]		= "default_epp",
+};
+
+static int auto_sel_mode;
+
+static int auto_sel_mode_set(const char *val, const struct kernel_param *kp)
+{
+	int *mode = kp->arg;
+	int ret;
+
+	ret = sysfs_match_string(auto_sel_mode_names, val);
+	if (ret < 0) {
+		pr_warn("Invalid auto_sel_mode \"%s\", ignoring it\n", val);
+		return 0;
+	}
+
+	*mode = ret;
+	return 0;
+}
+
+static int auto_sel_mode_get(char *buffer, const struct kernel_param *kp)
+{
+	int *mode = kp->arg;
+
+	return sysfs_emit(buffer, "%s\n", auto_sel_mode_names[*mode]);
+}
+
+static const struct kernel_param_ops auto_sel_mode_ops = {
+	.set = auto_sel_mode_set,
+	.get = auto_sel_mode_get,
+};
+
+module_param_cb(auto_sel_mode, &auto_sel_mode_ops, &auto_sel_mode, 0444);
+MODULE_PARM_DESC(auto_sel_mode,
+		 "Autonomous selection mode: performance, balance_performance, balance_power, power, default_epp, disabled");
+
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
 static enum {
 	FIE_UNSET = -1,
@@ -938,6 +990,72 @@ static u32 cppc_cpufreq_effective_nominal(struct cpufreq_policy *policy)
 	return (u32)ospm_nominal;
 }
 
+/*
+ * Apply the auto_sel_mode boot parameter in init(). Enable autonomous
+ * selection unless it is already enabled. Then set EPP for the selected mode.
+ *
+ * Enable auto_sel before writing EPP, as the platform may ignore EPP while
+ * autonomous selection is disabled. Save each value written, so that online()
+ * and resume() write it again.
+ */
+static void cppc_cpufreq_setup_auto_sel_mode(struct cpufreq_policy *policy)
+{
+	struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int cpu = policy->cpu;
+	u64 auto_sel, epp;
+	int ret;
+
+	if (auto_sel_mode == AUTO_SEL_MODE_DISABLED)
+		return;
+
+	/* U64_MAX means the platform does not implement the register. */
+	auto_sel = st->regs[CPPC_SAVED_AUTO_SEL][CPPC_SAVED_FIRMWARE];
+	if (auto_sel == U64_MAX) {
+		pr_info_once("Autonomous selection is not supported, ignoring auto_sel_mode\n");
+		return;
+	}
+
+	if (!auto_sel) {
+		ret = cppc_set_auto_sel(cpu, true);
+		if (ret) {
+			pr_warn("Failed to enable auto_sel for CPU%u (%d)\n",
+				cpu, ret);
+			return;
+		}
+		cppc_cpufreq_save_requested(policy, CPPC_SAVED_AUTO_SEL, true);
+	}
+	cpu_data->perf_ctrls.auto_sel = true;
+
+	switch (auto_sel_mode) {
+	case AUTO_SEL_MODE_PERFORMANCE:
+		epp = CPPC_EPP_PERFORMANCE_PREF;
+		break;
+	case AUTO_SEL_MODE_BALANCE_PERFORMANCE:
+		epp = CPPC_EPP_BALANCE_PERFORMANCE_PREF;
+		break;
+	case AUTO_SEL_MODE_BALANCE_POWER:
+		epp = CPPC_EPP_BALANCE_POWER_PREF;
+		break;
+	case AUTO_SEL_MODE_POWER:
+		epp = CPPC_EPP_ENERGY_EFFICIENCY_PREF;
+		break;
+	default:
+		/* default_epp keeps the EPP value set by firmware. */
+		return;
+	}
+
+	/* EPP is optional. */
+	ret = cppc_set_epp(cpu, epp);
+	if (ret) {
+		if (ret != -EOPNOTSUPP)
+			pr_warn("Failed to set EPP for CPU%u (%d)\n", cpu, ret);
+		return;
+	}
+	cpu_data->perf_ctrls.energy_perf = epp;
+	cppc_cpufreq_save_requested(policy, CPPC_SAVED_EPP, epp);
+}
+
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
@@ -1058,6 +1176,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	}
 	cpu_data->perf_limits_valid = true;
 
+	cppc_cpufreq_setup_auto_sel_mode(policy);
+
 	cppc_cpufreq_cpu_fie_init(policy);
 	return 0;
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 2cec54b4d2e2..3d47c07f494b 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -42,6 +42,8 @@
 #define CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
 
 #define CPPC_EPP_PERFORMANCE_PREF		0x00
+#define CPPC_EPP_BALANCE_PERFORMANCE_PREF	0x80
+#define CPPC_EPP_BALANCE_POWER_PREF		0xC0
 #define CPPC_EPP_ENERGY_EFFICIENCY_PREF		0xFF
 
 #define CPPC_PERF_LIMITED_DESIRED_EXCURSION	BIT(0)
-- 
2.34.1

