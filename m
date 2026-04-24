Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010032.outbound.protection.outlook.com [40.93.198.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6461237C107;
	Fri, 24 Apr 2026 20:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777061971; cv=fail; b=EXNH2i50WCSFAdWH8OeWqzFU4L1qm9iA2GK7viwzNyYhcAtqB7U5Ozxuwp/rZ6tWhbTFsArhchcyhrs4+8wcIbbPWR9iR++movGoXj7hFSQ0sz7Azv2fsSBdSrIanJ5qJKPJLN/FxWi3J4qwXeM752hFyrMXmldLlJ+WlTcM3KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777061971; c=relaxed/simple;
	bh=UeTNcDOO/NJTVJYkr5n8XEJh8Jdwc0zMBefNOhVd/1o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G2prrbi713rD2H4VHu1gtRFZM0g3U5neFi9Wmj1U/QFUgfNF1MK/IpzDFWVAdQ4RTczgubp2I1k38xw3nur4WDVaPcBdXWpMiY5LGWdPW+yBHhvKMUBM2SsQxaCJlklzAbhJ0DJwkMx7cnHQ0brkqVjelsp8P7E+lG9nynQJMdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dIV8kYTb; arc=fail smtp.client-ip=40.93.198.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dIV8kYTb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSPSoNYyUapFsTJ+hgSv5+4jSQo0hSEZXm4xD+JGgW7AxcB+5bFkmEpimD0qFMfmodiKlUH3n+9DcsTL4jwzx8mNrgv+I3S5e3jqCIhq9ewrjXY+7pLCnYNxRMaz+KfeRStxdLXWZoFLf6I47NbR7sGzLrP2+cbf4gpRs1V4vXNk46+Y4IEx3/D3BNoKMLWPrnNFoGQAGn5OwJeCpedE1ZmTfpPg4g/mFOghSELMYrJqbSBpuB3vAX6Q+5VUoxjEV300CT+4rC+tAJ4aavZkNdtEIjJXcGXu8lgb7/csRMWky9DptRN4L9nzOy775TTZM1kexyrAlFfmxM2g2Gjgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9v2w4pq1FLndtWxZUYPatJR+oW1t24IipFKyEGJ6ZoU=;
 b=JApSRMJItkEkGQPM+24MZ9oKrLF9tciU5yheKBeFzK3fw62kc8Sqo+sMiFt/OBwPQDTLikkO8ILCVWafHyjwk4QVE3RMThVF2Hlv5GYwI34F6cCzEzFGc6vY4XhZMZoYeybPyhEJoUxK3Bt41s/tlmnhaHHEjRQr6/ol2ZYHGYLLRRGq4TEocjE1hj9NWCUupojKDLbD4CO/dkdwG2nVgzTGBNpXoWi42rYGsJ/GCJAEP82phIp26MhfJpFcH6avNs7+mmWRuN7w1Y1CeyibZ/0GIMvI+5olWHzirCW+gmfQF7i0BJ4Xph6UsWYyu8eHr6pXUm01saL3O5wJp5zomg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9v2w4pq1FLndtWxZUYPatJR+oW1t24IipFKyEGJ6ZoU=;
 b=dIV8kYTbqKkgKoRBwdmbrrkEkOFY3+bavTKB9IaA2v96xPDvS1jSVI/TPczP7f3PDWTWkoHQhDK/S2wEufevlb8zsHwRLlFTI+7SRPdNdWETd3kodXfkICT1zUQtyBCpFSItvlkkLL72wU5/azaKfhPPMTX+vniDOsUdnEnwRq7jzHudlxU29SCKISkUg16/ihtDskbX5dljAUMQMbVp6z8QuZLzkK3fk5O22u/2PvyDTdzTztmujvkRO5ZqHEKZGb7uw5fD0Tvwrz6cLVlYXoWFkKFR1M478B4/3dciN8JNucgRrCUERYVISyEyk1yIHMWOHCwFm4BkxwQMRzWhVw==
Received: from CH5P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::28)
 by PH7PR12MB6857.namprd12.prod.outlook.com (2603:10b6:510:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 20:19:23 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::53) by CH5P222CA0010.outlook.office365.com
 (2603:10b6:610:1ee::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 20:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 20:19:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 13:19:03 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 13:19:02 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 13:18:56 -0700
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
Subject: [PATCH v2] cpufreq: CPPC: add autonomous mode boot parameter support
Date: Sat, 25 Apr 2026 01:48:14 +0530
Message-ID: <20260424201814.230071-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|PH7PR12MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 257a86f5-ef2a-43a8-df11-08dea23ec633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|921020|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	M6nixraRb6+hfkrj5gzb9NogRPFrDQUsiIeyDJ5q0x3wCGz0au2DNVAtzQ+PIDquGyEg+B2XTX59dBiMTYL7XLcQXGntEX0amrNK4gSNVfNJkGoZErkGvyXeni1AL0iu/CNQgj4BqvRZkNsEnfjqzXPjtN4mnp8ujkQysCIMwOqWLMC5SM02vU04T2IN/3pvy3ahfhmxe3K6BwrVVe0L2EtiFHlLt4ww1coWLrZ4DpyrLM/recYHmQv+8TuH8XR2tql1qX/8raWACOgTVh8c375ACny9ZEx9Ri1JncFWsoe0Vcy1W5hLNR+kQpUt1V//klfTwXqxA6KNrVOoKMMiyV5j+LMSRhXHR3yECdWB8FTPZiY06rpOpZ04C65iar4ppvN/Hyq2tXlzMbBpIRKG5+/b6RIUNWh2Fw7YrG9ypUVfDu33R3HOibk6I7flKLZ+iQY2ZiJL6uw3lTPWhF86WWIJxNvxCW5K1zE5SCKvxD6j+gXHtZ9xs74yChl8DYY8CFv+2aA+qmgJx1RSUxFlqQZAczOhzHhY4nKyg44Q7u7dqtTLD7JtCI/ng+yt9WagPqpnia80SrA9PEXf6b70277fyRKfpd4p0kb4pdXQk6qsE6KxTdP/WZMfk0hSUftcNi3TWx/+fp6i7IQcWhaP0qKzDyGK3IXh9pc+Fj9fvR68Kh5ZJta3H8JxJslJfrm3oWOxLSTOxZSIiBWlVH/jGEa2U069LmmCl11J8xbwqjGyaXC0ICCzdidRY30yxHHFwBPiC2nTG7LhmFbf9FjP2avTeuy5sqNdPpzQ0Q+G3jR4+zReEJzZEp4FKhhB/sLu
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(921020)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lc8cLpEWDnaxK3t71iqLSTQ2N+HFGHWhRqq7U5oXRxXeJErlh+Kq6TIXyeLi6WwWYqtGePGtEmG0qpFquBSxpK1XGQfY/WurMba9NEcYeSqkPGH/Mv7fzx/aegMOzr49VzewVZ9tCTsg6eQJA8z2SXmCbNjY9LMOtpetPceGVQroVyTk54hQoxtKDe4J7q6DsLrQMxlqDHOIClvtGDQsJO9muXsZszx5w7rrrIT5OfxqQ7V98B3zya0vJZks9WXF1mfnts+IEUJRU0W6241B2M5Nz9Its9g2njczI6Qqhb/FnOZP4nif2Kq2LaYnqYNfr9Yv15FtUyQyVFLwnn8QSjg+ro4rU3JNJ2WEXJ9uT0lfBKNjXJZ5HlSAkvHsibzB7X9N8ay8ziIY2jfhZmkwr4w3GcEAfu7LuSeBmJlQPoL8+xyky1APGCEl885hE/GU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 20:19:22.8578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 257a86f5-ef2a-43a8-df11-08dea23ec633
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6857

Add a kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable
CPPC autonomous performance selection on all CPUs at system startup.
When autonomous mode is enabled, the hardware automatically adjusts
CPU performance based on workload demands using Energy Performance
Preference (EPP) hints.

When auto_sel_mode=1:
- Configure all CPUs for autonomous operation on first init
- Set EPP to performance preference (0x0)
- Use HW min/max_perf when available; otherwise initialize from caps
- Clamp desired_perf to bounds before enabling autonomous mode
- Hardware controls frequency instead of the OS governor

The boot parameter is applied only during first policy initialization.
Skip applying it on CPU hotplug to preserve runtime sysfs configuration.

This patch depends on patch [2] ("cpufreq: Set policy->min and max
as real QoS constraints") so that the policy->min/max set in
cppc_cpufreq_cpu_init() are not overridden by cpufreq_set_policy()
during init.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org> (Documentation)
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
v[1] -> v2:
- Call cppc_set_enable() unconditionally so CPPC is enabled for both
  OS-driven and autonomous modes.
- Init min/max from caps instead of cppc_cpufreq_update_perf_limits()
  as policy->min/max aren't yet populated.

[1] https://lore.kernel.org/lkml/20260317151053.2361475-1-sumitg@nvidia.com/
[2] https://lore.kernel.org/lkml/20260423084731.1090384-2-pierre.gondois@arm.com/
---
 .../admin-guide/kernel-parameters.txt         | 13 +++
 drivers/cpufreq/cppc_cpufreq.c                | 89 +++++++++++++++++--
 2 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1abed1b93c..751817b0573a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1067,6 +1067,19 @@ Kernel parameters
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
index 02db03d03755..672fc3058190 100644
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
@@ -656,6 +659,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	caps = &cpu_data->perf_caps;
 	policy->driver_data = cpu_data;
 
+	/*
+	 * Enable CPPC for both OS-driven and autonomous modes.
+	 * The Enable register is optional - some platforms may not support it
+	 */
+	ret = cppc_set_enable(cpu, true);
+	if (ret && ret != -EOPNOTSUPP)
+		pr_warn("Failed to enable CPPC for CPU%d (%d)\n", cpu, ret);
+
 	min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
 	max = cppc_perf_to_khz(caps, policy->boost_enabled ?
 			caps->highest_perf : caps->nominal_perf);
@@ -711,11 +722,71 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
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
+		/* Program min/max/desired into CPPC regs before enabling auto_sel. */
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
@@ -1035,10 +1106,18 @@ static int __init cppc_cpufreq_init(void)
 
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

