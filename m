Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792498781;
	b=J8WeezvNovhrgoKVXnP26XBgN4/fjEn7z2AsIrfHAGCcP+EHUQm2/KvMG14nVlAo5iZO
	 neYEzZIGFIaY3PyZ8uL56zz3eabZzGpc6amS/H1OuHI0wscz2CMC9ZapE/ZbDcpg+qe/j
	 mkdHeynrzzJvuunSBC13+JOTm4qlpAwHXR0r7z00R5nflyTIjpop7BO31LIwL+dyPDUAl
	 y4cBzKVj8zJReyuaJgxWPwhbas9DbpN5qwNrr9RtQOX/Z1mCg+yK9R40hv0+7h+8uy2aA
	 MiovEclGHgqkZvT/Qb5x8Ra1f85JcIcJUIeOyYBBBinjcU75GuINxfMYaKxEM8zuR1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498781;
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
	bh=V3gAIcBmgCW3ppqM/mpoBlNKZxHzishuF4jVkSjuTlQ=;
	b=n02CG8MwB5cd53txk2JvlXFM9vU6UAPHlBeN1CGvep/ez/BpF3Q5CMn79iRpiEhz4eCf
	 ZBRQJI2uRYmr8RO2/xtyAAECcLFRLs/bIBxKFnI5RHMKlC6kSUMrfGmUaBm998aVZmx1E
	 6LrOnETbToOEQJj6C6+m21hB/kn5sPrQwMgk4WMx+fnd3SwDVXgZ4J0d42yuSxs53kR6X
	 NE5FKMSygbZbgZAQqiT1EWho1Hx4+anDVq0+yyQOvUesj8UwpeEXkkjZbz3QYt45jojQq
	 V5y0GT0SsRPeRSbbNuNT1ds9fkAxJ+nzEpF4KsLIYw3vpP9/skQpzq9ISZJjdvjlU+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lQzq+gxc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.71
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012071.outbound.protection.outlook.com [40.93.195.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49710606A31A;
	Tue, 20 Oct 2026 12:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49710606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lQzq+gxc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7fU+FcAh4BOOw/oySeHrI5qr4KyICY74AA1zHUF+Ar1pyOiqZjSl7jOGCx/axn6RWiYWrec3Zcc3+wR8YrldVmd8FoEd0L0ZkZDM0YXe9fnyMbD6zVyUm8cJ7DIo5S8eEETXKRJJBka+10Bmv3Dh/0A5KOK18LBI1iToDPvfDgszYKi2gLxtoDyKiSUDFHeIt1RWtwc59hEf4YO8DjYzjOe13g+rXne8bT8qTY7ji7193RhOZL6YxWyHzgkO4awDZIIiufmIOldPF5B+ojXElFEdF7+rq4TH0Z43P5ivk3jt083R8CEKwChMei4CSWuIuo0aUBbM+/TIIscdLKWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3gAIcBmgCW3ppqM/mpoBlNKZxHzishuF4jVkSjuTlQ=;
 b=oWgWygFoiXwzDqsaFM68JWYbbm5J8ZTbxi/w0J8TGKvy7u7tze193c25LRf3L+QPOxodTugCwRKXqpqJbyz+nGQCIeoVggF+UZjGWx4MTPrWwGGG67s6BUhNbG+OuUrYluKkasBF4So323UbnbLZKGQohIGlKZ4vEv5PuM/pvQcl6a8TtoL/0JNK5p7t9o/Y9A78FBiV8E+9KQeHGcH4TcMu64HzF2vphQYcT21D1f61Bz5BPRk6MyyFMfVMa4q7ZDLSrV74vLOfEm07lfA64rbxm0w+T0oRMv3W5NXK5jCYw8v/ImYkJUCy6Sb+Wp3DkoQQgRmUG+nS9oacW6zPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3gAIcBmgCW3ppqM/mpoBlNKZxHzishuF4jVkSjuTlQ=;
 b=lQzq+gxcqvk9i1d7Ye3EJqCa4qt0+DCkWd897fIJRV8xw5FDglM0auoEuqLbJFJ0aJzhzmfbcnH3v15rH2P7uLOILl+/tYwm1CRHqPmqIPL9aN0TErvWanRH+2vvAqhD83Jbqcxx9MfV0YxsXzkijv1OAzK2lFD8axw4figpmK1h2V859zuSG+6XHiIDQdK597tXNeVAgjC+2+9BSXbeMBtzpMsStQ4diZGXMwTlrC4V2NDHoxQD18vRj2ShNveH6iZRflPSU3OctnG2UTotn136DN6IAgPBXNsFE9uwNMRiYlkhBQHlAp+z7TqcgHihqq1YbZfvN/Ze5Zkvc5Dkhg==
Received: from BLAPR03CA0089.namprd03.prod.outlook.com (2603:10b6:208:329::34)
 by IA4PR12MB360382.namprd12.prod.outlook.com (2603:10b6:207:14c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 12:19:36 +0000
Received: from MN7PEPF0000014E.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::83) by BLAPR03CA0089.outlook.office365.com
 (2603:10b6:208:329::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 20
 Oct 2026 12:19:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN7PEPF0000014E.mail.protection.outlook.com (10.167.254.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 12:19:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 05:19:16 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 20 Oct
 2026 05:19:16 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 20 Oct 2026 05:19:09 -0700
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
Subject: [PATCH v6 2/5] cpufreq: CPPC: Keep the policy across CPU hotplug
Date: Tue, 20 Oct 2026 17:48:43 +0530
Message-ID: <20261020121846.691218-3-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014E:EE_|IA4PR12MB360382:EE_
X-MS-Office365-Filtering-Correlation-Id: f62951be-25ed-48c4-3d86-08df2ea46830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|36860700016|82310400026|921020|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yQ0bzLKHUOXpPWTbJqSZg0BGgz2qTP8AWyILHYNkEdp8PpzCVEN0PVLS61ycTtPuea4Pygexn+NkjPKtQmtY+I1UuAKV5tcvIHH5KcR3HHSuYC4/zQOpfoYb2Jt0TspPxUM2jfJSWu/lIkRfsY8lnHB4agBFMCUBhhl30NEB18Psq1PxJTU4o/88WN/4REHBCU0znqT3HyUNlZNSf26tGis2knT+YDUHxg9ZJr/W+wcRWrl1xoudL+2EMMEVI2xsIFT7xTidK221X+pBukZWtRowVkOR2jSMLQtIjxvX8K9bUECyY9VgEs3IxTN1UsN1D2a6myUPVEmjY1oxkzfDsFhRCCaasp3qutuQ0DgjCtTruAWxhlHT7739KvaA3g5GI4XbPUNx4Q4+7u+Ps0aGuWcecvYa2KSmW9hAAg0C1BX1HQEy6ccDGtbPt9QtK2fA7BYpEVEp/j5gXnf3MW3McVdy5KWeHoTLiBdRvIoOO2nPpoNeaHkZRnwo8ccMQtK5YHr17xW7ENQorLjJB9BdjLYOI2xPvETpZVQyJhCm7uT0sGyhpZ/YUAavNFsGnUXjZO6ZXT4E0HE+sRXun4D0+gIcN38hxnEFGdgWqRgdNQqhqUSNOMCif+xjo+/jpMU9mzmZHhck5IL1S0eKSH1JwIi1Z+GoHbt11IG9XGXwhx5QzO5yDmuHAD4jfBzedko7NEsF/HFXfmlN13rSngx4EIDJzw5d8tib3msiv55o1c/IHUSPvFcA2Ft+BD8udkgX
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(36860700016)(82310400026)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DZ18F5L3SneTaOAxZTVbuCSTagiI8DMpk5Nm2x+2YTAlwcXQ/1GqMbggO+I6aGRQIDigYD2dlzfWKho3W3w0UbSU+cTi7dxw5Azp+fB9X1ZayXiEu9I+HvRUx1kZYzXxOLls6Qtc9CXNYFE9a6vR1I7nwOwBfRWxI33oBmhZQ7n5cFgebrJwFQAq7kbNZKk0Jc6fWkmu5A6oa9WE2KMD9nyoi4I+HP/j6Q+UudZDeel93CXIJUQGKqS75ONnt1KO15tnpv83Nhe2R7oOVd78tp7x3Fr2mkkRFoAKhvVACz1fHrDx8ILS9+as4MWtNJBVUj60eOr/D5q2wA1YdRE2V1tJ9iH2gURQVVglqzZs8yHI+Kb3SE1WZHiZnNFSLLKQPKPTCHzZvPfcNypkCTAut6/2VK3SSQ3nodYCpH9s0nfYYTSxWeZkNHiPdiDOL2wW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 12:19:36.5438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f62951be-25ed-48c4-3d86-08df2ea46830
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN7PEPF0000014E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB360382

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

  - offline() requests the lowest performance and stops the frequency
    invariance updates, as exit() did. It lowers MIN with the request, so
    that the parked controls stay valid.
  - online() re-enables CPPC and restores the performance controls, as
    the platform may have reset them. Failures are logged, not returned,
    as the core would free the policy. It also restarts the frequency
    invariance updates with a new counter snapshot, as init() did, so
    that no sample spans the offline window.

The restore reprograms both limits, so it also refreshes the limits
cached for the fast path.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 106 ++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 709363e6d98d..7448ca43b363 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -209,7 +209,7 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
 	if (fie_disabled)
 		return;
 
-	/* policy->cpus will be empty here, use related_cpus instead */
+	/* policy->cpus excludes the offline CPUs, use related_cpus */
 	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, policy->related_cpus);
 
 	for_each_cpu(cpu, policy->related_cpus) {
@@ -837,6 +837,108 @@ static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	cppc_cpufreq_put_cpu_data(policy);
 }
 
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
+	u32 desired_perf, min_perf, max_perf;
+	struct cppc_perf_ctrls perf_ctrls = {};
+	unsigned int cpu = policy->cpu;
+	int ret;
+
+	/*
+	 * The platform may have reset the controls, so drop the limits cached
+	 * for the fast path until the restore below reprograms them.
+	 */
+	WRITE_ONCE(cpu_data->perf_limits_valid, false);
+
+	ret = cppc_set_enable(cpu, true);
+	if (ret && ret != -EOPNOTSUPP) {
+		pr_warn("Failed to re-enable CPPC for CPU%u (%d)\n", cpu, ret);
+		goto out_fie;
+	}
+
+	/*
+	 * Recompute min/max from the policy, clamp the last request into range,
+	 * and reprogram the performance controls. Publish the values only once
+	 * the platform has taken them.
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
+	 * Request the lowest performance while the policy has no online CPU,
+	 * lowering MIN with it so that the request stays a valid tuple. MAX
+	 * keeps the value the policy last programmed.
+	 */
+	perf_ctrls.desired_perf = cpu_data->perf_caps.lowest_perf;
+	perf_ctrls.min_perf = cpu_data->perf_caps.lowest_perf;
+	perf_ctrls.min_perf_valid = true;
+
+	ret = cppc_set_perf(cpu, &perf_ctrls);
+	if (ret)
+		pr_debug("Err setting perf value:%u on CPU:%u. ret:%d\n",
+			 cpu_data->perf_caps.lowest_perf, cpu, ret);
+
+	return 0;
+}
+
 static int cppc_cpufreq_cpu_resume(struct cpufreq_policy *policy)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
@@ -1149,6 +1251,8 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
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

