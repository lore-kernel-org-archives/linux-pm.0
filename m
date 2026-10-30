Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793352356;
	b=dVdzpHDPdmR/OhAF7mMF3LQ0PXG11inFY3JT6a0dza3QibpxbiAk4ueFzULTaFRa/h2T
	 9vWdnDXFHpWpH2tgUwgl2i2G6wGBuC6FZijQaxFj7ETONIHzx1D8tPTMPje/589jJC72E
	 cJyUMxcShsRb/ZA/LX9XMs8bg1Y6RfGx/qtmzWhdOVWXRNogS3hRxxO98ZlEjhI2VldoN
	 ACEzzqVQ1vKlVXtNcyQaVn4yZrXGUXaWOGRKytErAYUcLgAjX+heNMbl0yCjlY8JkoGKy
	 tj2B4cFOagWudsosNiyvWsrY+18ZsKbeBF/x84fRNYzqxuQdMCtILy+oiD5bXihzANg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352356;
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
	bh=rjCFj+/O/m75kqeWAXjICzJ//vFsNIZm6EZ3Im+JRF0=;
	b=C8n9rkno6NGFQFb1MSPBHt3Qv3BNBzqAxAbywCvjtXkw8RCaqGBWe75rqhXGwQaA8lR6
	 SImAqsbrW3lGWGDVaNxHxHlOJnd13k6VbTzBPWEX+X41GpwamW+nhGE4b+SmxjqXI0kC6
	 /Gj1zdq5xYWlZaSYkxUgFjPP6glZb0Y0rBZWW9Li7yxFWmz80uTYqsAoixWUboMu+Rlio
	 X7MU2VC0vUZy8hVkG9NFW1pRtPUkJ1RyYXFyzdqF51hPQnI8py2EkDiVTgP+EfPF0XTzE
	 o3VkNnGOrZ3Qar1rxGRlDfvrhTnZT1bjdhwj4qnLxpiDCFrNyxxC7s0FpZWQYlzctXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AJpZM3l0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.6
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010006.outbound.protection.outlook.com [40.93.198.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E26D606A31A;
	Fri, 30 Oct 2026 09:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E26D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AJpZM3l0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aazSVgI7K/Unfos8LFmmNrlliNht2BYaJMfsGnTfmqnFCd1gza5udPOV7gu8JWl7rznbq7wEgI3ARqbD3/tPISKCK/izSN5NsSPMOv1EjTRRe9fbbt2NPjmPsBFhchFkEg/tVioseP0ApgDdefd3gs3qkmn9xn4NrZDVSbzYMs9mq1DIVnr1Ta1XmtCNGZDgd+H8x2bWnGaEZXuEROcKRkm0xXyNyyCHB0XbyHPf4hcERycR8VN9zXdsnzFj3qDWstjwkzEpFMsiFDEGBHILq7CJqR4O5cKw0y/NxeNI73qVxYAOJerz4vz/JUOZYRxlXocGO/ssTyK2PlMOnIVHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjCFj+/O/m75kqeWAXjICzJ//vFsNIZm6EZ3Im+JRF0=;
 b=VXoFeo1R91zf5bo6e5eZ/wIdtzMvSz3e0rwxjUr7IWtQFBPA5g2uvY38nFzif7zOrAFVUmRKVhMj/T3QhUxy5xywu8kZCfMJrMqf3sGaP0QDiH+vBHo1CjCflTIMB2UKKUMZA40gWssygksHv+finLQy4yHho1YI0J09ej6V8hrDsxe8HKcrK/B7YdmiGY5LPVhvN3taON2Ja40TxxEIWoCxICjWp82A0rT+1M44TSDxSXwrwu91u1ZaHXhVOpBUX8wNcJTBYawLkaOgVDpimvRVHbRZAs/gyRZ1tgRSNL0rFY9i2A2VW0k+aaWsrQZf15+yiNmD7k9B77ZLO/i/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjCFj+/O/m75kqeWAXjICzJ//vFsNIZm6EZ3Im+JRF0=;
 b=AJpZM3l0URwTpgNKnTAkfuF+joNSGehHkffytD/unDDkhbeQp37xqLi6eT8bHeZVpiHZH5Y5vSbmOkGgAXr6pvJIGnm+lyF/OxH00Mm8/zFzIpfkKFJUeu1DM1IWTFEKpsncGgpzNoB+1yutYijui2hESMpSn2EtRH6a834Kem6A4DZr039zhJP2peXaMBlodUF/DMEhVJPAI1DWTl37BLbVoYk1aerQZ20orFBaTXVbQ6k5rWg3anx9bpISPokpZ3rDwczTe5wwnAwBHNPBxWaDEzR39HpaVbmRIuC0sdgKn8sZkOUbvgBwgTzSs1Q6exoPQ5dyKWi31QgUI4VvnA==
Received: from PH0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::35)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:25:50 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::6e) by PH0P220CA0012.outlook.office365.com
 (2603:10b6:510:d3::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 09:25:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 09:25:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 02:25:32 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 02:25:32 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 30 Oct 2026 02:25:25 -0700
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
Subject: [PATCH v7 5/5] cpufreq: CPPC: Preserve OSPM-set registers across suspend/resume
Date: Fri, 30 Oct 2026 14:54:16 +0530
Message-ID: <20261030092416.1993889-5-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa3d07e-ec64-4125-54c5-08df3667c965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|23010399003|6133799003|18002099003|22082099003|921020|56012099006|11063799006|10067099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	fawna9K2obNhgbGmm/ingsn1nJG/kDopij60kmVcQNTC7S561ZQTKBfe3MmdTL+XmN9Y0rUyDV4Tv17fjYFdmKkqJMEaXqN3d9H2VZQw/LKNXU8bUmaqNHDUMangNKHBzsWfotGS1fe9Mf6ewohPrJ3I+2pqfcbM8Z4iGCZblTGn4EMlb+C/lseNyXiw+FWK7n4KkYcGX2fHjmHoPls2Qvflq20oASFm9SmMBzNCs/Gp9hAf16wgieeP26PNWdOMfMHlqKMj1Z5zUURly7148cKzD0/g3P/vpW80+KZnYnMNTctzAST3qCytyghx3Xa/pbCnfxhET5ZWNcpTNg5jXPjWAeDa56jfWEr4jzIiJFkNeD+aJtl+0HyNtEDo2A1NsUYJYxiMnSFq7tzj6PK8pjItBXU0a7J0C6Fwlp8qgQiG8nsKQqrrn+lb9wKu6fKFSearutMWuL+FjX+J/Ch/2KzFOvu6NACBPJe7DrB292I8X1Z0mEDegMD1WK9chn0n0nB972d+0q4nHgpflsqbsCEQBbroVuTADXsRqaTP9OVeazBnAsnQtaMDRVIkkSc6JinA5YORkanPUR5+s58mT5m8ggUtIQSiROGqC77L+zVSG/bO9xLQx1GQ8GiZ+77dY+SGY2SG1o4HI8UxA1HebAbJztfroVn1v2idr9GzUhfah4kz+aIeeWpHEuGuvAJp2Dh1q34Pahk9Y7ptGNt0eWbNN9RwrC3AuXcIrqqOX6Br6vS0yKEsL5OoGkdTXLUo
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(10067099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Pon7wlQE5WOE39HgMTBNSKzFa2aGtWbhF+wItvSJeJL6gD4D10aTs5a70lIiwJCXxeH4RprUFsKA96b732pJDAZUVX+Nk9b2U220nR9ket/fNLgzWNt1FwToIEg7gVy/4mATdv6B3+xAIgvsqEWn7tTkEft23S666o1AiPDa1Di6YxtLRBx59AgPfVGtluj6ZDVvcxHZkKrzjVfYbA3DB1eHv1+7McUWmJbMN84YfCY8sqaTZIFLgrQrgsIvExG81KTdRDhOWJ7SYQUMhmKOcrpojB0tAc2n2BAwtuA53SfL4cUHgR32ZXYxQPgwtNsxdBMk9Q+mOCejj8PFXtO2d9MUs3PkFZ3Jh/ilGz5SfUYm3wLQcTffuX9ZejRf1w6D+4mOo1/OkXmMkDervaJQ0OLGAf503S9IDIWYzuo4VdJwUepPfu74xUmx47HtISHs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:25:49.7030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa3d07e-ec64-4125-54c5-08df3667c965
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814

Some platforms reset the OSPM-set registers and the performance controls
across system suspend, losing the values the OS set. The hotplug
callbacks do not cover this. offline() runs only when a policy's last
CPU goes down. The boot CPU stays up during suspend-to-RAM, so offline()
never runs for its policy. During suspend-to-idle, no CPU goes down at
all.

The cpufreq core calls the driver's suspend() for every active policy
before any CPU goes offline, and resume() after the CPUs come back. Use
them to restore and reapply the registers, as offline() and online() do:

  - suspend() restores the firmware values and sets a per-policy flag to
    record it. It also stops the frequency invariance updates, so that
    no sample spans the suspend.
  - offline() skips the firmware restore while the flag is set, as
    suspend() has already done it. The rest of offline() still runs.
  - online() does the same as after hotplug. It re-enables CPPC and
    reprograms the performance controls. It reapplies the requested
    values and restarts the frequency invariance updates. It also clears
    the flag, so that the next offline() restores the firmware values
    again.
  - resume() calls online() only if the flag is still set. This covers
    the boot CPU's policy in suspend-to-RAM and every policy in
    suspend-to-idle. For any other policy, online() already ran when its
    first CPU came back.

resume() no longer marks the copy of MIN and MAX that fast_switch() uses
as out of date. online() does it, and every policy goes through online()
on the way back, from CPU hotplug or from resume().

Also make fie_init() cover related_cpus, as fie_exit() does. suspend()
stops the updates on all CPUs of the policy, even offline ones. When
resume() calls online(), policy->cpus holds only the online CPUs. An
offline CPU that comes up later does not trigger online() again, as its
policy is already active. Without this, its updates would never restart.

Suggested-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 74 ++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 27ef1ea41a3e..76cb803617f5 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -86,6 +86,12 @@ enum cppc_saved_type {
  */
 struct cppc_policy_state {
 	u64 regs[CPPC_NR_SAVED_REGS][CPPC_NR_SAVED_TYPES];
+	/*
+	 * Set by suspend() after it restores the firmware values. While it is
+	 * set, offline() skips that restore and resume() calls online().
+	 * Cleared by init() and online().
+	 */
+	bool suspend_regs_handled;
 };
 
 static DEFINE_PER_CPU(struct cppc_policy_state, cppc_policy_state);
@@ -332,6 +338,7 @@ static struct scale_freq_data cppc_sftd_pcc = {
 
 static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 {
+	const struct cpumask *cpus = policy->related_cpus;
 	struct scale_freq_data *sftd;
 	struct cppc_freq_invariance *cppc_fi;
 	int cpu, ret;
@@ -339,7 +346,15 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 	if (fie_disabled)
 		return;
 
-	for_each_cpu(cpu, policy->cpus) {
+	/*
+	 * When resume() calls online(), policy->cpus has only the online CPUs.
+	 * online() does not run again for a CPU in the same policy that comes
+	 * up later, so use related_cpus. It is empty only during init().
+	 */
+	if (cpumask_empty(cpus))
+		cpus = policy->cpus;
+
+	for_each_cpu(cpu, cpus) {
 		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
 		cppc_fi->cpu = cpu;
 		cppc_fi->cpu_data = policy->driver_data;
@@ -354,10 +369,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 
 		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
 
-		/*
-		 * Don't abort as the CPU was offline while the driver was
-		 * getting registered.
-		 */
+		/* Don't abort for a CPU that is offline. */
 		if (ret && cpu_online(cpu)) {
 			pr_debug("%s: failed to read perf counters for cpu:%d: %d\n",
 				__func__, cpu, ret);
@@ -366,7 +378,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 	}
 
 	/* A shared policy may contain both PCC and non-PCC counters. */
-	for_each_cpu(cpu, policy->cpus) {
+	for_each_cpu(cpu, cpus) {
 		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
 		if (cppc_fi->pcc_work_initialized)
 			sftd = &cppc_sftd_pcc;
@@ -969,6 +981,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = cppc_perf_to_khz(caps, desired_perf);
 	cpu_data->perf_ctrls.desired_perf = desired_perf;
 
+	cppc_cpufreq_policy_state(policy)->suspend_regs_handled = false;
 	ret = cppc_cpufreq_save_firmware_regs(policy);
 	if (ret) {
 		pr_debug("Err reading CPU%d firmware values: ret:%d\n", cpu, ret);
@@ -1023,6 +1036,8 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	int ret;
 
+	cppc_cpufreq_policy_state(policy)->suspend_regs_handled = false;
+
 	/*
 	 * The platform may have reset MIN and MAX, so mark the copy that
 	 * fast_switch() uses as out of date until the restore below succeeds.
@@ -1078,8 +1093,12 @@ static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	int ret;
 
-	/* Leave the platform in its pre-driver state. */
-	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
+	/*
+	 * Leave the platform in its pre-driver state, unless suspend() already
+	 * did so earlier in this suspend cycle.
+	 */
+	if (!cppc_cpufreq_policy_state(policy)->suspend_regs_handled)
+		cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
 
 	/*
 	 * Stop the frequency invariance updates and cancel the pending work, so
@@ -1105,16 +1124,46 @@ static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int cppc_cpufreq_cpu_resume(struct cpufreq_policy *policy)
+/*
+ * Run for every active policy when the system suspends, before any CPU goes
+ * offline.
+ *
+ * Restore the firmware values. Doing it here covers a policy that keeps a CPU
+ * online, for which offline() never runs. offline() does not write them again
+ * in the same suspend cycle.
+ *
+ * Stop the frequency invariance updates too, so that no sample spans the
+ * suspend window. online() restarts them on the way back, from hotplug or
+ * from resume().
+ */
+static int cppc_cpufreq_cpu_suspend(struct cpufreq_policy *policy)
 {
-	struct cppc_cpudata *cpu_data = policy->driver_data;
+	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
+	cppc_cpufreq_policy_state(policy)->suspend_regs_handled = true;
 
-	/* The platform may have reset the controls during suspend. */
-	WRITE_ONCE(cpu_data->perf_limits_valid, false);
+	cppc_cpufreq_cpu_fie_exit(policy);
 
 	return 0;
 }
 
+/*
+ * Run the online() restore for a policy that kept a CPU online through
+ * suspend.
+ *
+ * For any other policy, online() ran when its first CPU came back, before the
+ * core calls resume(). That cleared the flag. Only a policy that still has it
+ * set needs online() here. Either way every policy goes through online(), so
+ * resume() does not need to mark the copy of MIN and MAX that fast_switch()
+ * uses as out of date.
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
@@ -1446,6 +1495,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.exit = cppc_cpufreq_cpu_exit,
 	.online = cppc_cpufreq_cpu_online,
 	.offline = cppc_cpufreq_cpu_offline,
+	.suspend = cppc_cpufreq_cpu_suspend,
 	.resume = cppc_cpufreq_cpu_resume,
 	.set_boost = cppc_cpufreq_set_boost,
 	.attr = cppc_cpufreq_attr,
-- 
2.34.1

