Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794470716;
	b=zfC4qpmCMBMUlQr58RQ6IgVjAvPG3UDEO6Ur0aaw3uw+EN0OGa3QmfPctjCTABKWvO0G
	 IMbpMmgwvAEUKeNkIon8lR4vOmnQTXH/rhrR4GzII48tGIwf9ljbBkfO9r3mzqjzq7YnB
	 L2NkF4R4Ie6Q9l3rFwqaNI831CQ334NSo9u9hypWg10wfV11B59oloUU+k+55E9x99uam
	 IrfZ3zSUyRrh+Xr+pRQZpc770+XjscfltcQIYKo3tc6Vr/vs0ZX6KXcgz+qBlNe6SzzVX
	 /l5BA67bjek8+xp5f2Iub1h+KDixC7UYxRHxDoS1CX9b/4UC9jQvXnf66tOkwuHaISw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470716;
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
	bh=3DP0u6heTUKIvk6c+NeqBXteoicj2MVAZTHcqEdezDA=;
	b=zqNXuezdl9LAo8vDaAoyAD9QoBS56g7UHVmDyJ9EfD1f3QEOk7ODv0kdKamahSJRbLMH
	 DLAOJNf7x7whr9RjLd0ohbpkzfe3ufqW7zMySZUbb8zQat8O54f7pQ7WbPwy7lDv9TeTq
	 L3/SzqLk27UDJWrr+ciakxjC2vLVHGjWNEvpavfq3tx8JYt+9YIPtiMAAmAj2C57vb98a
	 RI78Xz8v0Nm5TtYFLE8vq1raRy90DSE3+VLGac6Cb00vW83BkKFlwBKelFEmajKlQWdQu
	 PWlCiofW9tZpxMgeXaD/wDakP7WlOoE7aimgYeHAPRd1ruyHBfD1Ilj8ug6w7WNauYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UEwZW5Cp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.50
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610BC606A32A;
	Thu, 12 Nov 2026 08:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 610BC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UEwZW5Cp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtuD5ZDzq6pU4YB1UeIU+26TVsf2AhWo1+ZziHMUv++Dgw4ZnIrCoN2A7HFJ3FCRcPVjasjyCUJYvtOVkG3sbM9hvo3hcuduEqO8/wcj8pSpJbgw0PFStjqeDpPu5raQiWfuXdJMJHwy5YrZHxIurxi1G0Xlvv4BQfER/3Rf4Himi7l6Kle4xDclG1iaJsdZgn4jyynqjA7347LI8/mey4IWzBP5MeBJSmvkh3fuoy/8ltL2IjH7eZwMvrlqUCFgytztAN053g16VvVns2O+viDklM3kgAvOc7gLL6JTxpA4fCZczBqij/NgD7WV/zkkL5VrvDYdJx+j1WtPGf1T8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DP0u6heTUKIvk6c+NeqBXteoicj2MVAZTHcqEdezDA=;
 b=m436iRqqB/Vwf+uaS2CCdezyPNfHeOKl3+z66QxUXRr3E29gC50i0jFU/7x27WgMUm9XQz+y6TXS3uooYLFnHsVeUTM4JbJT4igR2eOHrTgAKwJ0AAYNoi2r1ll8aypkg7NaiVfgO1EusAzUgSNoK46NcV491Yzdo36oQwEeJ54PRAaHL26jD0TF1SidaqLrH/nSQNTHUb1+epqXXd7EVQcM2/rSUP7KMexQGHfpuLJSC5751Jt0NIikBmYxekfRHCOgF+tzWe862SdgFuRXN/tTSix1iZfq73DW0N6alKWW99QfqF4poAFbzs6JpPBvAN71ihshvp6S/YFYDyJhQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DP0u6heTUKIvk6c+NeqBXteoicj2MVAZTHcqEdezDA=;
 b=UEwZW5CpGWZFKGW1DgywIISFyi5gugiQnxYbanAkyKZoEAQaibTVaeRMyiM8dHJUOOxLlV5pUcAPjbBik8wJp4o5INLGJhapOzsozgB+7sPVmte25kYvBeSBqoojzOB2tjnzCDx0lh0OQXr4gRv0L3xwEHxzC/xGLZrHP/V5uj7CZq4xfV2VC7mx3CmGG5x7dJ1+qXGKedViwM/p+4OLfFPnWmzuNXyzW/LPB0LxXcaxc0wjwsqf2gxPkCTNlKDB+0ZsUTnR5j4TYDHwiF3UvdBd3W8UYtetHlN+Hz1fHK6k6JQqKWrSvH63EbT5Hqj1dFLqCpFzAWeSjv4IYFts3g==
Received: from CH2PR03CA0005.namprd03.prod.outlook.com (2603:10b6:610:59::15)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 08:05:08 +0000
Received: from BN2PEPF0000A7FE.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::27) by CH2PR03CA0005.outlook.office365.com
 (2603:10b6:610:59::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 08:05:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000A7FE.mail.protection.outlook.com (10.167.245.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 08:05:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 00:04:52 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 00:04:51 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Thu, 12 Nov 2026 00:04:44 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <christian.loehle@arm.com>,
	<pierre.gondois@arm.com>, <ionela.voinescu@arm.com>,
	<mario.limonciello@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <lenb@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v6 RESEND] cpufreq: CPPC: Add autonomous mode boot parameter support
Date: Thu, 12 Nov 2026 13:34:42 +0530
Message-ID: <20261112080442.4007723-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FE:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1000ee-8ca9-4347-b152-08df4093aaca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|23010399003|18002099003|6133799003|261009223027099003|3023799007|13003099007|921020|56012099006|11063799006|261028144727099003|261021121427099003|261102123227099003|261026140227099003|261026121527099003|261022113327099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Hhia6MmIOGDwQv9uKynqKv+RC0QBcceO9b017lw58lRbwmB0CbZEt3T5D2XDA1NHOcVJ2XjnoyCp81u1d4VG5oWwlo8Y2BOczxWvSCnamyGb6ohU/hPbF/R/5iEfmuJCwyj5oZpSYkiBzJMNMLvXecyLjsivCf9wCxnnLI7R0akhpSzoznyQj909jF4V2OvpDzrDBiRjNx3vHVC5VCQK5T5eHFvJGsghvaaWparlnxhWlmvAoxzaZf7pMBxBuaMoipmOBcnU2s3vtX4lRgqddJd4+8+ZTAyv7vDLAg6sYWSco6wCqTdOJr9RIKlXSyaW9BtyrlC7Ge9xw6bm7vIWXaz6UMxHvRDxhwvNYb2wtxQTL+HJaJcEBWy/uCBJx3+ah3NBhyvQzTiA+xuVrQ8eWoqqH5UUUu2TLbzN8DU6nIsUGre3XBn8y+T/2Imnt2WWjmq2bh0jZ4IoA9hdW3ziu+8F+9wZPExhE87qPVkcGkXviOV0+QVfs/tkAjezBKM4NxPuI1yPxF1UDZXJsNTNFs27WoxnyOXx2UMKjqy4an/b5O55NEt44KWET22KENojCvZKgu/EQozMjtn3n7RzAbTaAhxJVUNOrOfblHF6VAOmbTTVfexJ8P+xGLzFj28/4ym0TYQuVj0Lbr4vqdq+tpr7cqvfQwsY2oovgJRMMdTOgVi/R9QOKx1II30kct60k9+UTD8lpOUZ4etHm/cMiNR+DKu941VhKchWKF+Y+MF3pvExO1mgkDqb5uj5PK3O
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(23010399003)(18002099003)(6133799003)(261009223027099003)(3023799007)(13003099007)(921020)(56012099006)(11063799006)(261028144727099003)(261021121427099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022113327099003)(261022105027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QHKEBCl6NDGba7Dt69aC57kyGm6SlfhXVFrrSi115KQnxzA3JlIrC50ANv4kQ0+kqlyEj1Q/iuoRzvgQdzn5Kba+EpmXT6u+40ye8Mf9y2oQrE83zw9mV0waDndnvJ7M7R1bxyInym6TccDhIf4QdiwtL+5WWVmj0TRnV1IHxzFxqbW3sjyM1QYdSk6g79pQDMszaUc2ERntqBBSnIOyWsdQL2ShZJxWHjeNUJ8pa9fmFzD9qPPHuYKN1i1Qq2IUtvxtLZPSAUJ7DVE7oL4Aasjd54YTRIOrkP2KQIsl1oFiVlbdmjcyjAdUAVxWXTHaj4kdcEyAsxMj9ziUhm2d9XKxkEUf019K7TP+FqjeZjIbGNEUGVmCIdruGvLscOXQs/dOa9/qiUkrhd8zaDvDhMa9lmDH4gBwUaefJOXjE9acF2wifgWRQXk7pROrQsad
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 08:05:07.7906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1000ee-8ca9-4347-b152-08df4093aaca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A7FE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382

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
Resending v6 with base-commit info and Pierre added to Cc.
No changes to the code or commit message.

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

base-commit: a917b5968c17196b98b514158de800194d09e505
-- 
2.34.1

