Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F3430EF63;
	Mon, 15 Jun 2026 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781550025; cv=fail; b=Gu3ZOfKsat+/MkSIPk2bqDLViuZBi0wv5wLerw7W6NRf+8a/5GLGgeixzOjBRJ4nvpggyTX/PSJRvJ3cOCvyEFFFCo2I7EvOzQ/pmaS7RPCMzJGCuMhoFpH+9+gdYrxbnUisoirLkJLFKiKZWDb5HuSsACRi73dlTY6+vr1YErQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781550025; c=relaxed/simple;
	bh=xlgqTagXbioC5wAlt5Z1zgfg3l8QCRpzE6a1q22wBak=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jkEURu2LtWQIy8wXPyM8BYalRKf/ENNrZcmPBhUrjphOaPD0IEolhTp3ZYvBeOQKKhcy+exroY2dWmIy7O9P6wJsxa3xeJryF1N5Y0gswlgAnumERyOmXmRqNuy20L350cw0Dg3k6AxtbvdR1cSatQiR97zslx7jtP0aY64/F6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eIX+Qx1T; arc=fail smtp.client-ip=40.107.209.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eIX+Qx1T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruZ5Drw0QeoFno5+99tjcS1mgoUUAr95Ayo51NDiLQVcUFG/ghw/3sQRwQ4Q07yOcBBAi6of6Iye4N5BAHTxjJ/qvV7B5fkYppa1Q6U2/Hys1JqiQ/Znle7ZwZZh4oKjyIrL4VGxqhR865LaUDWo1LYfdMf9x8vC2Yh7aM/liyZSzgL+sQCuhEOpSa6VJNW7Zkg/A/13MOnpEPnAyaOWvawTWG0AGOqCmu+oFVEf1xteCYsRA8hlGIB3SE5AJ/r4/1YAWwkmZSS0M+rAdU5gNfq2V2wQtzWHf+b9KLj8Zm7EwYhQS/1sVhEzWovq+gou6Ho2dcfoexuBAXX1buXsZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVARQbbo9DhbzXHY+l0kXI7c5oMdkAcYf2ltB9dj2j8=;
 b=mvZ3U/lhZGy5Y+kHSv+ZiLtqkPBdpBIe+UKsgZjB2qVTuKu6yx/SeCDETfUd1wB+9G7zTCNyyuEluaQbGRtTeiSPPz225p03Y+J/RWzvFxli/MrR2rTCba4dbyLgW8s/je3IVnzFy0uI0lFa1J5+1IrFLOQW6FFL4VoBt+9snwQgD7hnfYjWmrt2QBOXw83IKoN/wTofHNZzGMEMhfAXJ816FOvxRooRNqkSkw1UMlcfFGl9SFeYq15xopkeRTWPsPeWCxtkj5ymV4F4tQ4crwJoxbpxHy1BF+4cqWHHTQjonxkXLe7UvioiBnNC9JnMHG6jsiuhIqE7to7r2n5TRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVARQbbo9DhbzXHY+l0kXI7c5oMdkAcYf2ltB9dj2j8=;
 b=eIX+Qx1TuVlvxo3nwouq9R16ZFc1WIQ5X/eEP9cbG0zAifgFYEfsWV5zkblgRnL1VmXRX8h6LLXTrdUN6Ng0h3SBGxanS9/kAhjlK2sLcxMnWQZT4m3OW8MXbcU6TV0n0qNmRgc+7P2q790fV3qnZF9WcVM1S4gQPbdJj2dgOoPjhG/L/VWQY6pd9JnhOdCyUIpAqc7AqSFI/WwPN9Oe/+gYgV/V9vNGf7+pEp40Lc31/naiM3Jf20cR2GNxZuIbHCsCIvgVXP0pyXyy6K0GSdcy2n88ZQgG0WG2T0WXU8rq+d0rX+fZ43Pn/Lhk1aPfQvM+HUSBSBZ8G2koOU49og==
Received: from CH5P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::12)
 by DM3PR12MB9328.namprd12.prod.outlook.com (2603:10b6:0:44::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 19:00:01 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::3c) by CH5P221CA0016.outlook.office365.com
 (2603:10b6:610:1f2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 19:00:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 19:00:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Jun
 2026 11:59:43 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 15 Jun 2026 11:59:42 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Jun 2026 11:59:37 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<pierre.gondois@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <mario.limonciello@amd.com>,
	<saket.dumbre@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v5] ACPI: CPPC: Add ospm_nominal_perf support
Date: Tue, 16 Jun 2026 00:29:34 +0530
Message-ID: <20260615185934.2383514-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|DM3PR12MB9328:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e5d512-0355-4a29-4a5e-08decb104dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|82310400026|23010399003|1800799024|11063799006|56012099006|18002099003|6133799003|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	86RqIMco46bHT0tvXcXfaDzWd/MkXTKQUxkfsoS5zDCYIy1+ejp8Q+8wuJVN914F1u+3JtXau8NnUDmClPNEO6bYNkO2e1W10E1eJyz2pOneRCuqph8peBu8N/DmBQe5BN49/ThJnOy+HMjL23iz94kSrhA1OmCuCvkhuP6eIDYg/BeOJEWCdk3/4Na98WRe1qlxYaFNu/FPjcuLd3ZK/wEN5aJ+VDjG/6MBGAvKQTOKHkWewNbug6SnxzS/CMiovNZfoAtHmKFS8H7gnsUHslbiMw62bNlalYYM2jpd+w7pfBMPFAiztiiO18CpZq7Os5lVccbSe30wdA+huYcMN+cGmNbqJOO6DsRj8s/piCdzRpCH1OGSjseHGCx9Qj8A1326AVu/CNYCjpFy0ropv9nm8uR73iKKWHH1yu3q1facso7I/rN5DvkyO7Dw8I9A7GbSEcpAZI1a7j2bUgPKhMh3iMllkge6zZDpOQJJyd4nOfN8LeXsteyIliIRF0/k5OaS0QD3IvNAGcyvDJUgdJfpldZoUAjKZjpiVrexIrCqVb1vZ6yHhE5fDSNIchW5eQuR7kmExqvA7Pb4yX6ygpua3m2aOBKI7cFSEl3bjq6zCkeu/9sp4BtRLl82sn8N10gGJjHDXcRiQrMHL2+3obhWzJRaLoHysXqJnmP3mI0suGdIRUriXUd0Xa/BbKj7q6pXMTQJezO8p2HyLHmP4Ile3bswLYRK3LHIUQi7Se0VsyCdqsWH4tNW9efS23Grx6X3Sj2zymAVduKrIgQi5Q1EtrEivh5OD1kBxkkXgKE=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(11063799006)(56012099006)(18002099003)(6133799003)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	97qwu48EERabMEBUaomzqjG/p3WU+wvwNEXYNY9PRcWVWwkNVVSqbyh+87zv96OZu/QP13nArySGmLtXP09OoOM/g70umUBr1286bfLs837W6/Mbx3LnpbDxo7l9nE9UmT3a+jA1J7MjpiGYa1Fwr5K30mujb112S6vjDYyae/LMrNaw6YPzUfnf9MbhY69zX9MwHZe+Z/faKxp7KAtlzyF18UnoKjhZPEZkf2p/iLEYVtFO5ngurzIhxAyv2keOipwuXQt+Cu1vq8vn/y325KV2qugKJ3JIKNIsN+p/aUzDWUeoy8eTHcO06FBV59FukrcKsX2DFcfCXK5tu71JYxVSOJa5gCiC9eo0/ljUgJOb+O1DsmbpAa8d/czURxcPBlFLeaxInqWQnkESRTAqGsZSZIb3SlXBzBtjm+dXcBXMtkI73vDfRebAOVvVX5G9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 19:00:01.6543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e5d512-0355-4a29-4a5e-08decb104dc8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9328

Expose the OSPM Nominal Performance register (ACPI 6.6, Section
8.4.6.1.2.6), which conveys the desired nominal performance level
at which the platform may run. Unlike the existing read-only
Nominal Performance register, it is writable and lets OSPM
request a lower nominal level than the platform-reported nominal.
The platform classifies performance above this level as boosted
and below as throttled for its power/thermal decisions.

It is exposed as a per-policy cpufreq sysfs attribute in kHz, to
match the cpufreq sysfs unit convention:

  /sys/devices/system/cpu/cpufreq/policyN/ospm_nominal_freq

The attribute is documented in
Documentation/ABI/testing/sysfs-devices-system-cpu.

Writes are converted to perf via cppc_khz_to_perf(), validated
against [Lowest Performance, Nominal Performance], and applied to
every CPU in policy->cpus.

On read, the current register value is returned, or
"<unsupported>" if the platform does not implement the register.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
Patch 1 of the v4 series ("ACPI: CPPC: Add support for CPPC v4") is
already applied, so this contains only patch 2.

Changes in v5:
- Add cppc_get_ospm_nominal_perf() to read the register directly.
- Drop the cppc_cpudata cache variables ospm_nominal_perf/_set.
- Show_ospm_nominal_freq() returns register value or "<unsupported>".
- Register rollback reads the register too.
- Move range check into the sysfs store from cppc_set_ospm_nominal_perf()
- ABI doc: update read description and add a task-migration note.

v4: https://lore.kernel.org/lkml/20260527194626.185286-1-sumitg@nvidia.com/
v3: https://lore.kernel.org/lkml/20260514194822.1841748-1-sumitg@nvidia.com/
v2: https://lore.kernel.org/lkml/20260430142430.755437-1-sumitg@nvidia.com/
v1: https://lore.kernel.org/lkml/20260427051823.280419-1-sumitg@nvidia.com/

 .../ABI/testing/sysfs-devices-system-cpu      | 26 ++++++++
 drivers/acpi/cppc_acpi.c                      | 32 +++++++++
 drivers/cpufreq/cppc_cpufreq.c                | 65 +++++++++++++++++++
 include/acpi/cppc_acpi.h                      | 10 +++
 4 files changed, 133 insertions(+)

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
index 9f572f481241..1fcc22a10b4c 100644
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
index f6cea0c54dd9..d160ceced7d9 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -1011,11 +1011,75 @@ static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
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
+	unsigned int sib, freq_khz, failing_cpu = 0;
+	u64 prev_perf;
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
+	/* Save the current value to roll back to if a sibling write fails. */
+	ret = cppc_get_ospm_nominal_perf(policy->cpu, &prev_perf);
+	if (ret)
+		return ret;
+
+	for_each_cpu(sib, policy->cpus) {
+		ret = cppc_set_ospm_nominal_perf(sib, perf);
+		if (ret) {
+			failing_cpu = sib;
+			goto rollback;
+		}
+	}
+
+	return count;
+
+rollback:
+	/*
+	 * Restore the previous value on siblings already updated.
+	 * for_each_cpu() iterates in CPU-id order, so siblings before
+	 * @failing_cpu were updated successfully.
+	 */
+	for_each_cpu(sib, policy->cpus) {
+		if (sib == failing_cpu)
+			break;
+		cppc_set_ospm_nominal_perf(sib, prev_perf);
+	}
+	return ret;
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
@@ -1023,6 +1087,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 	&auto_act_window,
 	&energy_performance_preference_val,
 	&perf_limited,
+	&ospm_nominal_freq,
 	NULL,
 };
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 8693890a7275..b545fec3fd47 100644
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
@@ -266,6 +268,14 @@ static inline int cppc_set_epp(int cpu, u64 epp_val)
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

