Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012032.outbound.protection.outlook.com [40.93.195.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B65950AC05;
	Wed, 16 Sep 2026 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789555204; cv=fail; b=SHbhWGFmt9rPmphTXfZKt1A7wuHWHa05ctDeJxV01ZxT1N2KX9UJQivX1pfjbDFjIluRMVVcf4BH9MT6S93iJcTOcuHbYxXV+6tXxEPL5E1hg2HQLoK0Rjdtl13q93lYsaXMGVHBbpvVCWICZDp6yZteIRqwLQZRmo+BA0Ws7NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789555204; c=relaxed/simple;
	bh=Qvduej68MGeX+BC3BOqc01C35uajYgGBUbKkzN7f7tk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiwExWg+GyOKlnycDZ9eP/uVuxr85FhDAdBgYav5fitrrsRd9pMOtnA1e8XSRBiJEhCSt1vGyck84YlIfxU/0iTddRhQVWoVMr2ov63hjdwaMQMd3zJffoLIiorORscHuS6nmQZ5Nqt0zlQA8X3pSAmGuCyHnTg+cSCDd8omXmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EWRzkJLv; arc=fail smtp.client-ip=40.93.195.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EWRzkJLv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvDduda84gbr1CwU92a/JTb/7GNpZCcJB9kh5DtICP5C7fRxISMriTqf5eKbmoZlj9cmC9pz/dwaAhReFEpiVpVIz9nnKSY+ITneVguEPC4ag2PPWsYM/n+HdI+kUMN92KWksUB2lkSF9sEIz7Ab+Wun7LvXhLt3nOtXW7tyofan7M4AusrNAkXsIixlHx+uqAwDhUR9y6YpGJFJhKaZ5UB4AKeFBojz8p6WXALF7lDAIti+f/3JhEKhGNqfasKpJgTTLUBrTJXgCesn6svVXaSQFMrGMknBQSRcH1VYEi7VZv0OSAX+JvhyAoaATyrhgBVvZFMMQMc2wVVvWxB7Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGoWmDSTUR34xt2WPPu+cAoxUpR34J7mn0r46m34R3k=;
 b=JVKiHOl3IH0+oqYsU+MvbzeSoJpXEx/j+wYyW/EzXM43ZeKiolL1IBQ6T+oaOtcO7f1xBWTF+22FM1DMrW+RXcNA9lBcJPkiRJ3oHIScsS6GcCSXv9mJYYrfzsCeaCUoJg/Evir9MaoMvIFn+L3ZZZdT0luyAyzhCnlrSmfwgb2z/M5Iwpllny4zdPxWfhlk/+sDQDmnCVz0kwO0XAjvqfJsjQK/CciibLVPV0xG6ddb4WVoFGsCSzGttezFkxxwPTRScuTyFrOrSe23d5W1cyJ+IeMYWkCw16Q6spvO8mi7SHnjoY+JCrKbo0m0XXDfZwzav4flPcnZL1EHJSxwbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGoWmDSTUR34xt2WPPu+cAoxUpR34J7mn0r46m34R3k=;
 b=EWRzkJLvUzivTA3D6OPrjBjhu5P/YUptOnmL6hH/IiT9jiwETLMTMbV+c4rPpcYZ+g27XT7ogSQAetIbJJAIBwmrl8ZoF+vRCHGIHPCmwtSSsDINQVzKmXJpmfij0sTOM5WYHrX0jjAWlY9mQ7a86lJAaqtNJXJqEjxoRa5oMYOEHZZ+QHCAffQVnCJjVx+Dkf2mjOyNo2WnTFWzzzh9ZB0WWJeLqi0rgAWLXK79m6fod16QmNU/QMbnns3UFgUpk/Wd633/9NN9mu+5Z3xhStYzb7c3ff3abxmYXNNNFV60bZTGfuKGT72G4YhTiiZiczKBSTgXOIRmn51cQKOjFQ==
Received: from SJ2PR07CA0014.namprd07.prod.outlook.com (2603:10b6:a03:505::7)
 by DSVPR12MB999150.namprd12.prod.outlook.com (2603:10b6:8:388::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Wed, 16 Sep
 2026 10:39:31 +0000
Received: from BY1PEPF00026966.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::28) by SJ2PR07CA0014.outlook.office365.com
 (2603:10b6:a03:505::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 10:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF00026966.mail.protection.outlook.com (10.167.244.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 10:39:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 03:39:13 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 16 Sep
 2026 03:39:13 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 16 Sep 2026 03:39:06 -0700
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
Subject: [PATCH v5 4/4] cpufreq: CPPC: Preserve OSPM-set registers across suspend/resume
Date: Wed, 16 Sep 2026 16:08:20 +0530
Message-ID: <20260916103820.1760297-5-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF00026966:EE_|DSVPR12MB999150:EE_
X-MS-Office365-Filtering-Correlation-Id: 6562345d-f95a-414d-97f9-08df13deca37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|7416014|23010399003|36860700016|22082099003|18002099003|921020|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	fcGNp9R8LhFLhRLxhW5oG5+NZY5PXvsjr/7q8lPp1qlcSjHjScdTvzbMHafE618M0NuEnPY6HAa8xKhVAzfITZqgP75G8w1h7I2JCarUEOAW8TIEou26tSLJL5kav+24VF36rSdNpTzt3q5o8UgFM3TUB8m7lFfOGHFOYdJr2sEcpjNb6IUwQnWBb9qZvi9QdIFmnqutJLP2YZkt74WepWWgbadQl5yU/3UfNOwc2T7W9D/YdJOHvp35kntfPWjsxaMmPZAP+vy/pariksePhM9JZ9A1pgfuGTwlY0OXxH7dCxxoqn+aCx7quDS2+MbJ3nhtRO/82OMzriRGDb4Z1Siqj7Q2GDvJZ9eEpJeU7gOxPJLooUjSWevTPTk+xRB1jUGK34MUQD1nSooduOGKq8AxAk22P5zU/tNUjY8uSiBU8IrT13+aFB5EGGf/GxpgxsQGcOSKCK3HEBjTRqMT12ieKcL0nwRnS+gGh7MNFG0lE4qMHgNg9PyxNIl17rqzJsBK3DZA/heyvr9hhnRL7nuj5AAdHySREUqPi4+5f3hX8G4RIP+xQVCYlogTrIp98GMLyKOi1Szvt7pReIc5XAaOQT+oHz5ZKYjKImF0PLYMj85E2k18ZxBvN8bKtdLI5Y/1YSRX2X5DuoZWrlombrZb2OSKN8jk8e3Kpt1DWRiofrzJOKJ/p2lonjKpv7HkH8FSvBqvXombkeEUuz2fJ87Pyd6a6JgkXGOANbJkzqmNPfO+QmofrG/xbFcboSOu
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(23010399003)(36860700016)(22082099003)(18002099003)(921020)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ye1sYuSm5OhWDqJOOgM+g9Z7Kxu31eyjAxefdHQbcOBcXlSiJCUWkCbtU4k7YiOQSGef38hShxzxXCRD27+c/ufciaUPTRzmGZzdclopHb1+7u02c8P3ZPw0JYZkdyevaR3SA6KH7IEx6855vGa58I2gOLylOoCP2Sd9ETGmAYYXBOK02aZ9WguAgTWbfyq3mFZsoStxJZOGbc2mxczLWWU4TmxRXoA5H4D1rd7nr1rOHKTl6E+9vUYAglgARZ1DEdQ3viT0++0kyljIKR0I7tAys1or3SIdQOGvZIsWBd86CS7khXRfgCeab7337sA94tAZTSdqfhJ85cVb+kuvai1Dzek5HEfOoV3RZCIlWlCEv2ahn1Fsr+1s7thWqvvdQHVbFnZXWqxh7fW/RQMwFCZT4/leVuCYiz9ajAb/71bwodcGY23paVIcbbkJUPIT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:39:30.5760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6562345d-f95a-414d-97f9-08df13deca37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026966.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999150

The driver preserves the OSPM-set registers across CPU hotplug, but system
suspend/resume is a separate path. On platforms that reset those registers
or the performance controls across suspend, the values are lost.

The hotplug callbacks cannot cover suspend on their own. Secondary CPUs go
offline only after devices are suspended, too late to touch the CPPC
registers. offline() does not run for every policy either, as the boot CPU
stays up during suspend-to-RAM and no CPU goes offline during
suspend-to-idle. The driver's suspend() callback runs earlier, from
cpufreq_suspend(), while all CPUs are still online and no device is
suspended, so CPPC access is still safe.

Reuse the same save/restore mechanism for suspend/resume:

  - suspend() saves the current OSPM-set values, restores the firmware
    ones and sets a per-policy flag, suspend_regs_handled, to record that.
    It also stops the frequency invariance updates, so that no sample
    spans the suspend window.
  - offline() sees the flag and skips the save and restore, as suspend()
    has already done both. Saving again would capture the firmware values
    that suspend() wrote back and lose what the OS set. It still requests
    the lowest desired performance.
  - online() clears the flag, so that a later offline() takes a fresh
    snapshot. It also restarts the frequency invariance updates.
  - resume() calls online() for a policy that still has the flag set. CPUs
    offlined during suspend come back before the core calls resume(), so
    online() has already run for their policies and cleared the flag.

Suggested-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 63 ++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index ac315071a979..11f2e8111ef9 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -87,6 +87,12 @@ struct cppc_saved_vals {
 
 struct cppc_policy_state {
 	struct cppc_saved_vals regs[CPPC_NR_SAVED_REGS];
+	/*
+	 * Set by suspend() after it saves the OSPM-set values and restores the
+	 * firmware ones, so a later offline() does not repeat those accesses.
+	 * Cleared at init() and by online().
+	 */
+	bool suspend_regs_handled;
 };
 
 static DEFINE_PER_CPU(struct cppc_policy_state, cppc_policy_state);
@@ -895,6 +901,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
+	cppc_cpufreq_policy_state(policy)->suspend_regs_handled = false;
 	cppc_cpufreq_save_regs(policy, CPPC_SAVED_FIRMWARE);
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
@@ -986,6 +993,8 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	int ret;
 
+	cppc_cpufreq_policy_state(policy)->suspend_regs_handled = false;
+
 	ret = cppc_set_enable(cpu, true);
 	if (ret && ret != -EOPNOTSUPP) {
 		pr_warn("Failed to re-enable CPPC for CPU%u (%d)\n", cpu, ret);
@@ -1034,9 +1043,14 @@ static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	int ret;
 
-	/* Save what the OS set, and leave the platform in its pre-driver state. */
-	cppc_cpufreq_save_regs(policy, CPPC_SAVED_REQUESTED);
-	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
+	/*
+	 * Save what the OS set and leave the platform in its pre-driver state,
+	 * unless suspend() already did so earlier in this suspend cycle.
+	 */
+	if (!cppc_cpufreq_policy_state(policy)->suspend_regs_handled) {
+		cppc_cpufreq_save_regs(policy, CPPC_SAVED_REQUESTED);
+		cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
+	}
 
 	/*
 	 * Stop the frequency invariance updates and cancel the pending work, so
@@ -1061,6 +1075,47 @@ static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 	return 0;
 }
 
+/*
+ * Run for every active policy when the system suspends, before any CPU goes
+ * offline.
+ *
+ * Save the OSPM-set values and restore the firmware values here, while CPPC
+ * access is still safe. Secondary CPUs go offline much later, with devices
+ * already suspended. That is too late for these accesses, so offline() skips
+ * them. Doing it here also covers a policy whose CPUs stay online, for which
+ * offline() never runs.
+ *
+ * Stop the frequency invariance updates here as well, so that no sample spans
+ * the suspend window. offline() would not do it for a policy whose CPUs stay
+ * online. online() restarts them on the way back.
+ */
+static int cppc_cpufreq_cpu_suspend(struct cpufreq_policy *policy)
+{
+	cppc_cpufreq_save_regs(policy, CPPC_SAVED_REQUESTED);
+	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
+	cppc_cpufreq_policy_state(policy)->suspend_regs_handled = true;
+
+	cppc_cpufreq_cpu_fie_exit(policy);
+
+	return 0;
+}
+
+/*
+ * Run the online() restore for a policy whose CPUs stayed online through
+ * suspend.
+ *
+ * CPUs offlined during suspend come back before the core calls resume(), so
+ * online() has already run for their policies and cleared the flag. Only a
+ * policy that still has it set needs online() here.
+ */
+static int cppc_cpufreq_cpu_resume(struct cpufreq_policy *policy)
+{
+	if (!cppc_cpufreq_policy_state(policy)->suspend_regs_handled)
+		return 0;
+
+	return cppc_cpufreq_cpu_online(policy);
+}
+
 static inline u64 get_delta(u64 t1, u64 t0)
 {
 	if (t1 > t0 || t0 > ~(u32)0)
@@ -1356,6 +1411,8 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.exit = cppc_cpufreq_cpu_exit,
 	.online = cppc_cpufreq_cpu_online,
 	.offline = cppc_cpufreq_cpu_offline,
+	.suspend = cppc_cpufreq_cpu_suspend,
+	.resume = cppc_cpufreq_cpu_resume,
 	.set_boost = cppc_cpufreq_set_boost,
 	.attr = cppc_cpufreq_attr,
 	.name = "cppc_cpufreq",
-- 
2.34.1

