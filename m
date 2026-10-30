Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793381355;
	b=NJzPGfu9e+f0PsIOcDBgAy1/HlGkEDAeiSGbM3U/vunCkjXhyAbfPN9fLE2MLkdObliQ
	 EunuzANjbO7vtju022K4SfYzhyr2BRyTJc/y8mLZiMRlCro1Y60S6q3LnYc2eAHNRz0+u
	 UeoDL8XRz9waOdLM289fJ7YW0EaLH2DHHCsG8Gx3GYY+8HtSLrkTGeEGOp25A/yPuIWI8
	 aDQ7GnZi6DaDmyTsl/0tYle0I3+hgvrWYG79nTAocK9YAFPC9vsbmgcXfYq3w1QmW3vDm
	 0P55d+WbKB7XoRyZa5NOrMM3NNuvg7YHGbBrOLvwA4XV4SthfQ3VE2czGa9zoNLdSpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381355;
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
	bh=z8zjCwdzwB95g7GuA4NM20BM2ov5FEKQ2bGoOIajImo=;
	b=fZUShc5xo5A24cev/swHW3qsmgUYmVUlX8wRcMWd856r9pY/f/1fksbc9zC2GLRhKxBH
	 4ABbyi+IY96YzT8nbOQ+8c6KtiJ9f8quxSZDx51k6ifiL6DqYxbCS86zHRzMlcxLb2JPC
	 gGoBmrRUQDFtygu88kAYQEoRr7rD8uqtDbzZpmDvj9FLAE0TJ0r3wjRTDIaVdSFWyUo/J
	 MSys/F9ss3k1tmiD6u1jaElVgj9y5Rmo5hZY756o+Yyu+TSmP224C95YKdnEbUJ1ypJUb
	 AEeNlwatMpLlsbtkUod7FvCPdmZE1Z51RxxMxMidpSZEuIiVwrRGuJot48eF632byKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iuojA1r9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.60
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FA0606A32F;
	Fri, 30 Oct 2026 17:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67FA0606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iuojA1r9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvopeUSdwMhiY+0LOlNEpAxKrcMwRg1TxUxRrGIMZFhN/spMxUr9SbivHnUlII92L/WBKTJinPUzDZ5lP5wEmNstYF/WWIzsSx+/MpCReJT38izVxQfp1bhOyVLcpbCq9WC9K4PTkNixBDtilaHqlpgm2hH1E2yhIzyae1OPqMxGZK+HiCSCQQogdiWBS0cRhMWiILVhGUhjsWMzsaYzXWZXVootgO1Vod2UnyMFtTSSlGt/R8mrSwqht2AVxPpHZ10XU6UKWl51NXa8Plxws4Z+A5VZh9E+YsSWI+0GGorVCcTdiPLDKY9y8fQfP8I9hR0lxZkwmkGtNo7FhJTcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8zjCwdzwB95g7GuA4NM20BM2ov5FEKQ2bGoOIajImo=;
 b=ZHmJYVQmCPrwHk1REbL5E0JveuGUtluGf56gHw9DUC5x5CvUBY4Ybo2abS/Ktnv5X9npXnGB3OVxQSw5V0fXHJmdWBmE20JjDlp5Y+2wIfKADxdFOnM8WggCGABT1kKkaWbJ+/nLJPA/qy2An8sunEVrn/E8+iMXR8TPQdb8BFgO2im6OMI6DILtTMWFySrnukzfR2aHyjYCqAPz+ugYaLUT3fEs7Qk6yjorJUHw/oMDaI/kfywnK4hBnpANiTLhws7TjxOVahm+hBXzdySNoS6cxZtxte1reAw29NTayNCnCsoUbm3r1AMBTTeJ7NxMcRW+a0eCJh2NOgh549Y6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8zjCwdzwB95g7GuA4NM20BM2ov5FEKQ2bGoOIajImo=;
 b=iuojA1r9ZY/cFdVxE+dN30KZl7gpa89evNz40HzeEzi4BQBSLeEMGkDm9HWrahJmMYkbq6PUm0kkmFOJFmnUS0MuDW7h96cHcjpAtf1OB6RGGaStZVUq+R7ghIZm8+Or9DyQiUZjBBQyXs1Jnvsg51eu9STfmIFmeeyZqHygf48a8Luw6I+pVYXNEcr0oHa3ZT8/AssZDekVG40HAEzsrdxvIFElp46xd+H2gsXMchX6ATxgXEKZ1kbpYg5rDvMjcFhsiiyi/Aq4Tc7MetIdqW0o6Y2jaTab3e92Zyhz+xabj8evecw1uyX4tkIdE7XfImK2L9g/i2BOUOe1HsC0TQ==
Received: from BN9PR03CA0511.namprd03.prod.outlook.com (2603:10b6:408:131::6)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 17:29:08 +0000
Received: from BN3PEPF00022BD0.namprd03.prod.outlook.com
 (2603:10b6:408:131:cafe::aa) by BN9PR03CA0511.outlook.office365.com
 (2603:10b6:408:131::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 30
 Oct 2026 17:29:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF00022BD0.mail.protection.outlook.com (10.167.248.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 17:29:08 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:28:46 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:28:45 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 30 Oct 2026 10:28:39 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<mario.limonciello@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <mochs@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v8 3/3] cpufreq: CPPC: Reflect the OSPM nominal in boost and limits
Date: Fri, 30 Oct 2026 22:57:45 +0530
Message-ID: <20261030172745.2045743-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030172745.2045743-1-sumitg@nvidia.com>
References: <20261030172745.2045743-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD0:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0d53e1-42a9-45b8-64c1-08df36ab4def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|82310400026|36860700016|921020|11063799006|56012099006|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|261022113327099003|261021123027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	oG2LKb6QdjKVgM8jwDubn/hCwSP3ZyK2a9yefgYe9vFJxhtywSYupCHb4cxFa3zYFEWBiUJlsoJOiWVPO+oglJZ5Zbg956peSxEAyd8rvNciCI7pBwyrM3n9ag2n4Izt02Z3jywrLaQJH7yLHUCAVB2RK/ZErzyAhE/6nOcE3XTEtkvI2U0WTOw1c/ep4xXkLtaEev0nyuDtgMIJvhigK8bVqX5aNxAQ99C8V8+WBJ5yn0xWaSrlo97Yzm3eIO5YX8hw8LbrLuDY0XLDo6YGetLB2VU8cLy/nHyJtu/BP5JSlwTvmJW/5V235gEdnAgV7RjSsaCEAMwVk+epnvu8c2OetjpQicOv5E8z4OcEpXDuNkO4DoaB8TEeYxmbuo3QEZ1xKjOsi/pPG0D5tEgrsXf4F3N3hF06RjN4r31ENQOwEeEaJPxrjzACDTapEvhkPkj7UhtPbA7edyBGPossrhRQ58LqNylprBXnbar3iKQoKk176g9HFP1fr1IyScdJ5Or8ezRho/FM4DY0QUNW6MbYJa9kM7tp6aOugDG2ROLdnU5f1iujYFdVc99zQZnBEJwDLyv6KwLK3cESyCkBJ0LzL+7tRiL0k0ktdaIi+Q14G6Y/0bt+lQvTD1OjpJXH1ja970BjR55MsmrdXpn4554/gDCIU6Tqk+Va6qeG0v3tBZ7YTfCIHca5cGuxd+Y1CY1co+owaO29Nq7WpCMHaNqWfkZLu3SPbuNI5lNi0maz6Vfvso1qfSZQxklKpi8Y
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(82310400026)(36860700016)(921020)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(261022113327099003)(261021123027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rIDuPYUdnRTlNnlq9A8rAwSeUIGTOodOXABIC1J38bdHtzPb+9sXV5D96BIqNmZCR/JLNEOw4V5BI049TkJWJjHqSo16EC2UMJwNWP9sdfOtNmIhxvg5fMF6WfGRz/Q4yyO2uKFQX8wEFu+XCL+mZ63ome6dEtMmZMqJlCgQ2L0vUPyTuFPSlyZN/3i/7k1zMfNgXJAqHfrI3UhfIQciwOrQ9Myxe29bHtR9wGH8L6CbOJcG+KzjEXzCXn5xn3RGhiePO04+wal4JfQN8lxgyYzd811upx2bO2h7Ftfp1pv3iaycVMR/o1y/TDTY/g1tmuYhMdQVMsELYJLsUnh53DSOjljyqNJBUj7HLuvauWiL3K04vPcaQbfsyw+ZwTsfUeHrzOdC48tKb84vByXEel3qC+k199nTBLkjakItbH2ok+fHqEHDw0q3roYc035d
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:29:08.3075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0d53e1-42a9-45b8-64c1-08df36ab4def
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493

Boost is the performance range above nominal, so lowering the OSPM
Nominal Performance enlarges the boost range and drops the non-boost
ceiling. Keep the policy limits consistent with the register.

Add cppc_cpufreq_effective_nominal(), which returns the OSPM Nominal
Performance when set and the platform nominal otherwise. Use it for the
non-boost ceiling in set_boost(), and to update the policy limits when
ospm_nominal_freq is written.

The cpufreq core caps scaling_max_freq with a per-policy QoS request,
boost_freq_req, that it sets to cpuinfo.max_freq and refreshes only when
boost is toggled. A write to ospm_nominal_freq changes cpuinfo.max_freq
without toggling boost, so cppc_cpufreq_update_nominal_limits() updates
the request itself, rather than leaving scaling_max_freq at the old
nominal.

When boost is enabled the ceiling is highest_perf, not the nominal, so
the update is skipped. set_boost() applies the new nominal when boost is
turned off.

A platform with highest_perf == nominal_perf has no boost range at boot.
Lowering the OSPM nominal from sysfs can create one. The core, however,
adds its boost FREQ_QOS_MAX request only at policy setup, and only if
boost_supported is already set. Set boost_supported in init() when the
OSPM register is supported and highest_perf > lowest_perf. Boost can
then be enabled after the nominal is lowered.

Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      |  4 ++
 drivers/cpufreq/cppc_cpufreq.c                | 72 ++++++++++++++++++-
 2 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 6af7fa86e44c..d219fc27a0c9 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -362,6 +362,10 @@ Description:	OSPM Nominal Performance (kHz)
 		Write a value in kHz, between the frequencies corresponding to
 		Lowest Performance and Nominal Performance.
 
+		While boost is disabled, cpuinfo_max_freq is set to this value
+		and scaling_max_freq cannot go above it. While boost is
+		enabled, cpuinfo_max_freq is the Highest Performance frequency.
+
 		The register cannot be read back, so a read returns the last
 		value written, rounded to a performance level. It returns
 		"<unset>" before the first write. Reads and writes fail with
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 662397526433..7cac31de7325 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -915,6 +915,29 @@ static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
 	policy->driver_data = NULL;
 }
 
+/*
+ * Return the non-boost performance ceiling. This is the OSPM Nominal
+ * Performance the driver last requested, or the platform-reported Nominal
+ * Performance if none was requested.
+ *
+ * The register is write-only, so the requested value comes from the
+ * software-tracked state rather than from hardware.
+ */
+static u32 cppc_cpufreq_effective_nominal(struct cpufreq_policy *policy)
+{
+	const struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u64 ospm_nominal;
+
+	ospm_nominal = st->regs[CPPC_SAVED_OSPM_NOMINAL_PERF][CPPC_SAVED_REQUESTED];
+
+	/* U64_MAX means OSPM has not selected a nominal level. */
+	if (ospm_nominal == U64_MAX)
+		return cpu_data->perf_caps.nominal_perf;
+
+	return (u32)ospm_nominal;
+}
+
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
@@ -974,9 +997,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	/*
 	 * If 'highest_perf' is greater than 'nominal_perf', we assume CPU Boost
-	 * is supported.
+	 * is supported. A writable OSPM Nominal Performance register can also
+	 * open a boost range at runtime by lowering the nominal, so assume
+	 * boost is supported in that case too, letting the core register its
+	 * QoS request up front.
 	 */
-	if (caps->highest_perf > caps->nominal_perf)
+	if (caps->highest_perf > caps->nominal_perf ||
+	    (caps->highest_perf > caps->lowest_perf &&
+	     cppc_ospm_nominal_perf_supported(cpu)))
 		policy->boost_supported = true;
 
 	/*
@@ -1280,11 +1308,12 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	u32 nominal = cppc_cpufreq_effective_nominal(policy);
 
 	if (state)
 		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->highest_perf);
 	else
-		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
+		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, nominal);
 
 	return 0;
 }
@@ -1494,6 +1523,41 @@ static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
 CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
 			 cppc_set_perf_limited)
 
+/*
+ * While boost is disabled, the nominal is the ceiling. Set cpuinfo.max_freq to
+ * it and update the core's boost_freq_req to match. The core only syncs
+ * boost_freq_req when boost is enabled or disabled, so a plain nominal change
+ * must update it here. Without that, raising the nominal again would leave the
+ * stale request capping the policy.
+ *
+ * Refresh the limits directly rather than leave it to the QoS notifier, which
+ * only schedules the update, so the new ceiling is in place once the write
+ * returns. The sysfs store path holds policy->rwsem, which the refresh needs.
+ */
+static void cppc_cpufreq_update_nominal_limits(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u32 nominal;
+	int ret;
+
+	if (policy->boost_enabled)
+		return;
+
+	nominal = cppc_cpufreq_effective_nominal(policy);
+	policy->cpuinfo.max_freq = cppc_perf_to_khz(&cpu_data->perf_caps,
+						    nominal);
+
+	if (freq_qos_request_active(&policy->boost_freq_req)) {
+		ret = freq_qos_update_request(&policy->boost_freq_req,
+					      policy->cpuinfo.max_freq);
+		if (ret < 0)
+			pr_debug("Failed to update boost limit on CPU%u (%d)\n",
+				 policy->cpu, ret);
+	}
+
+	refresh_frequency_limits(policy);
+}
+
 static ssize_t show_ospm_nominal_freq(struct cpufreq_policy *policy, char *buf)
 {
 	const struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
@@ -1552,6 +1616,8 @@ static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
 	st->regs[CPPC_SAVED_OSPM_NOMINAL_PERF][CPPC_SAVED_FIRMWARE] =
 		cpu_data->perf_caps.nominal_perf;
 
+	cppc_cpufreq_update_nominal_limits(policy);
+
 	return count;
 }
 
-- 
2.34.1

