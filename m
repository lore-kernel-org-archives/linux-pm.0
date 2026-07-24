Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC366400966;
	Fri, 24 Jul 2026 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930452; cv=fail; b=Hlc3uvQwVQKMTuI5tNddEFW5I4vdrT1EcuoupMgcK7vzYti7iUvj+/r+icLoaY2OhFerPNa/WElk8TbdvL2XQfvOLuvVj3AqZSexzJ0uaWs4hKFHvlgD4yQF+1umspK71L0N5w8a0aVRrneCucfsKnGKVDeLz35FRjDmsmhV4vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930452; c=relaxed/simple;
	bh=oar8FGZkWQcUqlHlOwFdHQpuPq8ZZre1PwA4KQao6uA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3u2hj9OZeSef0ZdJb01SieyMrr9u04eJrwM1ZB6Ep4/lF10WWiavXNDdZfSalmdZG5fGRs411sW2PtRDB0luWJdY8FEaQYFCs0C8amDLoRZn9O5cH/KEXNM49qFUAI5EJB6PSQiMyEPaGePIiq6p00o3lLsi0rpxf7tGUiGi8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LaAWUNDx; arc=fail smtp.client-ip=52.101.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LaAWUNDx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/nuAR5csBs8mrLbYv1es7Ed44GlRSeqtO0tlYIc8NijsImVg/uPeLmVoLmmjKJawKqnKvY2tvAKEjgV8j5xXH7TzxQQI6h7mYBsuGCgjQrkpojo6phl9ZcrKnttcssx2MfVIjX0WawRixdZ4zB647cKYsS+RwEAZ4to8ytUT4GNQBfHond2dHcV8oZmB4Pqs//pNjqBeIy/1z82r28mIYzIBfrOp6FMYahWcVS1L+s9cM+3Yj6ZfTMRv9LNeRp/7XasRrqBZ45BV8r/bx8BeuhKPs8NRcqcLSOF4hqJdU0uO7wLxZcH1HwaYJNVbP3x995pbGrCdgGVCN2uJRKOUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0Ym2kVJBdCK0c7/+gX4ff2K0ZzwWZhXP5Y+TR8wc34=;
 b=OYqMGOUiiIlj3TiZSPz4SbQpVUQOUSKtfWMafZM4pv3VrQ88n2GpdDgGcvskFh4S+inAgiVINWbc7P1IoEgBjJn5bs8XQtZorHiX/Cyd5T0U087l3jw4f9Tg/oUl1q6e/166xPCXorS+6v2AzIDOQ7QSsOA3jx60aq5kcQy6HNOQhOWBtBNWr6aOyo3D5abiez29n8rTnRDkQR03q+82YP9eyoe764uHq25nd9IldHftzThyzRHEzf77OpFeC3jPI1x0OAREnhLh8IXLLa8QPoTWTFVDO821KE+gcLDFHWT/4VhJadN1eLrUE5vrzAZFejrcwQzRv+/F8WqLpfdDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0Ym2kVJBdCK0c7/+gX4ff2K0ZzwWZhXP5Y+TR8wc34=;
 b=LaAWUNDxUoNh35oYS97eafMgL/U71RjTg0jyOiIr0MIgW+6pNUEdDlDmpeWEW9iZ5CZ3umTbN0Z5RQqFl6KM0ehIKQ7we+Erugh+W8fC3Qnm2nxjCCYcY4om7Qs8km42+E8uH+5eUmEBfDivARvHDiGnbCoR2FTK/5esA5b6/rRKY2GSWq+lHR4gcgg9TWWJjKfF2D3isZI3EUq1DZkwIxwS71sP6SWjlYMRPQwgc7CPf4jj22LdVv1Tt7cmOPHGqDuudC1d9D2ih14WDZwWSBecbaTU3deo6C6VsSCbjrYwb5fHntCBe7AyveFyR9gkFi75xBnhNbnGrvaw9384Ng==
Received: from DS7PR03CA0045.namprd03.prod.outlook.com (2603:10b6:5:3b5::20)
 by PH7PR12MB8780.namprd12.prod.outlook.com (2603:10b6:510:26b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 22:00:41 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::6c) by DS7PR03CA0045.outlook.office365.com
 (2603:10b6:5:3b5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Fri,
 24 Jul 2026 22:00:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 22:00:40 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 24 Jul
 2026 15:00:23 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Jul 2026 15:00:23 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Jul 2026 15:00:17 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<saket.dumbre@intel.co>, <ray.huang@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <kprateek.nayak@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v3 3/4] cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
Date: Sat, 25 Jul 2026 03:29:36 +0530
Message-ID: <20260724215937.3368276-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724215937.3368276-1-sumitg@nvidia.com>
References: <20260724215937.3368276-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|PH7PR12MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf87264-dc5d-45d7-67a4-08dee9cf0069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700016|23010399003|1800799024|921020|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	aSWE/274obLoFkkSCl4L/WSBOKZ7344JG6mcGHHS0+BGrgsuOdweSqOD0PsC13JRfu9LIKlQuEBE4mc0mEt77B2ID334Ib5WcLy7t2uPzpJazpmyoWoAELnlBE6bb3T9fJDp8KdaJ1bgeMSxksrIebzhatoBcx1FI7bzDFQhFxUdlF2r2CSLdcSp8EW30fOGzRP4UVZ2Vq+TPhJ6eoKT/M7OMEsa3IiUfUHrQk+I5BUWPzFP6Ce2gzo4DMcWTs08+CkptoKD9HDr0zGamAytaAm/PSKEvbOK7fHqzf31oc2/CxCTdFCNVpROAbysQBqeWHouFg8kvPnXif/78+0m8qpuEl0nbd6ptOLUElpX9MYwSRUWIwBAtffyaOgKN1SzoLk03kEEj/MYlOJ/A8bVpYD9BVujpWQayGavY/wr43LL58tiDdY1aOy5KZvVpYS7UGQ1t4UY6Q0tNhO8XrI+Itx/AuQc1LsrXXxEJbfawbqLXvO+Yss34+59BVBBt2C/o8k39cHYMH+U4MpEzvZ27oMfrUEtYNpNvmeltFLRrDpQ+ynkenoU7Dzn2/EYIMY9Ps2OoZby/SF6CbxF1OIQbk09eOHVWrkjO3huJhrbclMVCGxSJMoKhaypmobvFP2ZtXb79nOUQFTBJZ+yUwto/YFL+hDVNX+R5/E/uCq/f5eNjmkUgNdUREW5/WonW69pR/S9KzY6UPTMXjYOvCNiTavubgSSnNGo6CuoNsEyemJMEgEzHkmvKLP/uzZjwh7g
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700016)(23010399003)(1800799024)(921020)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NFfSdNZQbjm1KdeA15pxzR8tf4sBYDfYiqHv6nTwwoXvTx6OzTab5kkBXIxTAnr+FGHJUBb8pA3dpuiEPo8wKermc3qje7NMuZSF9Umz6Y4ZN4gqfrv2cKwN23YfjrVjBEMqJ8nHzeLzNWkvuYPWZnwCb8SPSM6ez/r67tRovUymHb+0jeTksZU1S+fFsVoXHq1c2bI3vPdLRwCpLlv9IOK2HMrGFAuUNIXWGEvWxAG1mECPDoXTqOxDVEeowwjorZzuN+UkLbE7kFibNiJyNVWVOM50sP4DVO/5HDKhenUyqiCZ2PwB8lh1BccWRBWKLLWBDdXGCbxAkOk174WVt//kzx15IvfMoRzC/KJ5+2TSfYdtkGhXu9tfw3S1qXnfNqawLxw+z0ZcU2iglWFAk0qp4R63sznFwmP7zmvzG5S2xtCJpN8iBTBBwHr/4JqC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 22:00:40.5803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf87264-dc5d-45d7-67a4-08dee9cf0069
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8780

Values written to OSPM-set CPPC registers (via sysfs or the autonomous
boot parameter) can be lost in two ways:

  - Across CPU hotplug: the platform may reset a CPU's registers while it
    is offline.
  - On driver unload: the value the driver wrote is left in the register
    instead of returning to its pre-driver state.

Add a small table-driven mechanism that handles both:

  - On init(), capture each register's firmware value before the
    driver programs anything.
  - On offline(), read back each register's current value (whatever was
    last set via sysfs or the boot parameter) so it can be reapplied, then
    restore the firmware value.
  - On online(), reapply the value captured at offline() after the
    performance request is re-established.

Keep Autonomous Selection (auto_sel) last in the table so that, on
online(), its saved value is reapplied after the other registers that
shape its behaviour.

Cover the Autonomous Selection (auto_sel), Energy Performance Preference
(EPP) and Autonomous Activity Window (auto_act_window) registers.

Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
Link: https://lore.kernel.org/all/86780f97-29ee-4a72-b311-38c89434b707@arm.com/
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 157 +++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 34cdba00e61a..8a13ec49eb9d 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -28,6 +28,150 @@
 
 static struct cpufreq_driver cppc_cpufreq_driver;
 
+/*
+ * OSPM-set CPPC registers tracked for save/restore. A value set via sysfs or
+ * the autonomous boot parameter is reapplied from online() across CPU
+ * hotplug, and the firmware value is restored from offline().
+ *
+ * Autonomous Selection (auto_sel) is kept last so its saved value is
+ * reapplied after the other registers that shape its behaviour.
+ */
+enum cppc_saved_reg_id {
+	CPPC_SAVED_EPP,
+	CPPC_SAVED_AUTO_ACT_WINDOW,
+	CPPC_SAVED_AUTO_SEL,
+	CPPC_NR_SAVED_REGS,
+};
+
+struct cppc_saved_reg {
+	int (*get)(int cpu, u64 *val);
+	int (*set)(int cpu, u64 val);
+};
+
+static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
+	[CPPC_SAVED_EPP] = {
+		cppc_get_epp_perf, cppc_set_epp,
+	},
+	[CPPC_SAVED_AUTO_ACT_WINDOW] = {
+		cppc_get_auto_act_window, cppc_set_auto_act_window,
+	},
+	[CPPC_SAVED_AUTO_SEL] = {
+		cppc_get_auto_sel, cppc_set_auto_sel,
+	},
+};
+
+/*
+ * Per-policy saved state for each register in cppc_saved_regs[]:
+ *   firmware_val  - value before the driver touched it, captured at init()
+ *                   and restored while the policy is offline. U64_MAX if it
+ *                   could not be read
+ *   requested_val - value in effect when the policy last went offline,
+ *                   reapplied at online(). U64_MAX if none
+ */
+struct cppc_saved_state {
+	u64 firmware_val;
+	u64 requested_val;
+};
+
+static DEFINE_PER_CPU(struct cppc_saved_state[CPPC_NR_SAVED_REGS], cppc_saved_state);
+
+/*
+ * Return this policy's saved state. Each policy keeps a single copy, stored in
+ * the per-CPU variable of the first CPU it manages. related_cpus (the policy's
+ * full set of CPUs) never changes while it exists, so this CPU (unlike
+ * policy->cpu) stays the same across CPU hotplug, and every callback reaches
+ * the same copy.
+ */
+static struct cppc_saved_state *cppc_cpufreq_policy_saved_state(struct cpufreq_policy *policy)
+{
+	const struct cpumask *policy_cpus = policy->related_cpus;
+
+	/*
+	 * related_cpus is empty until the core fills it in after init(). Until
+	 * then, fall back to policy->cpus, which has the same first CPU.
+	 */
+	if (cpumask_empty(policy_cpus))
+		policy_cpus = policy->cpus;
+
+	return per_cpu(cppc_saved_state, cpumask_first(policy_cpus));
+}
+
+/*
+ * Capture each register's firmware value before the driver programs anything.
+ */
+static void cppc_cpufreq_save_firmware_regs(struct cpufreq_policy *policy)
+{
+	struct cppc_saved_state *st = cppc_cpufreq_policy_saved_state(policy);
+	unsigned int cpu = policy->cpu;
+	u64 val;
+	int i;
+
+	for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
+		if (cppc_saved_regs[i].get(cpu, &val))
+			val = U64_MAX;
+		st[i].firmware_val = val;
+		st[i].requested_val = U64_MAX;
+	}
+}
+
+/*
+ * Save each register's current value so it can later be reapplied.
+ */
+static void cppc_cpufreq_save_requested_regs(struct cpufreq_policy *policy)
+{
+	struct cppc_saved_state *st = cppc_cpufreq_policy_saved_state(policy);
+	unsigned int cpu = policy->cpu;
+	u64 val;
+	int i;
+
+	for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
+		if (cppc_saved_regs[i].get(cpu, &val))
+			val = U64_MAX;
+		st[i].requested_val = val;
+	}
+}
+
+/*
+ * Restore each register's firmware value, leaving the platform in its
+ * pre-driver state.
+ */
+static void cppc_cpufreq_restore_firmware_regs(struct cpufreq_policy *policy)
+{
+	struct cppc_saved_state *st = cppc_cpufreq_policy_saved_state(policy);
+	unsigned int cpu = policy->cpu;
+	int i, ret;
+
+	for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
+		if (st[i].firmware_val == U64_MAX)
+			continue;
+
+		ret = cppc_saved_regs[i].set(cpu, st[i].firmware_val);
+		if (ret && ret != -EOPNOTSUPP)
+			pr_debug("Failed to restore firmware reg %d on CPU%u (%d)\n",
+				 i, cpu, ret);
+	}
+}
+
+/*
+ * Reapply each register's requested value that offline() saved.
+ */
+static void cppc_cpufreq_reapply_requested_regs(struct cpufreq_policy *policy)
+{
+	struct cppc_saved_state *st = cppc_cpufreq_policy_saved_state(policy);
+	unsigned int cpu = policy->cpu;
+	int i, ret;
+
+	for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
+		if (st[i].requested_val == U64_MAX)
+			continue;
+
+		ret = cppc_saved_regs[i].set(cpu, st[i].requested_val);
+		if (ret && ret != -EOPNOTSUPP)
+			pr_debug("Failed to reapply saved reg %d on CPU%u (%d)\n",
+				 i, cpu, ret);
+	}
+}
+
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
 static enum {
 	FIE_UNSET = -1,
@@ -707,6 +851,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
+	cppc_cpufreq_save_firmware_regs(policy);
+
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	if (ret) {
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
@@ -725,15 +871,24 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 /*
  * With offline() defined, the cpufreq core keeps the policy alive when
  * a CPU is hotplugged out.
+ *
+ * Save each register's current value so online() can reapply it, then
+ * restore the firmware value, leaving the platform in its pre-driver state.
  */
 static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 {
+	cppc_cpufreq_save_requested_regs(policy);
+	cppc_cpufreq_restore_firmware_regs(policy);
+
 	return 0;
 }
 
 /*
  * Re-enable CPPC when the policy's CPU comes back online, since the platform
  * may have disabled it while the CPU was offline.
+ *
+ * offline() reset the registers to their firmware values, so reapply the
+ * OSPM-set values it saved.
  */
 static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
 {
@@ -761,6 +916,8 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
 		pr_debug("Failed to reapply perf request on CPU%d (%d)\n",
 			 cpu, ret);
 
+	cppc_cpufreq_reapply_requested_regs(policy);
+
 	return 0;
 }
 
-- 
2.34.1

