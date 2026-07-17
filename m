Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793A3B19AE;
	Fri, 17 Jul 2026 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784325259; cv=fail; b=CYS049kpBE9D0+YmX7w1T9cPbdwWhWjlIOFhHO/BKnghihW8xabRV5+5KAaq8ffRhqAnCdrPXJxNbkeZ8J8UCeb7X+/Hp5gAmaV7PR1Mc+DoU5KdJu5+Q218mfZpZ4bIy8h71ig22J47Obetark/XQFlmqIyI7PqpvTAi5tbDRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784325259; c=relaxed/simple;
	bh=q4F6LLNA9reK4cQuxxluc2cN0FuKp9nXdvKndx+bow0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YEGC1sOrDNeZP+8g+TgVuFPZRVqlPECxrv6nfkO9OlWGovV962MY9m8+donnVOaRyXQdvNJYY3IKUiqBMLBeZRS24wNOVXqs4SBQm32qLaxUkhdmRjGstnxPjxya6L6HYFMfwbkVK+CfVCc8RVQakREe/fc6uGyIHvMhsCheP/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dtl1xvfl; arc=fail smtp.client-ip=52.101.56.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dtl1xvfl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lc9c3tudviiAnUDHLUZ3MuHL0mDUw+vuu3u7py0/UwFXUfH6u8WrYp5gwPM0wz5+ztK37lSesD1v3oexKZ2HEp14/V8FyjjKdzjhIm3mA8FbLw5fsEvy5gmcEWBeKRC+yyvKEGsCwNxIn8hgXMi//qevjPnt/lhhX+dJFDi1xNbBTq3anxrv4/Uz+ktyUlPxDrjt/6WD54TrMZoEi9ia2w8L9IF7MrB3GbF7f0hjDk8zzX2SmuwCllzOQIgahG99gm6rpvYU0DrO3nR0aaIruC9d+EbZgHxqZFyl4S9y2WaeY7DisrGDqeT1ZgmuU31Lk3ySugpTCjGCUvotVvQtlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVSqziGQmIEgDo2DHoIdZaMOFqXs9tMYEbhanBkqopk=;
 b=MDpA5hHu2O4UH39DN9FKARNJr8Pt3m/ta0oSf7WKLvttyEbEUSSKPt3/P1zPxmkmDGjFHwWkJ02GyXt/YsMcb3L8D0S9lu3tkrwIRHLJq28JCYhnej4OVj8ozLftBbCEFBVs5fn6jstml3OmJlGYgxBM/hxXzdgJdDMaCxTFO1dQ9+dKs9hhu+tm2sy/HcquoEWqTop8BaMEExgq+iQ1CkHM4XC2mQ67lIr/sJdj0Y8+Uqaqp28VTzor791EGFgBeSeXt0gUZhG+wPcH4g7PXyynoBKUMSSVuAf0DS5AvUI83OEZMquAp8R8uk6oD9BCciVvKXhkO+2oqDrMoIsu6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVSqziGQmIEgDo2DHoIdZaMOFqXs9tMYEbhanBkqopk=;
 b=Dtl1xvfl/IRnvmbd1w4Sj63pohlKW/9sBcXCNHiplVy01hu9cMT62yk1Zu7T7cxp3vq7hMIH2XtQ7IYAG8gDI4W8Gb2Yc6OSgzDk4aYSHiN92q9anYU+1jP6hE4oepl/nlGUUpmidIJAPVQBW3THJSJv8tAU9gpQr54+5Du5updROvcoXRvt3MurYV3xpNOQoNABgrRsAXZPBaeVREfOV0bjJGa6cMGQQae9mvZv6PizqV233WAiJiTN4RuHMZOgX+5UJEUV6b1DXGfxryjg3PDIdjxiGLoCFL6qn53LwnLZ9RVOXB5sW/nfpP/SJWpr2GyqhhKxX5KC5ySe81lpUw==
Received: from CH0PR03CA0191.namprd03.prod.outlook.com (2603:10b6:610:e4::16)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 21:54:02 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::74) by CH0PR03CA0191.outlook.office365.com
 (2603:10b6:610:e4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 21:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 21:54:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 17 Jul
 2026 14:53:51 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 17 Jul 2026 14:53:50 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Jul 2026 14:53:45 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<saket.dumbre@intel.co>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v6 1/2] ACPI: CPPC: Add ospm_nominal_perf support
Date: Sat, 18 Jul 2026 03:23:29 +0530
Message-ID: <20260717215330.2215058-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717215330.2215058-1-sumitg@nvidia.com>
References: <20260717215330.2215058-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e4f00a-8dcb-45c6-0b21-08dee44de9de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|23010399003|1800799024|82310400026|921020|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xrAjxURH+Wqz2z5G80Up5ZgjgBZfy/t9iuHQyd9x5CY6bpzK64fWXOW5cHSwRBi89Nm5gsiKZF+UfKjhBZwQGjyyZHbQF5N9V8PHPrlhTLzGIvN42cg9wCoUa3nA+/Im1tJ3vWZOPvGHR7cjDWi01P1KxLuzztTWX/Zj1637OBGZzc1sMwVr1l4Mb5J9oqXM9VJEIFvgQZ7u8EaDIVNRlIR9GCRvRkrMUL4A41i5LQsnaDs49jWEjiZ1oiWMCZ3TlMsjKMdD2YfbGAH7S3GfJMXsjgQotc70v0GX1rqf/KAcWuZyOwJ+vRO1BEDPJ1GjVCqEr+HCnAbgwBrBWdpOwxA4cVwkIkZxaKmxt76O/x/zsH38APiXw5x0iDQyMZAZKwoa8m9CjgMz5SunzOMz5PevAtV6s+JX7R1WOTnPPuJWksqkfTLeD7i/kqqkQAi7RZcWOKsW+e9glXBZrRZ7asatu2RVxZjJMXfZEmR6QY64yCVj84CfDFqohHiZ1wQSWUgrG9NK1d2Q5l/IZYa5jZYtxsutSd3bwKvrGIOuttU+jFvjqTLe1AdhKsXVwUjimME4s1WWtPqfKMCxIPJubcbt4ZrAQiYtg+RlK0Ob+Io9G5R4U1xQuudgs8rgsp+S7JLLZRJqk0C53gyax4Yw4LDsnsXbHTga2DYm7pDdOnLTMijvrztTiFHtf1rTqbkO6MBHPDP0tZXs2oxVWjGYvQzV2ElBo6Q+u/7EKk9Fjtm4OFJLmGFsCDZEdjvJMIWZ
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(23010399003)(1800799024)(82310400026)(921020)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G6lUTuE1mSdHMf3e9yVGVb9NAN00vNo3Z/l/c08LfpgYnCHbTWLaQY3S9JHGyC2JavvBV3rYu0YLV6+UWI0H+MMZ4UYaJDrevtn4htUP/I1Kq3loAZmhmR3fM3irdeWTWQ8YIvc0XInfE9g/wki4xU0IKOEiK0meakN3aJgZqfCeoyexu+T2Uzmkya7NVEgvlyVisLeTgFmFsP0NLrpN9MP8lKHr9v02DepqZ+TVQMOEjtznR7kfqxJ/JOTTgcCIBEiixIyfYIuN+s/4OT2/kSuYPNHwlPPr8hcFu2hsoDAOjgnLYkNg/nxB5DERwoAe/6B2e8ow2vqJ2pslJoCeqVLfUZWOCqfYw6m4PSAiQjtAkzA0PdgcIsz7GCvL17xMGxD5/d3+zLcInzEvYxY8yCN78h/VgAf9mF9choiT+PBrgMvwoJ9FhEa3U90qzsjr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 21:54:01.8985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e4f00a-8dcb-45c6-0b21-08dee44de9de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189

Expose the OSPM Nominal Performance register (ACPI 6.6, Section
8.4.6.1.2.6), which conveys the desired nominal performance level
at which the platform may run. Unlike the existing read-only
Nominal Performance register, it is writable and lets OSPM
request a lower nominal level than the platform-reported nominal.
The platform classifies performance above this level as boosted
and below as throttled for its power/thermal decisions.

It is exposed as a per-policy cpufreq sysfs attribute in kHz, to
match the cpufreq sysfs unit convention:

  /sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq

The attribute is documented in
Documentation/ABI/testing/sysfs-devices-system-cpu.

Writes are converted to perf via cppc_khz_to_perf(), validated
against [Lowest Performance, Nominal Performance], and applied to
the policy->cpu. The register is assumed shared across the
policy->cpus.

On read, the current register value is returned, or
"<unsupported>" if the platform does not implement the register.

Also add the register to the OSPM-set register save/restore
table, so its value survives CPU hotplug and reverts to the
firmware value on driver unload, like the other registers in
the table.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      | 26 ++++++++++
 drivers/acpi/cppc_acpi.c                      | 32 +++++++++++++
 drivers/cpufreq/cppc_cpufreq.c                | 47 +++++++++++++++++++
 include/acpi/cppc_acpi.h                      | 10 ++++
 4 files changed, 115 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 82d10d556cc8..a8d592c08823 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -346,6 +346,32 @@ Description:	Performance Limited
 
 		This file is only present if the cppc-cpufreq driver is in use.
 
+What:		/sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
+Date:		May 2026
+Contact:	linux-pm@vger.kernel.org
+Description:	OSPM Nominal Performance (kHz)
+
+		OSPM uses this attribute to request a nominal performance
+		level lower than the platform-reported nominal. The
+		platform treats performance above this level as boost
+		and below as throttle for power and thermal decisions.
+
+		Read returns the current value in kHz, or "<unsupported>"
+		if the platform does not implement the register. Write a
+		kHz value in the range [lowest_freq, nominal_freq].
+
+		Note that tasks may be migrated from one CPU to another
+		by the scheduler's load-balancing algorithm, and if
+		different OSPM Nominal Performance values are set for
+		those CPUs (through different cpufreq policies), that may
+		lead to undesirable outcomes. To avoid such issues it is
+		better to set the same value across all policies, or to
+		pin every task potentially sensitive to it to a specific
+		CPU.
+
+		This file is only present if the cppc-cpufreq driver is
+		in use.
+
 What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
 Date:		August 2008
 KernelVersion:	2.6.27
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a7fec6c93178..681d4fd40c11 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1685,6 +1685,38 @@ int cppc_set_epp(int cpu, u64 epp_val)
 }
 EXPORT_SYMBOL_GPL(cppc_set_epp);
 
+/**
+ * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance register.
+ * @cpu: CPU on which to write register.
+ * @ospm_nominal_perf: Value to write to the OSPM Nominal Performance register.
+ *
+ * OSPM Nominal Performance conveys the desired nominal performance level
+ * at which the platform may run. Per ACPI 6.6, s8.4.6.1.2.6, the value
+ * must lie within [Lowest Performance, Nominal Performance] and may be
+ * set independently of Minimum, Maximum and Desired performance. The
+ * caller is responsible for validating the range.
+ *
+ * Return: 0 on success or negative error code.
+ */
+int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
+{
+	return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
+
+/**
+ * cppc_get_ospm_nominal_perf() - Read OSPM Nominal Performance register.
+ * @cpu: CPU from which to read register.
+ * @ospm_nominal_perf: Pointer to store the OSPM Nominal Performance value.
+ *
+ * Return: 0 on success or negative error code.
+ */
+int cppc_get_ospm_nominal_perf(int cpu, u64 *ospm_nominal_perf)
+{
+	return cppc_get_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_get_ospm_nominal_perf);
+
 /**
  * cppc_get_auto_act_window() - Read autonomous activity window register.
  * @cpu: CPU from which to read register.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 9c88512d635c..eb6746810fa6 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -37,6 +37,7 @@ enum cppc_saved_reg_id {
 	CPPC_SAVED_AUTO_SEL,
 	CPPC_SAVED_EPP,
 	CPPC_SAVED_AUTO_ACT_WINDOW,
+	CPPC_SAVED_OSPM_NOMINAL_PERF,
 	CPPC_NR_SAVED_REGS,
 };
 
@@ -55,6 +56,9 @@ static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
 	[CPPC_SAVED_AUTO_ACT_WINDOW] = {
 		cppc_get_auto_act_window, cppc_set_auto_act_window,
 	},
+	[CPPC_SAVED_OSPM_NOMINAL_PERF] = {
+		cppc_get_ospm_nominal_perf, cppc_set_ospm_nominal_perf,
+	},
 };
 
 /*
@@ -1166,11 +1170,53 @@ static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
 CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
 			 cppc_set_perf_limited)
 
+static ssize_t show_ospm_nominal_freq(struct cpufreq_policy *policy, char *buf)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u64 perf;
+	int ret;
+
+	ret = cppc_get_ospm_nominal_perf(policy->cpu, &perf);
+	if (ret == -EOPNOTSUPP)
+		return sysfs_emit(buf, "<unsupported>\n");
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n",
+			  cppc_perf_to_khz(&cpu_data->perf_caps, perf));
+}
+
+static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
+				       const char *buf, size_t count)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int freq_khz;
+	u32 perf;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &freq_khz);
+	if (ret)
+		return ret;
+
+	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
+	if (perf < cpu_data->perf_caps.lowest_perf ||
+	    perf > cpu_data->perf_caps.nominal_perf)
+		return -EINVAL;
+
+	/* The register is assumed shared across the policy's CPUs. */
+	ret = cppc_set_ospm_nominal_perf(policy->cpu, perf);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 cpufreq_freq_attr_ro(freqdomain_cpus);
 cpufreq_freq_attr_rw(auto_select);
 cpufreq_freq_attr_rw(auto_act_window);
 cpufreq_freq_attr_rw(energy_performance_preference_val);
 cpufreq_freq_attr_rw(perf_limited);
+cpufreq_freq_attr_rw(ospm_nominal_freq);
 
 static struct freq_attr *cppc_cpufreq_attr[] = {
 	&freqdomain_cpus,
@@ -1178,6 +1224,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 	&auto_act_window,
 	&energy_performance_preference_val,
 	&perf_limited,
+	&ospm_nominal_freq,
 	NULL,
 };
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index cd07e1e92bf4..4c9e59643cc0 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -180,6 +180,8 @@ extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
 extern int cppc_set_epp(int cpu, u64 epp_val);
+extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
+extern int cppc_get_ospm_nominal_perf(int cpu, u64 *ospm_nominal_perf);
 extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
 extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
 extern int cppc_get_auto_sel(int cpu, bool *enable);
@@ -268,6 +270,14 @@ static inline int cppc_set_epp(int cpu, u64 epp_val)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_get_ospm_nominal_perf(int cpu, u64 *ospm_nominal_perf)
+{
+	return -EOPNOTSUPP;
+}
 static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
 {
 	return -EOPNOTSUPP;
-- 
2.34.1

