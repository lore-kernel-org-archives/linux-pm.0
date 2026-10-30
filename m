Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793352300;
	b=ZemhMQIgIUhmrT9RSWoA/0F5mpnwXKq9FpkYSAT8Lkqj6RaNQcYYXDWfaONriawzwn7u
	 r/b0NSIBg5FlLGGzovSyQdvQM2ip+wxJI60qTsjr5RZswDH5HOHiNoAhBw70MODKOcyoY
	 bCrn1TmEjZYOOQ5xUYVYAelRPFRqSs7Cx5QQiK02hmM+ZwH3i1a/zk8lEe04HevYsI6T6
	 y2ED1T1sav2v6BolQRd3llydzpu62Lly9eJFbu4GgK6r1E2dhGXCxzi2f980VH3HzrL3a
	 wTGjxUvqEyHfAKVq5pAws0qfYZd9f+K9oygwWh3fob9xWwSpW1iM9Zhp/XntnxR2dIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352300;
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
	bh=wRaW6Ome2/W5wrG4u4bAxV6GGaWcCUeDYCbCkzUSJeg=;
	b=G614MyoN4LqArVtyAE4v7/+OEn/fK7fNzYtVNw8ei2Ef+0NCzMOYz84tgEvEviTfCYL2
	 o8Qr8HbtCfJSRJK9jhjuaUXjUQ/522ZyG2JYRl+C10th4siuDD+XX89uzpwbiPqauOHbV
	 uy78y/VLiRlpP/Tfktv34ibr2ED/Ug1i3PS61MTQr6pWPK1SXD/qXy2LNhTKXQ9ZiPqPQ
	 Zb6Y9rDrRtoALUKcNytnQgXVVp7aV9/J/JSP+BMMsNd6DBxkYM7fI+U9Clvy/iTIfGlY/
	 vAiZVh4X1ZOJovxANM3EmDv/mcxyueqh8XISnFK2eyj/mV5AeXmIko+MEerfdEgvjwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XndBu+LB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.65
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ACC606A31C;
	Fri, 30 Oct 2026 09:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9ACC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XndBu+LB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kiu9HYFdqHosgOykOgJEtUY7wB4uSUd4DDmgrWLcrp/KE4EJmlqCpF3dOk4zlBQb80DwShsO7zAxRn/zRJstkH9wjEpAoOl+MWOyO86U2AXOIGrHckBXZ0N1mP+dDRo+gJgS63T4Ms3iFO8vgycpCcDbaDr3RYZEPQUCn/KBWPK4XNSvUZkU/SkCP5JhlL9lAHwT885qArkFEm9xlPVcvzg8Etx9NyF7mBIuMtr4YDu8NCfiqiurBnn+XK9NHOuQcwt+k8MxTvyS9D7LxrNOBHd/McBSY4j1RAGxih520C+KGwcl/dHDY49Qj9cmD0eaashoCZFiQ510MjpvrwE44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRaW6Ome2/W5wrG4u4bAxV6GGaWcCUeDYCbCkzUSJeg=;
 b=oLqypwIhUcjA5x/b4Z2ekONeyefBsnH6QzdEwWFzl9r/f4fPgJOfsdsAZSQ0MpOL0eRzonAkRl9zmvRfzaBhfZJidbU5GUIeSUDjWnVyOGZWS3oAE6iRIg0RKHYCjfLnV9/3lqYevXF3s4Op0CBdzgBlqRJ7Av++Bg9u/Cc6szi30VAHY90XnCtN+4xhYpzhDquZvAlbTmkySfEVxC/QiYjXBLjY5Teep6/vBvCUTEt8nlZZPm2/J4fpEzqIucuaAw78c9M45rLsljl5NHq1ObEV/wI/MprQJ41yy+/jxE+UFgWGLIg04APvFFTcCgbHdcJmVq4b2E7h/X635HiGdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRaW6Ome2/W5wrG4u4bAxV6GGaWcCUeDYCbCkzUSJeg=;
 b=XndBu+LBqBSdqYZNi+9/W1GvUIbHTJsVqVIoUU3fm3m4PCppcLeOCJ2UAD0l46BFXasNrHwuEWT/kYZGPlvaFsywhRKpf9G/PSu1QwVGgSTGl946aEEc4Yb5I5luWLsETmH+NghllpjD8jI9t9BMhqwk57jdV9u0NNVn1oiTo0AELu3GfINysVx4FKNFRWoL7yhsaxnKeNmnJRW6QOjQxrCmC19bpZNhYbkfnuPjY35az05u7Tk7RyPk7AXWx62iGOT3faoaqWXQyaVdu0OmU7NjrbFYJjEogZScSZgfPmJwDlbKNes7KYIPhe/bFah912eJ6uKIAk8fO4U3qsCkzg==
Received: from SN7PR04CA0083.namprd04.prod.outlook.com (2603:10b6:806:121::28)
 by MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 09:24:53 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::49) by SN7PR04CA0083.outlook.office365.com
 (2603:10b6:806:121::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 09:24:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 09:24:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 02:24:33 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 02:24:33 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 30 Oct 2026 02:24:27 -0700
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
Subject: [PATCH v7 2/5] cpufreq: CPPC: Keep the policy across CPU hotplug
Date: Fri, 30 Oct 2026 14:54:13 +0530
Message-ID: <20261030092416.1993889-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030092416.1993889-1-sumitg@nvidia.com>
References: <20261030092416.1993889-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|MW4PR12MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f9de25-1952-4bc6-9ef2-08df3667a73f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|23010399003|82310400026|1800799024|18002099003|22082099003|921020|11063799006|56012099006|261009223027099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	9Ry+kOSNYKLWSYYXFsilAZd9rZH9iuoqiuC2m9kgA6HwL9q7bahHXClSaA6Rr8YcVNw+arFwVFfiJQi4EZEj33cBe3Lw2PxaehydVVGsUFK6PIZaC3BvAthzXKawtK4gVP+43orpySxb8PetelLzA04zA2Gyklm09ibtzO4jUUiF/+oXMiDnAmytdDc0u3LQeeeNkedOIb8B4tSNnSIMC4p07YcLfGSmJyyudhhv/E2PPBu0hLx97UOjoA8CGChVWjVLGLwN6mmiFzmPNIljxcBccQhJpPC0+OrntYnR7w+Ti3pqMTQGn3s6z10eMkw3kHgPoJWXbXnCH5SebAMCPxGF/yTfmmecBa+GGidtsaXa24kmYPCD6pco8/ZJdld5jlqGw0yQzkPJ+uCRyWZZa8sEvVIp5BHz8HI5QWcR9lp/MP/D+DxcfSiwtwU4lNYrd6FSLO5OE8e+UhzqWuWVou04lLlPT4PHDeUUTD60LlHTKGrVdw0xk925O+5I7sK6XukrarSxyuhR7aRnFbQTAu3FXACZqDE+q5XiaCvJWNwye7l5fb8EbW7LbdJoFikN6Wxld+s98E33Yz8y0LusUo43TE4maBqppXhJkaezveDTDO5tIrKsVgrWwZhU4+MjQ+USkyWqPvE7eRuoKf+qbcK4ysJsrB3vmirvkzIqQzckkbJnmACFK6mHShJFGwf09GQ2BGYc6qc2phqHWqMuuq4doueL7WTSbtTQwmNBZg9jJJhTxWh/q9D32JO0jHfn
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(18002099003)(22082099003)(921020)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VlO3rsdrkaSpHl8vcISbPgo1/F2LFSFjnHwr028b3pGWuugKPpQzhBx+eL3gud2ftYfShidTnje0OhRmJFHbRbXNymdOXkIXWbEIdNyN3dc6N1eYj8bynEKFXacUt1BUTu7cAX8KMEcTLf1ZoSMjTB7A/6yK3BBkRWRt1aJWFNN0bmJS7/+TomM5VPYugz1SB2LA0lS85ohaL4rurpIel1vXfFam8b7blUwYFNW5G+lOVmRi1LZT9DCyh3wnWGrR+pJ/LL9fBUCdUd1NSrPRG1CvTHg9tPvN73C2f15fPqchyLQYgA28+CwWAYyzFJvBsTFifmuG6x22JsT7HpwR1CKMI1SDqgCJY1rogzuROX3ArjPeTAxTdZdzu1ko6xB+VumsKb0r1c/MTbmL137NWrmntyaXUdPgSPq+Y3692xa7pvkOvBYhS1yO4/OFng/g
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:24:52.4060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f9de25-1952-4bc6-9ef2-08df3667a73f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729

Without online()/offline() callbacks, the cpufreq core calls exit() when
a policy's last online CPU goes down. That drops the driver's per-policy
data, which init() rebuilds when a CPU comes back.

Add lightweight online()/offline() callbacks so the core instead keeps
the policy active and reuses the driver's cpu_data across CPU hotplug.
init() then runs once instead of on every hotplug, making CPU hotplug
faster.

This also lets offline() and online() restore and reapply register
values across CPU hotplug. A later patch in this series uses this to
preserve the OSPM-set registers.

Move what init() and exit() did on hotplug into the new callbacks:

  - offline() requests the lowest performance and stops the frequency
    invariance updates, as exit() did. It also sets MIN to the lowest
    performance, so that Desired is not below MIN while the CPU is
    offline.
  - online() re-enables CPPC and restores the performance controls, as
    the platform may have reset them. Failures are logged, not returned,
    as the core would free the policy. It also restarts the frequency
    invariance updates with a new counter snapshot, as init() did, so
    that no sample spans the offline window.
  - exit() now only frees the driver data, as the core calls offline()
    before it.

The driver keeps a copy of the MIN and MAX it last wrote, so that
fast_switch() can skip writing them again. online() marks that copy out
of date before the restore, as the platform may have reset the limits,
and updates it once the restore succeeds.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 106 ++++++++++++++++++++++++++++++---
 1 file changed, 97 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index ded4f935638e..2cf250b38633 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -209,7 +209,7 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
 	if (fie_disabled)
 		return;
 
-	/* policy->cpus will be empty here, use related_cpus instead */
+	/* policy->cpus has only the online CPUs, so use related_cpus */
 	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, policy->related_cpus);
 
 	for_each_cpu(cpu, policy->related_cpus) {
@@ -807,24 +807,110 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 }
 
 static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	/*
+	 * The core always calls offline() first, so only the driver data is
+	 * left to free.
+	 */
+	cppc_cpufreq_put_cpu_data(policy);
+}
+
+/*
+ * Run when the policy's first CPU comes back online, the counterpart of
+ * offline().
+ *
+ * The platform may have disabled CPPC and reset the performance controls
+ * (desired, min and max performance) while the CPU was offline. Re-enable
+ * CPPC and reprogram the controls.
+ *
+ * Log failures but do not return them, as the core would free the policy.
+ * Continue after a failure to enable CPPC, as the writes that follow fail
+ * on their own if the platform does not take them. A failed controls write
+ * is not fatal, as the next frequency change writes the controls again.
+ */
+static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
-	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	u32 desired_perf, min_perf, max_perf;
+	struct cppc_perf_ctrls perf_ctrls = {};
+	unsigned int cpu = policy->cpu;
+	int ret;
+
+	/*
+	 * The platform may have reset MIN and MAX, so mark the copy that
+	 * fast_switch() uses as out of date until the restore below succeeds.
+	 */
+	WRITE_ONCE(cpu_data->perf_limits_valid, false);
+
+	ret = cppc_set_enable(cpu, true);
+	if (ret && ret != -EOPNOTSUPP)
+		pr_warn("Failed to re-enable CPPC for CPU%u (%d)\n", cpu, ret);
+
+	/*
+	 * Recompute min/max from the policy, clamp the last request into range,
+	 * and reprogram the performance controls. Update the driver's copy only
+	 * if the write succeeds. Otherwise the next frequency change writes the
+	 * limits again.
+	 */
+	cppc_cpufreq_get_perf_limits(cpu_data, policy, &min_perf, &max_perf);
+	desired_perf = clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
+			       min_perf, max_perf);
+
+	perf_ctrls.desired_perf = desired_perf;
+	perf_ctrls.min_perf = min_perf;
+	perf_ctrls.max_perf = max_perf;
+	perf_ctrls.min_perf_valid = true;
+
+	ret = cppc_set_perf(cpu, &perf_ctrls);
+	if (ret) {
+		pr_debug("Failed to restore perf controls on CPU%u (%d)\n",
+			 cpu, ret);
+	} else {
+		WRITE_ONCE(cpu_data->perf_ctrls.desired_perf, desired_perf);
+		WRITE_ONCE(cpu_data->perf_ctrls.min_perf, min_perf);
+		WRITE_ONCE(cpu_data->perf_ctrls.max_perf, max_perf);
+		WRITE_ONCE(cpu_data->perf_limits_valid, true);
+	}
+
+	/* Restart what offline() stopped, with a new counter snapshot. */
+	cppc_cpufreq_cpu_fie_init(policy);
+
+	return 0;
+}
+
+/*
+ * Run when the policy's last online CPU goes down, the counterpart of online().
+ * Having offline() makes the core keep the policy rather than call exit().
+ */
+static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_ctrls perf_ctrls = cpu_data->perf_ctrls;
 	unsigned int cpu = policy->cpu;
 	int ret;
 
+	/*
+	 * Stop the frequency invariance updates and cancel the pending work, so
+	 * that no sample spans the offline window. online() restarts them with
+	 * a new counter snapshot.
+	 */
 	cppc_cpufreq_cpu_fie_exit(policy);
 
-	cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
-	cpu_data->perf_ctrls.min_perf = caps->lowest_perf;
-	cpu_data->perf_ctrls.min_perf_valid = true;
+	/*
+	 * Request the lowest performance while the policy has no online CPU,
+	 * lowering MIN with it so that the request stays a valid tuple. MAX
+	 * keeps the value the policy last programmed.
+	 */
+	perf_ctrls.desired_perf = cpu_data->perf_caps.lowest_perf;
+	perf_ctrls.min_perf = cpu_data->perf_caps.lowest_perf;
+	perf_ctrls.min_perf_valid = true;
 
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	ret = cppc_set_perf(cpu, &perf_ctrls);
 	if (ret)
-		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
-			 caps->lowest_perf, cpu, ret);
+		pr_debug("Err setting perf value:%u on CPU:%u. ret:%d\n",
+			 cpu_data->perf_caps.lowest_perf, cpu, ret);
 
-	cppc_cpufreq_put_cpu_data(policy);
+	return 0;
 }
 
 static int cppc_cpufreq_cpu_resume(struct cpufreq_policy *policy)
@@ -1141,6 +1227,8 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.fast_switch = cppc_cpufreq_fast_switch,
 	.init = cppc_cpufreq_cpu_init,
 	.exit = cppc_cpufreq_cpu_exit,
+	.online = cppc_cpufreq_cpu_online,
+	.offline = cppc_cpufreq_cpu_offline,
 	.resume = cppc_cpufreq_cpu_resume,
 	.set_boost = cppc_cpufreq_set_boost,
 	.attr = cppc_cpufreq_attr,
-- 
2.34.1

