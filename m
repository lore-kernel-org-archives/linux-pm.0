Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC7B3CF030;
	Tue, 23 Jun 2026 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782202067; cv=fail; b=bP+/G+4LymmnKTnk5SHehA/sMlhzWvfNGo8bYqrZvtgNoVwaSlPckotNgmgXZR1oaVl6i4YnyPeADJZyugVACl6Ydo/UWpf2jm80Q4/Wh+uUusV2bPaA5d8OqO5j/zf8YUNQ9nGbh5e8ekQf7uyEhFLusEyxDhLnbeGYMWWQka4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782202067; c=relaxed/simple;
	bh=kltB9DHn76Nz0HyWaRRQPvL/fQSj4HgwWSieDsOZu3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FD8TjLDG2Yuhl0wfRFhCUlRDm9iTRhCvNyInLPalfBG8R6x66H1EpyEgY8n8ciBujKewB6TXzDRq9U19quna9Lp+sSS2Dxl5EVn+JpIAB7+QzG8e7w0hmn0b/OekFvK89/a3kGwfuUjZ9IApeKob42bZbWzUtzXu6hls6enLtcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L0sqFuRe; arc=fail smtp.client-ip=52.101.52.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L0sqFuRe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMgIRvXvJc/0VrV807gy9w08lsUjibKJoOHJKPWYsVVmC7DmUhby6dn0QuJp98+XQJv41fqwLNxbWjddUKUh30FrmAKBIY1LAtc15a+hxFOX/Is81GHX//k/dg67QcIj6OWuJ31jw5UpGX6DQYCi6QDYNJp/7UzteSWRDzNIERbsWCZvEpAGz8R5SwD50q8zt+cYoq3rYfPBAuHKQxGrmNem/ul/r6orzqLYwBg+3XGdZvYp5BUhfm7Ih/+ueXi9NRZveeyka94uK1I6bEaAPYDYYYP9ZdNcnma8SoUJcEUzUJODlfpDFnwukVF2oWEBZnyvAfwmQB1d3Cux8WegCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgdq1FAW8+f6LPZM74suEJU1VqMOzaVFkAwX0nonJjE=;
 b=fdgACRCJZYs2vCW4+PALBgwStxMZq6s5AEl3ACAmON/7ZSLm6U26SY9Q3BJqQBpTJbv390lw2myYKd06OlaIEjD4pJaOFUQBVgZSukunAh3XZ7NAV7pDSm3HxLpRZUI9bS5I94qKnzRhDfR60d0tIURASZoKzGoeny7j+uym6wbEXd4pTVqDaB+g7sWriUCUZbpyBW7AgzVM86noDkYZ7yjbmKy30Ejx4nEBGPEkE+JErkiOj/Sov82C95ry4aa/zoVtLWPvqRTrVscFHNhBCiq/wLa9zTQfwvq8Hign5IWo7L/z+scLJZcJklIPkyp12b79Esn3bknTB+Y5ZAdX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgdq1FAW8+f6LPZM74suEJU1VqMOzaVFkAwX0nonJjE=;
 b=L0sqFuReenXx5wW506/nCwctNlyKORWDR6pDW2WlqcSeYUxOjFlOg0S2AqHGOk7MCSv320kzTHS9aWVZvDj7d0MQTLgl3Pzux5ePlDc0P+VVDxCv/Rms0h8wYAPla9t47cnhQKjiQpOIhG1MbqIECqA9Wj7yUE5O5cOKHuuL1j+1dbfhgftaE7hnha0jRhUz3PUC/uSGeAuTYXpNB7BHr57egfzSclwX6TCyJ2QniSonbDmrg3GHQpe+iFONNUPah+9dGEoTxmqdjsevCkuJAnL9PEcZ05R9LHi05kHuBXT5YmBdZh7VDAlkGfapb49VkOoodkWwJor832Pp1SMnKw==
Received: from MN2PR07CA0026.namprd07.prod.outlook.com (2603:10b6:208:1a0::36)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 08:07:35 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::65) by MN2PR07CA0026.outlook.office365.com
 (2603:10b6:208:1a0::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 08:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 08:07:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 01:07:18 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 01:07:17 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Jun 2026 01:07:11 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<rdunlap@infradead.org>, <mario.limonciello@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v5 2/2] cpufreq: CPPC: add autonomous mode boot parameter support
Date: Tue, 23 Jun 2026 13:36:52 +0530
Message-ID: <20260623080652.3353386-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623080652.3353386-1-sumitg@nvidia.com>
References: <20260623080652.3353386-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: e2553c26-c141-442e-230c-08ded0fe79b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|23010399003|1800799024|6133799003|11063799006|3023799007|18092099006|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	QxZfAwu5+OhQrs5cOiAggAqnAOXhfnkcvi918V8VdJAt+fFHpRJqqsrU2mNZFB/8RWsi2bfn+VdWuDWOl3zCANiyIessXCKlewTr/ibhkPslpawUVsiQ2egKR4rCBRr0OzWlJ0CiKhkfPE5DIkPvfrWFnz9VHstOm/II5emg/62YDat5x9R0kVM2+v/FkZDP59xRd34fconXkcjPuXXi6eMVBLjxUTsb/UbBHO0F53hPp3jkJhj28pTbCpehYmMqv2Nb7Npp6tDds2w3/zbVbYdqvdNoQJZKYcR3I8LWYPQP96YxCtdzynFL34m/gtFrhjflyhBZTZtAWys3qdO0CnR6ASiIydHvw2S3uhTAAO4zgSmvGWrti5/a8ywNQKdx6eE6BwiHOi8EyeNtHHfle+X15VwPOoJQlLW/VtP40NIHOfkjqNs1g7lodKwMW9HPV9rB11pdg8Gv/rbOmX9i3ELyVrjf7CMdbRz3MfmCOl9e7qUR6YyR7CMoYAcpqdoMb1IRqIMgqSGCNikU4La2ikcmjKCjT4ckqoB9QMGLu89qu3mO0KHIVEmpdKLY58KeNxe2AHhcAUUVPHQNzn9geu3O7phsZTy6uU9C8ZUe9AM9K6vNtqSiVTYY31BbKLFtGP+k6PfEdF4nPs/8YErj9UoSr+H/fx/nAA5JKaSepmSai0+8SdiG6FIvwEdqWrfTHc9s7bE4nm5mcsdeFjLE1xcIDArx2Xa5xj4EU5gXEtfAmUKoJT9H5kjjZcyY9E4e
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(23010399003)(1800799024)(6133799003)(11063799006)(3023799007)(18092099006)(22082099003)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zpDe0tMV+eN/ar2PRIcqd2uJrZTGkPx9JV1thNNykoTD4m5kd1nBlm7bmUn4Q3QCR/VTBaKL3C3Ryptzoq937qGJKmciwW63PnwypLMO4C7KtchSyuktmhc0cX057kKp5Rvg9ms5IzmuyXiFpWNyJJZado2uNl/3PpDHvOTSfvOd6A4JfbHdAvK0cRRFSDHKEFQLM7kD9/2Lm6farnCL9cKIZiJjSxGXfUqGEORDus5MY7CC/HsFK0hB54UNPC+kMNA9QdEW0dMPci7WRFETzZkQTMDwxN+81KQ6GkNBClrnPZWY0raCfXylKwkq8+SCdVY7lzOqd3xNbPBtcH3CTCZgAc74NmxiY6Y/v9THy5Fyx/VJWSARNqQqVgZen1N9o9ALiOuaozuZuNvdZsoMb74aPQQPXBopTonSbqqzI/3qtMoXYC4I0tNV5VWqBKqh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:07:31.3406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2553c26-c141-442e-230c-08ded0fe79b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578

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

Unset, "0"/"disabled", or an unrecognized value leaves autonomous
selection disabled.

The boot parameter is applied only during first policy initialization.
Skip applying it on CPU hotplug to preserve runtime sysfs configuration.

This relies on commit 8c83947c5dbb ("cpufreq: Use policy->min/max init as
QoS request") so that the policy->min/max set in cppc_cpufreq_cpu_init()
are used as the policy's QoS requests and not overridden by
cpufreq_set_policy() during init.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../admin-guide/kernel-parameters.txt         |  22 +++
 drivers/cpufreq/cppc_cpufreq.c                | 151 +++++++++++++++++-
 include/acpi/cppc_acpi.h                      |   1 +
 3 files changed, 169 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..88820d34d516 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1019,6 +1019,28 @@ Kernel parameters
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
+			  disabled, 0:
+				  cpufreq governors are used (auto_sel disabled)
+			  performance, 1:
+				  enable auto_sel + set EPP to performance (0x0)
+			  balance_performance, 2:
+				  enable auto_sel + set EPP to
+				  balance_performance (0x80)
+			  default_epp, 3:
+				  enable auto_sel, preserve EPP value programmed
+				  by BIOS/firmware
+			Unset or an unrecognized value is treated as disabled.
+
 	cpu_init_udelay=N
 			[X86,EARLY] Delay for N microsec between assert and de-assert
 			of APIC INIT to start processors.  This delay occurs
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index f7a47576717a..efa673e3830c 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -28,6 +28,55 @@
 
 static struct cpufreq_driver cppc_cpufreq_driver;
 
+/* Autonomous Selection boot parameter modes */
+enum {
+	AUTO_SEL_DISABLED = 0,
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
+	*mode = AUTO_SEL_DISABLED;
+
+	if (sysfs_streq(val, "performance") || sysfs_streq(val, "1"))
+		*mode = AUTO_SEL_PERFORMANCE;
+	else if (sysfs_streq(val, "balance_performance") || sysfs_streq(val, "2"))
+		*mode = AUTO_SEL_BALANCE_PERFORMANCE;
+	else if (sysfs_streq(val, "default_epp") || sysfs_streq(val, "3"))
+		*mode = AUTO_SEL_DEFAULT_EPP;
+	else if (!sysfs_streq(val, "disabled") && !sysfs_streq(val, "0"))
+		pr_warn("Invalid auto_sel_mode \"%s\", disable auto select\n", val);
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
@@ -645,7 +694,9 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	struct cppc_cpudata *cpu_data;
 	struct cppc_perf_caps *caps;
+	bool set_epp = true;
 	int ret;
+	u32 epp;
 
 	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
 	if (!cpu_data) {
@@ -715,11 +766,87 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
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
@@ -1066,10 +1193,24 @@ static int __init cppc_cpufreq_init(void)
 
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
+		 "disabled or 0 (use cpufreq governors), "
+		 "performance or 1 (EPP=performance), "
+		 "balance_performance or 2 (EPP=balance_performance), "
+		 "default_epp or 3 (preserve BIOS/firmware EPP); "
+		 "an unrecognized value is treated as disabled");
+
 module_exit(cppc_cpufreq_exit);
 MODULE_AUTHOR("Ashwin Chaugule");
 MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 8693890a7275..9b18fb9aab7c 100644
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

