Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A27333440;
	Thu, 16 Jul 2026 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216375; cv=fail; b=H6Z+27l+RVonLU8VZ85kIUrDB+CLFTpeT50OXoknYZueRR5ttQsWVUpaAsWp2zAOR43Okp4QRccvPEopSj7A/6DMuo0wiKiW0PxBohsQTHJOJVNKNHiqvweWXmIM2ajtIB25UVdSazo+ZnbBoIYxWhteWrbWGGoEKEB5ecVoJfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216375; c=relaxed/simple;
	bh=xRN+fazCt4mm1aY85cqfFxY9br5VtxWlNg++HrL8rIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9aX0REgjmMVFv6IEg/as1mceF9o9Dy2HtdAoE7c9yW7E1Am4kkiebn04HnrkEUzO30exOFOH/BKPHpGGIfJnmoNAybWFq856bsOpCBOLrn8RHeeDGcnb6dRLpZvI1NGdwY/qpacK+8PwzHyD1EmoqSVrLj0DnDhZKqc8MZkkf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GhfvPBaL; arc=fail smtp.client-ip=40.107.208.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GhfvPBaL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpiVk+lVAfBNP1fcB+n4BQUEtaAPEaiWLwvAxQtZMtP8W4RD3a1xvSrWHCVpxVo+NNFdbWF/cKDexVuEETEHwHlOq9RAiJYkh4GxxLYG96y1KWM3na8RoV9duz1u1geb0PThobXpkIzvlkf5/o1bdaV9IJ8uT8bkM9tVhbvFJRZVYTUqo3QGyGfD7BsoNgsv6AbWjAf2rs6wAy+Xb4P0KNZcLmQIQwVbA9XBFBLhmxBnrkGXPvCfb8CdnRTDcSO47B3TxuMUcLvZR11SkzWmyttNrgdEbU4ANO2iMMqsnLAzDv2JFOYdga79F7yWQCFYpYoH+NPx8xllEt4bDWwwuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaIfdGrWcrHmBFNxTiWbdWTM45TkG+KDkEt3dn84wTY=;
 b=rPwoZcDnHqUWlBPfeYsLJX5TSCOyb53CzD0idHe153niK/S/I4rKWEWC55xEnx2pPSG4wm1M6XZQyU30Z2xyPK8H6q8+qwSL4wbjBjvfh+LCxByGzHFiBY1SzANJJGOD7s874C/dHoRUCFQA1QheK+2LZNidsJUpMMJjvKK8srUWw86uFen2Ze2FY4QF3tMpFXydjVE/uFm/jrjsZOuFR5GlMpqqdP9uAYStAHj7ef/sop/ZPbusrFhtuQCq0atphXu84Ty4NVeZxNi0Vm/6Aqi8gnmsKxGWZnoHxyOZFjFLgjXYyFi74YOUkkTM5yHZUBhSLO8rqomeKOT2yDiBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaIfdGrWcrHmBFNxTiWbdWTM45TkG+KDkEt3dn84wTY=;
 b=GhfvPBaL5nxrY7I3B7tk87MdkV2gLrsfvm6o2cC8ZpXSr1BhjVc5g6wKbz/si0LXL4nQRYP6V9Ugz0VOPx8Tpl3/b4u9/73zJAA5goPlLPhzaQRGoT2PsOCMOYuUOrRP1vr1kOACacrvoFkYKMdXgtw1OBlvsc5lY/kfEM4dgKZbsysCSvmL7oqu8RTRpXkErdnvPeUxBOpDF91/6cw6/fOmD/EYh09BSKuXxXXUUeP84xjL13bq+BMkuZsk/ZCEWG2G7zPIeYQYEi0vmnZP9ko9ckKlcMfiZvcw+TWlH0t9YgigSyzhPKBDtwjyhFoOIvQUpVlRXBfSbw4BgPhypQ==
Received: from CP5P284CA0156.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:22a::15)
 by DS0PR12MB6437.namprd12.prod.outlook.com (2603:10b6:8:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 15:39:25 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10d6:103:22a:cafe::ac) by CP5P284CA0156.outlook.office365.com
 (2603:10d6:103:22a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 15:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 15:39:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Jul
 2026 08:38:54 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Jul
 2026 08:38:53 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Jul 2026 08:38:48 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <saket.dumbre@intel.com>, <lenb@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v2 3/3] cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
Date: Thu, 16 Jul 2026 21:08:20 +0530
Message-ID: <20260716153820.2007095-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716153820.2007095-1-sumitg@nvidia.com>
References: <20260716153820.2007095-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DS0PR12MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: f12d4e2c-12b2-4cd2-5455-08dee3506a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|82310400026|1800799024|921020|13003099007|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oMWC8YOG7NNk2SoVWOG/fRTTEhrON51znJVJwiG8VXjtqg3W7d4P8ITZhahB99J/ScFLSGJcELXIZ0GJa7miT2ZU/d12n3xzRt+IKgukQ/COEtuDt8pm8jPGkibc1plB9jliWu/gLDDoJHn358f7s3S4u7cPQKAx/xgRPwOzMPWV0IofayORYIMajT3BlVEiA9y6ReLPdKsIIEW2UnA+X/0/Ug2gtE/a38aRRXcDWeak0PHTqua0y/rACgdErDYkULMu4uKLnO0tW51Nitpld5nhnOCNqyOaQc6aresc6ODfkiPdMtnERN9ZSUbjhBiuYRxCwuihQLYJkQEOkrFoBi5VRB2aDyMayslHI4QutKKz0ZrQiN+o3lBBoM6hrbqpQuMoFEXKxgr3RKiO0Ko/57qN4vKu9FPXp7EvPPZNU3e+CtiyjVcJoMCACafngshVSJ2ngE6sWeJQljdM8+N3Z4WOTdlfT84Tz1r90Gd24Bg/VvwV+jRs4jqmzj4QTY2RQvX7SqzfzHtn4Db3TAF/xjfbrQqzs2FaONNL52T0qL7tV1VFgvDrMIptb3nrWPx+5MBkktA6iNch7xDaiOOAgPmETZYB1bQH0/v21uF8h7Lja6/A1y3L+yV3TrcdxERnoFFhGNocW7mLymGfE/jGfCf0QfwRFuYt3q9BzAtVB6GuPEiEhrirW8F+ZbHy7+Xs2kvw7uITAvOHImicrJ2Uom2MGVp5fFyq7G4AnkgzHRhUv139aDV01oQe2TYitWVJ
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(82310400026)(1800799024)(921020)(13003099007)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k9iIl+Y9NJfdMvd3q9csBQNDc2kLL+zou5t8tRqR5yMfHhUSgDPTTdpsInxvNsplZO5Nf6ZVYYC6e78EWg3KjdRygaz8WO9FO+Mf2uqCQovsc6+7+/s4J5RBGOGgWBjrRbIJqfv6FGFn/W510Bmqds4G3g3tMCb2q7ZOAD8UdCMibmHcQVz2XmrV4bpakppjR6NivYcfNv3zRi2kOeCkIzQrc9a75YvOxiW/OZ5S7Z2DIpRWWdbkwct6tEEwgc+haH2AAq1bz8XmfkPQDKKyTQ3qItFzq/KPoYjoiaakUhHDyN/8SRwnjopKrVbiaf36Tgp9ePZvTsHceGis4tTmx33WacUv54QOzIKKMzJ5pg0/ikmk3f5lVqxT48fkApRaOgBxFFSHv+8SJ10xvQaiMLbL1ZP5vl4AZiTzj0qTMStHN8FZHA1eGTns+gN1S0zQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 15:39:24.7284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f12d4e2c-12b2-4cd2-5455-08dee3506a0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6437

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
  - On online(), reapply the value captured at offline().

Cover the Autonomous Selection (auto_sel), Energy Performance Preference
(EPP) and Autonomous Activity Window (auto_act_window) registers.

Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
Link: https://lore.kernel.org/all/86780f97-29ee-4a72-b311-38c89434b707@arm.com/
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 130 +++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 432c6a6288a7..9c88512d635c 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -28,6 +28,123 @@
 
 static struct cpufreq_driver cppc_cpufreq_driver;
 
+/*
+ * OSPM-set CPPC registers tracked for save/restore. A value set via sysfs or
+ * the autonomous boot parameter is reapplied from online() across CPU
+ * hotplug, and the firmware value is restored from offline().
+ */
+enum cppc_saved_reg_id {
+	CPPC_SAVED_AUTO_SEL,
+	CPPC_SAVED_EPP,
+	CPPC_SAVED_AUTO_ACT_WINDOW,
+	CPPC_NR_SAVED_REGS,
+};
+
+struct cppc_saved_reg {
+	int (*get)(int cpu, u64 *val);
+	int (*set)(int cpu, u64 val);
+};
+
+static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
+	[CPPC_SAVED_AUTO_SEL] = {
+		cppc_get_auto_sel_u64, cppc_set_auto_sel_u64,
+	},
+	[CPPC_SAVED_EPP] = {
+		cppc_get_epp_perf, cppc_set_epp,
+	},
+	[CPPC_SAVED_AUTO_ACT_WINDOW] = {
+		cppc_get_auto_act_window, cppc_set_auto_act_window,
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
+ * Save each register's current value so online() can later reapply it, then
+ * restore the firmware value to leave the platform in its pre-driver state.
+ */
+static void
+cppc_cpufreq_save_req_and_restore_firmware_regs(struct cpufreq_policy *policy)
+{
+	struct cppc_saved_state *st = cppc_cpufreq_policy_saved_state(policy);
+	unsigned int cpu = policy->cpu;
+	u64 val;
+	int i;
+
+	for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
+		if (!cppc_saved_regs[i].get(cpu, &val))
+			st[i].requested_val = val;
+		if (st[i].firmware_val != U64_MAX)
+			cppc_saved_regs[i].set(cpu, st[i].firmware_val);
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
+	int i;
+
+	for (i = 0; i < CPPC_NR_SAVED_REGS; i++)
+		if (st[i].requested_val != U64_MAX)
+			cppc_saved_regs[i].set(cpu, st[i].requested_val);
+}
+
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
 static enum {
 	FIE_UNSET = -1,
@@ -707,6 +824,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
+	cppc_cpufreq_save_firmware_regs(policy);
+
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	if (ret) {
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
@@ -725,15 +844,24 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 /*
  * With offline() defined, the cpufreq core keeps the policy alive when
  * a CPU is hotplugged out.
+ *
+ * Save each register's current value so online() can reapply it, then restore
+ * the firmware value, leaving the platform in its pre-driver state while the
+ * policy is down (CPU hotplug or driver unload).
  */
 static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 {
+	cppc_cpufreq_save_req_and_restore_firmware_regs(policy);
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
@@ -744,6 +872,8 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
 	if (ret && ret != -EOPNOTSUPP)
 		pr_warn("Failed to re-enable CPPC for CPU%d (%d)\n", cpu, ret);
 
+	cppc_cpufreq_reapply_requested_regs(policy);
+
 	return 0;
 }
 
-- 
2.34.1

