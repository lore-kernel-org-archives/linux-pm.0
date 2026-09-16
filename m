Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013070.outbound.protection.outlook.com [40.107.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904614FECC1;
	Wed, 16 Sep 2026 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789555165; cv=fail; b=eCj9Y2KhfhrejdraOGRpZEdZECIhqaDyBUXR9YsLiu7yG5qV/E9+EIRqEdtE3CdWoh/PsQB/mQHMrHyE/ZzHCHZE6zoGqrX27OvGlq9nS8anuDPMXfhTBih02qvQ8JnnDbTGQbDGlli+o9h1ELza41eUVmRDXehGK4adv6pF+4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789555165; c=relaxed/simple;
	bh=nYz8R7vXFLhK3Wh1A8vGvJDs2yiL9SC2pfoQoN8+Apk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6tTajqYYHo7kFU3/D5Pm3AuQlwf8cpKT37mi/PTGG7W8TLYeZuCZ+nkciJa/LNHBqiUWhUed07MFwYLRghQPEvctqMbiWdgzi9qtTaGCL8g/RUU/RRs5WBGAoMnd4br0lvTgyEUM90xmd7LyuGnPiso4HHhMHrUYhuybYsFbYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VPWFVy2y; arc=fail smtp.client-ip=40.107.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VPWFVy2y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCYBGccUs9O9KBa0cuvN7fMyZ+vfFX+yAYQH4c7ZTgvJl9fa2ZF+wuPWCHct52ER9d/49GJCyjw9WZKp0iTyOmcPon3UylXJxXny9Mz8XgkU/xS3StWx57f7BqL62AhnEVkQEa1aHBBDFzoxWJvNtBfGSViTOpiA+HtL0gLxiKI5Bw2/pC8ZL5himwWhk4vy9u5XEIQZPWfZI847U3jJMBiQTOmcL2sVaPhoUnA7ZoIHX+me9lKR1bO4mXI7focIeqfStnh69YhhjAgl/mNk3VScnNMqgjbAdZk33YTb1OPVzgdrVOLceY9D4RIDgYWNerj5QWImcXcWl3ip1b80/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VB9X7TuPdcla+XhemCJdJPG4Vxnl1kOuRCW4uXtaiU0=;
 b=oSVDzxCHB5xzzu3HbgvpXYR0PVh6nJFossUgaj4Ie0jptkTb8kTNy9Jj2RwIQpd1Ovc/HiI8sRV96tJ8d1kWH0BI9r+FlxNDOqJuLx8LDvQDixXuMz6+GpbgcXv7AOS/a+Iv6VgHamEs9hZ2IRcP2NKNiImFKuT8TB8Z/qA89vDbEeUNIl/C55v1+bBNOsKQZ2l+Bjy8B5d+Uj97dSRXT278vALvocT8kb1IQfFSvqUjPuEVcngji637mI1RsgkV31g16VJR9Q1jX0G6Rekn+v80DdoFGSy3n7vqMKl2rNI1d1CxlDHYG7KyABQTd3fEDCLtwgdGRMeWEwJ3dzExSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VB9X7TuPdcla+XhemCJdJPG4Vxnl1kOuRCW4uXtaiU0=;
 b=VPWFVy2yeMeqfpyNCM3vGGjaC3dIztUJg/redYyQT2s+fzFQOmEXFLo5j7SXPuoY6S6E5mw2qzzAgZnO0uOQ0jtIa0pbY88uEwL/MwrTnwqxOEOAY7Yvh/gizTk4tt5sfAFuG6bIt33iq24tARMLjwACOO4u41YuQMNQMUgkohTU1P5bqi3oPsEL3UvPCaa+9kAafaC6mIbdDbTMsEgm3sw8APImjuRDSQIh2tDkgoDhJphhUdmTUrQ9p95xmjbYi6GM2tuTiBN7YQv3xPTiuqA0bmMM4+1D5sKdxef2EcX8KOnIIexVnNm6y6gmY1pVwi34QivYwHHlaO29bynJEg==
Received: from SJ2PR07CA0005.namprd07.prod.outlook.com (2603:10b6:a03:505::29)
 by DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 10:39:06 +0000
Received: from BY1PEPF00026966.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::6f) by SJ2PR07CA0005.outlook.office365.com
 (2603:10b6:a03:505::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Wed,
 16 Sep 2026 10:39:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF00026966.mail.protection.outlook.com (10.167.244.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 10:39:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 03:38:41 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 03:38:40 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 16 Sep 2026 03:38:33 -0700
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
Subject: [PATCH v5 1/4] cpufreq: CPPC: Keep the policy across CPU hotplug
Date: Wed, 16 Sep 2026 16:08:17 +0530
Message-ID: <20260916103820.1760297-2-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF00026966:EE_|DS7PR12MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: 6138d4c7-3c30-44c6-fe0b-08df13deb9f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|82310400026|1800799024|921020|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	njf+LMBPPGBRGcHSPvkhXwxeD7Nq9OmmgXT7YwCkDumrE8VkDPaPFRW8PQRfV+QDAV1Aw/5879d2DSVVp48Oyngzi/GnmQtGP5BWZEKbySAG+S08OW49dCtIxQV5djd3Go4vYvJjS6dmht5i7q74mt/jX2LVrBXac31sXf9VrRwgGYbMuC2gcHoGUdcTEyewUcAimBun1VqpQBfdod5dP4AsVRn6xMHg3kssGo8WL88WR90G3v5nqYuaqZZlNQ1AhguqBoTeMO2h3KdGGIpYMFqwr9et4LDS8TmJxJsrGAQQ6yFP+thA8El3cR3fLFYZmcya2McrhH5fGVz+kXOVQ1BN1+xWhqxZ9wPXBc+bERQHgeMIBskfcoSvQnShBt20w2uoPfeuV297HOgJJenKVEZNiwM7fPfngUFCHnvZFzQ9bXUNBCiizRrVIg48lXy0bPBPMtP/eqZNPbfUXGiR6IewaWj2IULYhZLni7VtErcnyBsizcIp0UY5hPzAQF2YSHSkJ1anc71Dyu5u9AU6AUpWIzIrx/JM6ENm8Y0flr2uhr9PLJn0iifhyrvVqLzwMBi+tNLzbf4BQU1vKw4GfuR3bavupxuPhBhfwJc7dGqHPSjXfiF1t1MRLzlsBtwU4Tmz5/E9inKiCh6x30/Qg4LyWG+9vYk6xyRLHFXPv9YrczXkmtFuURauDXWTKNxonAJBeYLblGVb8w2f4QH424Uni9ZOlcPUtYHdspg2edKB2BSadxpBlf1B6tSlbh5z
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(82310400026)(1800799024)(921020)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FlEjx1boELIXzzfctl+tDeIu8ovmwB1+HefQsdIjXrwF1/ch/9IQ8RFaVBl4B8ZhxUSAnLuGSw7Da2YWz4QfT6HOmiFYB81Wis5Ie5mzhdMpE9l0T+6PU0oM7cpP0HjABfe9ICsYmTFVrxUGo/zPuyZ93CL4f/NU5ZulUsxZ3UhQpqwS+cAUUTgJPPVZXzk52zBBY8nIZRNqngOnvKBIJvExNwpT9Coyxe6t1josAPoyGUQaN6qJI0eOSgW07bAgwYQxHELqLXg2iTRZfGAmVi0F3NL3uADkUvliRpraIG2dK8soSJWOWyP2iAK+0ubXNgj6zHbB57th7ZMPiG68caqGRJSDUXnuNhlSRSkh/6LBTlDRrSA1JPdMQW1agkr9aFuR0n7oQFNwuK5swiThkrEFqaIkkePuoNgoWvPWWJ1zUSV8yQgRWORxaGvegXW+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:39:03.3014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6138d4c7-3c30-44c6-fe0b-08df13deb9f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026966.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286

Without online()/offline() callbacks, the cpufreq core calls exit() when
a policy's last online CPU goes down. That drops the driver's per-policy
data, which init() rebuilds when a CPU comes back.

Add lightweight online()/offline() callbacks so the core instead keeps
the policy live and reuses the driver's cpu_data across CPU hotplug.
init() then runs once instead of on every hotplug, making CPU hotplug
faster.

The driver can now save what the OS set in offline() and put it back in
online(). A later patch in this series uses this to preserve the OSPM-set
registers.

Move what init() and exit() did on hotplug into the new callbacks:

  - offline() requests the lowest desired performance and stops the
    frequency invariance updates, as exit() did.
  - online() re-enables CPPC and restores the performance controls, as
    the platform may have reset them. Failures are logged, not returned,
    as the core would free the policy. It also restarts the frequency
    invariance updates with a new counter snapshot, as init() did, so
    that no sample spans the offline window.

The restore in online() uses cppc_set_perf(), which writes MIN before
MAX. Each write takes effect on its own unless the registers are accessed
through PCC. If the saved MIN is above the MAX the platform currently has,
restoring it would leave MIN above MAX until the MAX write lands, so raise
MAX first.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 130 ++++++++++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index f767898ebfb5..37ead7f6c179 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -184,12 +184,10 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 }
 
 /*
- * We free all the resources on policy's removal and not on CPU removal as the
+ * We free the resources for the whole policy and not per CPU as the
  * irq-work are per-cpu and the hotplug core takes care of flushing the pending
  * irq-works (hint: smpcfd_dying_cpu()) on CPU hotplug. Even if the kthread-work
  * fires on another CPU after the concerned CPU is removed, it won't harm.
- *
- * We just need to make sure to remove them all on policy->exit().
  */
 static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
 {
@@ -199,7 +197,7 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
 	if (fie_disabled)
 		return;
 
-	/* policy->cpus will be empty here, use related_cpus instead */
+	/* policy->cpus excludes the offline CPUs, use related_cpus */
 	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, policy->related_cpus);
 
 	for_each_cpu(cpu, policy->related_cpus) {
@@ -754,6 +752,128 @@ static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	cppc_cpufreq_put_cpu_data(policy);
 }
 
+/*
+ * Prepare the restore in online() so that the platform never sees MIN above
+ * MAX.
+ *
+ * cppc_set_perf() writes MIN before MAX, and each write takes effect on its
+ * own unless the registers are accessed through PCC, which delivers them in
+ * one transaction. If the MIN being restored is above the MAX currently
+ * programmed, the CPU sits with MIN above MAX until the MAX write lands, so
+ * raise MAX first. Restoring a lower MAX needs no preparation. Both values
+ * come from the policy limits, which keep MIN below MAX, so the MIN written
+ * first is never above the MAX that follows it.
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
+ * Run when the policy's first CPU comes back online, the counterpart of
+ * offline().
+ *
+ * The platform may have disabled CPPC and reset the performance controls
+ * (desired, min and max performance) while the CPU was offline, so re-enable
+ * CPPC and reprogram them.
+ *
+ * Report failures without returning them, or the core would free the policy and
+ * leave the CPU without cpufreq. A failed write to the performance controls is
+ * not fatal, as the governor's next request programs them again. A failed CPPC
+ * enable stops the restore, as the writes that follow may not reach the
+ * platform.
+ */
+static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int cpu = policy->cpu;
+	int ret;
+
+	ret = cppc_set_enable(cpu, true);
+	if (ret && ret != -EOPNOTSUPP) {
+		pr_warn("Failed to re-enable CPPC for CPU%u (%d)\n", cpu, ret);
+		goto out_fie;
+	}
+
+	/*
+	 * Recompute min/max from the policy, clamp desired_perf into range, and
+	 * reprogram the performance controls.
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
+		pr_debug("Failed to prepare perf restore on CPU%u (%d)\n",
+			 cpu, ret);
+
+	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	if (ret)
+		pr_debug("Failed to restore perf controls on CPU%u (%d)\n",
+			 cpu, ret);
+
+out_fie:
+	/* Restart what offline() stopped, with a new counter snapshot. */
+	cppc_cpufreq_cpu_fie_init(policy);
+
+	return 0;
+}
+
+/*
+ * Run when the policy's last online CPU goes down, undoing what online() did.
+ * Defining offline() is what makes the core keep the policy alive instead of
+ * tearing it down.
+ */
+static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_ctrls perf_ctrls = cpu_data->perf_ctrls;
+	unsigned int cpu = policy->cpu;
+	int ret;
+
+	/*
+	 * Stop the frequency invariance updates and cancel the pending work, so
+	 * that no sample spans the offline window. online() restarts them with
+	 * a new counter snapshot.
+	 */
+	cppc_cpufreq_cpu_fie_exit(policy);
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
 static inline u64 get_delta(u64 t1, u64 t0)
 {
 	if (t1 > t0 || t0 > ~(u32)0)
@@ -1047,6 +1167,8 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
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

