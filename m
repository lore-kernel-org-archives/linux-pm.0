Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE0B4FECD1;
	Wed, 16 Sep 2026 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789555178; cv=fail; b=GSSp4zUlrYaRSsknDhf/IIGyWc8ZcybnU1uTOt5KbXCP+BNE2C4H5VFIsR0Y8MQ0zncYyvPnxY/jtubRXZSO7ZNhW5dMGR1h+gyvcz6Ydva8AWmr/aFLXsK+/3iKBaTLnuT1bJo/YLNPl7wARcP5RsRtLF/9epR/ePWuhmHy6As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789555178; c=relaxed/simple;
	bh=R3KfGLagMjMBM2TpLXoM47suK8AQQssODNSuxLCtSUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDCrudef3II8HHyffjUDJD+JKHVmVPdMtIU/fPZjsLtUNDhq2Z5MygUJVQprhZfDsM/Japc85o5iGWxOB5tNiqyri69xpTE3eJv7TgIRxaWhrVpGscMzHDzya6Y8hsw/cRHyFJ+IrmOibRPi/rt63ch8FemeOs7HA8io6SdqUm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZTPfvQXh; arc=fail smtp.client-ip=40.93.194.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZTPfvQXh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuoN41OD5vDCFsKYWJbGN9WhvJjK2GWy2tEP0y+DHTpyClwJuAlPQuFm0IPLC+MnS4JebaVW1ivDRk9eNRXb2vaZOTy88AlVMasbj2CDaFvLsonrd0iGCePT4eITX295Mb8mcHBeGqoiqYJVyDrnCt2HK/w/xkpTjb5rPeOtubia8Wq5TgQpDttK7h2OeY6Pxi2Vq/zcxm6Ks5oszcQKjJStrf0LAkAOzt7hOlgDKJO2ZcAY/D02k+6E5r8MNqAUUPVVOQmBo8//PNWCN6vbNglvTvJTyc4eizhzYQ53w0kdVzL/bdu/b1KjcTsbEcC5S7fmBdLAU+dfvQa4qoxYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXr9gQ01yMVT2+PPfl7nlpwjXuJiYtgnLPxNOnDaOIM=;
 b=O+hu9vhbVYPGuIAWxhXUMYcPDsQ9UaowEF70Q1Gv9CrU15aEUwavUNNIYpwA7RKTt4AAJ5p70mKA0FHZirtCkYP8e9RESLJjMRNzZOoZt4+FNSzC7n2mxLWzKLynFng/aXCzMvadM9Z0kql2LH0Gg+ctUUGPEL++IeCR9qxnqUlnpxffLID7ELTpFhrj2pWFrRkciyKpobxOSIOz67JPkHhPCmX5XU3XgVivq9sYekdayMBku6zGPleQOd3jrkt8zdZtj68vSWnYYWVCmfxzhZCryXWq6r2XPxSEfacKaz95nk/yhNJ6z/07P+F+uf3mtF8N8iPGGsKilzkXqThNZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXr9gQ01yMVT2+PPfl7nlpwjXuJiYtgnLPxNOnDaOIM=;
 b=ZTPfvQXhUErPigJtO0VCnPgdPK6Ivme8AMYCeicdvht3nZR+/UUggkghfqhqsDCw9TFsqcIKfzikP18Vhmde7Sr87aVdhLXFHe1JpgPvftYJpEnN0kd1ktyhd0pfUzmIj0svpuW38I46xULyfol9zyzeuwAFPzfTa9gJjEOmJRPnWxLETZ2nb5zYTqungukjaf3qecvDeyCi7+Eb7Cb8f0qWZTyOyMyLuCZDw6WOXwcWKN/4OHFl5Vp5NUvP507g+cakQ3SBnRpDJSmWC9TZ58pueenf2Y7DR9Gr8gfLUAKW8/WJlQhKO+z4QrxN88pleB/jWrkMQxtvjVUxMW+cog==
Received: from BY3PR05CA0039.namprd05.prod.outlook.com (2603:10b6:a03:39b::14)
 by SJ0PR12MB5674.namprd12.prod.outlook.com (2603:10b6:a03:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Wed, 16 Sep
 2026 10:39:20 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:39b:cafe::71) by BY3PR05CA0039.outlook.office365.com
 (2603:10b6:a03:39b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 10:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 10:39:20 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 03:39:00 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 16 Sep
 2026 03:38:59 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 16 Sep 2026 03:38:52 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v5 3/4] cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
Date: Wed, 16 Sep 2026 16:08:19 +0530
Message-ID: <20260916103820.1760297-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916103820.1760297-1-sumitg@nvidia.com>
References: <20260916103820.1760297-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|SJ0PR12MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: 75613a40-71bd-4c6e-c4b3-08df13dec43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|7416014|1800799024|82310400026|13003099007|921020|6133799003|22082099003|10067099003|56012099006|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	wt+4RM1e7mpQufwzanq5fYT2v8hdUNbTHquFmcXd1762xgjlGwL1h4bBWy5Pycv8dLXyJUjZLy/2OOw8FUWrSwKuWa3M7E/nBcvTme7ea1B+P/hrJWbRtcF5SID7bpj+mqf3kmxSEoDM3sFGSwRAp29MVx2RtO2u16e3OO1R/39D7jsjyKxUR/IcEH/GSXfptgKiyADnOryO8iUzccGch2SjbjEGpDhIsPb98mVCl2cB8J25PYoPQ3hwB7vg33/364n/et5ciCs/jsEwm0b8jq+q0yjK5IX9If6gkkWgaxAhVqBR1BzzJk9NBsV6sskIJixns8CMMiYWCygMJHJXY+uWZ6Ye9vahYPfisPvCy6tsaUlIGFwSKgM8+4sV+3BkTvuQSPWiFuFIsJ5dRI+4EOY91oVKs5K2pCU89E2559nG1vCYoJcfyZNtAe//NJQAMEBsQmiuH4R29KcFYBI1urv3ksFFteSz8z8j14aJwj+2Ou0b0wLQfs4SMPafd3f/yLrBx+BzGoO9hgaZWH9suzMmGK2HylH/+fruIjtnB7Y0/jXYm8qesUDFuAZwOig9bMrn/MJwVWpYrPP81lzsLclykEnqrRAg1VhlNfyvTXOGbXvLCdSl7vAvOpS7egER9j8apuDryBaiy8LEeGNOHlQ2psYM8JoNI6P5zaLwJhjPXUCgov+MGC+iCQsOEQBYVJRqYneElhtG32Od99b0dnm5IWMOBqcDVbFXgqtby0vDpcf2Y6ZMP+5/3Ve6JA6e
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(7416014)(1800799024)(82310400026)(13003099007)(921020)(6133799003)(22082099003)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YmcV1ReGx5r9EtXz/TvIcUAqcLdQq+6MmXT1boVPXq9RQrZHGR4m7Z2wVlVlbuYDgbb/L5csfX+m+VbVs/HEgUrLCW26u5DQr+LX0p5uIpFchyKjIby1ORBLGpSuPMTNuh+p7eY5FhTsWLOwVJtUPZLBPLaMJGRaUVNKXo6oi2qOlJb8FIjwCyGzxIg5/n03oPQTBOS5xtzKXY8dNFJccVUaIXcO8JyaaexAFCnj767f/wqSBoEV+qpBuZ6rgmR6eicnXj0oGTNWjhxXaKHJ797pyeEuYaA4oK1MrKOrMJQQ0HJTia95Zvnj9UyTGVbh2HmB+ove6zPJViAhaM4sH8UAEC6j0oHd90hAKpa6UMF5sbVMkmHlMeAsV5rjTRoyzbhSaJQIJ+Ah0GjGTrBbZiYkOVDpgN1ar7wTmW5Tq6thi0x/aJGlUVGioxdveVfl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:39:20.4626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75613a40-71bd-4c6e-c4b3-08df13dec43e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5674

Values written to OSPM-set CPPC registers via sysfs can be lost in two
ways:

  - Across CPU hotplug: the platform may reset a CPU's registers while it
    is offline.
  - On driver unload: the value the driver wrote is left in the register
    instead of returning to its pre-driver state.

Add a small table-driven mechanism that handles both:

  - On init(), capture each register's firmware value before the
    driver programs anything.
  - On offline(), read back each register's current value (whatever was
    last set via sysfs) so it can be reapplied, then restore the firmware
    value.
  - On online(), reapply the value captured at offline() after
    reprogramming the performance controls. A failed write to the controls
    does not skip the reapply, as no other path restores these registers.
  - On exit(), nothing is needed, as the core calls offline() first, which
    already restored the firmware values.

Cover the Autonomous Selection (auto_sel), Energy Performance Preference
(EPP) and Autonomous Activity Window (auto_act_window) registers. Writes
to EPP and auto_act_window only have meaning while auto_sel is enabled,
so write auto_sel before them when enabling it and after them when
disabling it. While autonomous selection stays disabled, the platform may
ignore those writes.

Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
Link: https://lore.kernel.org/all/86780f97-29ee-4a72-b311-38c89434b707@arm.com/
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 193 ++++++++++++++++++++++++++++++++-
 1 file changed, 190 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index d7d96fe0da1b..ac315071a979 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -28,6 +28,183 @@
 
 static struct cpufreq_driver cppc_cpufreq_driver;
 
+/*
+ * OSPM-set CPPC registers tracked for save/restore. A value the OS wrote is
+ * reapplied from online() across CPU hotplug, and the firmware value is
+ * restored from offline().
+ *
+ * Autonomous Selection (auto_sel) is kept first, as the registers after it
+ * only have meaning while it is enabled.
+ */
+enum cppc_saved_reg_id {
+	CPPC_SAVED_AUTO_SEL,
+	CPPC_SAVED_EPP,
+	CPPC_SAVED_AUTO_ACT_WINDOW,
+	CPPC_NR_SAVED_REGS,
+};
+
+struct cppc_saved_reg {
+	const char *name;
+	int (*get)(int cpu, u64 *val);
+	int (*set)(int cpu, u64 val);
+};
+
+static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
+	[CPPC_SAVED_AUTO_SEL] = {
+		.name = "auto_sel",
+		.get = cppc_get_auto_sel,
+		.set = cppc_set_auto_sel,
+	},
+	[CPPC_SAVED_EPP] = {
+		.name = "epp",
+		.get = cppc_get_epp_perf,
+		.set = cppc_set_epp,
+	},
+	[CPPC_SAVED_AUTO_ACT_WINDOW] = {
+		.name = "auto_act_window",
+		.get = cppc_get_auto_act_window,
+		.set = cppc_set_auto_act_window,
+	},
+};
+
+enum cppc_saved_type {
+	CPPC_SAVED_FIRMWARE,
+	CPPC_SAVED_REQUESTED,
+};
+
+/*
+ * Per-policy values saved for each register in cppc_saved_regs[]:
+ *   firmware_val  - value before the driver touched it, captured at init()
+ *                   and written back when the policy goes offline. U64_MAX
+ *                   if it could not be read
+ *   requested_val - value in effect when the policy last went offline,
+ *                   reapplied at online(). U64_MAX if none
+ */
+struct cppc_saved_vals {
+	u64 firmware_val;
+	u64 requested_val;
+};
+
+struct cppc_policy_state {
+	struct cppc_saved_vals regs[CPPC_NR_SAVED_REGS];
+};
+
+static DEFINE_PER_CPU(struct cppc_policy_state, cppc_policy_state);
+
+/*
+ * Per-policy state is kept in the per-CPU variable of the first CPU the policy
+ * manages. related_cpus (the policy's full set of CPUs) never changes while the
+ * policy exists, so this CPU (unlike policy->cpu) stays the same across CPU
+ * hotplug, and every callback reaches the same copy.
+ */
+static struct cppc_policy_state *
+cppc_cpufreq_policy_state(struct cpufreq_policy *policy)
+{
+	const struct cpumask *policy_cpus = policy->related_cpus;
+
+	/*
+	 * related_cpus is empty until the core fills it in after init(), so
+	 * fall back to policy->cpus, which has the same first CPU.
+	 */
+	if (cpumask_empty(policy_cpus))
+		policy_cpus = policy->cpus;
+
+	return &per_cpu(cppc_policy_state, cpumask_first(policy_cpus));
+}
+
+/*
+ * Save each register's current value, either as the firmware value, captured
+ * before the driver programs anything, or as the requested value, to reapply
+ * at online().
+ */
+static void cppc_cpufreq_save_regs(struct cpufreq_policy *policy,
+				   enum cppc_saved_type saved_type)
+{
+	struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
+	unsigned int cpu = policy->cpu;
+	u64 val;
+	int i;
+
+	for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
+		if (cppc_saved_regs[i].get(cpu, &val))
+			val = U64_MAX;
+
+		if (saved_type == CPPC_SAVED_FIRMWARE) {
+			st->regs[i].firmware_val = val;
+			st->regs[i].requested_val = U64_MAX;
+		} else {
+			st->regs[i].requested_val = val;
+		}
+	}
+}
+
+static u64 cppc_cpufreq_saved_reg_value(const struct cppc_saved_vals *st,
+					enum cppc_saved_reg_id reg,
+					enum cppc_saved_type saved_type)
+{
+	if (saved_type == CPPC_SAVED_FIRMWARE)
+		return st[reg].firmware_val;
+
+	return st[reg].requested_val;
+}
+
+/*
+ * Write one tracked register, skipping it when there is no saved value.
+ * A register the platform does not allow writing is not an error.
+ */
+static void cppc_cpufreq_write_saved_reg(unsigned int cpu,
+					 enum cppc_saved_reg_id reg, u64 val,
+					 enum cppc_saved_type saved_type)
+{
+	const char *op = (saved_type == CPPC_SAVED_FIRMWARE) ?
+			 "restore firmware" : "reapply saved";
+	int ret;
+
+	if (val == U64_MAX)
+		return;
+
+	ret = cppc_saved_regs[reg].set(cpu, val);
+	if (ret == -EOPNOTSUPP)
+		return;
+	if (ret)
+		pr_debug("Failed to %s %s=%llu on CPU%u (%d)\n", op,
+			 cppc_saved_regs[reg].name, val, cpu, ret);
+}
+
+/*
+ * Apply the saved firmware or requested value to each tracked register.
+ *
+ * Write auto_sel first when the value being applied enables autonomous
+ * selection and last when it disables it, so the writes to the dependent
+ * registers can still take effect. While autonomous selection stays disabled,
+ * the platform may ignore those writes. Do not enable it temporarily to force
+ * them through.
+ */
+static void cppc_cpufreq_apply_saved_regs(struct cpufreq_policy *policy,
+					  enum cppc_saved_type saved_type)
+{
+	const struct cppc_saved_vals *st = cppc_cpufreq_policy_state(policy)->regs;
+	unsigned int cpu = policy->cpu;
+	u64 auto_sel, val;
+	int i;
+
+	auto_sel = cppc_cpufreq_saved_reg_value(st, CPPC_SAVED_AUTO_SEL,
+						saved_type);
+
+	if (auto_sel)
+		cppc_cpufreq_write_saved_reg(cpu, CPPC_SAVED_AUTO_SEL, auto_sel,
+					     saved_type);
+
+	for (i = CPPC_SAVED_AUTO_SEL + 1; i < CPPC_NR_SAVED_REGS; i++) {
+		val = cppc_cpufreq_saved_reg_value(st, i, saved_type);
+		cppc_cpufreq_write_saved_reg(cpu, i, val, saved_type);
+	}
+
+	if (!auto_sel)
+		cppc_cpufreq_write_saved_reg(cpu, CPPC_SAVED_AUTO_SEL, auto_sel,
+					     saved_type);
+}
+
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
 static enum {
 	FIE_UNSET = -1,
@@ -718,6 +895,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
+	cppc_cpufreq_save_regs(policy, CPPC_SAVED_FIRMWARE);
+
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	if (ret) {
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
@@ -791,12 +970,14 @@ cppc_cpufreq_prepare_perf_restore(unsigned int cpu,
  *
  * The platform may have disabled CPPC and reset the performance controls
  * (desired, min and max performance) while the CPU was offline, so re-enable
- * CPPC and reprogram them.
+ * CPPC and reprogram them. Also reapply the OSPM-set registers that offline()
+ * reset to firmware values.
  *
  * Report failures without returning them, or the core would free the policy and
  * leave the CPU without cpufreq. A failed write to the performance controls is
- * not fatal, as the governor's next request programs them again. A failed CPPC
- * enable stops the restore, as the writes that follow may not reach the
+ * not fatal, as the governor's next request programs them again. The OSPM-set
+ * registers are reapplied even then, as no other path restores them. A failed
+ * CPPC enable skips both restores, as the writes that follow may not reach the
  * platform.
  */
 static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
@@ -832,6 +1013,8 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
 		pr_debug("Failed to restore perf controls on CPU%u (%d)\n",
 			 cpu, ret);
 
+	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_REQUESTED);
+
 out_fie:
 	/* Restart what offline() stopped, with a new counter snapshot. */
 	cppc_cpufreq_cpu_fie_init(policy);
@@ -851,6 +1034,10 @@ static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	int ret;
 
+	/* Save what the OS set, and leave the platform in its pre-driver state. */
+	cppc_cpufreq_save_regs(policy, CPPC_SAVED_REQUESTED);
+	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
+
 	/*
 	 * Stop the frequency invariance updates and cancel the pending work, so
 	 * that no sample spans the offline window. online() restarts them with
-- 
2.34.1

