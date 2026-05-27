Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013012.outbound.protection.outlook.com [40.107.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA25C3BF684;
	Wed, 27 May 2026 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779913609; cv=fail; b=GyQKxH0/RHbMEzx9qJeiwWNMr0C8uH2IXJLDUooZ8HPc8gRWasFHq5t5fI2jhn/Tzhvp1J4xC3fyewvKwVku6p2XreFNIJM+tAcg6C7HL0tpfYCo5aDHl5vYsA8QXO1ivYHD6FkftJ6qXXEMWrgMyAd19NnoQJiZLfEkvlzehcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779913609; c=relaxed/simple;
	bh=y0jYMBLjmLxBIJeTWu5Nyl1GspLcy5QRlvKIPnZCavg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SzXrdBSfNOEQD4TLy+6OOWciMjyXRhz8Vk72EXd0LOVtp+JjzTn8NPtoQPqZjHOcJ8HNmNqpMQPfvbAniHg3shOwD/wXhTKduDabmiaOvo6pJP/bxBhh64fafsu01XjAHWItHhjuqiSHUacJstaViaa+GdkdTIWm6N4GWYLqh8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VRIB8/us; arc=fail smtp.client-ip=40.107.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VRIB8/us"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSpJrTATzjCJFGaMJf49qj3EA3oEGstGEbVrpS2PS4gE/3yQtrFLNr4J4cVYlYWedQSV+/RSEt4CRxTMLoENAxrl+vhByoc3paSdqRBHdP+4HYyGtlER63wtPFWKiTe3OUmKBTussIzRAYSxZzivk5A2C3mboesLvHcCHsq7J4+8MBvDp0S1fpgnKX5b22kNrvVu5lK6TZGKbgBOjtS6lwkEb+jo1DgURzBDlKfC4rgVZEAsxEXxUdgNReC10VR77VHVL3BsxeWvGzOJKGU8xCHK1NZUADc9MGXM4ySPQ1fmSfHUsPIryGqw1NhR+ThV01L2X3HRHHKoWPna1asH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJ32RM4pcrn0RFFNjtbCOwRr3V9GyKOkeew6uGW9OUE=;
 b=h25Jg6DbNPvfRinSiQv3fmGTybl8P4VOohxY7B31GU9uajKvOAPwMBtYUGhldcAkR0FeTZ7OxeDarFrsHMJ9x7Gh94WGCFlPiMsLpOOMpH9Wxw4BVBnZrJMoRWUKjvj5hLuiqm/8gOjSyR4VT+jANyrIVgto+ESvK3wazgVwovIDTa+ByRT6tzU4jrxquJy7hiNxvpcDVwBdNHph/0+5H6n8yFAHHtuW1DfVgbbF56c62K3sSje/YurHT0fmGAIwKv91DIttaaPghDSDBQGgLmArdWzDgzCKUCDfZc9Wsv+opwt36szzBljO8rzay/mfNXrr3YXc4nQj5cnCde1uMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJ32RM4pcrn0RFFNjtbCOwRr3V9GyKOkeew6uGW9OUE=;
 b=VRIB8/us95e5gWDlfFMgVoY6uREwrYC/1GFFS4f//la1+gX7cotWOY1ItZafPVZAHzLW6ShcxvPdVkjogiT+jMkeNCQ4vtRa/nWXIG2w7ucYTVlTULvYkoYN5mhmd7MkOfdktVkfV5/W1uhDhAAE8ZqmFwV+5PGeMHshfSy1m6ZA8TDvAWLc6lYmz2qNVPCq1kyo2vIi21ahlbQDe/kzwvtHchIKc0x4gjxgMes3g+gd2PDPqAR8fN2n936Lkgc8vG7OsIhXKXHrazw6DlGZhbPDtpOy6oFAE0Urrgbxx0YAeDSx5C0AfTKO1U5NW5UcEWgExyy87+Sz354H2TJM5A==
Received: from CH5PR04CA0023.namprd04.prod.outlook.com (2603:10b6:610:1f4::23)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 20:26:40 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::5f) by CH5PR04CA0023.outlook.office365.com
 (2603:10b6:610:1f4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 20:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 20:26:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 13:26:24 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 27 May 2026 13:26:23 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 27 May 2026 13:26:18 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<rdunlap@infradead.org>, <mario.limonciello@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <mochs@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v4 2/2] cpufreq: CPPC: add autonomous mode boot parameter support
Date: Thu, 28 May 2026 01:55:50 +0530
Message-ID: <20260527202550.206828-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527202550.206828-1-sumitg@nvidia.com>
References: <20260527202550.206828-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d178303-b9c9-4e5e-8dcc-08debc2e4286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|921020|13003099007|3023799007|11063799006|22082099003|6133799003|18002099003|18092099006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ExgWt+x2brjCaN7gGrfo0u5zfL6eRJEyK9mLXxypybtVosdXyjuelAaQrc/DQFmAcFxHjZFiI7Kv/f/N7rctalEYy4K7v7pv6oaFDsezZGnAauJH6W0JX9RpR8EDLy7R+QKKJCvDs75rb9BKtY0QJthoFe4GLc6jwP844wZEwgj3xooxbRfNQVHrhHHJmhRGiiKglrzSeSQqHrv9pPGKFXrI/NMGgqnzWKOYFXPQ25pi+rnM0sCz45Z2YcRbSufvEMy/fRM14qetLT+F5z0FM9wyT5m+hlbnCJiIrHwVsMLuHT/EoDGRsLcTrvmBWdpZMKzN/Gx47ZJbVoFYlYWP+3FpktpHFGBeLPDEhEasFJMUF3TSzEh95x+071xERoSnbRSTQT+mdwCsjNlj7MXSi0yer9xM8RMDZSo7JumQFdaBKltlnfbzVdNYkfS0KNl2+1lcPJ9lWEA8mQkbsLbvkeTjkgqq8ytF+BqrmQliBHj1Cxt2XveeKcRfp5zygiyEmfUCVtXfpkd6xjMXIs70sO6WU/aEBrDFe+OmKkH8JrbY7VO2FCPwbI2BAu5JIDPtR/ZzsUNkjAGsXIhd4/UGmR7PqDzSxkRhP+4znYRWI3RHxwg72S+8tOoX4+Xkn6gtZmDgb6EoqYrVDig9hQc+LbJD9OzY36+F80sW3QeDe09HJ8XZcoyjsLEMYj2XaC90kFBgYQ6z4m/a9i2CcEHh2S37XPAQgemx35LNc1wiQLjwAauJQQ4PaTiUwmqDcc++PhhGbE28PpUqvqNcYIBcvg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(921020)(13003099007)(3023799007)(11063799006)(22082099003)(6133799003)(18002099003)(18092099006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NA9nti+xFeFvqlfyjw7AZA8JpIyDfzpOxCCkPoyytw36dKRktUsqSCqpt4ko+IQ73Uk2RjZqRgISiYeck538qNRjld5wI03SUOW27jaM45AyAfowaQWCAEVfcJAXr5vuX6pIvzvmDk9d97cQxTIVLiGP39w1omx/QknBLjAQZ0DgA7jgdra1csiCyD7HNg5CA9Cdk4nvgs/YmSJqmMqlTpwm7D8ttNL/sPew8dPZnS4ptkTx5kOeCqKP5cQSdrPQ8jtUTZvqUCRZ8BdgEUFvaobCwE9bVKe9bsZK1MCBCNosnzkKNS2SEGvgKCB5xBQ+c74/LwQUdCuuOgZyyXbDdMvI+0AgYRMpLQPKROXUCmaRN6ldgZbq6blLfdXJwrFLGjC1MYEGTqBXi9XE1VE/kHxY4emWM+p1eAQyUyiPH06sTsN6LEs3GQ+rAhNBYwNW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 20:26:40.2588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d178303-b9c9-4e5e-8dcc-08debc2e4286
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231

Add a kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable
CPPC autonomous performance selection on all CPUs at system startup.
When autonomous mode is enabled, the hardware automatically adjusts
CPU performance based on workload demands using Energy Performance
Preference (EPP) hints.

When the parameter is set:
- Configure all CPUs for autonomous operation on first init
- Use HW min/max_perf when available; otherwise initialize from caps
- Initialize desired_perf to max_perf as a starting hint
- Hardware controls frequency instead of the OS governor
- EPP behavior depends on parameter value:
  - performance (or 1):         override EPP to performance (0x0)
  - balance_performance (or 2): override EPP to balance_performance
                                (0x80)
  - default_epp (or 3):         preserve EPP value programmed by
                                BIOS/firmware

The boot parameter is applied only during first policy initialization.
Skip applying it on CPU hotplug to preserve runtime sysfs configuration.

This patch depends on patch series [1] ("cpufreq: Set policy->min and
max as real QoS constraints") so that the policy->min/max set in
cppc_cpufreq_cpu_init() are not overridden by cpufreq_set_policy()
during init.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
[1] https://lore.kernel.org/lkml/20260511135538.522653-1-pierre.gondois@arm.com/
---
 .../admin-guide/kernel-parameters.txt         |  20 +++
 drivers/cpufreq/cppc_cpufreq.c                | 146 +++++++++++++++++-
 include/acpi/cppc_acpi.h                      |   1 +
 3 files changed, 162 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6f0910abdd25..5182905719ed 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1047,6 +1047,26 @@ Kernel parameters
 			policy to use. This governor must be registered in the
 			kernel before the cpufreq driver probes.
 
+	cppc_cpufreq.auto_sel_mode=
+			[CPU_FREQ] Enable ACPI CPPC autonomous performance
+			selection. When enabled, hardware automatically adjusts
+			CPU frequency on all CPUs based on workload demands.
+			In Autonomous mode, Energy Performance Preference (EPP)
+			hints guide hardware toward performance (0x0) or energy
+			efficiency (0xff).
+			Requires ACPI CPPC autonomous selection register
+			support.
+			Accepts:
+			  performance, 1:
+				  enable auto_sel + set EPP to performance (0x0)
+			  balance_performance, 2:
+				  enable auto_sel + set EPP to
+				  balance_performance (0x80)
+			  default_epp, 3:
+				  enable auto_sel, preserve EPP value programmed
+				  by BIOS/firmware
+			Unset: cpufreq governors are used (auto_sel disabled).
+
 	cpu_init_udelay=N
 			[X86,EARLY] Delay for N microsec between assert and de-assert
 			of APIC INIT to start processors.  This delay occurs
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7db33761e899..5ae164fce557 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -28,6 +28,52 @@
 
 static struct cpufreq_driver cppc_cpufreq_driver;
 
+/* Autonomous Selection boot parameter modes */
+enum {
+	AUTO_SEL_PERFORMANCE = 1,
+	AUTO_SEL_BALANCE_PERFORMANCE = 2,
+	AUTO_SEL_DEFAULT_EPP = 3,
+};
+
+static int auto_sel_mode;
+
+static int auto_sel_mode_set(const char *val, const struct kernel_param *kp)
+{
+	int *mode = kp->arg;
+
+	if (sysfs_streq(val, "performance") || sysfs_streq(val, "1"))
+		*mode = AUTO_SEL_PERFORMANCE;
+	else if (sysfs_streq(val, "balance_performance") || sysfs_streq(val, "2"))
+		*mode = AUTO_SEL_BALANCE_PERFORMANCE;
+	else if (sysfs_streq(val, "default_epp") || sysfs_streq(val, "3"))
+		*mode = AUTO_SEL_DEFAULT_EPP;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int auto_sel_mode_get(char *buffer, const struct kernel_param *kp)
+{
+	int *mode = kp->arg;
+
+	switch (*mode) {
+	case AUTO_SEL_PERFORMANCE:
+		return sysfs_emit(buffer, "performance\n");
+	case AUTO_SEL_BALANCE_PERFORMANCE:
+		return sysfs_emit(buffer, "balance_performance\n");
+	case AUTO_SEL_DEFAULT_EPP:
+		return sysfs_emit(buffer, "default_epp\n");
+	default:
+		return sysfs_emit(buffer, "disabled\n");
+	}
+}
+
+static const struct kernel_param_ops auto_sel_mode_ops = {
+	.set = auto_sel_mode_set,
+	.get = auto_sel_mode_get,
+};
+
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
 static enum {
 	FIE_UNSET = -1,
@@ -645,7 +691,9 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	struct cppc_cpudata *cpu_data;
 	struct cppc_perf_caps *caps;
+	bool set_epp = true;
 	int ret;
+	u32 epp;
 
 	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
 	if (!cpu_data) {
@@ -715,11 +763,87 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
-	if (ret) {
-		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
-			 caps->highest_perf, cpu, ret);
-		goto out;
+	/*
+	 * Enable autonomous mode on first init if boot param is set.
+	 * Check last_governor to detect first init and skip if auto_sel
+	 * is already enabled.
+	 */
+	if (auto_sel_mode && policy->last_governor[0] == '\0' &&
+	    !cpu_data->perf_ctrls.auto_sel) {
+		/* Init min/max_perf from caps if not already set by HW. */
+		if (!cpu_data->perf_ctrls.min_perf)
+			cpu_data->perf_ctrls.min_perf = caps->lowest_nonlinear_perf;
+		if (!cpu_data->perf_ctrls.max_perf)
+			cpu_data->perf_ctrls.max_perf = policy->boost_enabled ?
+				caps->highest_perf : caps->nominal_perf;
+
+		/*
+		 * In autonomous mode desired_perf is only a hint; EPP and
+		 * the platform drive actual selection within [min, max].
+		 * Initialize it to max_perf so HW starts at the upper bound.
+		 */
+		cpu_data->perf_ctrls.desired_perf = cpu_data->perf_ctrls.max_perf;
+
+		policy->cur = cppc_perf_to_khz(caps,
+					       cpu_data->perf_ctrls.desired_perf);
+
+		/*
+		 * Set EPP per mode. 'default_epp' preserves the BIOS/firmware
+		 * programmed EPP value. EPP is optional - some platforms may
+		 * not support it.
+		 */
+		switch (auto_sel_mode) {
+		case AUTO_SEL_PERFORMANCE:
+			epp = CPPC_EPP_PERFORMANCE_PREF;
+			break;
+		case AUTO_SEL_BALANCE_PERFORMANCE:
+			epp = CPPC_EPP_BALANCE_PERFORMANCE_PREF;
+			break;
+		default:
+			set_epp = false;
+			break;
+		}
+
+		if (set_epp) {
+			ret = cppc_set_epp(cpu, epp);
+			if (ret && ret != -EOPNOTSUPP)
+				pr_warn("Failed to set EPP for CPU%d (%d)\n", cpu, ret);
+			else if (!ret)
+				cpu_data->perf_ctrls.energy_perf = epp;
+		}
+
+		/* Program min/max/desired into CPPC regs (non-fatal on failure). */
+		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+		if (ret)
+			pr_warn("set_perf failed CPU%d (%d); using HW values\n",
+				cpu, ret);
+
+		ret = cppc_set_auto_sel(cpu, true);
+		if (ret && ret != -EOPNOTSUPP)
+			pr_warn("auto_sel CPU%d failed (%d); using OS mode\n",
+				cpu, ret);
+		else if (!ret)
+			cpu_data->perf_ctrls.auto_sel = true;
+	}
+
+	if (cpu_data->perf_ctrls.auto_sel) {
+		/* Sync policy limits from HW when autonomous mode is active */
+		policy->min = cppc_perf_to_khz(caps,
+					       cpu_data->perf_ctrls.min_perf ?:
+					       caps->lowest_nonlinear_perf);
+		policy->max = cppc_perf_to_khz(caps,
+					       cpu_data->perf_ctrls.max_perf ?:
+					       (policy->boost_enabled ?
+						caps->highest_perf :
+						caps->nominal_perf));
+	} else {
+		/* Normal mode: governors control frequency */
+		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+		if (ret) {
+			pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
+				 caps->highest_perf, cpu, ret);
+			goto out;
+		}
 	}
 
 	cppc_cpufreq_cpu_fie_init(policy);
@@ -1126,10 +1250,22 @@ static int __init cppc_cpufreq_init(void)
 
 static void __exit cppc_cpufreq_exit(void)
 {
+	unsigned int cpu;
+
+	for_each_present_cpu(cpu)
+		cppc_set_auto_sel(cpu, false);
+
 	cpufreq_unregister_driver(&cppc_cpufreq_driver);
 	cppc_freq_invariance_exit();
 }
 
+module_param_cb(auto_sel_mode, &auto_sel_mode_ops, &auto_sel_mode, 0444);
+MODULE_PARM_DESC(auto_sel_mode,
+		 "Enable CPPC autonomous performance selection at boot: "
+		 "performance or 1 (EPP=performance), "
+		 "balance_performance or 2 (EPP=balance_performance), "
+		 "default_epp or 3 (preserve BIOS/firmware EPP)");
+
 module_exit(cppc_cpufreq_exit);
 MODULE_AUTHOR("Ashwin Chaugule");
 MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index dc70a8215a3e..14c6d5d0ac12 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -42,6 +42,7 @@
 #define CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
 
 #define CPPC_EPP_PERFORMANCE_PREF		0x00
+#define CPPC_EPP_BALANCE_PERFORMANCE_PREF	0x80
 #define CPPC_EPP_ENERGY_EFFICIENCY_PREF		0xFF
 
 #define CPPC_PERF_LIMITED_DESIRED_EXCURSION	BIT(0)
-- 
2.34.1

