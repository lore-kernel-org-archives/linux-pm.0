Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792498808;
	b=XPf/q8TcG6IlF4K9lclRdS6legHCtNvxkstTJxJPa+Vzi1idq6WmrTD071fzmSAz2SA5
	 dXZ6ym5jNzHhGpYAamWt3RJqWi4FWFbpC2viLvovWjvoRqnfjCDb49VUo1dJB6X8O45hv
	 almBWeMNnIkTuUdNwS/0ooOc2Qd2DR884QAdpv0ia7L6sqiC46mBHEpxBGJHwnRwAN0hl
	 ch0fbx6dBAOchAb4YTek6m20vYPsa0MuHhDXWzmo48w8erpsi99U87Q6gCgD9WmYqPXt+
	 hHsCqlOiUgdDkB59eskb6RKZ6pTLMvW9h+J0tuR3Yc1naRs+IjFkW7t00YnMOwIvAbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498808;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
	 Content-Transfer-Encoding:Content-Type:X-NV-OnPremToCloud:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=hXwa0cXrLjMnF7wWVx+0MiXIBUhFPVKZAE5OA7tGyzM=;
	b=EHQwLmHeb87dQcHMal+ZcBDuHt0lsvGFsWO1vxJXrtui7M+SHMA2CASdpuVTV5oUcQZ3
	 BIkv+7hsq5YVKBImolPWLhv7nGZOvC7TpuNx0vPIuX+tfG4oL7PSDbXkXe97eYlstc8r7
	 BlPrSrnWFbx1kyIu1315tVquLnj/QkNpDB7RL9zKtV2fm55Fha99U728XkuUFEeEZlfRm
	 L+R2lDa41/QuVTiVs9VQdJDcZ3nEnpRT6FP+DeIG0gU3g1MuM1mKgn5vbK4mt/fz9atIW
	 7pTDvhRyQwN4XeyQ1a0hrRzc4RFgBh7mt2uLVWTaIX4DkOY3C3XhpVTnR1fsG7yD8yg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mT1esXyF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.44
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD56606A31A;
	Tue, 20 Oct 2026 12:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAD56606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mT1esXyF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNxHeIlDDN0Q/Wqe9D049tRUSj/QhwJUsk1osiJ96MgqV4rgyBz6CbsUwE52oYAN/8nLg1BrBqjEGSHYIjyaLuI7CzcCMuT9ED+P2HuRNe4KAqv5cKHQClHFGRoSI0hoCwAQfQzrsIzxZc+x8u2/vosyEVV9TCMHb7NHKKD721JTmk8SnZpn2hhZc4wLJ3u5vayg9Kgdi2hPJHetpjblpqaDG83Lw6Mn4EHc10d631A1BN334N/tOudY6PM/3TMm4nKd4ZWZjAgFixMcIG7AAO4Fh3Eyg3smdHzhup8qeXtPxLadE71BcvnuFV8GRrYN31QAZzCT7ufA46y7/OUo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXwa0cXrLjMnF7wWVx+0MiXIBUhFPVKZAE5OA7tGyzM=;
 b=ZdG5hQXiINNKEfDrHy8ABSPx5BMmoIBx7mKRxzdrvacpkeLePQtUb2byRHTK11i3JfFsWGcYF0J8jxtOZ9f+IF8q4YHELUUWidC2BXzJ/Xicayy6vuQ272gt8bjwmRq/D1rhNQoZSWXf5SflJT+AdTwJ8lUvgEc5M+AsxGVxSveOzzzwRfyFa+Ifk0TrmeHrufGQkyVLAEVJCUZxkFAdFvy1eGnPTxayvCkMwmp1p68P02tWdWlp6kJONvDBCMhGc23Vfrpr3GV7HDgzUdH+EJDb28bC4ML4649cnH0Ryo+uFcBgbW20Te8PD29cUTve6AI5X2rR00mT75UtN/Ww4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXwa0cXrLjMnF7wWVx+0MiXIBUhFPVKZAE5OA7tGyzM=;
 b=mT1esXyFVd1qfXWltX+fwS7AquPn5f48w98gBrOd61dS3iPikwJABf1gIi0at1G4vrmGR1QSQ2Z1E9+B54NjIxol5ptKFJNFAeeYGPDXrl8pWdVXFwZkeCdKHUXQZrAkeNng2MNl/T9c0neVe7WmVCCZNG5a1wwWHlSxNjvA75ZtjsIcrKqNkUEoy6r1PxwQ+hAQWmnaMG859qZYRkxHggtyxPKjZkMVD8jUzzJdTWDQJzg3F+pEoQ71RtN49p/oiU9Ohg7U0mxy8CDSiBIHD6STNYz6SWUoGII2eVFRdoKpXSx1tu5i7t0WgyO5grTx6oSrDOmH/RQ/RK40AhhU2A==
Received: from BN9PR03CA0773.namprd03.prod.outlook.com (2603:10b6:408:13a::28)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 12:19:58 +0000
Received: from MN7PEPF0000014A.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::c) by BN9PR03CA0773.outlook.office365.com
 (2603:10b6:408:13a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 12:19:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN7PEPF0000014A.mail.protection.outlook.com (10.167.254.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 12:19:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 05:19:40 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 20 Oct
 2026 05:19:40 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 20 Oct 2026 05:19:33 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <mochs@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v6 4/5] cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
Date: Tue, 20 Oct 2026 17:48:45 +0530
Message-ID: <20261020121846.691218-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020121846.691218-1-sumitg@nvidia.com>
References: <20261020121846.691218-1-sumitg@nvidia.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014A:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: d21add78-bb95-4da7-3d30-08df2ea47542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|36860700016|82310400026|921020|56012099006|5023799004|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	6YTWHyRNc6419VdgN4fNO7kNB68w4nJoLrShgfQBCPJ3f8AuxuZ/rjmSfdvgA+0RyJypgyfd5WLcaoNYJXPwIzHl3xS+/5bGJ8ErKcOGXI7KWPtpIvd/VhLGCwaUZ7oCjtXJ4ks/DOqBGWSYHBuErw4A0GiU2/rtgVeXSfdX1/iQGv8GiZza4ub6EgiCOCPg5evYyft6/DQEluhceN9I7EOh4Vs6AMHpu/Pw7qrhhmwm+qcedvH/WP20AIONnNQbN5PgA9csRfUGrS0MpmJWqZrg6B2DOsdfIkzdbx5ZpF9AZ1WQDLTbfTilR0Hf/jM9kqeFc93h30QyBdRku6osYlRgMBpIu1dhrbtCxrrNDNMwFQdlfyg7sfv/mCPUNnShxqgRq59RNMClQrqdGGCI4R6UnFfs745qBYIn6RhBmGokqSTPfqyi/ES9UN5pAjU0j1tlIDD1ZBW2JvVKn6QWDHJc0zmphqpEbqUZ85RiNNe1+Wre6Xk+k6QNTxD/3TNBwA4sycJBwRbch7EggwF6UU4/CLxy8VACzim0sOa7+9x097y2aV5vP+T6pPhzXSGF5Saq8d8aTGnJoKQLl6eEPR1y2Bli+8oDSRzwOiKKeu6iFLGTUQWLQM7HjsG/DGOSp9IbfjU5e5AH0TfzzFZ+vq4mLTRNYTn2/sFpusRG1lCmM+bl59IeOEQzRj7h3vfarauG+fhT2vGWzP6j6uwFsdCbUyuH0FlSpBglE+tvE8rxOO38yW5491WpnETv9l/N
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(921020)(56012099006)(5023799004)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y65swoQw7weaj4SCvLouGDJm5KKcVTMS3fUPJWae4jK6m16bYYDXOw+Z+WdTrFeMTAjL5/7SwlOen5Xx0PxmDjmw1nJGV+TU7JmtyyibNwwPImSBk3uBx8hmEcFRvpENZOLfqU6dG7XII9NZXExP4ecZ32lLDea0Y+okpy2HBtFR/kvZOy1xyZNRPvSeUyNO8NUCtN/L9Jzfv0M3PWbZCuDg1woixlRnIYMlN3Qes46flZ/5D5b1Iki12p/7k/LB3dwVZGgJMubnaE+BEDD7oq5mji9X4PZX9zrgA3KV+HSCK9CVdEG0dMYSXWnir8GWvVkkvwwZetLMQhrm8E9lsW5e6QDa5nzH5/2Gnm4Zt8ko6qVm3xVicV+7k51lLMLvfWrNHNfqy+Dl/YUL0dcsdsF98x1eSB7QabID8SYpNKgblP4u2R46Hk5k8uxDrGo8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 12:19:58.4134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d21add78-bb95-4da7-3d30-08df2ea47542
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN7PEPF0000014A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553

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
 drivers/cpufreq/cppc_cpufreq.c | 176 ++++++++++++++++++++++++++++++++-
 1 file changed, 173 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 9e1214e1cb0d..1b733f15d641 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -29,6 +29,166 @@
 
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
+	CPPC_NR_SAVED_TYPES,
+};
+
+/*
+ * Per-policy values saved for each register in cppc_saved_regs[], U64_MAX
+ * if there is none:
+ *   CPPC_SAVED_FIRMWARE  - value before the driver touched it, captured at
+ *                          init() and written back when the policy goes
+ *                          offline
+ *   CPPC_SAVED_REQUESTED - value in effect when the policy last went offline,
+ *                          reapplied at online()
+ */
+struct cppc_policy_state {
+	u64 regs[CPPC_NR_SAVED_REGS][CPPC_NR_SAVED_TYPES];
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
+		st->regs[i][saved_type] = val;
+		if (saved_type == CPPC_SAVED_FIRMWARE)
+			st->regs[i][CPPC_SAVED_REQUESTED] = U64_MAX;
+	}
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
+	const struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
+	unsigned int cpu = policy->cpu;
+	u64 auto_sel, val;
+	int i;
+
+	auto_sel = st->regs[CPPC_SAVED_AUTO_SEL][saved_type];
+
+	if (auto_sel)
+		cppc_cpufreq_write_saved_reg(cpu, CPPC_SAVED_AUTO_SEL, auto_sel,
+					     saved_type);
+
+	for (i = CPPC_SAVED_AUTO_SEL + 1; i < CPPC_NR_SAVED_REGS; i++) {
+		val = st->regs[i][saved_type];
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
@@ -800,6 +960,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = cppc_perf_to_khz(caps, desired_perf);
 	cpu_data->perf_ctrls.desired_perf = desired_perf;
 
+	cppc_cpufreq_save_regs(policy, CPPC_SAVED_FIRMWARE);
+
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	if (ret) {
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
@@ -843,12 +1005,14 @@ static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
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
@@ -896,6 +1060,8 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
 		WRITE_ONCE(cpu_data->perf_limits_valid, true);
 	}
 
+	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_REQUESTED);
+
 out_fie:
 	/* Restart what offline() stopped, with a new counter snapshot. */
 	cppc_cpufreq_cpu_fie_init(policy);
@@ -915,6 +1081,10 @@ static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
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

