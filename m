Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E7744A418;
	Thu,  6 Aug 2026 20:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047008; cv=fail; b=kwL9VlRfNPuN4HVD/lAWiWV9GUtE5fk2DzDfucCs9BOryRfixcp6AQYaNM5y1bZW82jYqJ1BAATL4PahbBEZzZXWNLH5PaQ37aRseKqCOCFN2GtGGzF6HAhZnlaMq44HOp5SzJETxdD8To6yovcTANTv0dRmXwNxVLTzU8a2+/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047008; c=relaxed/simple;
	bh=n8B9k0WNYRoBPZuyuywPb6CXIRo1njSUuoJ7R1LtiM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GypBT9+5D2N0Y1r97gUAKNGZGd8kblyf4NcsMbGHUhs0ETsIr2ZwrAcH/w4jgXYR2kjsuucfBgx1FjqhiDegKde+Povxl8KGxNjeIexsh5yp3+8+DMS3GrNx+oLjYLBRjfXaWYXf7Np034Ec7LVBr3XZW/brZMPjRvbNV/6U/oI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o7BVUxqa; arc=fail smtp.client-ip=52.101.48.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o7BVUxqa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PY3TFCxFp5VPsZlwzaRlCpJh/sugAlQCxM4W0tI02KoOVRSx3QrMEFvnhMWorFlULvY0LL+fRJmKBUb2UtRbzgJwvVMw93i95I94EER7jY8ETftVN11pXID9eYMEMeK6szKLxQ2VaDYTZvTyceyPEilsh+YQfKRiwLvKl7dQKqzapwC2zup2sFC3+ozJX22geF4PFDAsn3nSKpFPwk+hvEJrUhunjLbApN49YAn8Mm+VxfORKAV7Mpx1SJ8SQip5cUc6Aj+DysYaaP6t0rmyHhkgeiez1Ep28gHZ+O+YC3yYHIPKOpu4sKBp16ueqj6h7t1YJMVpaJakkN7WZ71bhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Uq7Qw7xxMGyXtyTXFXwblOGJkhoHHtY2m96G8FhPJ0=;
 b=bTqSL1vBvLsj7xriRTczdc4iU7mCH7ih3U+gl+Eg0iHcYTSUtH0VdBtaIV5+QoD2uP31t8REjxU8/UmCnV6Oo5oooQJBfIrpjySyweVhVaStlwdwZbMF/rSzeH8mvF8N9+kVs328VTKGJ6KcwrmJaAsGLalLzF8jPkRvg0Sa+K6DIuNriXG/TJPUFcGPyFwMA2GbS+WqEeHANYC+DkEo9SDi6p8SuJ4fKaR/PWZY419dDu+g2gz58C/7daQRj1Ri5EVMcIFZqrfsJ40qzY5R31NXblYW8qUYSMNHxZHLoUtpdj48uvgj1abYNcxDrjivsIE4CqA1MHuG9FQva+lv/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Uq7Qw7xxMGyXtyTXFXwblOGJkhoHHtY2m96G8FhPJ0=;
 b=o7BVUxqa6AvOxHpY32zrYTrnhsr2mhUrZn/A8efEZ33F8kn9cvKwnEIzVgAtD+0JDrnXrbN9xvBvBpk8wuCZN2ooNnKP3hSWav0wFABo3vVMtrfI9sgHRm9AuC3hqtFUotzMN8wgPEAlDA/r/x7Q86Rx9au3+QR9AdYiJVYgLL0XvX5EUhNQi5qBiXOJ7F7sCFLQUG0tYLz5bdEsP7qouex+iQC0v/YCcOw+gB7NfE3nLXW+6NbUPPyrVO77+2t/5pczdNsWZG2MwqZYB15l6ueu9d+g/2nTZDqchxOU+anwJkYSFzuUJJxLxRSe+nrLkDo1mw9kWhE5ndY90nSdGQ==
Received: from PH8PR22CA0015.namprd22.prod.outlook.com (2603:10b6:510:2d1::23)
 by CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 20:09:43 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::11) by PH8PR22CA0015.outlook.office365.com
 (2603:10b6:510:2d1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 20:09:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 20:09:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 6 Aug
 2026 13:09:19 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Aug
 2026 13:09:18 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Aug 2026 13:09:12 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<saket.dumbre@intel.com>, <ray.huang@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <kprateek.nayak@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v4 1/4] cpufreq: CPPC: Keep the policy across CPU hotplug
Date: Fri, 7 Aug 2026 01:38:54 +0530
Message-ID: <20260806200857.601152-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806200857.601152-1-sumitg@nvidia.com>
References: <20260806200857.601152-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|CY1PR12MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: 25526dc9-fcab-4f77-c781-08def3f6a7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|23010399003|1800799024|22082099003|18002099003|6133799003|11063799006|10067099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	FXTmAfox6I2L9k3ndhtKFvS4PLwKTbrhNOFm9wEUKBxdPsRqgQzMyYUsFl2WAGQ6pIcsa/1/Md067gpEbFNdhxxe8M3LMkdusxjLdzMH9LvSeSNje1wzkD3cMvFIDCZGwH8AJBqOhkxlmFEPWGToB1DE77+kjFq5vP54Kmuxl/e6wD1i4keSn4M+BxpJFm6zHDVAYS0HyVn9fgU4m3Y7vmwxBwkUnnBijq7joI0e9xQVr0QsSuymwezAjj1S04KsNBLlrH1lJzMcwT7Xms/HqEwo7vdbUHrmgO3K5pewEK9qwIevOS7t/d4CwLaMd+WeqrBAVywpi6mkRXiz2MLeZLDs8OX6dwPtzq9B2gX7U5im9s7jrXFxTK43ifbfQo3XJBlWl/apWJw+sRwdl9JBP/nvleonQmUsXhglQ1ejMS4eM+ls1J2v51wh2OG6phoh4EaKxdmQr83GfDb9axVcESkj5hkTFuxegZvQfOgwmQpNhT+2OT4J5X5rnTSw9ISy95CHd96kCI3rKydtdxDWQTlPD7R6mGMcB18epu6lMHFjIzjmDZHioriAsvvZcEksxPrf05LjLzkLQ6BDG6aDww1efAM00aJeDjeUZLNxiMDFef8T08jruRaTuI6J0O1FXLWy0+lsCOwqirlJ4Xxo7TpkO8yK8DDh92Y30gvYUSch9Wj1LXIrvCpUhFQTDCN6dEMv+PTi58eBscgKdgjv+JfxRkN0Zex9PFtl058JYzHpe6YAnFr0PJy9GJi3Oa+G
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(23010399003)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(10067099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	otp3bAImkCxareOcEuoTbJQASo57/bcPuh6ylsYv1xD9LFbdCNaWLhmUBL2DX80/V7MYUbOXYlDf55cnCa8pOBGKNW7wGHzaLD45OnRwEFYL5avnjKVc7uXy82x8FBUHG8058g/v08Nis8GxGN/FXJ1UKvY/3KZo7RItJJo6ouO7H7jo9FVvC02xgKKTXjsZDesjy/rA/ch11ycVLfWkC+2Ax3UpKkTu54AGVCZrXi9rvoXZMzrZjfUodmG/SoqoFQCO5vG32R2GJQcsemN+59iEwisQDZ6Ek6QkA5cUdBDzj6RB8gaI24jnlH2krYmGSoXfHYetxpmVISPmqxxLHP5ZhoyoQYrPV6MwJjy6KzXuo0lVVJ8Xf8UMEoELi6qjvS2fsyAnleOmNWkIUs0bxucOKx98zpAlSYln0MPC4pu3xAIqDFvrm5fIPvuLXIZL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 20:09:43.2957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25526dc9-fcab-4f77-c781-08def3f6a7c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9601

Without online()/offline() callbacks, the cpufreq core fully tears
down a policy during exit() when its last online CPU is offlined, and
rebuilds it during init() when it comes back.

Add lightweight online()/offline() callbacks so the core instead keeps
the policy live and reuses the driver's cpu_data across CPU hotplug.
This avoids re-reading the CPPC capabilities on every offline/online,
making CPU hotplug faster.

Move what init() and exit() did on hotplug into the new callbacks:

  - offline() requests the lowest desired performance, as exit() did.
  - online() re-enables CPPC and restores the performance controls, as
    the platform may have reset them. Failures are logged, not returned,
    as the core would free the policy.
  - online() also resyncs the frequency invariance counters, so that the
    first tick does not measure across the offline window.

The restore in online() uses cppc_set_perf(), which writes MIN before
MAX. If the platform lowered MAX while the CPU was offline, writing the
saved MIN could briefly leave MIN above MAX on registers not accessed
through PCC, as PCC delivers the writes in one transaction. Raise MAX
ahead of the restore when the saved MIN is above it.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 128 +++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 80893844353c..4b3da9a3e122 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -211,6 +211,29 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
 	}
 }
 
+/*
+ * Resync the counter snapshot, as the policy is kept across CPU hotplug and
+ * the first tick after online would otherwise span the offline window.
+ */
+static void cppc_cpufreq_cpu_fie_resync(struct cpufreq_policy *policy)
+{
+	struct cppc_freq_invariance *cppc_fi;
+	int cpu, ret;
+
+	if (fie_disabled)
+		return;
+
+	/* policy->cpus still holds related_cpus here, so skip offline CPUs. */
+	for_each_cpu_and(cpu, policy->cpus, cpu_online_mask) {
+		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
+
+		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
+		if (ret)
+			pr_debug("%s: failed to read perf counters for cpu:%d: %d\n",
+				 __func__, cpu, ret);
+	}
+}
+
 static void cppc_fie_kworker_init(void)
 {
 	struct sched_attr attr = {
@@ -281,6 +304,10 @@ static inline void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
 {
 }
 
+static inline void cppc_cpufreq_cpu_fie_resync(struct cpufreq_policy *policy)
+{
+}
+
 static inline void cppc_freq_invariance_init(void)
 {
 }
@@ -735,6 +762,105 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
+/*
+ * With offline() defined, the cpufreq core keeps the policy alive when
+ * a CPU is hotplugged out.
+ */
+static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_ctrls perf_ctrls = cpu_data->perf_ctrls;
+	unsigned int cpu = policy->cpu;
+	int ret;
+
+	/*
+	 * Request the lowest desired performance while the policy has no online
+	 * CPU. Zeroing MIN and MAX makes cppc_set_perf() leave them unchanged.
+	 */
+	perf_ctrls.desired_perf = cpu_data->perf_caps.lowest_perf;
+	perf_ctrls.min_perf = 0;
+	perf_ctrls.max_perf = 0;
+
+	ret = cppc_set_perf(cpu, &perf_ctrls);
+	if (ret)
+		pr_debug("Err setting perf value:%u on CPU:%u. ret:%d\n",
+			 cpu_data->perf_caps.lowest_perf, cpu, ret);
+
+	return 0;
+}
+
+/*
+ * Raise MAX ahead of the full restore when the requested MIN is above the
+ * current MAX. cppc_set_perf() writes MIN before MAX, so the platform would
+ * otherwise briefly see MIN above MAX on registers not accessed through PCC.
+ * Lowering MAX is safe, as the MIN written first is never above it.
+ */
+static int
+cppc_cpufreq_prepare_perf_restore(unsigned int cpu,
+				  const struct cppc_perf_ctrls *target)
+{
+	struct cppc_perf_ctrls cur = {}, prep = {};
+	int ret;
+
+	ret = cppc_get_perf(cpu, &cur);
+	if (ret)
+		return ret;
+
+	if (!cur.max_perf || target->min_perf <= cur.max_perf)
+		return 0;
+
+	prep.desired_perf = target->desired_perf;
+	prep.min_perf = 0;	/* Zero leaves MIN unchanged. */
+	prep.max_perf = target->max_perf;
+
+	return cppc_set_perf(cpu, &prep);
+}
+
+/*
+ * Restore what the CPU may have lost while offline, as the platform may have
+ * disabled CPPC and reset the performance controls. Never fail the callback,
+ * or the core would free the policy and leave the CPU without cpufreq. The
+ * governor redoes the control writes, so they are best effort, unlike the
+ * enable, which only a later online() can retry.
+ */
+static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int cpu = policy->cpu;
+	int ret;
+
+	cppc_cpufreq_cpu_fie_resync(policy);
+
+	ret = cppc_set_enable(cpu, true);
+	if (ret && ret != -EOPNOTSUPP) {
+		pr_warn("Failed to re-enable CPPC for CPU%u (%d)\n", cpu, ret);
+		return 0;
+	}
+
+	/*
+	 * The platform may reset the controls while the CPU is offline, so
+	 * recompute min/max, clamp desired_perf into range, and reprogram them.
+	 */
+	cppc_cpufreq_update_perf_limits(cpu_data, policy);
+
+	cpu_data->perf_ctrls.desired_perf =
+		clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
+			cpu_data->perf_ctrls.min_perf,
+			cpu_data->perf_ctrls.max_perf);
+
+	ret = cppc_cpufreq_prepare_perf_restore(cpu, &cpu_data->perf_ctrls);
+	if (ret)
+		pr_debug("Failed to reorder perf restore on CPU%u (%d)\n",
+			 cpu, ret);
+
+	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	if (ret)
+		pr_debug("Failed to reapply perf request on CPU%u (%d)\n",
+			 cpu, ret);
+
+	return 0;
+}
+
 static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
@@ -1047,6 +1173,8 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.fast_switch = cppc_cpufreq_fast_switch,
 	.init = cppc_cpufreq_cpu_init,
 	.exit = cppc_cpufreq_cpu_exit,
+	.online = cppc_cpufreq_cpu_online,
+	.offline = cppc_cpufreq_cpu_offline,
 	.set_boost = cppc_cpufreq_set_boost,
 	.attr = cppc_cpufreq_attr,
 	.name = "cppc_cpufreq",
-- 
2.34.1

