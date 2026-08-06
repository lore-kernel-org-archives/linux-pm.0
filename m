Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA15355055;
	Thu,  6 Aug 2026 20:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047024; cv=fail; b=tXA4nrXvAm+QHry+mt9aLgCSJoIGoEP3eUKTYQSxRnaz9k0jbcB1ooDUl3YxQJjCivOUmRrEL6gUj2oveisrEsbFMJ4B+za/2Xc5xA+xAdwVImd97UwjTb9n58kBz8KUyGLxOETjRPHzMpqtgCVeIPoTuCncajoKF9BmPBV7nbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047024; c=relaxed/simple;
	bh=5CB94e66l8nhBzof5RaHUkuelmv4PifXPIOMMVYmS14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFtTlEIxliVIaxFZiJFXU0SRbij5c32/pjCh1VwJys1UWiVJdoBEUXunBcOSrfFoQIOnz9zoeYjYprrN++2ypXkPyNO973GZy5a7RmE7dCr7QkZxvnLSMYlywPIunvlwJ7qVnnTwS0ED253gOHQClxRJr05MFSyaMBKRNsj+Ed4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V8HqlK9n; arc=fail smtp.client-ip=52.101.193.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V8HqlK9n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJYf3zuO/VbKokwnGU4yGJ/ckenmTnsVFefr20s3B2cdvJW+0i9jIw+ZLMmKp6VkEAJZ2DjghsIjv+yNF3MWNnvmp1QHDTskdpC06SLCxFYqce8CP18UF/HgAJmLP93xIUE/6TUR4vDqXxr4WKvs3YHnCPxNuh5ED6u1ohDUwnhXLD6Vhnf3G1oQ/qh18OcEq/lHN5d4kf5O/brceAv8mAmY2fIKVVayPcWJYsFAQCG6m4+vC1V5X+L7sRxZHzWDm8yKfmVKio6lW2jArRUg215bEYl9irAy6ti+HrjRada+o4s4EMrGBrb14VBiKRYLFx6b1+D6fz4CwKd5oLNtgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbD3KCeUMSwfExKh1njc4cBBO+rhlTuPsAKuIyr3GEQ=;
 b=kaou1ilPq0W7nod4mgMO6TjkXS1y+7BPrTFl11txO/82otICQHbYUpuMnUVt0JaLbbX1sgBtcbsA8nZivWU52NiUfiZXYlVYDHGOOnJfvI+7xrQ4F5ispXuP45INqwNxwCtOHbon6pQgOwdg1T/Bv1Ha6vV5qeTyGpY++2ztQNfPZTeBHFNyt4gqxJLL98C0u3+fupurncFCGI6jw1aY/gr252COajHX9gRKlV1H/X00yqrYoSki+XmDdYUxSlXMdBJWjSHeB2Y1ZLa8L05WKyVfohsQQgowUgl9O6kNC9tZSm9/Cr0wAqtuNxh7U/dqxylGOr9kDeOb/25fFJlRGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbD3KCeUMSwfExKh1njc4cBBO+rhlTuPsAKuIyr3GEQ=;
 b=V8HqlK9n23sK3v64Z4xvyqU91VymukXeAsf/4ahi8eQLjyx1VYZva8WJQzAkYdayar3NUzxX4UFCwoMzn3tX0OThbfyMOLX+9om242o1zaYkZOyUY0f0sFku12gniu2NFGgIuzukxVWMQJMi/Yr08ARMWfTy0ArB3j1qHzePWpzw+ADuj7Vz3tlQ6cc7iiczwzcwCZ/w24LtatncYgBdeVy5OPBGcsLmxPmCcxT/gYW+aAmIR5JB8UCWSDiRcV27ffZ9eQH1E/x9mTeRz1NE1IkV5y+hDu+Izh2Rx/N0kxH0Vf6rLYyk3xfwX3rlnAAelmVHC0gwPBbCPK12rgFaHg==
Received: from PH8PR22CA0004.namprd22.prod.outlook.com (2603:10b6:510:2d1::19)
 by CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 20:10:09 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::a1) by PH8PR22CA0004.outlook.office365.com
 (2603:10b6:510:2d1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 20:10:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 20:10:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 6 Aug
 2026 13:09:40 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Aug
 2026 13:09:39 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Aug 2026 13:09:33 -0700
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
Subject: [PATCH v4 3/4] cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
Date: Fri, 7 Aug 2026 01:38:56 +0530
Message-ID: <20260806200857.601152-4-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|CY8PR12MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: d91824a9-9c8c-489d-201e-08def3f6b6a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|7416014|376014|22082099003|13003099007|921020|6133799003|56012099006|11063799006|5023799004|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	w1JheA0il+zn7Tb0ieXGdk2RW8M+/tw2s3AMfUOtODhKbJmzhbB5tW2W2AMbK3ZzSiN987dFGevBm1sBNOEXI0Y7fBskUbEwsuNX7NDwl06V7lVIX0OeeVpL6lnY77ZMUxh28ttnpSWnLQ3bTeeGCp9eznXf8Ja0Jk9ROxIj5rwkXwThgGv6TD25+zhq05rfza6UzOZR+7Xia1mRiQThWHFDrYzYKr06jY6lwy8AjFlerqw/W/LX8jscPzYQuzKZkssezxYDM8ZGbH5ZKEnxRr27xgChq8VW8SsY4l2vTnk99XN3+pvgDQwbDx+vz/hhUzZUOQu7OkcRO1XLQtn303izjxO3vpaVa+R99V1p/44zpKkVdUmR02hdL12Q9RCKIGRsNbpdu/SjzgAQaUg6jJNwZpVJOdHQ9jolvOnz8AT7ByErx9SfbsTsW2h1Ao+G2/TE3/gVIleikYh7cwQigraOti66WNT87JZcygqTkVHpM4yOH/UYfniYmP/mYKNYKyLulbC4KP6+/MFYu0+XjkOL1Shp0oWxm/O+ssiBNI9F2nILdaZaAq7TfGpTzHNaSB4XDjipf0zA4SZ6iSNaGiOqAS4GG2w8/5KG2UF6WP87fQJA08FJ8ZCNyPWBG7XxLWFGhQutTceiZmj2GSKX1Iq22bRWOpoOK1bSnmjxt6NcrSMQlzsbJEC7p7d2YmZ99dSw3tJI6pBhfzRxx18s0u7MJBSj2SoS7MbgLc9pAzFpVa+VepY1nqFAt2EJ49F4
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(7416014)(376014)(22082099003)(13003099007)(921020)(6133799003)(56012099006)(11063799006)(5023799004)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p/oq9ktlSFWW9MD+Pe6XyOrYIXEQLY/9rt6CrXJJ5oOMkS5zkTw1kn8x6ErtZjahY6gSdUB19Uyydy37OinIBpJNRvluDiddVXEdU17zNrNfge/D04XBMtx/H9chyxEySNoH9wCqqgXGvvpH50bupiqr1zHBUazpJUWJ4ZSSJM07RYMYaygQCc3edooUq7HTdcvHCCNxU1O3L+Fb59o2NBAUX2b9KXJ/hKWPngWxnZPnwu6QKfvVlF6IUGykrRdiGNygTT7lF305QAvPpMVJPt51IUOV+SgML6YS8TCxGEaqSNwh6KCxevb7wwozdtElnj7tyImDyWhqBoRSNtgq4VgTGINJYWLSFlB2cIYvzoodmpjLoCiiI5hvSKAj3/hHm7xPqN33uSahCuimdwNYrU/iylLeBS4nMeeaIUrgO1AR/+eQq0iii/HXNy4Paqp1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 20:10:08.3754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d91824a9-9c8c-489d-201e-08def3f6b6a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7755

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
  - On online(), reapply the value captured at offline() after the
    performance request is re-established.
  - On exit(), nothing is needed, as the core calls offline() first, which
    already restored the firmware values.

Cover the Autonomous Selection (auto_sel), Energy Performance Preference
(EPP) and Autonomous Activity Window (auto_act_window) registers. Writes
to EPP and auto_act_window only have meaning while auto_sel is enabled,
so write auto_sel before them when enabling it and after them when
disabling it. If autonomous selection is already disabled, those writes
may be ignored.

Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
Link: https://lore.kernel.org/all/86780f97-29ee-4a72-b311-38c89434b707@arm.com/
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 191 ++++++++++++++++++++++++++++++++-
 1 file changed, 190 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index b50d3f893b1d..f8628b1fc6b7 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -28,6 +28,183 @@
 
 static struct cpufreq_driver cppc_cpufreq_driver;
 
+/*
+ * OSPM-set CPPC registers tracked for save/restore. A value set via sysfs is
+ * reapplied from online() across CPU hotplug, and the firmware value is
+ * restored from offline().
+ *
+ * Autonomous Selection (auto_sel) is kept first, as writes to the registers
+ * listed after it only have meaning while autonomous selection is enabled.
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
+ *                   and restored while the policy is offline. U64_MAX if it
+ *                   could not be read
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
+ * Save each register's current value. init() saves the firmware value, before
+ * the driver programs anything, and offline() saves the requested value, to
+ * reapply at online().
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
+ * Write one tracked register, skipping values that were never saved and
+ * registers the platform does not allow writing.
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
+ * registers can still take effect. If autonomous selection is already
+ * disabled, those writes are best effort. Do not enable it temporarily to
+ * force them through.
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
@@ -747,6 +924,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
+	cppc_cpufreq_save_regs(policy, CPPC_SAVED_FIRMWARE);
+
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	if (ret) {
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
@@ -773,6 +952,10 @@ static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	int ret;
 
+	/* Leave the platform in its pre-driver state while offline. */
+	cppc_cpufreq_save_regs(policy, CPPC_SAVED_REQUESTED);
+	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
+
 	/*
 	 * Request the lowest desired performance while the policy has no online
 	 * CPU. Zeroing MIN and MAX makes cppc_set_perf() leave them unchanged.
@@ -822,6 +1005,8 @@ cppc_cpufreq_prepare_perf_restore(unsigned int cpu,
  * or the core would free the policy and leave the CPU without cpufreq. The
  * governor redoes the control writes, so they are best effort, unlike the
  * enable, which only a later online() can retry.
+ *
+ * Also reapply the OSPM-set registers that offline() reset to firmware values.
  */
 static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
 {
@@ -854,9 +1039,13 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
 			 cpu, ret);
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
-	if (ret)
+	if (ret) {
 		pr_debug("Failed to reapply perf request on CPU%u (%d)\n",
 			 cpu, ret);
+		return 0;
+	}
+
+	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_REQUESTED);
 
 	return 0;
 }
-- 
2.34.1

