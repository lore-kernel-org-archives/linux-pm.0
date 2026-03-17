Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013054.outbound.protection.outlook.com [40.93.196.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4153E9F93;
	Tue, 17 Mar 2026 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760295; cv=fail; b=hzbbVpUDKJoGaJXW3QATsA6EyWosUs/HutbL+DirK8Eu31MJKLoIFrs+g0jUcOXePlO0d5YSmvUvwE5SXyYH2ToyAki3EKz8rPzutBXeleysu77wzve41LKGPsl7OJomcNzYNA+e/uYpauzpk2+GVYnja05nXg371YDPihhxjis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760295; c=relaxed/simple;
	bh=addAALColFKs+x4JEUXPmaeJ+ysvFkQDYIYmpzaAmfI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qBQQegjVqS93HC7n6c+G5GK9HOKhctZHPxMIkF1/TkWL+3z0dVapTsuG9+23dHG9Egp4TlFJ5qfydN0QMpSRhp3NQrNT8hBLWUThLbgCq/0Li98bsa9J4fyymhSEgw87iafR/ix9m0mcbX/PNQjL2PqCRDEjWtQIF4u13ImNTY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b5otJ3kc; arc=fail smtp.client-ip=40.93.196.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b5otJ3kc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTPHm0m5gVbQbDo69fS1DG8gp0MdG7Jh5gHlITSfEhFSpame7flSJpGwqpqcO3iXFzkeYTb6FOklWRrbNfKQ7qu93q3/Oh+dWQ8OhIIA84s4Omo1Rj9dPbrwYTAGp15WzNHM/Z6zLFMiRU5kNxlf7KWmOKg4WTwmPJrzbMqmw8Kze5QwrSZQFG7REn7VVykr64JVDmt+c7Teq3jO1QnP1z9QHjaLtSCmVpc3t0PhBXIoJvATW0rMM/RRp05MF3fRpegBfAReNb5B2F6xzTyaqO1V03OhGnXSYABNp+30UDefyXjsVQQXRFUBpWurEBvzxkN6jO0/akmvv3IWsBf+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctgUOVWfyCEMvIQHVLbQ1XH6H3q489lSv1GkXPjqUZw=;
 b=FuBkOosvqQXBhYd10D6vCboEZ7K8vTMnqLGXEl4giI9Yp8X1QENJtmHfKXsACnFfzzVNgyINohmHl33zEym/OVd9SIh2naUMl2W4o7X1ATS0rcOpZJCqbOQvw6ZtMlGRr91o6kdwxLCE+mietnJXd0v7XhPTqMrtOEBHoi0dnhko3dObhrSIqnoUPRl97dpboHo2dPVPRnrnzPrs9FinQyK8ZGAcWTVJVmo7O3EZmUQYt7/8RKL0Ip8VHz25e67KdRorBASyv7XDpSu3MezY6yL8FPt6Hwo2QgSBpPfjkC1zQPxUx7q2LICzi/m2wIYDX5qihwPfqhxccWitOQolCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctgUOVWfyCEMvIQHVLbQ1XH6H3q489lSv1GkXPjqUZw=;
 b=b5otJ3kcECjymUi9RHFftwUiN7QAP2cLbzrTP3Zn9ZWoVdCvHbbaUYlfM2Qff8vsa+VEJ8IwjaH5N9/u542iHDepQhEzw/ppgi8EWIsQffpE+Mm/FSjJDy5ZXeXaf6rbeiwmqAvcst8MuRR6L1Q2Cd8HQw5Zl7AFAkeivY/mkEdRt4/r7BX43GXYgQ7/MK1kpq7IBRe+tRiZUauVRIjA24r5h5FQQ00w3FUkEpd4sOqQqYD60xRIk379j2uMWEsa1OAic4nD8NHouI2Xi07mtLE+3uZatqh0xU3nPnMJ6OyPlRdUCYCQ11RDriKIj0e3haijjaWB8CooO1QjUbEKqg==
Received: from BN9PR03CA0892.namprd03.prod.outlook.com (2603:10b6:408:13c::27)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 15:11:25 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::61) by BN9PR03CA0892.outlook.office365.com
 (2603:10b6:408:13c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 15:11:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.0 via Frontend Transport; Tue, 17 Mar 2026 15:11:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 08:11:01 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 08:11:01 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 08:10:55 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<rdunlap@infradead.org>, <mario.limonciello@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <nhartman@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH] cpufreq: CPPC: add autonomous mode boot parameter support
Date: Tue, 17 Mar 2026 20:40:52 +0530
Message-ID: <20260317151053.2361475-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|CH3PR12MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: fc60729a-8e31-4f0f-d6aa-08de843774be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FC1Q+OA+vKKNnOyf8s7LlQPFxvN/xeqPtLK/2cOJWrGQNVWpBnMU1S9nYb6T/0LOzfG87K8mKSqVCeAEmif9uz4fKH+U9OrYk0C4A4ujnVsp/D75HUdnfT/dbf0Uxo4W00Fu7I9icDm6BuppVsrXViAg1kbx75aWJj63dvuYghAbI4T1O41ZBLfkH3ed5w+HGbyxpuiko0/VFbykPJcJViZXgm+aBFH15ZhDo9DJkjq6eJEmf11NmgDtwAboX+hChPhLWGDJ2fAhFhzA0HmZKAsXi9ltRvQRe5olqGJWEywPim6z1Fj53lEWrvTFZ3T9KQAqdWOkXoSJChQV0xxruCI+pt1sdDV3RVgQyCep5gs80ClflRtvLcnxnoaX3mzIZhVLpc+H7NOPCEC7nqedDiK9YIWm8f9YEdoT4NNvzDXAIOI+d5ydPdHxTpmkdP43Qpl5x8ACkzlRILcwkgCKI0AWN9byDslDHKDf4tzRXLoPi5zATW1Tl4o38ZhfnHIaIaWV2aYeAiWuwMSyDPenbJ+Vx5Ts+YlupPdGIkLnENb05RNomRRtLQY6qRtp+g2v3tsKvtDTAHJWS/KQi6DFiBj86oxQtBlZ30OEXylr/m1I7mGgS3IdqHF6XJxPpDlgP+1QMwC/L3miptucYug8eRBhpPafOTYZ9Pi3BHexG9QyWECyTcLnUPQBzj6cHuifNE1nLCVeokIPO8GmXBVWjbKMbcPT/Cg/259VbmuyiRHFCn2KGkizi6lsdfDrOwJVGe5ypzGUbob2Xizc3mYF3Y9y1NOuHZ7pNMU1dsq7+8iS3UuAsOskwbttSXZFd5rP
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UJ5BgstGSXMruKsCoSCdlzWSuf2x2g2iXk6mzh6vPzOAV2Tnq3GgUGi6rB7OcXbDWAnnFli+JRiYjAMKCU+KZ36eJJPIF2luqQZIr6c385Oz0DZ2UfI4UfRR3E6bT1Ya1fjmEiMDt+FSo57F979bsgQl5jue6tnmlAr+TvgzCdc/nv5HWfYGWQm6Lmw6WTq7XVLigYJ3iPNFPTuyseOlVAsI9AfVf6zGtCleAx61H0FmzZQoRPg1TGF8/Esxy9kUpfC8ewVu83AgpazUhKi63O0bbHAgEpaRYnxvL/5lP1NoNy0qQSsS9t6aH/y2OY+CU3btr+uOfmLKW7Lz2MAocCMqENThjkp8ohegyMQ+4TQYgerJZyHRDKF4tEY9NjDrIO68GgbdRDdAb4RNP98SM9mY7htXZ2qoYLjo0hVnxUY7vFWSC7XKfBZ3CAcC2II+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 15:11:24.8067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc60729a-8e31-4f0f-d6aa-08de843774be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307

Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
autonomous performance selection on all CPUs at system startup without
requiring runtime sysfs manipulation. When autonomous mode is enabled,
the hardware automatically adjusts CPU performance based on workload
demands using Energy Performance Preference (EPP) hints.

When auto_sel_mode=1:
- Configure all CPUs for autonomous operation on first init
- Set EPP to performance preference (0x0)
- Use HW min/max when set; otherwise program from policy limits (caps)
- Clamp desired_perf to bounds before enabling autonomous mode
- Hardware controls frequency instead of the OS governor

The boot parameter is applied only during first policy initialization.
On hotplug, skip applying it so that the user's runtime sysfs
configuration is preserved.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org> (Documentation)
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
Part 1 [1] of this series was applied for 7.1 and present in next.
Sending this patch as reworked version of 'patch 11' from [2] based
on next.

[1] https://lore.kernel.org/lkml/20260206142658.72583-1-sumitg@nvidia.com/
[2] https://lore.kernel.org/lkml/20251223121307.711773-1-sumitg@nvidia.com/
---
 .../admin-guide/kernel-parameters.txt         | 13 +++
 drivers/cpufreq/cppc_cpufreq.c                | 84 +++++++++++++++++--
 2 files changed, 92 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fa6171b5fdd5..de4b4c89edfe 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1060,6 +1060,19 @@ Kernel parameters
 			policy to use. This governor must be registered in the
 			kernel before the cpufreq driver probes.
 
+	cppc_cpufreq.auto_sel_mode=
+			[CPU_FREQ] Enable ACPI CPPC autonomous performance
+			selection. When enabled, hardware automatically adjusts
+			CPU frequency on all CPUs based on workload demands.
+			In Autonomous mode, Energy Performance Preference (EPP)
+			hints guide hardware toward performance (0x0) or energy
+			efficiency (0xff).
+			Requires ACPI CPPC autonomous selection register support.
+			Format: <bool>
+			Default: 0 (disabled)
+			0: use cpufreq governors
+			1: enable if supported by hardware
+
 	cpu_init_udelay=N
 			[X86,EARLY] Delay for N microsec between assert and de-assert
 			of APIC INIT to start processors.  This delay occurs
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 5dfb109cf1f4..49c148b2a0a4 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -28,6 +28,9 @@
 
 static struct cpufreq_driver cppc_cpufreq_driver;
 
+/* Autonomous Selection boot parameter */
+static bool auto_sel_mode;
+
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
 static enum {
 	FIE_UNSET = -1,
@@ -708,11 +711,74 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
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
+		/* Enable CPPC - optional register, some platforms need it */
+		ret = cppc_set_enable(cpu, true);
+		if (ret && ret != -EOPNOTSUPP)
+			pr_warn("Failed to enable CPPC for CPU%d (%d)\n", cpu, ret);
+
+		/*
+		 * Prefer HW min/max_perf when set; otherwise program from
+		 * policy limits derived earlier from caps.
+		 * Clamp desired_perf to bounds and sync policy->cur.
+		 */
+		if (!cpu_data->perf_ctrls.min_perf || !cpu_data->perf_ctrls.max_perf)
+			cppc_cpufreq_update_perf_limits(cpu_data, policy);
+
+		cpu_data->perf_ctrls.desired_perf =
+			clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
+				cpu_data->perf_ctrls.min_perf,
+				cpu_data->perf_ctrls.max_perf);
+
+		policy->cur = cppc_perf_to_khz(caps,
+					       cpu_data->perf_ctrls.desired_perf);
+
+		/* EPP is optional - some platforms may not support it */
+		ret = cppc_set_epp(cpu, CPPC_EPP_PERFORMANCE_PREF);
+		if (ret && ret != -EOPNOTSUPP)
+			pr_warn("Failed to set EPP for CPU%d (%d)\n", cpu, ret);
+		else if (!ret)
+			cpu_data->perf_ctrls.energy_perf = CPPC_EPP_PERFORMANCE_PREF;
+
+		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+		if (ret) {
+			pr_debug("Err setting perf for autonomous mode CPU:%d ret:%d\n",
+				 cpu, ret);
+			goto out;
+		}
+
+		ret = cppc_set_auto_sel(cpu, true);
+		if (ret && ret != -EOPNOTSUPP) {
+			pr_warn("Failed autonomous config for CPU%d (%d)\n",
+				cpu, ret);
+			goto out;
+		}
+		if (!ret)
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
+					       caps->nominal_perf);
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
@@ -1038,10 +1104,18 @@ static int __init cppc_cpufreq_init(void)
 
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
 
+module_param(auto_sel_mode, bool, 0444);
+MODULE_PARM_DESC(auto_sel_mode, "Enable CPPC autonomous performance selection at boot");
+
 module_exit(cppc_cpufreq_exit);
 MODULE_AUTHOR("Ashwin Chaugule");
 MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");
-- 
2.34.1

